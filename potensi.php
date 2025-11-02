<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$potensi = data_source('potensi', []);

render_base_layout([
    'title' => 'Potensi Desa | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Potensi unggulan Desa Sendangan meliputi UMKM, destinasi wisata, serta seni dan budaya.',
    'activePage' => 'potensi',
    'content' => static function () use ($potensi): void {
        $umkm = $potensi['umkm'] ?? [];
        $wisata = $potensi['wisata'] ?? [];
        $seni = $potensi['seni'] ?? [];
        ?>
        <!-- <section class="section">
            <div class="container page-header">
                <div>
                    <span class="chip">Potensi Desa</span>
                    <h1>Potensi Unggulan Sendangan</h1>
                    <p>Kembangkan potensi lokal menuju Desa Sendangan yang berdaya dan berkelanjutan.</p>
                </div>
            </div>
        </section> -->

        <?php if ($umkm !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>UMKM Unggulan</h2>
                        <p>Pelaku usaha desa yang terus bertumbuh melalui inovasi.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($umkm as $item): ?>
                            <article class="card">
                                <h3><?= e($item['nama'] ?? '') ?></h3>
                                <p><?= e($item['deskripsi'] ?? '') ?></p>
                                <?php if (!empty($item['kontak'])): ?>
                                    <a class="btn btn-secondary" href="https://wa.me/<?= e(preg_replace('/\D+/', '', $item['kontak'])) ?>" target="_blank" rel="noopener">
                                        Hubungi
                                    </a>
                                <?php endif; ?>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($wisata !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Wisata Desa</h2>
                        <p>Destinasi wisata alam dan sejarah yang menjadi kebanggaan Desa Sendangan.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($wisata as $item): ?>
                            <article class="card">
                                <span class="chip"><?= e($item['status'] ?? 'Dalam Pengembangan') ?></span>
                                <h3><?= e($item['nama'] ?? '') ?></h3>
                                <p><?= e($item['deskripsi'] ?? '') ?></p>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($seni !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Seni & Budaya</h2>
                        <p>Pelestarian tradisi dan budaya lokal oleh komunitas Desa Sendangan.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($seni as $item): ?>
                            <article class="card">
                                <h3><?= e($item['nama'] ?? '') ?></h3>
                                <p><?= e($item['deskripsi'] ?? '') ?></p>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>
        <?php
    },
]);

