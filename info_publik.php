<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$infoPublik = data_source('info_publik', []);
$tab = strtolower((string) filter_input(INPUT_GET, 'tab', FILTER_SANITIZE_FULL_SPECIAL_CHARS));

$tabs = [
    'berita' => 'Berita Desa',
    'pengumuman' => 'Pengumuman',
    'galeri' => 'Galeri',
];

if (!array_key_exists($tab, $tabs)) {
    $tab = 'berita';
}

render_base_layout([
    'title' => $tabs[$tab] . ' | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Informasi publik Desa Sendangan: berita terbaru, pengumuman penting, dan galeri kegiatan.',
    'activePage' => 'informasi',
    'content' => static function () use ($tabs, $tab, $infoPublik): void {
        $berita = $infoPublik['berita'] ?? [];
        $pengumuman = $infoPublik['pengumuman'] ?? [];
        $galeri = $infoPublik['galeri'] ?? [];
        ?>
        <section class="section">
            <div class="container page-header">
                <div>
                    <span class="chip">Informasi Publik</span>
                    <h1><?= e($tabs[$tab]) ?></h1>
                    <p>Pusat informasi resmi Desa Sendangan untuk warga dan masyarakat umum.</p>
                </div>
            </div>

            <div class="container tab-nav">
                <?php foreach ($tabs as $key => $label): ?>
                    <a class="<?= $tab === $key ? 'active' : '' ?>"
                       href="<?= e(base_uri('info_publik.php?tab=' . $key)) ?>">
                        <?= e($label) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        </section>

        <?php if ($tab === 'berita'): ?>
            <section class="section section-info-content">
                <div class="container info-content">
                    <div class="news-grid">
                        <?php foreach ($berita as $item): ?>
                            <?php
                            $beritaJudul = (string) ($item['judul'] ?? '');
                            $beritaRingkasan = (string) ($item['ringkasan'] ?? '');
                            $excerpt = mb_substr(trim(strip_tags($beritaRingkasan)), 0, 160);
                            if (mb_strlen($beritaRingkasan) > 160) {
                                $excerpt .= '...';
                            }
                            $beritaTanggal = (string) ($item['tanggal'] ?? '');
                            $beritaTautan = (string) ($item['tautan'] ?? '#');
                            $beritaViews = isset($item['berita_dilihat']) ? (int) $item['berita_dilihat'] : 0;
                            ?>
                            <article class="news-card">
                                <?php if (!empty($item['gambar'])): ?>
                                    <div class="news-card-image">
                                        <img src="<?= e((string) $item['gambar']) ?>" alt="<?= e($beritaJudul === '' ? 'Berita Desa' : $beritaJudul) ?>">
                                    </div>
                                <?php endif; ?>
                                <div class="news-card-content">
                                    <div class="news-meta">
                                        <span class="news-views"><?= e(number_format($beritaViews)) ?> kali dibaca</span>
                                        <?php if ($beritaTanggal !== ''): ?>
                                            <span class="news-date"><?= e($beritaTanggal) ?></span>
                                        <?php endif; ?>
                                    </div>
                                    <h3 class="news-title"><?= e($beritaJudul) ?></h3>
                                    <p class="news-excerpt"><?= e($excerpt) ?></p>
                                    <a class="news-link" href="<?= e($beritaTautan) ?>">
                                        Baca Selengkapnya &rarr;
                                    </a>
                                </div>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php elseif ($tab === 'pengumuman'): ?>
            <section class="section section-info-content">
                <div class="container info-content">
                    <ul class="announcement-list">
                        <?php foreach ($pengumuman as $item): ?>
                            <li>
                                <div>
                                    <strong><?= e($item['judul'] ?? '') ?></strong>
                                    <span><?= e($item['tanggal'] ?? '') ?></span>
                                </div>
                                <a class="btn btn-secondary" href="<?= e($item['tautan'] ?? '#') ?>">Detail</a>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            </section>
        <?php elseif ($tab === 'galeri'): ?>
            <section class="section section-info-content">
                <div class="container info-content">
                    <div class="gallery-grid gallery-grid--plain">
                        <?php foreach ($galeri as $item): ?>
                            <?php
                            $galleryCaption = (string) ($item['galeri_keterangan'] ?? $item['judul'] ?? '');
                            $galleryImage = (string) ($item['gambar'] ?? asset('images/placeholder-gallery.jpg'));
                            ?>
                            <figure class="gallery-plain-card">
                                <img src="<?= e($galleryImage) ?>" alt="<?= e($galleryCaption !== '' ? $galleryCaption : 'Galeri Desa Sendangan') ?>">
                                <?php if ($galleryCaption !== ''): ?>
                                    <figcaption><?= e($galleryCaption) ?></figcaption>
                                <?php endif; ?>
                            </figure>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>
        <?php
    },
]);
