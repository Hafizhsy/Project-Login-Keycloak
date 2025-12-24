<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "title">
        Registrasi Akun
    <#elseif section = "form">
        <form id="kc-register-form" class="login-form" action="${url.registrationAction}" method="post">
            
            <h2 style="color: #0d47a1; margin-bottom: 30px; font-size: 24px; font-weight: 700;">
                Registrasi Akun Baru
            </h2>

            <div class="form-group">
                <label class="form-label" for="firstName">Nama Depan *</label>
                <div class="input-wrapper">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" id="firstName" class="form-control" name="firstName" 
                           value="${(register.formData.firstName!'')}" 
                           placeholder="Nama depan" />
                </div>
                <#if messagesPerField.existsError('firstName')>
                    <span class="input-error" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                    </span>
                </#if>
            </div>

            <div class="form-group">
                <label class="form-label" for="lastName">Nama Belakang *</label>
                <div class="input-wrapper">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" id="lastName" class="form-control" name="lastName" 
                           value="${(register.formData.lastName!'')}" 
                           placeholder="Nama belakang" />
                </div>
                <#if messagesPerField.existsError('lastName')>
                    <span class="input-error" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                    </span>
                </#if>
            </div>

            <div class="form-group">
                <label class="form-label" for="email">Email *</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" id="email" class="form-control" name="email" 
                           value="${(register.formData.email!'')}" 
                           placeholder="email@example.com" autocomplete="email" />
                </div>
                <#if messagesPerField.existsError('email')>
                    <span class="input-error" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('email'))?no_esc}
                    </span>
                </#if>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="form-group">
                    <label class="form-label" for="username">Username *</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user-circle input-icon"></i>
                        <input type="text" id="username" class="form-control" name="username" 
                               value="${(register.formData.username!'')}" 
                               placeholder="Username" autocomplete="username" />
                    </div>
                    <#if messagesPerField.existsError('username')>
                        <span class="input-error" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('username'))?no_esc}
                        </span>
                    </#if>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="form-group">
                    <label class="form-label" for="password">Password *</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" class="form-control" name="password" 
                               placeholder="Masukkan password" autocomplete="new-password" />
                        <button type="button" class="password-toggle" onclick="togglePassword('password', 'toggleIcon1')">
                            <i class="far fa-eye" id="toggleIcon1"></i>
                        </button>
                    </div>
                    <#if messagesPerField.existsError('password')>
                        <span class="input-error" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
                    </#if>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password-confirm">Konfirmasi Password *</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password-confirm" class="form-control" 
                               name="password-confirm" placeholder="Konfirmasi password" />
                        <button type="button" class="password-toggle" onclick="togglePassword('password-confirm', 'toggleIcon2')">
                            <i class="far fa-eye" id="toggleIcon2"></i>
                        </button>
                    </div>
                    <#if messagesPerField.existsError('password-confirm')>
                        <span class="input-error" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                    </#if>
                </div>
            </#if>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    <#if messagesPerField.existsError('recaptchaResponse')>
                        <span class="input-error" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('recaptchaResponse'))?no_esc}
                        </span>
                    </#if>
                </div>
            </#if>

            <button type="submit" class="login-btn">
                <i class="fas fa-user-plus"></i> Daftar
            </button>

            <div style="margin-top: 20px; text-align: center;">
                <span style="color: #64748b;">Sudah punya akun? </span>
                <a href="${url.loginUrl}" style="color: #1976d2; font-weight: 700; text-decoration: none;">
                    Login
                </a>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>