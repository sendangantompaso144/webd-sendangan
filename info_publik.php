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
            <section class="section">
                <div class="container">
                    <div class="cards-grid">
                        <?php foreach ($berita as $item): ?>
                            <article class="card media-card">
                                <div class="media-thumb" style="background-image: url('<?= e($item['gambar'] ?? asset('images/placeholder-news.jpg')) ?>');"></div>
                                <div>
                                    <span class="chip"><?= e($item['tanggal'] ?? '') ?></span>
                                    <h3><?= e($item['judul'] ?? '') ?></h3>
                                    <p><?= e($item['ringkasan'] ?? '') ?></p>
                                    <a class="btn btn-secondary" href="<?= e($item['tautan'] ?? '#') ?>">Baca Selengkapnya</a>
                                </div>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php elseif ($tab === 'pengumuman'): ?>
            <section class="section">
                <div class="container">
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
            <section class="section">
                <div class="container">
                    <div class="gallery-grid">
                        <?php foreach ($galeri as $item): ?>
                            <figure class="gallery-card">
                                <div class="gallery-thumb" style="background-image: url('<?= e($item['gambar'] ?? asset('images/placeholder-gallery.jpg')) ?>');"></div>
                                <figcaption><?= e($item['judul'] ?? '') ?></figcaption>
                            </figure>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>
        <?php
    },
]);

