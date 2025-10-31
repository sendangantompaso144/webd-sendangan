<?php

/**
 * @var string $active
 */

$active ??= '';
$mainNavigation = navigation('main');
$brandLogo = app_config('branding.logo', asset('images/logo-desa.svg'));
$brandName = app_config('name', 'Desa Sendangan');
$tagline = app_config('tagline', '');
?>
<header class="site-header">
    <div class="container nav-container">
        <a class="brand" href="<?= e(base_uri('index.php')) ?>">
            <span class="brand-logo">
                <img src="<?= e($brandLogo) ?>" alt="Logo Desa <?= e($brandName) ?>">
            </span>
            <span class="brand-text">
                <strong><?= e($brandName) ?></strong>
                <?php if ($tagline !== ''): ?>
                    <small><?= e($tagline) ?></small>
                <?php endif; ?>
            </span>
        </a>

        <input type="checkbox" id="menu-toggle" class="menu-toggle" hidden>
        <label for="menu-toggle" class="menu-button" aria-label="Toggle navigation">
            <span></span>
            <span></span>
            <span></span>
        </label>

        <nav class="main-navigation">
            <ul>
                <?php foreach ($mainNavigation as $item): ?>
                    <?php
                        $isActive = $active === ($item['page'] ?? '');
                        $hasChildren = isset($item['children']) && is_array($item['children']);
                        $itemHref = base_uri($item['href'] ?? '#');
                    ?>
                    <li class="<?= $isActive ? 'active' : '' ?><?= $hasChildren ? ' has-children' : '' ?>">
                        <a href="<?= e($itemHref) ?>">
                            <?= e($item['label'] ?? '') ?>
                        </a>

                        <?php if ($hasChildren): ?>
                            <ul class="dropdown">
                                <?php foreach ($item['children'] as $child): ?>
                                    <li>
                                        <a href="<?= e(base_uri($child['href'] ?? '#')) ?>">
                                            <?= e($child['label'] ?? '') ?>
                                        </a>
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        </nav>
    </div>
</header>
