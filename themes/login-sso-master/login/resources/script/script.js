// Password Visibility Toggle
class PasswordToggle {
    constructor() {
        this.toggleBtn = document.getElementById('togglePassword');
        this.passwordInput = document.getElementById('password');
        this.eyeIcon = this.toggleBtn ? this.toggleBtn.querySelector('iconify-icon') : null;

        if (this.toggleBtn && this.passwordInput && this.eyeIcon) {
            this.initToggle();
        } else {
            console.warn('[v0] PasswordToggle: element(s) not found, skipping init');
        }
    }

    initToggle() {
        this.toggleBtn.addEventListener('click', (e) => this.handleToggle(e));
    }

    handleToggle(e) {
        e.preventDefault();
        const isPassword = this.passwordInput.getAttribute('type') === 'password';
        const newType = isPassword ? 'text' : 'password';
        const newIcon = isPassword ? 'mdi:eye-outline' : 'mdi:eye-off-outline';
        const ariaLabel = isPassword ? 'Hide password' : 'Show password';

        this.passwordInput.setAttribute('type', newType);
        this.eyeIcon.setAttribute('icon', newIcon);
        this.toggleBtn.setAttribute('aria-label', ariaLabel);
        this.toggleBtn.setAttribute('aria-pressed', String(isPassword)); // true ketika sedang ditampilkan
    }
}

// Form Validation
class FormValidator {
    constructor() {
        this.form = document.getElementById('signinForm');
        this.usernameInput = document.getElementById('username');
        this.passwordInput = document.getElementById('password');
        this.usernameError = document.getElementById('usernameError');
        this.passwordError = document.getElementById('passwordError');

        if (this.form && this.usernameInput && this.passwordInput && this.usernameError && this.passwordError) {
            this.initValidation();
        } else {
            console.warn('[v0] FormValidator: element(s) not found, skipping init');
        }
    }

    initValidation() {
        this.usernameInput.addEventListener('blur', () => this.validateUsername());
        this.usernameInput.addEventListener('input', () => this.clearUsernameError());
        
        this.passwordInput.addEventListener('blur', () => this.validatePassword());
        this.passwordInput.addEventListener('input', () => this.clearPasswordError());

        this.form.addEventListener('submit', (e) => this.handleSubmit(e));
    }

    validateUsername() {
        const username = this.usernameInput.value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        if (!username) {
            this.showUsernameError('Username or email is required');
            return false;
        }

        // Jika pakai email
        if (username.includes('@')) {
            if (!emailRegex.test(username)) {
                this.showUsernameError('Please enter a valid email address');
                return false;
            }
        } else {
            // Minimal 3 karakter
            if (username.length < 3) {
                this.showUsernameError('Username must be at least 3 characters');
                return false;
            }
        }

        this.clearUsernameError();
        return true;
    }

    validatePassword() {
        const password = this.passwordInput.value;
        
        if (!password) {
            this.showPasswordError('Password is required');
            return false;
        }

        if (password.length < 6) {
            this.showPasswordError('Password must be at least 6 characters');
            return false;
        }

        this.clearPasswordError();
        return true;
    }

    showUsernameError(message) {
        this.usernameError.textContent = message;
        this.usernameError.classList.add('show');
        this.usernameInput.classList.add('error');
    }

    clearUsernameError() {
        this.usernameError.classList.remove('show');
        this.usernameInput.classList.remove('error');
    }

    showPasswordError(message) {
        this.passwordError.textContent = message;
        this.passwordError.classList.add('show');
        this.passwordInput.classList.add('error');
    }

    clearPasswordError() {
        this.passwordError.classList.remove('show');
        this.passwordInput.classList.remove('error');
    }

    handleSubmit(e) {
        e.preventDefault();

        const isUsernameValid = this.validateUsername();
        const isPasswordValid = this.validatePassword();

        if (isUsernameValid && isPasswordValid) {
            this.submitForm();
        }
    }

    submitForm() {
        console.log('[v0] Form validation passed - submitting form');
        alert('Login successful! (Demo mode - validation passed)');
        
        // Reset form
        this.form.reset();
        this.clearUsernameError();
        this.clearPasswordError();
        
        // Reset password visibility
        this.passwordInput.setAttribute('type', 'password');
        const toggleBtn = document.getElementById('togglePassword');
        const eyeIcon = toggleBtn ? toggleBtn.querySelector('iconify-icon') : null;

        if (eyeIcon) {
            eyeIcon.setAttribute('icon', 'mdi:eye-off-outline'); // kembali ke "hidden"
        }
        if (toggleBtn) {
            toggleBtn.setAttribute('aria-pressed', 'false');
            toggleBtn.setAttribute('aria-label', 'Show password');
        }
    }
}

// Initialize all components when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    console.log('[v0] Initializing login page components');
    
    const passwordToggle = document.getElementById('togglePassword');
    if (passwordToggle) {
        new PasswordToggle();
    }
    
    const form = document.getElementById('signinForm');
    if (form) {
        new FormValidator();
    }

    console.log('[v0] All components initialized successfully');
});
