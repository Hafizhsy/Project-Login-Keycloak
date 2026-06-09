<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section = "header">
        <h1 class="sso-title">Verifikasi 2FA</h1>
        <p class="sso-welcome">Masukkan kode autentikasi Anda</p>
    <#elseif section = "form">
        <form id="kc-otp-login-form" class="sso-form" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="otp" class="form-label">Kode Verifikasi</label>
                <div class="input-wrapper otp-input-container">
                    <input id="otp" name="otp" autocomplete="one-time-code" type="text" 
                           class="input-control text-center tracking-[1em] font-bold text-2xl" 
                           placeholder="000000" autofocus required />
                </div>
            </div>

            <button class="btn-primary" name="login" id="kc-login" type="submit">
                Verifikasi & Masuk
            </button>
        </form>
        
        <div class="text-center mt-6">
            <a href="${url.loginUrl}" class="text-sm text-slate-500 hover:text-blue-600"> Kembali ke Login </a>
        </div>
    </#if>
</@layout.registrationLayout>