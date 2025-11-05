<?php

/**
 * @var string $active
 */

$active ??= '';
$mainNavigation = navigation('main');
$brandName = app_config('name', 'Desa Sendangan');
$tagline = app_config('tagline', '');
$logoMinahasa = asset('images/logo-minahasa.png');
$logoUnsrat = asset('images/logo-unsrat.png');
?>
<header class="site-header">
    <div class="container nav-container">
        <a class="brand" href="<?= e(base_uri('index.php')) ?>">
            <span
                class="brand-logo-group"
                data-tooltip="Kolaborasi Pemerintah Desa Sendangan dan KKT 144 Universitas Sam Ratulangi"
            >
                <span class="brand-logo logo2">
                    <img src="<?= e($logoUnsrat) ?>" alt="Logo Universitas Sam Ratulangi">
                </span>
                <span class="brand-logo logo1">
                    <img src="<?= e($logoMinahasa) ?>" alt="Logo Pemerintah Kabupaten Minahasa">
                </span>
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
                        $isInfoPublik = strtolower($item['label'] ?? '') === 'informasi publik';
                    ?>
                    <li class="<?= $isActive ? 'active' : '' ?><?= $hasChildren ? ' has-children' : '' ?>">
                        <a href="<?= e($itemHref) ?>">
                            <?= e($item['label'] ?? '') ?>
                        </a>

                        <?php if ($hasChildren): ?>
                            <ul class="dropdown<?= $isInfoPublik ? ' dropdown--info-publik' : '' ?>">
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
