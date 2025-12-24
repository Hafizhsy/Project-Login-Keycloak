<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div class="container">
        <!-- Left Section -->
        <div class="left-section">
            <div class="slider-container">
                <div class="slider-content">
                    <!-- Slide 1 -->
                    <div class="slide">
                        <div class="illustration-container">
                            <img src="${url.resourcesPath}/img/slide-1.png" alt="Welcome SSO" class="slide-image"/>
                        </div>
                        <h1 class="sso-title">Selamat Datang di SSO Pemda DIY</h1>
                        <p class="sso-description">
                            Dapatkan akses semua layanan dalam aplikasi hanya dengan satu kali login
                        </p>
                    </div>

                    <!-- Slide 2 -->
                    <div class="slide">
                        <div class="illustration-container">
                            <img src="${url.resourcesPath}/img/slide-2.png" alt="Bantuan Login" class="slide-image"/>
                        </div>
                        <h1 class="sso-title">Bantuan Login</h1>
                        <p class="sso-description">
                            Jika Anda mengalamai kesulitan dalam proses login atau membutuhkan bantuan teknis lainya, silahkan hubungi tim dukungan kami via discord atau WhatsApp
                        </p>
                    </div>

                    <!-- Slide 3 -->
                    <div class="slide">
                        <div class="illustration-container">
                            <img src="${url.resourcesPath}/img/slide-3.png" alt="Keamanan Akun" class="slide-image"/>
                        </div>
                        <h1 class="sso-title">Keamanan Akun</h1>
                        <p class="sso-description">
                            Jangan pernah membagikan username dan password SSO kepada orang lain. Selalu pastikan Anda login di domain akun anda
                        </p>
                    </div>

                    <!-- Slide 4 -->
                    <div class="slide">
                        <div class="illustration-container">
                            <img src="${url.resourcesPath}/img/slide-4.png" alt="Pembaruan 2FA" class="slide-image"/>
                        </div>
                        <h1 class="sso-title">Pembaruan 2FA</h1>
                        <p class="sso-description">
                            Pastikan Anda mengupdate 2FA setiap kali login untuk meningkatkan keamanan akun anda
                        </p>
                    </div> 
                </div>
            </div>
            
            <div class="dots">
                <div class="dot active" onclick="goToSlide(0)"></div>
                <div class="dot" onclick="goToSlide(1)"></div>
                <div class="dot" onclick="goToSlide(2)"></div>
                <div class="dot" onclick="goToSlide(3)"></div>
            </div>
        </div>

        <!-- Right Section -->
        <div class="right-section">
            <div class="login-card">
                <div class="login-header">
                    <h1>SSO PEMDA DIY</h1>
                    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <p>Belum punya akun? <a href="${url.registrationUrl}">Registrasi</a></p>
                    </#if>
                </div>

                <!-- Logo Section -->
                <div class="logo-section">
                    <img src="${url.resourcesPath}/img/pemprov_jogja.png" alt="Logo SSO Pemda DIY" class="login-logo" />
                    <p class="logo-subtitle">Single Sign-On Pemerintah Daerah DIY</p>
                </div>

                <#if messagesPerField.existsError('username','password')>
                    <div class="alert alert-error">
                        <span class="alert-icon">✕</span>
                        <span class="kc-feedback-text">${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}</span>
                    </div>
                </#if>

                <div id="kc-form">
                    <div id="kc-form-wrapper">
                        <#if realm.password>
                            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                <div class="form-group">
                                    <label for="username">
                                        <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>Username<#else>${msg("email")}</#if>
                                    </label>

                                    <input 
                                        tabindex="1" 
                                        id="username" 
                                        name="username" 
                                        value="${(login.username!'')}" 
                                        type="text" 
                                        autofocus 
                                        autocomplete="off"
                                        placeholder="Masukkan username"
                                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                    />
                                </div>

                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <div class="password-group">
                                        <input 
                                            tabindex="2" 
                                            id="password" 
                                            name="password" 
                                            type="password" 
                                            autocomplete="off"
                                            placeholder="Masukkan password"
                                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                        />
                                        <span class="password-toggle" onclick="togglePassword()"></span>
                                    </div>
                                    <#if realm.resetPasswordAllowed>
                                        <div class="forgot-password">
                                            <a tabindex="5" href="${url.loginResetCredentialsUrl}">Lupa kata sandi?</a>
                                        </div>
                                    </#if>
                                </div>

                                <#if realm.rememberMe && !usernameEditDisabled??>
                                    <div class="form-group checkbox-group">
                                        <label>
                                            <input 
                                                tabindex="3" 
                                                id="rememberMe" 
                                                name="rememberMe" 
                                                type="checkbox"
                                                <#if login.rememberMe??>checked</#if>
                                            /> 
                                            Ingat saya
                                        </label>
                                    </div>
                                </#if>

                                <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                                <button tabindex="4" name="login" id="kc-login" type="submit" class="login-btn">
                                    Sign in
                                </button>
                            </form>
                        </#if>
                    </div>
                </div>

                <#if realm.password && social.providers??>
                    <div class="sso-buttons">
                        <#list social.providers as p>
                            <#if p.providerId == "google">
                                <a id="social-${p.alias}" href="${p.loginUrl}" class="sso-btn google">
                                    <svg width="20" height="20" viewBox="0 0 24 24">
                                        <path fill="#4285f4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                                        <path fill="#34a853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                                        <path fill="#fbbc05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                                        <path fill="#ea4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                                    </svg>
                                    Masuk dengan Google
                                </a>
                            <#elseif p.providerId == "apple">
                                <a id="social-${p.alias}" href="${p.loginUrl}" class="sso-btn apple">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="white">
                                        <path d="M17.05 20.28c-.98.95-2.05.88-3.08.4-1.09-.5-2.08-.48-3.24 0-1.44.62-2.2.44-3.06-.4C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/>
                                    </svg>
                                    Masuk dengan Apple
                                </a>
                            <#else>
                                <a id="social-${p.alias}" href="${p.loginUrl}" class="sso-btn">
                                    <#if p.iconClasses?has_content>
                                        <i class="${p.iconClasses!}" aria-hidden="true"></i>
                                    </#if>
                                    <span>Masuk dengan ${p.displayName!}</span>
                                </a>
                            </#if>
                        </#list>
                    </div>
                </#if>

                <!-- Footer -->
                <div class="footer-section">
                    <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                        <div class="language-selector-wrapper">
                            <select class="language-selector" onchange="window.location.href=this.value">
                                <#list locale.supported as l>
                                    <option value="${l.url}" <#if locale.currentLanguageTag == l.label>selected</#if>>${l.label}</option>
                                </#list>
                            </select>
                        </div>
                    <#else>
                        <select class="language-selector">
                            <option value="id">Indonesia</option>
                        </select>
                    </#if>
                    <a href="#bantuan" class="help-link">Perlu Bantuan?</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        let currentSlide = 0;
        const totalSlides = 4;

        function goToSlide(index) {
            currentSlide = index;
            const sliderContent = document.querySelector('.slider-content');
            if (sliderContent) {
                sliderContent.style.transform = 'translateX(-' + (currentSlide * 100) + '%)';
                
                const dots = document.querySelectorAll('.dot');
                dots.forEach(function(dot, i) {
                    if (i === currentSlide) {
                        dot.classList.add('active');
                    } else {
                        dot.classList.remove('active');
                    }
                });
            }
        }

        setInterval(function() {
            currentSlide = (currentSlide + 1) % totalSlides;
            goToSlide(currentSlide);
        }, 5000);

        function togglePassword() {
            const passwordInput = document.getElementById('password');
            if (passwordInput) {
                const type = passwordInput.type === 'password' ? 'text' : 'password';
                passwordInput.type = type;
            }
        }
    </script>
    </#if>
</@layout.registrationLayout>