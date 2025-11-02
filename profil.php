<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$profil = data_source('profil', []);

render_base_layout([
    'title' => 'Profil Desa | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Profil Desa Sendangan mencakup sejarah desa, demografi, fasilitas, dan program strategis.',
    'activePage' => 'profil',
    'content' => static function () use ($profil): void {
        $sejarah = $profil['sejarah'] ?? [];
        $demografi = $profil['demografi'] ?? [];
        $fasilitas = $profil['fasilitas'] ?? [];
        $program = $profil['program'] ?? [];
        ?>
        <!-- <section class="section">
            <div class="container page-header">
                <div>
                    <span class="chip">Profil Desa</span>
                    <h1>Desa Sendangan</h1>
                    <p>Informasi lengkap mengenai karakter dan potensi Desa Sendangan.</p>
                </div>
            </div>
        </section> -->

        <?php if ($sejarah !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Sejarah Desa</h2>
                        <p>Perjalanan Desa Sendangan dari masa ke masa.</p>
                    </div>
                    <div class="timeline">
                        <?php foreach ($sejarah as $entry): ?>
                            <div class="timeline-item">
                                <div class="timeline-point"></div>
                                <p><?= e($entry) ?></p>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($demografi !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Peta dan Demografi</h2>
                        <p>Gambaran umum wilayah dan komposisi penduduk desa.</p>
                    </div>
                    <div class="demografi-grid">
                        <div class="map-placeholder">
                            <span>Peta Desa Sendangan</span>
                        </div>
                        <div class="demografi-list">
                            <?php foreach ($demografi as $item): ?>
                                <article class="card">
                                    <h3><?= e($item['label'] ?? '') ?></h3>
                                    <p><?= e($item['value'] ?? '') ?></p>
                                </article>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($fasilitas !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Fasilitas Desa</h2>
                        <p>Fasilitas layanan publik, pendidikan, kesehatan, dan aktivitas warga.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($fasilitas as $item): ?>
                            <article class="card">
                                <?php if (!empty($item['fasilitas_gambar'])): ?>
                                    <div class="card-image">
                                        <img src="<?= e($item['fasilitas_gambar']) ?>" alt="<?= e(($item['fasilitas_nama'] ?? 'Fasilitas Desa') . ' - Foto') ?>">
                                    </div>
                                <?php endif; ?>
                                <h3><?= e($item['fasilitas_nama'] ?? '') ?></h3>
                                <?php if (!empty($item['fasilitas_gmaps_link'])): ?>
                                    <a class="btn btn-secondary card__action" href="<?= e($item['fasilitas_gmaps_link']) ?>" target="_blank" rel="noopener">
                                        Lihat Lokasi
                                    </a>
                                <?php endif; ?>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($program !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Program Desa</h2>
                        <p>Inisiatif pembangunan dan pemberdayaan masyarakat yang sedang berjalan.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($program as $item): ?>
                            <article class="card program-card">
                                <?php if (!empty($item['program_gambar'])): ?>
                                    <div class="card-image">
                                        <img src="<?= e($item['program_gambar']) ?>" alt="<?= e(($item['program_nama'] ?? 'Program Desa') . ' - Foto') ?>">
                                    </div>
                                <?php endif; ?>
                                <h3><?= e($item['program_nama'] ?? '') ?></h3>
                                <p><?= e($item['program_deskripsi'] ?? '') ?></p>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>
        <?php
    },
]);
