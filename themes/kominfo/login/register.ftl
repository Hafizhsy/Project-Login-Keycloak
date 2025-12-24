<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <h1 class="title">Buat Akun Baru</h1>
    <#elseif section = "form">
        <form id="kc-register-form" class="form" action="${url.registrationAction}" method="post">

            <#-- FIRST NAME -->
            <div class="input-group">
                <label for="firstName">Nama Depan</label>
                <input type="text" id="firstName" name="firstName"
                       value="${(register.formData.firstName!'')}" required>
            </div>

            <#-- LAST NAME -->
            <div class="input-group">
                <label for="lastName">Nama Belakang</label>
                <input type="text" id="lastName" name="lastName"
                       value="${(register.formData.lastName!'')}">
            </div>

            <#-- USERNAME -->
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"
                       value="${(register.formData.username!'')}" required>
            </div>

            <#-- EMAIL -->
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email"
                       value="${(register.formData.email!'')}" required>
            </div>

            <#-- PASSWORD -->
            <div class="input-group">
                <label for="password">Kata Sandi</label>
                <input type="password" id="password" name="password" required>
            </div>

            <#-- PASSWORD CONFIRM -->
            <div class="input-group">
                <label for="password-confirm">Konfirmasi Kata Sandi</label>
                <input type="password" id="password-confirm" name="password-confirm" required>
            </div>

            <button type="submit" class="btn-submit">Daftar Sekarang</button>

        </form>

        <p class="bottom-text">
            Sudah punya akun? <a href="${url.loginUrl}">Login di sini</a>
        </p>

    <#elseif section = "socialProviders">
        <#-- OPSIONAL: TOMBOL GOOGLE / APPLE -->
        <#if social.providers?has_content>
            <div class="social-login">
                <#list social.providers as p>
                    <a class="social-btn" href="${p.loginUrl}">
                        Daftar dengan ${p.displayName}
                    </a>
                </#list>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
