<?php

declare(strict_types=1);

require_once __DIR__ . '/../app/bootstrap.php';

/**
 * @param array{
 *     title?: string,
 *     description?: string,
 *     bodyClass?: string,
 *     activePage?: string,
 *     content?: callable|string,
 *     styles?: array<int, string>,
 *     scripts?: array<int, string>,
 *     meta?: array<string, string>
 * } $options
 */
function render_base_layout(array $options = []): void
{
    $title = $options['title'] ?? app_config('name', 'Desa Sendangan');
    $description = $options['description'] ?? app_config('meta.description', '');
    $bodyClass = $options['bodyClass'] ?? '';
    $activePage = $options['activePage'] ?? '';
    $content = $options['content'] ?? '';
    $styles = $options['styles'] ?? [];
    $scripts = $options['scripts'] ?? [];
    $meta = $options['meta'] ?? [];

    $styles = array_merge([asset('css/main.css')], $styles);
    $metaTags = array_merge([
        'description' => $description,
    ], $meta);

    ob_start();
    if (is_callable($content)) {
        $result = $content();
        $buffer = ob_get_clean();
        $pageContent = $buffer !== '' ? $buffer : (string) $result;
    } else {
        $pageContent = (string) $content;
    }

    $fontsUrl = 'https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Inter:wght@400;500;600;700&family=Poppins:wght@500;600;700&display=swap';

    ?><!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Open Graph (Facebook, WhatsApp, LinkedIn, dsb.) -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="Desa Sendangan">
    <meta property="og:description" content="Pusat informasi resmi Desa Sendangan">
    <meta property="og:url" content="https://sendangantompaso.web.id">
    <meta property="og:image" content="https://sendangantompaso.web.id/assets/images/favicon.ico">
    <meta property="og:site_name" content="Desa Sendangan">
    <title><?= e($title) ?></title>
    <?php foreach ($metaTags as $name => $value): ?>
        <?php if ($value !== ''): ?>
            <meta name="<?= e($name) ?>" content="<?= e($value) ?>">
        <?php endif; ?>
    <?php endforeach; ?>
    <link rel="icon" type="image/x-icon" href="assets/images/favicon.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="<?= e($fontsUrl) ?>">
    <?php foreach ($styles as $href): ?>
        <link rel="stylesheet" href="<?= e($href) ?>">
    <?php endforeach; ?>
</head>
<body class="<?= e($bodyClass) ?>">
    <?= render_component('Navbar', ['active' => $activePage]) ?>

    <main>
        <?= $pageContent ?>
    </main>

    <?= render_component('Footer') ?>

    <?php foreach ($scripts as $script): ?>
        <script src="<?= e($script) ?>" defer></script>
    <?php endforeach; ?>
    <script>
        (function () {
            var body = document.body;
            if (!body || !body.classList.contains('page-home')) {
                return;
            }

            var header = document.querySelector('.site-header');
            if (!header) {
                return;
            }

            var updateHeaderState = function () {
                if (window.scrollY > 3) {
                    header.classList.add('is-scrolled');
                } else {
                    header.classList.remove('is-scrolled');
                }
            };

            updateHeaderState();
            window.addEventListener('scroll', updateHeaderState, { passive: true });
        })();
    </script>
    <script>
        // Navbar Mobile Enhancement
(function() {
    'use strict';

    const menuToggle = document.getElementById('menu-toggle');
    const body = document.body;

    if (!menuToggle) return;

    // 1. Fallback untuk browser yang tidak support :has()
    menuToggle.addEventListener('change', function() {
        if (this.checked) {
            body.classList.add('menu-open');
        } else {
            body.classList.remove('menu-open');
        }
    });

    // 2. Tutup menu saat user scroll (opsional - hapus jika tidak diinginkan)
    // let scrollTimeout;
    // window.addEventListener('scroll', function() {
    //     if (!menuToggle.checked) return;

    //     clearTimeout(scrollTimeout);
    //     scrollTimeout = setTimeout(function() {
    //         menuToggle.checked = false;
    //         body.classList.remove('menu-open');
    //     }, 150);
    // }, { passive: true });

    // 3. Tutup menu saat klik link (agar smooth scroll bekerja)
    const navLinks = document.querySelectorAll('.main-navigation a');
    navLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            menuToggle.checked = false;
            body.classList.remove('menu-open');
        });
    });

    // 4. Tutup menu saat klik overlay
    const navigation = document.querySelector('.main-navigation');
    if (navigation) {
        navigation.addEventListener('click', function(e) {
            // Jika klik di area overlay (pseudo-element ::before)
            if (e.target === navigation && menuToggle.checked) {
                menuToggle.checked = false;
                body.classList.remove('menu-open');
            }
        });
    }

    // 5. Tutup menu dengan tombol ESC
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && menuToggle.checked) {
            menuToggle.checked = false;
            body.classList.remove('menu-open');
        }
    });

})();
    </script>
    <script>
        // Navbar Mobile Enhancement
(function() {
    'use strict';

    const menuToggle = document.getElementById('menu-toggle');
    const body = document.body;
    const navigation = document.querySelector('.main-navigation');

    if (!menuToggle) return;

    // 1. Fallback untuk browser yang tidak support :has()
    menuToggle.addEventListener('change', function() {
        if (this.checked) {
            body.classList.add('menu-open');
        } else {
            body.classList.remove('menu-open');
        }
    });

    // 2. Handle klik pada tombol close (pseudo-element ::after)
    if (navigation) {
        navigation.addEventListener('click', function(e) {
            const rect = navigation.getBoundingClientRect();
            const closeButtonArea = {
                top: 10,
                right: 10,
                width: 54,
                height: 54
            };

            // Check if click is in close button area (top-right corner)
            const clickX = e.clientX - rect.left;
            const clickY = e.clientY - rect.top;
            
            if (
                clickX > rect.width - closeButtonArea.right - closeButtonArea.width &&
                clickX < rect.width - closeButtonArea.right &&
                clickY > closeButtonArea.top &&
                clickY < closeButtonArea.top + closeButtonArea.height
            ) {
                menuToggle.checked = false;
                body.classList.remove('menu-open');
                return;
            }

            // Klik di overlay (area hitam transparan)
            if (e.target === navigation && menuToggle.checked) {
                menuToggle.checked = false;
                body.classList.remove('menu-open');
            }
        });
    }

    // 3. Tutup menu saat klik link menu
    const navLinks = document.querySelectorAll('.main-navigation a');
    navLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            // Delay sedikit agar smooth scroll bisa bekerja
            setTimeout(function() {
                menuToggle.checked = false;
                body.classList.remove('menu-open');
            }, 100);
        });
    });

    // 4. Tutup menu dengan tombol ESC
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && menuToggle.checked) {
            menuToggle.checked = false;
            body.classList.remove('menu-open');
        }
    });

    // 5. Cegah scroll propagation pada sidebar
    if (navigation) {
        navigation.addEventListener('touchmove', function(e) {
            // Allow scroll dalam sidebar
            e.stopPropagation();
        }, { passive: true });
    }

    // 6. Tutup menu saat orientasi berubah
    window.addEventListener('orientationchange', function() {
        if (menuToggle.checked) {
            menuToggle.checked = false;
            body.classList.remove('menu-open');
        }
    });

    // 7. Auto-close saat resize ke desktop
    let resizeTimeout;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(function() {
            if (window.innerWidth > 960 && menuToggle.checked) {
                menuToggle.checked = false;
                body.classList.remove('menu-open');
            }
        }, 150);
    });

})();
    </script>
</body>
</html>
<?php
}
