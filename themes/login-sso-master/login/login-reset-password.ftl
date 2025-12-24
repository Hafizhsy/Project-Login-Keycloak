<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true bodyClass="forgot-page">

<div class="sso-page">
  <div class="sso-card">

    <aside class="sso-side">
      <div class="sso-side-bg">
        <img class="sso-motif" src="${url.resourcesPath}/image/motif.png" alt="Motif Pemda DIY" />
      </div>

      <section class="sso-help-text">
        <div class="carousel-container">
          <div class="carousel-slide active">
            <iconify-icon icon="mdi:lock-reset" class="slide-icon"></iconify-icon>
            <h2 class="sso-help-title">Reset Aman</h2>
            <p class="sso-help-description">
              Kami mengirimkan tautan rahasia ke email Anda untuk memastikan hanya Anda
              yang dapat mengganti password.
            </p>
          </div>

          <div class="carousel-slide">
            <iconify-icon icon="mdi:shield-lock-outline" class="slide-icon"></iconify-icon>
            <h2 class="sso-help-title">Verifikasi Domain</h2>
            <p class="sso-help-description">
              Pastikan Anda hanya membuka tautan reset dari domain resmi Pemda DIY agar akun tetap terlindungi.
            </p>
          </div>

          <div class="carousel-slide">
            <iconify-icon icon="mdi:headset" class="slide-icon"></iconify-icon>
            <h2 class="sso-help-title">Tim Bantuan</h2>
            <p class="sso-help-description">
              Jika tidak menerima email reset, hubungi helpdesk kami melalui WhatsApp atau email resmi.
            </p>
          </div>

          <div class="carousel-indicators">
            <span class="indicator active"></span>
            <span class="indicator"></span>
            <span class="indicator"></span>
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

    <main class="sso-main forgot-main">
      <header class="sso-header forgot-header">
        <img src="${url.resourcesPath}/image/pemprov_jogja.png" alt="Logo Pemda DIY" class="sso-user-icon">
        <p class="sso-welcome">Layanan Reset Password</p>
        <h1 class="sso-title">Pulihkan Akun Anda</h1>
      </header>

      <section class="sso-form-section forgot-form-section">
        <p class="forgot-description">
          Masukkan email terdaftar. Kami akan mengirimkan tautan reset.
        </p>

        <form id="kc-reset-password-form" class="sso-form auth-form" action="${url.loginResetCredentialsUrl}" method="post">
          <div class="form-group">
            <label for="username">Email Address</label>
            <div class="input-wrapper">
              <iconify-icon icon="mdi:email" class="input-icon" width="18" height="18"></iconify-icon>
              <input type="email" id="username" name="username"
                placeholder="Masukkan email Anda"
                class="input-control"
                required />
            </div>
          </div>

          <button type="submit" class="btn-primary">Kirim Link Reset</button>
        </form>

        <div class="back-to-login">
          <a href="${url.loginUrl}" class="back-link">
            <iconify-icon icon="mdi:arrow-left" width="18" height="18"></iconify-icon>
            <span>Kembali ke Login</span>
          </a>
        </div>
      </section>

      <footer class="forgot-footer">
        <p>Copyright © SSO Pemda DIY</p>
      </footer>
    </main>
  </div>
</div>

</@layout.registrationLayout>
