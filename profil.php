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
        $demografiDasar = $profil['demografi_dasar'] ?? null;
        $demografi = [];
        $fasilitas = $profil['fasilitas'] ?? [];
        $program = $profil['program'] ?? [];

        if (is_array($demografiDasar)) {
            $pendudukJaga = $demografiDasar['penduduk_jaga'] ?? [];
            $luasWilayahHa = isset($demografiDasar['luas_wilayah_ha']) ? (float) $demografiDasar['luas_wilayah_ha'] : null;

            if ($luasWilayahHa !== null) {
                $luasWilayahFormatted = fmod($luasWilayahHa, 1.0) === 0.0
                    ? number_format((int) $luasWilayahHa, 0, ',', '.')
                    : number_format($luasWilayahHa, 2, ',', '.');

                $demografi[] = [
                    'label' => 'Luas Wilayah',
                    'value' => $luasWilayahFormatted . ' Ha',
                ];
            }

            $jumlahJaga = $demografiDasar['jumlah_jaga'] ?? count($pendudukJaga);
            if ((int) $jumlahJaga > 0) {
                $demografi[] = [
                    'label' => 'Jumlah Jaga',
                    'value' => (int) $jumlahJaga . ' Jaga',
                ];
            }

            $totalLaki = 0;
            $totalPerempuan = 0;

            foreach ($pendudukJaga as $index => $jaga) {
                if (!is_array($jaga)) {
                    continue;
                }

                $namaJaga = $jaga['nama'] ?? 'Jaga ' . ($index + 1);
                $laki = (int) ($jaga['laki_laki'] ?? 0);
                $perempuan = (int) ($jaga['perempuan'] ?? 0);

                $totalLaki += $laki;
                $totalPerempuan += $perempuan;

                $demografi[] = [
                    'label' => 'Penduduk ' . $namaJaga,
                    'value' => sprintf('%d laki-laki, %d perempuan', $laki, $perempuan),
                ];
            }

            $totalPenduduk = $totalLaki + $totalPerempuan;

            if ($totalPenduduk > 0) {
                $demografi[] = [
                    'label' => 'Komposisi Penduduk',
                    'value' => sprintf('Total %d jiwa (%d laki-laki, %d perempuan)', $totalPenduduk, $totalLaki, $totalPerempuan),
                ];

                if ($luasWilayahHa !== null && $luasWilayahHa > 0) {
                    $kepadatan = $totalPenduduk / ($luasWilayahHa / 100);

                    $demografi[] = [
                        'label' => 'Kepadatan Penduduk',
                        'value' => sprintf('%d jiwa/km2', (int) round($kepadatan)),
                    ];
                }
            }

            if (isset($demografiDasar['kepala_keluarga'])) {
                $demografi[] = [
                    'label' => 'Kepala Keluarga',
                    'value' => (int) $demografiDasar['kepala_keluarga'] . ' KK',
                ];
            }
        }
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
                        <div class="demografi-info">
                            <?php foreach ($demografi as $item): ?>
                                <div class="demografi-item">
                                    <span class="demografi-item__label"><?= e($item['label'] ?? '') ?></span>
                                    <span class="demografi-item__value"><?= e($item['value'] ?? '') ?></span>
                                </div>
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
