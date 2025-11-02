<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$apbdesData = data_source('apbdes', []);

render_base_layout([
    'title' => 'APBDes | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Daftar dokumen APBDes Desa Sendangan yang dapat diunduh oleh masyarakat.',
    'activePage' => 'apbdes',
    'content' => static function () use ($apbdesData): void {
        $dokumen = [];

        if (is_array($apbdesData)) {
            if (array_is_list($apbdesData)) {
                $dokumen = $apbdesData;
            } elseif (isset($apbdesData['dokumen']) && is_array($apbdesData['dokumen'])) {
                $dokumen = $apbdesData['dokumen'];
            }
        }
        ?>
        <section class="section">
            <div class="container page-header">
                <div>
                    <span class="chip">APBDes</span>
                    <h1>Arsip Dokumen APBDes</h1>
                    <p>Unduh dokumen APBDes terbaru berikut penanggung jawab pembaruannya.</p>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <?php if ($dokumen === []): ?>
                    <div class="empty-state">
                        <p>Belum ada dokumen APBDes yang tersedia saat ini.</p>
                    </div>
                <?php else: ?>
                    <div class="cards-grid">
                        <?php foreach ($dokumen as $item): ?>
                            <article class="card card--apbdes">
                                <h3><?= e((string) ($item['apbdes_judul'] ?? 'Dokumen APBDes')) ?></h3>
                                <?php if (!empty($item['apbdes_edited_by'])): ?>
                                    <p class="card-meta">Disunting oleh <?= e((string) $item['apbdes_edited_by']) ?></p>
                                <?php endif; ?>
                                <a class="btn btn-primary" href="<?= e((string) ($item['apbdes_file'] ?? '#')) ?>" target="_blank" rel="noopener">
                                    Unduh Dokumen
                                </a>
                            </article>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
            </div>
        </section>
        <?php
    },
]);
