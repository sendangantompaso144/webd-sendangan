<?php

$footerLinks = navigation('footer');
$brandName = app_config('name', 'Desa Sendangan');
$currentYear = (int) date('Y');

$contactDefaults = [
    'kontak.email_desa' => app_config('contact.email', 'desa@sendangan.id'),
    'kontak.telepon_desa' => app_config('contact.phone', '+62 812-3456-7890'),
];

$contactData = data_values($contactDefaults) + $contactDefaults;

$contactEmail = (string) ($contactData['kontak.email_desa'] ?? $contactDefaults['kontak.email_desa']);
$contactPhone = (string) ($contactData['kontak.telepon_desa'] ?? $contactDefaults['kontak.telepon_desa']);
$contactPhoneHref = preg_replace('/[^0-9+]/', '', $contactPhone) ?: $contactPhone;
?>
<footer class="site-footer">
    <div class="container footer-grid">
        <div>
            <h3><?= e($brandName) ?></h3>
            <p><?= e(app_config('tagline', 'Portal Desa Sendangan')) ?></p>
            <ul class="contact-list">
                <li><?= e(app_config('contact.address', 'Sendangan, Tompaso, Minahasa')) ?></li>
                <li><a href="mailto:<?= e($contactEmail) ?>">
                    <?= e($contactEmail) ?>
                </a></li>
                <li><a href="tel:<?= e($contactPhoneHref) ?>">
                    <?= e($contactPhone) ?>
                </a></li>
            </ul>
        </div>

        <?php if ($footerLinks !== []): ?>
            <div>
                <h4>Tautan Terkait</h4>
                <ul class="footer-links">
                    <?php foreach ($footerLinks as $link): ?>
                        <li>
                            <a href="<?= e($link['href'] ?? '#') ?>" target="_blank" rel="noopener">
                                <?= e($link['label'] ?? '') ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>
    </div>

    <div class="footer-meta">
        <span>&copy; <?= $currentYear ?> <?= e($brandName) ?>. Semua hak dilindungi.</span>
    </div>
</footer>
