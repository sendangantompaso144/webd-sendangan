<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$apbdesData = data_source('apbdes', []);

render_base_layout([
    'title' => 'APBDes | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Ringkasan pendapatan, belanja, dan laporan realisasi APBDes Desa Sendangan.',
    'activePage' => 'apbdes',
    'content' => static function () use ($apbdesData): void {
        $pendapatan = $apbdesData['pendapatan'] ?? [];
        $belanja = $apbdesData['belanja'] ?? [];
        $realisasi = $apbdesData['realisasi'] ?? [];

        $totalPendapatan = array_sum(array_map(static fn ($item) => (float) ($item['nilai'] ?? 0), $pendapatan));
        $totalBelanja = array_sum(array_map(static fn ($item) => (float) ($item['nilai'] ?? 0), $belanja));
        ?>
        <section class="section">
            <div class="container">
                <div class="section-header">
                    <h1>Anggaran Pendapatan dan Belanja Desa</h1>
                    <p>Data ringkas APBDes Desa Sendangan sebagai wujud transparansi kepada masyarakat.</p>
                </div>

                <div class="apbdes-summary">
                    <article>
                        <h3>Total Pendapatan</h3>
                        <strong><?= e(format_currency($totalPendapatan)) ?></strong>
                    </article>
                    <article>
                        <h3>Total Belanja</h3>
                        <strong><?= e(format_currency($totalBelanja)) ?></strong>
                    </article>
                    <article>
                        <h3>Surplus / Defisit</h3>
                        <strong><?= e(format_currency($totalPendapatan - $totalBelanja)) ?></strong>
                    </article>
                </div>
            </div>
        </section>

        <?php if ($pendapatan !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Pendapatan Desa</h2>
                        <p>Sumber pendapatan desa pada tahun anggaran berjalan.</p>
                    </div>
                    <div class="table-scroll">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Sumber Pendapatan</th>
                                    <th>Nilai</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($pendapatan as $item): ?>
                                    <tr>
                                        <td><?= e($item['sumber'] ?? '') ?></td>
                                        <td><?= e(format_currency((float) ($item['nilai'] ?? 0))) ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Total</th>
                                    <th><?= e(format_currency($totalPendapatan)) ?></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($belanja !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Belanja Desa</h2>
                        <p>Distribusi belanja desa berdasarkan program prioritas.</p>
                    </div>
                    <div class="table-scroll">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Program</th>
                                    <th>Nilai</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($belanja as $item): ?>
                                    <tr>
                                        <td><?= e($item['program'] ?? '') ?></td>
                                        <td><?= e(format_currency((float) ($item['nilai'] ?? 0))) ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Total</th>
                                    <th><?= e(format_currency($totalBelanja)) ?></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($realisasi !== []): ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2>Laporan Realisasi</h2>
                        <p>Unduh laporan realisasi APBDes terbaru.</p>
                    </div>
                    <div class="cards-grid">
                        <?php foreach ($realisasi as $laporan): ?>
                            <article class="card">
                                <span class="chip"><?= e($laporan['tahun'] ?? '') ?></span>
                                <h3><?= e($laporan['judul'] ?? '') ?></h3>
                                <a class="btn btn-primary" href="<?= e($laporan['berkas'] ?? '#') ?>" target="_blank" rel="noopener">
                                    Unduh PDF
                                </a>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>
        <?php
    },
]);

