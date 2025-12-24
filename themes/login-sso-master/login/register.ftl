<#import "template.ftl" as layout>
<@layout.registrationLayout 
  displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm')
  bodyClass="sso-page register-page">
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
              <iconify-icon icon="mdi:account-plus" class="slide-icon"></iconify-icon>
              <h2 class="sso-help-title">Daftar Akun SSO</h2>
              <p class="sso-help-description">
                Buat akun SSO Pemda DIY untuk mengakses semua layanan digital pemerintah Yogyakarta dalam satu akun.
              </p>
            </div>

            <div class="carousel-slide">
              <iconify-icon icon="mdi:shield-check" class="slide-icon"></iconify-icon>
              <h2 class="sso-help-title">Data Aman & Terenkripsi</h2>
              <p class="sso-help-description">
                Data pribadi Anda akan tersimpan dengan aman menggunakan enkripsi tingkat enterprise untuk melindungi privasi Anda.
              </p>
            </div>

            <div class="carousel-slide">
              <iconify-icon icon="mdi:email-check" class="slide-icon"></iconify-icon>
              <h2 class="sso-help-title">Verifikasi Email</h2>
              <p class="sso-help-description">
                Setelah registrasi, Anda akan menerima email verifikasi. Klik link di email untuk mengaktifkan akun Anda.
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
      <main class="sso-main register-main">
        <header class="sso-header">
          <img src="${url.resourcesPath}/image/pemprov_jogja.png" alt="Logo Pemda DIY" class="sso-user-icon">
          <p class="sso-welcome">Bergabung dengan</p>
          <h1 class="sso-title">SSO Pemda DIY</h1>
        </header>

        <section class="sso-form-section">
          <form id="kc-register-form" class="sso-form register-form" action="${url.registrationAction}" method="post">
            
            <!-- NAMA DEPAN & BELAKANG -->
            <div class="form-row">
              <div class="form-group">
                <label for="firstName" class="form-label">
                  Nama Depan <span class="required">*</span>
                </label>
                <div class="input-wrapper">
                  <input type="text" id="firstName" name="firstName" 
                    value="${(register.formData.firstName!'')}"
                    class="input-control <#if messagesPerField.existsError('firstName')>error</#if>" 
                    placeholder="Masukkan nama depan"
                    autocomplete="given-name" required />
                </div>
                <#if messagesPerField.existsError('firstName')>
                  <span class="error-text">
                    <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                    ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                  </span>
                </#if>
              </div>

              <div class="form-group">
                <label for="lastName" class="form-label">
                  Nama Belakang <span class="required">*</span>
                </label>
                <div class="input-wrapper">
                  <input type="text" id="lastName" name="lastName" 
                    value="${(register.formData.lastName!'')}"
                    class="input-control <#if messagesPerField.existsError('lastName')>error</#if>" 
                    placeholder="Masukkan nama belakang"
                    autocomplete="family-name" required />
                </div>
                <#if messagesPerField.existsError('lastName')>
                  <span class="error-text">
                    <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                    ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                  </span>
                </#if>
              </div>
            </div>

            <!-- EMAIL -->
            <div class="form-group">
              <label for="email" class="form-label">
                Email <span class="required">*</span>
              </label>
              <div class="input-wrapper">
                <iconify-icon icon="mdi:email" class="input-icon"></iconify-icon>
                <input type="email" id="email" name="email" 
                  value="${(register.formData.email!'')}"
                  class="input-control with-icon <#if messagesPerField.existsError('email')>error</#if>" 
                  placeholder="contoh@email.com"
                  autocomplete="email" required />
              </div>
              <#if messagesPerField.existsError('email')>
                <span class="error-text">
                  <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                  ${kcSanitize(messagesPerField.get('email'))?no_esc}
                </span>
              </#if>
            </div>

            <!-- USERNAME -->
            <#if !realm.registrationEmailAsUsername>
              <div class="form-group">
                <label for="username" class="form-label">
                  Username <span class="required">*</span>
                </label>
                <div class="input-wrapper">
                  <iconify-icon icon="mdi:account" class="input-icon"></iconify-icon>
                  <input type="text" id="username" name="username" 
                    value="${(register.formData.username!'')}"
                    class="input-control with-icon <#if messagesPerField.existsError('username')>error</#if>" 
                    placeholder="Pilih username unik"
                    autocomplete="username" required />
                </div>
                <#if messagesPerField.existsError('username')>
                  <span class="error-text">
                    <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                  </span>
                <#else>
                  <span class="help-text">
                    <iconify-icon icon="mdi:information"></iconify-icon>
                    Username harus unik dan akan digunakan untuk login
                  </span>
                </#if>
              </div>
            </#if>

            <!-- PASSWORD -->
            <div class="form-group">
              <label for="password" class="form-label">
                Password <span class="required">*</span>
              </label>
              <div class="input-wrapper input-wrapper--password">
                <iconify-icon icon="mdi:lock" class="input-icon"></iconify-icon>
                <input type="password" id="password" name="password" 
                  class="input-control with-icon <#if messagesPerField.existsError('password')>error</#if>" 
                  placeholder="Buat password yang kuat"
                  autocomplete="new-password" required />
                <button type="button" class="btn-eye-toggle" id="togglePassword" aria-label="Show password">
                  <iconify-icon icon="mdi:eye-off-outline" class="eye-icon"></iconify-icon>
                </button>
              </div>
              <#if messagesPerField.existsError('password')>
                <span class="error-text">
                  <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                  ${kcSanitize(messagesPerField.get('password'))?no_esc}
                </span>
              </#if>
              
              <!-- Password Strength Indicator -->
              <div class="password-strength" id="password-strength">
                <div class="strength-bar">
                  <div class="strength-fill" id="strength-fill"></div>
                </div>
                <span class="strength-text" id="strength-text">Password strength</span>
              </div>
            </div>

            <!-- CONFIRM PASSWORD -->
            <div class="form-group">
              <label for="password-confirm" class="form-label">
                Konfirmasi Password <span class="required">*</span>
              </label>
              <div class="input-wrapper input-wrapper--password">
                <iconify-icon icon="mdi:lock-check" class="input-icon"></iconify-icon>
                <input type="password" id="password-confirm" name="password-confirm" 
                  class="input-control with-icon <#if messagesPerField.existsError('password-confirm')>error</#if>" 
                  placeholder="Ketik ulang password"
                  autocomplete="new-password" required />
                <button type="button" class="btn-eye-toggle" id="togglePasswordConfirm" aria-label="Show password">
                  <iconify-icon icon="mdi:eye-off-outline" class="eye-icon"></iconify-icon>
                </button>
              </div>
              <#if messagesPerField.existsError('password-confirm')>
                <span class="error-text">
                  <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                  ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                </span>
              </#if>
            </div>

            <!-- TERMS & CONDITIONS -->
            <div class="form-group checkbox-group">
              <label class="checkbox-label">
                <input type="checkbox" name="termsAccepted" class="checkbox-input" required />
                <span class="checkbox-custom"></span>
                <span class="checkbox-text">
                  Saya setuju dengan <a href="#" class="link-inline">Syarat & Ketentuan</a> dan 
                  <a href="#" class="link-inline">Kebijakan Privasi</a> SSO Pemda DIY
                </span>
              </label>
            </div>

            <!-- SUBMIT BUTTON -->
            <button type="submit" class="btn-primary btn-register">
              <iconify-icon icon="mdi:account-plus"></iconify-icon>
              Daftar Sekarang
            </button>

          <!-- ALREADY HAVE ACCOUNT -->
          <div class="already-registered">
            <p>Sudah punya akun? <a href="${url.loginUrl}" class="link-login">Login disini</a></p>
          </div>

  <!-- Password Strength Script -->
  <script src="${url.resourcesPath}/script/register.js"></script>
</@layout.registrationLayout>