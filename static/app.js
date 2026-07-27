// static/app.js - Interactivity & Interface Toggles

document.addEventListener('DOMContentLoaded', () => {
    // Mood selection toggles
    const moodButtons = document.querySelectorAll('.mood-btn');
    moodButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            moodButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        });
    });

    // Login Modal toggles
    const loginBtn = document.getElementById('login-toggle-btn');
    const authOverlay = document.getElementById('auth-overlay');
    const closeAuthBtn = document.getElementById('close-auth-btn');

    if (loginBtn && authOverlay) {
        loginBtn.addEventListener('click', () => {
            authOverlay.classList.remove('hidden');
            authOverlay.classList.add('flex');
        });
    }

    if (closeAuthBtn && authOverlay) {
        closeAuthBtn.addEventListener('click', () => {
            authOverlay.classList.add('hidden');
            authOverlay.classList.remove('flex');
        });
    }

    // "Find Food" button interactive loading simulation
    const findFoodBtn = document.getElementById('find-food-btn');
    const resultsSection = document.getElementById('results-section');
    const loadingState = document.getElementById('loading-state');
    const cardsContainer = document.getElementById('cards-container');

    if (findFoodBtn && resultsSection && loadingState && cardsContainer) {
        findFoodBtn.addEventListener('click', (e) => {
            e.preventDefault();
            
            // Show loading spinner
            cardsContainer.classList.add('hidden');
            loadingState.classList.remove('hidden');
            resultsSection.scrollIntoView({ behavior: 'smooth' });

            // Simulate server network latency
            setTimeout(() => {
                loadingState.classList.add('hidden');
                cardsContainer.classList.remove('hidden');
                
                // Trigger reflow for card entry animations
                const cards = cardsContainer.querySelectorAll('.glass-card');
                cards.forEach((card, index) => {
                    card.style.animation = 'none';
                    card.offsetHeight; // trigger reflow
                    card.style.animation = `fadeInSlide 0.6s cubic-bezier(0.16, 1, 0.3, 1) ${index * 0.15}s forwards`;
                });
            }, 1200);
        });
    }
});
