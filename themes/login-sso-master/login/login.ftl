<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true bodyClass="sso-page">
  <div class="sso-page">
    <div class="sso-card">
      <!-- LEFT PANEL -->
      <aside class="sso-side">
        <div class="sso-side-bg">
         <img class="sso-motif" src="${url.resourcesPath}/image/motif.png" alt="Motif Pemda DIY" />
        </div>

        <section class="sso-help-text">
          <div class="carousel-container">
            <div class="carousel-slide active">
              <iconify-icon icon="mdi:headset-help" class="slide-icon"></iconify-icon>
              <img src="${url.resourcesPath}/image/bantuan.png" alt="Bantuan Login" class="bantuan-icon">
              <h2 class="sso-help-title">Bantuan Login</h2>
              <p class="sso-help-description">
                Jika Anda mengalami kesulitan dalam proses login atau membutuhkan bantuan teknis lainnya,
                silakan hubungi tim dukungan kami via Discord atau WhatsApp.
              </p>
            </div>

            <div class="carousel-slide">
              <img src="${url.resourcesPath}/image/keamanan-password.png" alt="Keamanan Akun" class="bantuan-icon">
              <h2 class="sso-help-title">Keamanan Akun</h2>
              <p class="sso-help-description">
                Jangan pernah membagikan username dan password SSO Anda kepada orang lain.
                Selalu pastikan Anda login di domain resmi Pemda DIY.
              </p>
            </div>

            <div class="carousel-slide">
              <img src="${url.resourcesPath}/image/pembaruan-2FA.png" alt="Pembaruan 2FA" class="bantuan-icon">
              <h2 class="sso-help-title">Pembaruan 2FA</h2>
              <p class="sso-help-description">
                Pastikan Anda mengupdate 2FA setiap kali login untuk meningkatkan keamanan akun Anda. Jangan pernah membagikan username dan password SSO Anda kepada orang lain. Selalu pastikan Anda login di domain resmi Pemda DIY.
              </p>
            </div>

            <div class="carousel-indicators">
              <span class="indicator active"></span>
              <span class="indicator"></span>
              <span class="indicator"></span>
            </div>
          </div>
        </section>

        <section class="sso-helpdesk-card">
          <p class="sso-helpdesk-title">Need Help?</p>
          <div class="sso-helpdesk-icons">
            <iconify-icon icon="mage:whatsapp" class="helpdesk-icon"></iconify-icon>
            <a href="https://discord.com/invite/diskominfo-diy-905311916359041064" class="helpdesk-icon" target="_blank">
              <iconify-icon icon="ic:baseline-discord"></iconify-icon>
            </a>
          </div>
        </section>
      </aside>

      <!-- RIGHT PANEL -->
      <main class="sso-main">
        <header class="sso-header">
          <img src="${url.resourcesPath}/image/pemprov_jogja.png" alt="User Icon" class="sso-user-icon">
          <p class="sso-welcome">Selamat Datang kembali di</p>
          <h1 class="sso-title">SSO Pemda DIY</h1>
        </header>

        <!-- PASSWORD LOGIN SECTION -->
        <section class="sso-form-section" id="password-section">
          <form id="kc-form-login" class="sso-form" action="${url.loginAction}" method="post">
            <!-- USERNAME -->
            <div class="form-group">
              <label for="username" class="form-label">Username</label>
              <div class="input-wrapper">
                <input type="text" id="username" name="username"
                  value="${(login.username!'')}"
                  class="input-control" placeholder="Masukkan Username"
                  autocomplete="username" required />
              </div>
            </div>

            <!-- PASSWORD -->
            <div class="form-group">
              <label for="password" class="form-label">Password</label>
              <div class="input-wrapper input-wrapper--password">
                <input type="password" id="password" name="password" class="input-control"
                  placeholder="Masukkan Password" autocomplete="current-password" required />
                <button type="button" class="btn-eye-toggle" id="togglePassword" aria-label="Show password">
                  <iconify-icon icon="mdi:eye-off-outline" class="eye-icon"></iconify-icon>
                </button>
              </div>
            </div>

            <!-- REMEMBER ME -->
            <div class="form-remember-row">
              <label class="checkbox-label">
                <input type="checkbox" name="rememberMe" class="checkbox-input" />
                <span class="checkbox-custom"></span>
                <span class="checkbox-text">Remember me</span>
              </label>
            </div>

            <!-- FORGOT PASSWORD -->
            <div class="form-extra-row">
              <a href="${url.loginResetCredentialsUrl}" class="link-forgot-password">Lupa password?</a>
            </div>

            <!-- SUBMIT -->
            <button type="submit" class="btn-primary">
              Sign in
            </button>
          </form>

          <!-- SOCIAL LOGIN -->
          <#if social?? && social.providers??>
            <div class="social-login">
              <div class="social-divider">
                <span>atau</span>
              </div>
              <#list social.providers as p>
                <a class="btn-social" href="${p.loginUrl}" id="social-${p.alias}">
                  <#if p.alias == "google">
                    <svg class="social-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                      <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                      <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                      <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                    </svg>
                  <#elseif p.alias == "facebook">
                    <svg class="social-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" fill="#1877F2"/>
                    </svg>
                  <#else>
                    <iconify-icon icon="mdi:login" class="social-icon"></iconify-icon>
                  </#if>
                  <span>Login dengan ${p.displayName}</span>
                </a>
              </#list>
            </div>
          </#if>

          <!-- REGISTER SECTION -->
          <#if realm.registrationAllowed && !registrationDisabled??>
            <div class="register-section">
              <div class="register-divider">
                <span class="divider-line"></span>
                <span class="divider-text">Belum punya akun?</span>
              <a href="${url.registrationUrl}" class="btn-register-link">
                <span>Register</span>
              </a>
              <footer class="sso-footer-links">
            <div class="footer-divider">
              <span class="divider-line"></span>
            </div>
            
            <div class="footer-grid">
              <a href="https://wiki.jogjaprov.go.id/diskominfo/panduan/panduan-2fa" class="footer-item">
                <div class="footer-icon-box security">
                  <iconify-icon icon="mdi:shield-check-outline"></iconify-icon>
                </div>
                <div class="footer-text">
                  <span class="footer-label">Panduan</span>
                  <span class="footer-sub">SSO / 2FA</span>
                </div>
              </a>

              <a href="https://drive.google.com/file/d/1nvLDfcjULstrpKbt-8o3nSY23FgCMxl4/view" class="footer-item">
                <div class="footer-icon-box privacy">
                  <iconify-icon icon="mdi:lock-outline"></iconify-icon>
                </div>
                <div class="footer-text">
                  <span class="footer-label">Kebijakan</span>
                  <span class="footer-sub">Privasi</span>
                </div>
              </a>

              <a href="https://diskominfo.notion.site/28e22b0cdb8080e6a777e835aee5cff7" class="footer-item">
                <div class="footer-icon-box feedback">
                  <iconify-icon icon="mdi:comment-quote-outline"></iconify-icon>
                </div>
                <div class="footer-text">
                  <span class="footer-label">Bantuan</span>
                  <span class="footer-sub">Kritik & Saran</span>
                </div>
              </a>
            </div>

            <p class="sso-copyright">
              &copy; 2026 Pemerintah Daerah DIY
            </p>
          </footer>
            </div>
            </div>
          </#if>
        </section>
      </main>
      
    </div>
  </div>
</@layout.registrationLayout>