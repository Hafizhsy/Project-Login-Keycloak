<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>

    <title><#nested "header"></title>

    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>

</head>

<body>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <div class="container">
        
        <div class="left-panel">
            <div class="logo-section">
                <div class="logo-wrapper">
                    <div class="logo-circle">
                        <#-- Ganti icon dengan logo image -->
                        <img src="${url.resourcesPath}/img/logo-yogya.png" 
                             alt="Logo Pemda DIY" 
                             style="width: 110px; height: 100px; object-fit: contain;" />
                    </div>
                </div>
                <div class="site-title">SSO PEMDA DIY</div>
                <div class="site-subtitle">Single Sign-On Portal</div>
            </div>

            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="alert alert-${message.type}">
                    <#if message.type = 'success'><i class="fas fa-check-circle"></i></#if>
                    <#if message.type = 'warning'><i class="fas fa-exclamation-triangle"></i></#if>
                    <#if message.type = 'error'><i class="fas fa-times-circle"></i></#if>
                    <#if message.type = 'info'><i class="fas fa-info-circle"></i></#if>
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>

            <#-- Main Form Content dari page lain (login.ftl, register.ftl, dll) -->
            <#nested "form">
            
        </div>

        <#-- RIGHT PANEL: Info Section -->
        <div class="right-panel">
            <div class="welcome-content">
                <h1 class="welcome-title">Selamat Datang di SSO Pemda DIY</h1>
                <p class="welcome-subtitle">Hal yang harus Anda perhatikan:</p>

                <ul class="info-list">
                    <li class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="info-text">
                            Jaga kerahasiaan akun Anda dan tidak membagikan password kepada orang lain
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-key"></i>
                        </div>
                        <div class="info-text">
                            Selalu mengganti password Anda secara berkala
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <div class="info-text">
                            Pastikan menggunakan kata sandi yang unik dan mudah diingat. Gunakan kombinasi huruf besar, kecil, angka dengan minimal 12 karakter
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <div class="info-text">
                            Panduan 2FA dapat dilihat pada link berikut: <a href="#" style="color: #90caf9;">klik di sini</a>
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <div class="info-text">
                            Jika mengalami kesulitan, hubungi kami via Discord: <a href="#" style="color: #90caf9;">klik di sini</a>
                        </div>
                    </li>
                </ul>

                <div class="support-section">
                    <p class="support-text">Butuh bantuan?</p>
                    <a href="#" class="support-link">
                        <i class="fab fa-discord"></i>
                        Hubungi Support via Discord
                    </a>
                </div>
            </div>

            <div class="footer-info">
                © 2025 - Dinas Komunikasi dan Informatika Daerah Daerah Istimewa Yogyakarta
            </div>
        </div>
        
    </div>
    <script>
        function togglePassword(inputId, iconId) {
            var input = document.getElementById(inputId || 'password');
            var icon = document.getElementById(iconId || 'toggleIcon');
            
            if (input && icon) {
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.className = 'far fa-eye';
                } else {
                    input.type = 'password';
                    icon.className = 'far fa-eye-slash';
                }
            }
        }
    </script>
</body>
</html>
</#macro>