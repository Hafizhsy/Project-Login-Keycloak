<#macro registrationLayout
    displayMessage = false
    showAnotherWayIfPresent = true
    bodyClass=""
>
<!DOCTYPE html>
<html lang="${locale!'id'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <#if title??>
            ${title}
        <#elseif msg?? && msg("loginTitle")??>
            ${msg("loginTitle")}
        <#else>
            SSO Pemda DIY
        </#if>
    </title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
    
    <!-- Iconify -->
    <script src="https://code.iconify.design/iconify-icon/1.0.8/iconify-icon.min.js"></script>
</head>

<body class="${bodyClass}" data-realm="${realm.name}">
    
    <!-- Error/Success Messages -->
    <#if displayMessage && message?has_content>
        <div class="alert-wrapper alert-${message.type}">
            <div class="kc-feedback-text">
                <#if message.type == 'success'>
                    <iconify-icon icon="mdi:check-circle" class="alert-icon"></iconify-icon>
                <#elseif message.type == 'warning'>
                    <iconify-icon icon="mdi:alert" class="alert-icon"></iconify-icon>
                <#elseif message.type == 'error'>
                    <iconify-icon icon="mdi:alert-circle" class="alert-icon"></iconify-icon>
                <#elseif message.type == 'info'>
                    <iconify-icon icon="mdi:information" class="alert-icon"></iconify-icon>
                </#if>
                <span class="${message.type}-message">${kcSanitize(message.summary)?no_esc}</span>
            </div>
        </div>
    </#if>

    <!-- Main Content -->
    <#nested>

    <!-- Scripts -->
    <script src="${url.resourcesPath}/script/script.js"></script>
    <script src="${url.resourcesPath}/script/carousel.js"></script>
    
    <!-- QR Code Library & Script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    <script src="${url.resourcesPath}/script/qr-login.js"></script>
</body>
</html>
</#macro>