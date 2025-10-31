<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$homeData = data_source('home', []);

render_base_layout([
    'title' => 'Beranda | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Beranda Desa Sendangan: sambutan, data singkat, dan layanan utama untuk warga.',
    'activePage' => 'home',
    'content' => static function () use ($homeData): void {
        $stats = $homeData['stats'] ?? [];
        $features = $homeData['features'] ?? [];
        $administrasi = $homeData['administrasi'] ?? [];
        $potentials = $homeData['potentials'] ?? [];
        ?>
        <section class="hero hero--full">
            <div class="hero-gradient">
                <div class="container hero-inner">
                    <div class="hero-content">
                        <span class="chip chip-light">Selamat datang di</span>
                        <h1>Website Desa Sendangan</h1>
                    </div>
                </div>
            </div>
        </section>

        <?php if ($stats !== []): ?>
            <section class="hero-stats">
                <div class="container stats-strip stats-strip--hero">
                    <?php foreach ($stats as $stat): ?>
                        <article class="stats-card">
                            <h4><?= e($stat['label'] ?? '') ?></h4>
                            <strong><?= e($stat['value'] ?? '') ?></strong>
                            <?php if (!empty($stat['note'])): ?>
                                <small><?= e($stat['note']) ?></small>
                            <?php endif; ?>
                        </article>
                    <?php endforeach; ?>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($features !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Jelajahi Desa Sendangan</h2>
                        <p>Menu utama untuk mengenal desa dan mengakses informasi layanan.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($features as $feature): ?>
                            <article class="card">
                                <h3><?= e($feature['title'] ?? '') ?></h3>
                                <p><?= e($feature['summary'] ?? '') ?></p>
                                <a class="btn btn-secondary" href="<?= e(base_uri($feature['link'] ?? '#')) ?>">
                                    Kunjungi
                                </a>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <section class="section" id="sambutan">
            <div class="container sambutan-grid">
                <div class="sambutan-photo">
                    <div class="photo-placeholder">
                        <span>Foto Hukum Tua</span>
                    </div>
                </div>
                <div class="sambutan-content">
                    <span class="chip">Sambutan Hukum Tua</span>
                    <h2>Sambutan Kepala Desa Sendangan</h2>
                    <p>
                        Puji syukur kita panjatkan kehadirat Tuhan Yang Maha Esa, berkat dan kasih-Nya Desa Sendangan terus bertumbuh
                        sebagai desa yang mandiri, rukun, dan berdaya saing. Portal ini kami hadirkan agar informasi desa dapat diakses
                        secara terbuka oleh seluruh warga.
                    </p>
                    <p>
                        Mari bersama kita jaga transparansi, partisipasi, dan semangat gotong royong demi mewujudkan Desa Sendangan yang lebih maju.
                    </p>
                    <a class="btn btn-primary" href="<?= e(base_uri('profil.php')) ?>">Profil Desa</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="section-header">
                    <h2>Peta Desa</h2>
                    <p>Segera hadir peta interaktif Desa Sendangan yang memudahkan pencarian lokasi fasilitas umum dan potensi desa.</p>
                </div>
                <div class="map-placeholder">
                    <span>Peta Desa dalam Pengembangan</span>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="section-header">
                    <h2>Struktur Organisasi</h2>
                    <p>Susunan perangkat desa dalam melayani masyarakat.</p>
                </div>
                <div class="cards-grid">
                    <article class="card">Kepala Desa</article>
                    <article class="card">Sekretaris Desa</article>
                    <article class="card">Kaur Pemerintahan</article>
                    <article class="card">Kaur Pembangunan</article>
                    <article class="card">Kaur Keuangan</article>
                    <article class="card">Kaur Umum</article>
                </div>
            </div>
        </section>

        <?php if ($administrasi !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Administrasi Penduduk</h2>
                        <p>Layanan administrasi yang tersedia untuk warga Desa Sendangan.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($administrasi as $item): ?>
                            <article class="card">
                                <h3><?= e($item['label'] ?? '') ?></h3>
                                <p><?= e($item['value'] ?? '') ?></p>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($potentials !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Potensi Desa</h2>
                        <a class="btn btn-secondary" href="<?= e(base_uri('potensi.php')) ?>">Lihat Semua Potensi</a>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($potentials as $potential): ?>
                            <article class="card">
                                <span class="chip"><?= e($potential['category'] ?? '') ?></span>
                                <h3><?= e($potential['title'] ?? '') ?></h3>
                                <?php if (!empty($potential['status'])): ?>
                                    <p>Status: <?= e($potential['status']) ?></p>
                                <?php endif; ?>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <section class="section">
            <div class="container">
                <div class="section-header">
                    <h2>Berita Terbaru</h2>
                    <a class="btn btn-primary" href="<?= e(base_uri('info_publik.php?tab=berita')) ?>">Lihat Semua Berita</a>
                </div>
                <div class="cards-grid">
                    <article class="card">
                        <span class="chip">Berita</span>
                        <h3>Pelatihan Digital untuk UMKM Sendangan</h3>
                        <p>Pemerintah desa bersama komunitas pemuda mengadakan pelatihan pemasaran digital bagi pelaku UMKM.</p>
                        <a class="btn btn-secondary" href="#">Baca Selengkapnya</a>
                    </article>
                    <article class="card">
                        <span class="chip">Pengumuman</span>
                        <h3>Jadwal Pelayanan Administrasi</h3>
                        <p>Pelayanan administrasi kependudukan tersedia setiap Selasa dan Kamis pukul 09.00-14.00 WITA.</p>
                        <a class="btn btn-secondary" href="#">Baca Selengkapnya</a>
                    </article>
                    <article class="card">
                        <span class="chip">Agenda</span>
                        <h3>Gotong Royong Bersama Warga</h3>
                        <p>Agenda bersih lingkungan dilaksanakan setiap Sabtu pekan pertama, dimulai dari Balai Desa.</p>
                        <a class="btn btn-secondary" href="#">Baca Selengkapnya</a>
                    </article>
                </div>
            </div>
        </section>
        <?php
    },
]);
