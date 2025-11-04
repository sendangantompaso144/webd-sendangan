<?php

$footerLinks  = navigation('footer');
$brandName    = app_config('name', 'Desa Sendangan');
$currentYear  = (int) date('Y');

$contactDefaults = [
    'kontak.email_desa'   => app_config('contact.email', 'desa@sendangan.id'),
    'kontak.telepon_desa' => app_config('contact.phone', '+62 812-3456-7890'),
];
$contactData   = data_values($contactDefaults) + $contactDefaults;
$contactEmail  = (string) ($contactData['kontak.email_desa'] ?? $contactDefaults['kontak.email_desa']);
$contactPhone  = (string) ($contactData['kontak.telepon_desa'] ?? $contactDefaults['kontak.telepon_desa']);
$contactPhoneHref = preg_replace('/[^0-9+]/', '', $contactPhone) ?: $contactPhone;

$creditDefaults = [
    'credit.program'    => 'Program Kerja KKT 144',
    'credit.tim'        => '',
    // 'credit.tahun'      => (string) $currentYear,
    'credit.tahun'      => '2025',
    'credit.link_label' => 'UNSRAT',
    'credit.link_url'   => 'https://www.unsrat.ac.id/',
];
$credit = data_values($creditDefaults) + $creditDefaults;

?>
<footer class="site-footer">
    <div class="container footer-grid">
        <div>
            <h3><?= e($brandName) ?></h3>
            <p><?= e(app_config('tagline', 'Portal Desa Sendangan')) ?></p>
            <ul class="contact-list">
                <li><?= e(app_config('contact.address', 'Sendangan, Tompaso, Minahasa')) ?></li>
                <li><a href="mailto:<?= e($contactEmail) ?>"><?= e($contactEmail) ?></a></li>
                <li><a href="tel:<?= e($contactPhoneHref) ?>"><?= e($contactPhone) ?></a></li>
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

    <!-- Bungkus meta footer dengan .container agar lebarnya sama -->
    <div class="container">
        <div class="footer-meta">
            <span>&copy; <?= $currentYear ?> <?= e($brandName) ?>. Semua hak dilindungi.</span>

            <span class="footer-sep" aria-hidden="true">•</span>

            <small class="footer-credit">
                <?= e($credit['credit.program']) ?> —
                <?= e($credit['credit.tim']) ?> <?= e($credit['credit.tahun']) ?>,
                <a href="<?= e($credit['credit.link_url']) ?>" target="_blank" rel="noopener">
                    <?= e($credit['credit.link_label']) ?>
                </a>
            </small>

            <span class="footer-sep" aria-hidden="true">•</span>

            <a href="admin.php" class="admin-link" rel="nofollow noopener" aria-label="Masuk Panel Admin">Admin</a>
        </div>
    </div>
</footer>

<style>
.site-footer .footer-meta{
    display:flex; flex-wrap:wrap; gap:.5rem .75rem; align-items:center;
    justify-content:space-between; padding:14px 0; font-size:.9rem; color:#64748b;
    border-top:1px solid rgba(100,116,139,.2);
}
.site-footer .footer-meta .footer-credit{ opacity:.9; }
.site-footer .footer-meta .footer-sep{ opacity:.35; margin:0 .25rem; }
.site-footer .admin-link{
    font-size:.9rem; opacity:.75; text-decoration:none;
}
.site-footer .admin-link:hover{ opacity:1; text-decoration:underline; }
@media (max-width:640px){
  .site-footer .footer-meta{ flex-direction:column; align-items:flex-start; gap:.4rem; }
  .site-footer .footer-sep{ display:none; }
}
</style>
