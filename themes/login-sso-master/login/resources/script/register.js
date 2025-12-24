/**
 * Registration Form Handler
 * SSO Pemda DIY
 */

(function() {
  'use strict';

  // Initialize
  document.addEventListener('DOMContentLoaded', function() {
    initPasswordToggle();
    initPasswordStrength();
    initPasswordMatch();
    initFormValidation();
    console.log('Register form initialized');
  });

  /**
   * Password Toggle Visibility
   */
  function initPasswordToggle() {
    // Toggle password
    const togglePassword = document.getElementById('togglePassword');
    if (togglePassword) {
      togglePassword.addEventListener('click', function() {
        togglePasswordVisibility('password', this);
      });
    }

    // Toggle confirm password
    const togglePasswordConfirm = document.getElementById('togglePasswordConfirm');
    if (togglePasswordConfirm) {
      togglePasswordConfirm.addEventListener('click', function() {
        togglePasswordVisibility('password-confirm', this);
      });
    }
  }

  /**
   * Toggle password visibility
   */
  function togglePasswordVisibility(inputId, button) {
    const input = document.getElementById(inputId);
    const icon = button.querySelector('.eye-icon');
    
    if (!input || !icon) return;

    if (input.type === 'password') {
      input.type = 'text';
      icon.setAttribute('icon', 'mdi:eye-outline');
      button.setAttribute('aria-label', 'Hide password');
    } else {
      input.type = 'password';
      icon.setAttribute('icon', 'mdi:eye-off-outline');
      button.setAttribute('aria-label', 'Show password');
    }
  }

  /**
   * Password Strength Indicator
   */
  function initPasswordStrength() {
    const passwordInput = document.getElementById('password');
    if (!passwordInput) return;

    passwordInput.addEventListener('input', function() {
      checkPasswordStrength(this.value);
    });
  }

  /**
   * Check password strength
   */
  function checkPasswordStrength(password) {
    const strengthFill = document.getElementById('strength-fill');
    const strengthText = document.getElementById('strength-text');
    
    if (!strengthFill || !strengthText) return;

    // Calculate strength
    let strength = 0;
    const checks = {
      length: password.length >= 8,
      lowercase: /[a-z]/.test(password),
      uppercase: /[A-Z]/.test(password),
      number: /[0-9]/.test(password),
      special: /[^A-Za-z0-9]/.test(password)
    };

    // Count passed checks
    Object.values(checks).forEach(check => {
      if (check) strength++;
    });

    // Update UI
    let width = 0;
    let text = '';
    let color = '';

    if (password.length === 0) {
      width = 0;
      text = 'Password strength';
      color = '#e5e7eb';
    } else if (strength <= 2) {
      width = 33;
      text = 'Lemah';
      color = '#ef4444';
    } else if (strength <= 3) {
      width = 66;
      text = 'Sedang';
      color = '#f59e0b';
    } else {
      width = 100;
      text = 'Kuat';
      color = '#10b981';
    }

    strengthFill.style.width = width + '%';
    strengthFill.style.backgroundColor = color;
    strengthText.textContent = text;
    strengthText.style.color = color;
  }

  /**
   * Password Match Validation
   */
  function initPasswordMatch() {
    const password = document.getElementById('password');
    const passwordConfirm = document.getElementById('password-confirm');

    if (!password || !passwordConfirm) return;

    passwordConfirm.addEventListener('input', function() {
      checkPasswordMatch();
    });

    password.addEventListener('input', function() {
      if (passwordConfirm.value) {
        checkPasswordMatch();
      }
    });
  }

  /**
   * Check if passwords match
   */
  function checkPasswordMatch() {
    const password = document.getElementById('password');
    const passwordConfirm = document.getElementById('password-confirm');

    if (!password || !passwordConfirm) return;

    const wrapper = passwordConfirm.closest('.form-group');
    let errorText = wrapper.querySelector('.error-text');

    if (passwordConfirm.value && password.value !== passwordConfirm.value) {
      passwordConfirm.classList.add('error');
      
      if (!errorText) {
        errorText = document.createElement('span');
        errorText.className = 'error-text';
        errorText.innerHTML = '<iconify-icon icon="mdi:alert-circle"></iconify-icon> Password tidak cocok';
        wrapper.appendChild(errorText);
      }
    } else {
      passwordConfirm.classList.remove('error');
      if (errorText) {
        errorText.remove();
      }
    }
  }

  /**
   * Form Validation
   */
  function initFormValidation() {
    const form = document.getElementById('kc-register-form');
    if (!form) return;

    form.addEventListener('submit', function(e) {
      const isValid = validateForm();
      
      if (!isValid) {
        e.preventDefault();
        
        // Scroll to first error
        const firstError = form.querySelector('.error');
        if (firstError) {
          firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
          firstError.focus();
        }
      }
    });
  }

  /**
   * Validate entire form
   */
  function validateForm() {
    let isValid = true;

    // Check required fields
    const requiredFields = [
      'firstName',
      'lastName',
      'email',
      'password',
      'password-confirm'
    ];

    // Add username if not using email as username
    const usernameField = document.getElementById('username');
    if (usernameField) {
      requiredFields.push('username');
    }

    requiredFields.forEach(fieldId => {
      const field = document.getElementById(fieldId);
      if (field && !field.value.trim()) {
        field.classList.add('error');
        isValid = false;
      } else if (field) {
        field.classList.remove('error');
      }
    });

    // Check email format
    const emailField = document.getElementById('email');
    if (emailField && emailField.value) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(emailField.value)) {
        emailField.classList.add('error');
        isValid = false;
      }
    }

    // Check password match
    const password = document.getElementById('password');
    const passwordConfirm = document.getElementById('password-confirm');
    if (password && passwordConfirm) {
      if (password.value !== passwordConfirm.value) {
        passwordConfirm.classList.add('error');
        isValid = false;
      }
    }

    // Check password strength (minimum sedang)
    if (password && password.value) {
      const strength = calculateStrength(password.value);
      if (strength < 3) {
        password.classList.add('error');
        isValid = false;
      }
    }

    // Check terms acceptance
    const termsCheckbox = document.querySelector('input[name="termsAccepted"]');
    if (termsCheckbox && !termsCheckbox.checked) {
      termsCheckbox.closest('.checkbox-label').classList.add('error');
      isValid = false;
    } else if (termsCheckbox) {
      termsCheckbox.closest('.checkbox-label').classList.remove('error');
    }

    return isValid;
  }

  /**
   * Calculate password strength score
   */
  function calculateStrength(password) {
    let strength = 0;
    const checks = {
      length: password.length >= 8,
      lowercase: /[a-z]/.test(password),
      uppercase: /[A-Z]/.test(password),
      number: /[0-9]/.test(password),
      special: /[^A-Za-z0-9]/.test(password)
    };

    Object.values(checks).forEach(check => {
      if (check) strength++;
    });

    return strength;
  }

  /**
   * Real-time field validation
   */
  document.addEventListener('DOMContentLoaded', function() {
    const inputs = document.querySelectorAll('.input-control');
    
    inputs.forEach(input => {
      input.addEventListener('blur', function() {
        if (this.hasAttribute('required') && !this.value.trim()) {
          this.classList.add('error');
        } else {
          this.classList.remove('error');
        }
      });

      input.addEventListener('input', function() {
        if (this.classList.contains('error') && this.value.trim()) {
          this.classList.remove('error');
        }
      });
    });
  });

})();