// Forgot Password Form Validation
class ForgotPasswordValidator {
    constructor() {
        this.form = document.getElementById('forgotPasswordForm');
        this.emailInput = document.getElementById('email');
        this.emailError = document.getElementById('emailError');
        this.initValidation();
    }

    initValidation() {
        this.emailInput.addEventListener('blur', () => this.validateEmail());
        this.emailInput.addEventListener('input', () => this.clearEmailError());

        this.form.addEventListener('submit', (e) => this.handleSubmit(e));
    }

    validateEmail() {
        const email = this.emailInput.value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        if (!email) {
            this.showEmailError('Email address is required');
            return false;
        }

        if (!emailRegex.test(email)) {
            this.showEmailError('Please enter a valid email address');
            return false;
        }

        this.clearEmailError();
        return true;
    }

    showEmailError(message) {
        this.emailError.textContent = message;
        this.emailError.classList.add('show');
        this.emailInput.classList.add('error');
    }

    clearEmailError() {
        this.emailError.classList.remove('show');
        this.emailInput.classList.remove('error');
    }

    handleSubmit(e) {
        e.preventDefault();

        const isEmailValid = this.validateEmail();

        if (isEmailValid) {
            this.submitForm();
        }
    }

    submitForm() {
        console.log('[v0] Forgot password form submitted');
        
        // Show success message
        const successMessage = document.createElement('div');
        successMessage.className = 'success-message';
        successMessage.innerHTML = `
            <iconify-icon icon="mdi:check-circle" width="20" height="20"></iconify-icon>
            <span>Reset link has been sent to your email!</span>
        `;
        
        const form = document.getElementById('forgotPasswordForm');
        form.insertBefore(successMessage, form.firstChild);
        
        // Reset form
        this.form.reset();
        this.clearEmailError();
        
        // Remove success message after 5 seconds
        setTimeout(() => {
            successMessage.remove();
        }, 5000);
    }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    console.log('[v0] Initializing forgot password page');
    
    const form = document.getElementById('forgotPasswordForm');
    if (form) {
        new ForgotPasswordValidator();
    }

    console.log('[v0] Forgot password page initialized');
});

