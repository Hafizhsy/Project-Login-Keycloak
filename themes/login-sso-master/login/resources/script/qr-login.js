(function() {
  'use strict';

  // Configuration
  const CONFIG = {
    QR_EXPIRY_TIME: 120, // 2 minutes in seconds
    POLL_INTERVAL: 2000, // Poll every 2 seconds
    DEMO_MODE: true // Set to false in production
  };

  // State
  let state = {
    currentMethod: 'password',
    countdown: CONFIG.QR_EXPIRY_TIME,
    countdownTimer: null,
    pollTimer: null,
    qrCodeInstance: null,
    sessionId: null
  };

  /**
   * Initialize QR Login functionality
   */
  function init() {
    // Check if QR elements exist on page
    const qrSection = document.getElementById('qr-section');
    if (!qrSection) {
      console.log('QR Login not available on this page');
      return;
    }

    // Setup event listeners
    setupEventListeners();
    
    console.log('QR Login initialized');
  }

  /**
   * Setup event listeners
   */
  function setupEventListeners() {
    const btnPassword = document.getElementById('btn-password');
    const btnQr = document.getElementById('btn-qr');
    const btnRefresh = document.getElementById('btn-refresh');

    if (btnPassword) {
      btnPassword.addEventListener('click', () => switchLoginMethod('password'));
    }

    if (btnQr) {
      btnQr.addEventListener('click', () => switchLoginMethod('qr'));
    }

    if (btnRefresh) {
      btnRefresh.addEventListener('click', refreshQR);
    }

    // Cleanup on page unload
    window.addEventListener('beforeunload', cleanup);
  }

  /**
   * Switch between password and QR login methods
   * @param {string} method - 'password' or 'qr'
   */
  function switchLoginMethod(method) {
    state.currentMethod = method;

    const passwordSection = document.getElementById('password-section');
    const qrSection = document.getElementById('qr-section');
    const btnPassword = document.getElementById('btn-password');
    const btnQr = document.getElementById('btn-qr');

    if (method === 'password') {
      // Show password form
      passwordSection.style.display = 'block';
      qrSection.style.display = 'none';
      btnPassword.classList.add('active');
      btnQr.classList.remove('active');

      // Stop QR timers
      stopTimers();
    } else {
      // Show QR code section
      passwordSection.style.display = 'none';
      qrSection.style.display = 'flex';
      btnPassword.classList.remove('active');
      btnQr.classList.add('active');

      // Generate QR code if not already created
      if (!state.qrCodeInstance) {
        createQRCode();
        startCountdown();
      }
    }
  }

  /**
   * Generate unique session ID
   * @returns {string} Session ID
   */
  function generateSessionId() {
    return 'qr_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
  }

  /**
   * Get realm name from page context
   * @returns {string} Realm name
   */
  function getRealmName() {
    // Try to get from data attribute or window object
    const realmEl = document.querySelector('[data-realm]');
    if (realmEl) {
      return realmEl.getAttribute('data-realm');
    }
    
    // Fallback: parse from URL
    const pathParts = window.location.pathname.split('/');
    const realmIndex = pathParts.indexOf('realms');
    if (realmIndex >= 0 && pathParts.length > realmIndex + 1) {
      return pathParts[realmIndex + 1];
    }
    
    return 'master'; // Default realm
  }

  /**
   * Create QR Code
   */
  function createQRCode() {
    const qrContainer = document.getElementById('qrcode');
    if (!qrContainer) {
      console.error('QR container not found');
      return;
    }

    // Clear previous QR code
    qrContainer.innerHTML = '';

    // Generate session ID
    state.sessionId = generateSessionId();

    // Prepare QR data
    const qrData = {
      sessionId: state.sessionId,
      realm: getRealmName(),
      timestamp: Date.now(),
      expiresIn: CONFIG.QR_EXPIRY_TIME,
      loginUrl: window.location.origin + '/realms/' + getRealmName() + '/qr-verify'
    };

    // Store session ID
    try {
      sessionStorage.setItem('qr_session_id', state.sessionId);
    } catch (e) {
      console.warn('SessionStorage not available:', e);
    }

    // Generate QR Code
    try {
      state.qrCodeInstance = new QRCode(qrContainer, {
        text: JSON.stringify(qrData),
        width: 240,
        height: 240,
        colorDark: '#000000',
        colorLight: '#ffffff',
        correctLevel: QRCode.CorrectLevel.H
      });

      // Reset countdown
      state.countdown = CONFIG.QR_EXPIRY_TIME;
      
      // Show scanning status
      showStatus('scanning');
      
      // Start polling
      startPolling();

      console.log('QR Code generated:', state.sessionId);
    } catch (error) {
      console.error('Error generating QR code:', error);
      showStatus('error');
    }
  }

  /**
   * Start countdown timer
   */
  function startCountdown() {
    // Clear existing timer
    if (state.countdownTimer) {
      clearInterval(state.countdownTimer);
    }

    state.countdownTimer = setInterval(() => {
      state.countdown--;
      updateCountdown();

      if (state.countdown <= 0) {
        stopTimers();
        showStatus('expired');
      }
    }, 1000);
  }

  /**
   * Update countdown display
   */
  function updateCountdown() {
    const minutes = Math.floor(state.countdown / 60);
    const seconds = state.countdown % 60;
    const timerEl = document.getElementById('timer');

    if (timerEl) {
      timerEl.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;

      // Change color when time is running out
      if (state.countdown <= 30) {
        timerEl.style.color = '#ef4444';
      } else {
        timerEl.style.color = '#ffffff';
      }
    }
  }

  /**
   * Start polling for QR scan status
   */
  function startPolling() {
    // Clear existing timer
    if (state.pollTimer) {
      clearInterval(state.pollTimer);
    }

    state.pollTimer = setInterval(async () => {
      try {
        if (CONFIG.DEMO_MODE) {
          // Demo mode: simulate random success
          if (state.countdown < 110 && Math.random() > 0.95) {
            handleLoginSuccess();
          }
        } else {
          // Production mode: call actual API
          await checkQRStatus();
        }
      } catch (error) {
        console.error('Polling error:', error);
      }
    }, CONFIG.POLL_INTERVAL);
  }

  /**
   * Check QR scan status via API
   */
  async function checkQRStatus() {
    const sessionId = state.sessionId;
    if (!sessionId) return;

    try {
      const response = await fetch(
        '/realms/' + getRealmName() + '/qr-auth/status/' + sessionId,
        {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json'
          }
        }
      );

      if (response.ok) {
        const data = await response.json();

        if (data.status === 'approved') {
          handleLoginSuccess();
        } else if (data.status === 'rejected') {
          handleLoginRejected();
        }
      }
    } catch (error) {
      console.error('API error:', error);
    }
  }

  /**
   * Handle successful QR login
   */
  function handleLoginSuccess() {
    stopTimers();
    showStatus('success');

    setTimeout(() => {
      if (CONFIG.DEMO_MODE) {
        alert('QR Login berhasil! (Demo mode)\n\nDalam production, akan redirect ke dashboard.');
      } else {
        // Redirect to login action
        const loginUrl = document.querySelector('[data-login-url]');
        if (loginUrl) {
          window.location.href = loginUrl.getAttribute('data-login-url') + 
                                '?session_state=' + state.sessionId;
        }
      }
    }, 1500);
  }

  /**
   * Handle rejected QR login
   */
  function handleLoginRejected() {
    stopTimers();
    showStatus('error');
  }

  /**
   * Show status message
   * @param {string} status - 'scanning', 'success', 'error', 'expired'
   */
  function showStatus(status) {
    const statusEl = document.getElementById('qr-status');
    const qrBox = document.getElementById('qr-box');
    const refreshBtn = document.getElementById('btn-refresh');

    if (!statusEl) return;

    statusEl.className = 'qr-status';

    const statusContent = {
      scanning: {
        icon: 'mdi:radar',
        iconClass: 'rotating',
        title: 'Menunggu Scan...',
        message: 'Scan QR code dengan aplikasi SSO Pemda DIY',
        opacity: '1',
        showRefresh: false
      },
      success: {
        icon: 'mdi:check-circle',
        iconClass: '',
        title: 'Login Berhasil!',
        message: 'Redirecting...',
        opacity: '0.3',
        showRefresh: false
      },
      error: {
        icon: 'mdi:close-circle',
        iconClass: '',
        title: 'Login Ditolak',
        message: 'Konfirmasi ditolak di aplikasi',
        opacity: '0.3',
        showRefresh: true
      },
      expired: {
        icon: 'mdi:clock-alert',
        iconClass: '',
        title: 'QR Code Expired',
        message: 'Kode QR sudah kadaluarsa',
        opacity: '0.3',
        showRefresh: true
      }
    };

    const config = statusContent[status];
    if (!config) return;

    statusEl.innerHTML = `
      <div class="status-content ${status}">
        <iconify-icon icon="${config.icon}" class="status-icon ${config.iconClass}"></iconify-icon>
        <h3>${config.title}</h3>
        <p>${config.message}</p>
      </div>
    `;

    if (qrBox) {
      qrBox.style.opacity = config.opacity;
    }

    if (refreshBtn) {
      refreshBtn.style.display = config.showRefresh ? 'inline-flex' : 'none';
    }
  }

  /**
   * Refresh QR Code
   */
  function refreshQR() {
    state.qrCodeInstance = null;
    createQRCode();
    startCountdown();
  }

  /**
   * Stop all timers
   */
  function stopTimers() {
    if (state.countdownTimer) {
      clearInterval(state.countdownTimer);
      state.countdownTimer = null;
    }

    if (state.pollTimer) {
      clearInterval(state.pollTimer);
      state.pollTimer = null;
    }
  }

  /**
   * Cleanup function
   */
  function cleanup() {
    stopTimers();
    state.qrCodeInstance = null;
  }

  /**
   * Public API
   */
  window.QRLogin = {
    init: init,
    switchMethod: switchLoginMethod,
    refresh: refreshQR,
    setDemoMode: (enabled) => { CONFIG.DEMO_MODE = enabled; }
  };

  // Auto-initialize when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

})();