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
    <title><?= e($title) ?></title>
    <?php foreach ($metaTags as $name => $value): ?>
        <?php if ($value !== ''): ?>
            <meta name="<?= e($name) ?>" content="<?= e($value) ?>">
        <?php endif; ?>
    <?php endforeach; ?>
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
</body>
</html>
<?php
}
