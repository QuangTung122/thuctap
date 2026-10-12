(function () {
    const navbar = document.querySelector('.navbar');
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link, .navbar-nav .btn');

    function updateNavbar() {
        navbar.classList.toggle('scrolled', window.scrollY > 24);
    }

    window.addEventListener('scroll', updateNavbar, { passive: true });
    updateNavbar();

    navLinks.forEach((link) => {
        link.addEventListener('click', () => {
            if (window.innerWidth < 992) {
                $('.navbar-collapse').collapse('hide');
            }
        });
    });

    const goalForm = document.querySelector('#goalForm');
    const goalMessage = document.querySelector('#goalMessage');
    if (goalForm) {
        goalForm.addEventListener('submit', (event) => {
            event.preventDefault();
            const goalName = document.querySelector('#goalName').value.trim();
            goalMessage.textContent = goalName ? `Đã lưu mục tiêu “${goalName}”.` : 'Hãy nhập tên mục tiêu trước khi lưu.';
        });
    }
}());