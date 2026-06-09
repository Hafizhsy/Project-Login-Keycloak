<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false bodyClass="sso-page otp-setup-page"; section>
  <#if section = "form">
    <div class="otp-shell">
      <section class="otp-brand-panel">
        <div class="otp-brand-overlay"></div>
        <div class="otp-brand-content">
          <img src="${url.resourcesPath}/image/pemprov_jogja.png" alt="Logo Pemda DIY" class="otp-logo" />
          <p class="otp-eyebrow">Keamanan Akun</p>
          <h1>Aktifkan Verifikasi 2 Langkah</h1>
          <p>
            Scan QR menggunakan Google Authenticator, Microsoft Authenticator, atau aplikasi OTP lain untuk melindungi akun SSO Anda.
          </p>
          <div class="otp-checklist">
            <span>1. Scan QR</span>
            <span>2. Masukkan kode 6 digit</span>
            <span>3. Simpan perangkat</span>
          </div>
        </div>
      </section>

      <main class="otp-card">
        <div class="otp-card-header">
          <p class="otp-step">Setup Authenticator</p>
          <h2>Hubungkan aplikasi OTP</h2>
          <p>Buka aplikasi authenticator, scan QR di bawah, lalu masukkan kode yang muncul.</p>
        </div>

        <#if (message?has_content)>
          <div class="otp-alert otp-alert-${message.type}">
            ${kcSanitize(message.summary)?no_esc}
          </div>
        </#if>

        <div class="otp-qr-wrap">
          <#if totp.totpSecretQrCode??>
            <img src="data:image/png;base64,${totp.totpSecretQrCode}" alt="QR OTP" class="otp-qr" />
          <#elseif totp.totpSecretEncoded??>
            <div class="otp-qr-fallback">QR tidak tersedia</div>
          </#if>
        </div>

        <#if totp.totpSecretEncoded??>
          <div class="otp-secret-box">
            <span>Secret key</span>
            <code>${totp.totpSecretEncoded}</code>
          </div>
        </#if>

        <form id="kc-totp-settings-form" class="otp-form" action="${url.loginAction}" method="post">
          <#if mode??>
            <input type="hidden" name="mode" value="${mode}" />
          </#if>
          <#if totp.totpSecret??>
            <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
          </#if>

          <label for="totp" class="otp-label">Kode OTP</label>
          <input
            id="totp"
            name="totp"
            class="otp-code-input <#if messagesPerField.existsError('totp')>otp-input-error</#if>"
            type="text"
            inputmode="numeric"
            pattern="[0-9]*"
            autocomplete="one-time-code"
            maxlength="6"
            placeholder="000000"
            autofocus
            required
          />

          <#if messagesPerField.existsError('totp')>
            <p class="otp-error">${kcSanitize(messagesPerField.get('totp'))?no_esc}</p>
          </#if>

          <label for="userLabel" class="otp-label">Nama perangkat</label>
          <input
            id="userLabel"
            name="userLabel"
            class="otp-device-input"
            type="text"
            autocomplete="off"
            value="${(totp.otpCredentials[0].userLabel)!''}"
            placeholder="Contoh: HP pribadi"
          />

          <button id="kc-submit" class="otp-submit" type="submit">
            Aktifkan OTP
          </button>
        </form>
      </main>
    </div>
  </#if>
</@layout.registrationLayout>
