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
}());