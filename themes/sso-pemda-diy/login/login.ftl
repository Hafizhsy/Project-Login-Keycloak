<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password'); section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" 
                  action="${url.loginAction}" method="post" class="login-form">
        
                <div class="form-group">
                    <label for="username" class="form-label">
                        <#if !realm.loginWithEmailAllowed>${msg("username")}
                        <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
                        <#else>${msg("email")}</#if>
                    </label>

                    <div class="input-wrapper">
                        <i class="fas fa-user input-icon"></i>
                        <input tabindex="1" id="username" class="form-control" name="username" 
                               value="${(login.username!'')}" type="text" autofocus autocomplete="off"
                               placeholder="Masukkan username atau email"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                    </div>

                    <#if messagesPerField.existsError('username','password')>
                        <span class="input-error" aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                    </#if>
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">${msg("password")}</label>
                    
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input tabindex="2" id="password" class="form-control" name="password" 
                               type="password" autocomplete="off" placeholder="Masukkan password"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                        <button type="button" class="password-toggle" onclick="togglePassword('password', 'toggleIcon')">
                            <i class="far fa-eye-slash" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>

                <#-- Remember Me & Forgot Password -->
                <div class="form-footer">
                    <div class="remember-wrapper">
                        <#if realm.rememberMe && !usernameHidden??>
                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" 
                                   <#if login.rememberMe??>checked</#if> />
                            <label for="rememberMe" class="remember-label">${msg("rememberMe")}</label>
                        </#if>
                    </div>
                    
                    <#if realm.resetPasswordAllowed>
                        <a tabindex="5" href="${url.loginResetCredentialsUrl}" class="forgot-link">
                            ${msg("doForgotPassword")}
                        </a>
                    </#if>
                </div>

                <#-- Hidden Input for Credential -->
                <input type="hidden" id="id-hidden-input" name="credentialId" 
                       <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if> />

                <#-- Login Button -->
                <button tabindex="4" class="login-btn" name="login" id="kc-login" type="submit">
                    <i class="fas fa-sign-in-alt"></i> ${msg("doLogIn")}
                </button>

                <#-- Registration Link -->
                <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                    <div id="kc-registration">
                        <span>Belum punya akun? </span>
                        <a tabindex="6" href="${url.registrationUrl}">
                            ${msg("doRegister")}
                        </a>
                    </div>
                </#if>
            </form>
        </#if>
        
         <#if realm.password && social.providers??>
            <div class="social-divider">
                <span>masuk dengan</span>
            </div>

            <div class="social-login-container">
                <#list social.providers as p>
                    <a id="social-${p.alias}" 
                       class="social-btn social-btn-${p.alias}" 
                       href="${p.loginUrl}"
                       tabindex="7">
                        <#if p.alias == "google">
                            <svg width="18" height="18" viewBox="0 0 18 18" xmlns="http://www.w3.org/2000/svg">
                                <path fill="#4285F4" d="M17.64 9.2c0-.637-.057-1.251-.164-1.84H9v3.481h4.844c-.209 1.125-.843 2.078-1.796 2.717v2.258h2.908c1.702-1.567 2.684-3.874 2.684-6.615z"/>
                                <path fill="#34A853" d="M9.003 18c2.43 0 4.467-.806 5.956-2.18L12.05 13.56c-.806.54-1.836.86-3.047.86-2.344 0-4.328-1.584-5.036-3.711H.96v2.332C2.438 15.983 5.482 18 9.003 18z"/>
                                <path fill="#FBBC05" d="M3.964 10.712c-.18-.54-.282-1.117-.282-1.71 0-.593.102-1.17.282-1.71V4.96H.957C.347 6.175 0 7.55 0 9.002c0 1.452.348 2.827.957 4.042l3.007-2.332z"/>
                                <path fill="#EA4335" d="M9.003 3.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C13.464.891 11.428 0 9.002 0 5.482 0 2.438 2.017.96 4.958L3.967 7.29c.708-2.127 2.692-3.71 5.036-3.71z"/>
                            </svg>
                        <#elseif p.alias == "facebook">
                            <i class="fab fa-facebook"></i>
                        <#elseif p.alias == "github">
                            <i class="fab fa-github"></i>
                        <#elseif p.alias == "microsoft">
                            <i class="fab fa-microsoft"></i>
                        <#else>
                            <i class="fas fa-sign-in-alt"></i>
                        </#if>
                        <span>Masuk dengan ${p.displayName!}</span>
                    </a>
                </#list>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>