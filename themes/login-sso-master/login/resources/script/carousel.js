// Carousel Management
class Carousel {
    constructor(container) {
        this.container = container;
        this.slides = Array.from(container.querySelectorAll('.carousel-slide'));
        this.indicators = Array.from(container.querySelectorAll('.carousel-indicators .indicator'));
        this.currentSlide = 0;
        this.autoPlayInterval = null;
        this.init();
    }

    init() {
        if (!this.slides || this.slides.length === 0) {
            console.warn('[v0] Carousel: no slides found in container, skipping init');
            return;
        }

        this.setupIndicators();
        this.setupSlideInteractions();

        if (this.slides.length > 1) {
            this.startAutoPlay();

            this.container.addEventListener('mouseenter', () => this.stopAutoPlay());
            this.container.addEventListener('mouseleave', () => this.startAutoPlay());
        } else {
            const indicatorsContainer = this.container.querySelector('.carousel-indicators');
            if (indicatorsContainer) {
                indicatorsContainer.style.display = 'none';
            }
        }
    }

    setupIndicators() {
        this.indicators.forEach((indicator, index) => {
            indicator.setAttribute('role', 'button');
            indicator.setAttribute('tabindex', '0');
            indicator.addEventListener('click', () => {
                this.goToSlide(index);
                this.restartAutoPlay();
            });
            indicator.addEventListener('keydown', (event) => {
                if (event.key === 'Enter' || event.key === ' ') {
                    event.preventDefault();
                    this.goToSlide(index);
                    this.restartAutoPlay();
                }
            });
        });
    }

    setupSlideInteractions() {
        this.slides.forEach((slide, index) => {
            slide.dataset.slideIndex = index;
            const title = slide.querySelector('.sso-help-title');
            if (title) {
                slide.setAttribute('aria-label', title.textContent.trim());
            }
            slide.setAttribute('role', 'button');
            slide.setAttribute('tabindex', index === this.currentSlide ? '0' : '-1');
            slide.setAttribute('aria-hidden', index === this.currentSlide ? 'false' : 'true');

            slide.addEventListener('click', () => {
                this.nextSlide();
                this.restartAutoPlay();
            });

            slide.addEventListener('keydown', (event) => {
                if (event.key === 'Enter' || event.key === ' ') {
                    event.preventDefault();
                    this.nextSlide();
                    this.restartAutoPlay();
                }
            });
        });
    }

    updateSlideAccessibility() {
        this.slides.forEach((slide, index) => {
            const isActive = index === this.currentSlide;
            slide.setAttribute('tabindex', isActive ? '0' : '-1');
            slide.setAttribute('aria-hidden', isActive ? 'false' : 'true');
        });
    }

    goToSlide(index) {
        if (index === this.currentSlide || index < 0 || index >= this.slides.length) return;

        this.slides[this.currentSlide].classList.remove('active');
        if (this.indicators[this.currentSlide]) {
            this.indicators[this.currentSlide].classList.remove('active');
        }

        if (index < this.currentSlide) {
            this.slides[this.currentSlide].classList.add('prev');
        } else {
            this.slides[this.currentSlide].classList.remove('prev');
        }

        this.currentSlide = index;

        this.slides[this.currentSlide].classList.add('active');
        this.slides[this.currentSlide].classList.remove('prev');
        if (this.indicators[this.currentSlide]) {
            this.indicators[this.currentSlide].classList.add('active');
        }

        this.updateSlideAccessibility();

        const activeSlide = this.slides[this.currentSlide];
        const slideIcon = activeSlide.querySelector('.slide-icon, .bantuan-icon');
        if (slideIcon) {
            slideIcon.style.animation = 'none';
            setTimeout(() => {
                slideIcon.style.animation = '';
            }, 10);
        }
    }

    nextSlide() {
        const next = (this.currentSlide + 1) % this.slides.length;
        this.goToSlide(next);
    }

    prevSlide() {
        const prev = (this.currentSlide - 1 + this.slides.length) % this.slides.length;
        this.goToSlide(prev);
    }

    startAutoPlay() {
        if (this.slides.length <= 1 || this.autoPlayInterval) return;
        this.autoPlayInterval = setInterval(() => {
            this.nextSlide();
        }, 5000);
    }

    restartAutoPlay() {
        if (this.slides.length <= 1) return;
        this.stopAutoPlay();
        this.startAutoPlay();
    }

    stopAutoPlay() {
        if (this.autoPlayInterval) {
            clearInterval(this.autoPlayInterval);
            this.autoPlayInterval = null;
        }
    }
}

// Initialize carousel when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    const carouselContainers = document.querySelectorAll('.carousel-container');
    if (!carouselContainers.length) {
        console.warn('[v0] Carousel: no containers found on this page');
        return;
    }

    carouselContainers.forEach((container) => new Carousel(container));
});
