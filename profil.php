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

        $sejarah = array_values(array_filter(array_map(
            static fn($item): string => is_string($item) ? trim($item) : '',
            is_array($sejarah) ? $sejarah : []
        ), static fn(string $paragraph): bool => $paragraph !== ''));

        if (!is_array($fasilitas)) {
            $fasilitas = [];
        } else {
            $fasilitas = array_values(array_filter(array_map(
                static function ($item): ?array {
                    if (!is_array($item)) {
                        return null;
                    }
                    $image = trim((string) ($item['fasilitas_gambar'] ?? ''));
                    if ($image !== '' && !str_starts_with($image, 'http')) {
                        $item['fasilitas_gambar'] = base_uri('uploads/fasilitas/' . ltrim($image, '/'));
                    }
                    $gmaps = trim((string) ($item['fasilitas_gmaps_link'] ?? ''));
                    $item['fasilitas_gmaps_link'] = $gmaps !== '' ? $gmaps : '';
                    return $item;
                },
                $fasilitas
            ), static fn($item): bool => is_array($item) && ($item['fasilitas_nama'] ?? '') !== ''));
        }

        if (!is_array($program)) {
            $program = [];
        } else {
            $program = array_values(array_filter(array_map(
                static function ($item): ?array {
                    if (!is_array($item)) {
                        return null;
                    }
                    $image = trim((string) ($item['program_gambar'] ?? ''));
                    if ($image !== '' && !str_starts_with($image, 'http')) {
                        $item['program_gambar'] = base_uri('uploads/program/' . ltrim($image, '/'));
                    }
                    return $item;
                },
                $program
            ), static fn($item): bool => is_array($item) && ($item['program_nama'] ?? '') !== ''));
        }

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

        $mapDefaults = [
            'media.peta_desa_sendangan' => 'peta-desa-sendangan.jpg',
            'media.peta_desa_sendangan_citra' => 'peta-desa-sendangan-citra.jpg',
        ];

        $mapValues = data_values($mapDefaults) + $mapDefaults;

        $resolveMapMedia = static function (string $raw): string {
            $raw = trim($raw);
            if ($raw === '') {
                return '';
            }

            if (str_starts_with($raw, 'http')) {
                return $raw;
            }

            $relativeMedia = ltrim(str_replace('\\', '/', $raw), '/');

            if (!str_contains($relativeMedia, '/')) {
                if (is_file(base_path('uploads/' . $relativeMedia))) {
                    $relativeMedia = 'uploads/' . $relativeMedia;
                } elseif (is_file(base_path('uploads/assets/' . $relativeMedia))) {
                    $relativeMedia = 'uploads/assets/' . $relativeMedia;
                } else {
                    $relativeMedia = 'uploads/' . $relativeMedia;
                }
            } elseif (!str_starts_with($relativeMedia, 'uploads/')) {
                $relativeMedia = 'uploads/' . $relativeMedia;
            }

            return base_uri($relativeMedia);
        };

        $mapMedia = $resolveMapMedia((string) ($mapValues['media.peta_desa_sendangan'] ?? ''));
        $mapMediaSatellite = $resolveMapMedia((string) ($mapValues['media.peta_desa_sendangan_citra'] ?? ''));

        $mapTitle = 'Peta Desa Sendangan';
        $mapAlt = $mapTitle;
        $mapSatelliteAlt = $mapAlt . ' - Peta Citra';
        $mapHasDefault = $mapMedia !== '';
        $mapHasSatellite = $mapMediaSatellite !== '';
        $mapToggleEnabled = $mapHasDefault && $mapHasSatellite;
        $mapInitialView = $mapHasDefault ? 'default' : ($mapHasSatellite ? 'satellite' : 'none');
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
                    <div class="demografi-map-section"<?php if ($mapInitialView !== 'none'): ?> data-map-section data-map-mode="<?= e($mapInitialView) ?>"<?php endif; ?>>
                        <?php if ($mapToggleEnabled): ?>
                            <div class="demografi-map-toggle-wrapper">
                                <div class="map-toggle demografi-map-toggle" data-map-toggle>
                                    <span class="map-toggle-label">Tampilan</span>
                                    <label class="map-toggle-switch">
                                        <input type="checkbox" data-map-toggle-input aria-label="Tampilkan peta citra (satelit)">
                                        <span class="map-toggle-slider">
                                            <span class="map-toggle-option map-toggle-option-default">Wilayah</span>
                                            <span class="map-toggle-option map-toggle-option-satellite">Citra</span>
                                        </span>
                                    </label>
                                    <!-- <span class="map-toggle-caption" data-map-toggle-caption data-default="Peta Wilayah" data-satellite="Peta Citra" aria-live="polite">Peta Wilayah</span> -->
                                </div>
                            </div>
                        <?php endif; ?>
                        <div class="demografi-grid">
                            <?php if ($mapInitialView !== 'none'): ?>
                                <div class="map-display map-display--interactive" data-map-display>
                                    <?php if ($mapHasDefault): ?>
                                        <div class="map-image<?= $mapInitialView === 'default' ? ' is-active' : '' ?>" data-map-view="default">
                                            <img src="<?= e($mapMedia) ?>" alt="<?= e($mapAlt) ?>">
                                        </div>
                                    <?php endif; ?>
                                    <?php if ($mapHasSatellite): ?>
                                        <div class="map-image<?= $mapInitialView === 'satellite' ? ' is-active' : '' ?>" data-map-view="satellite">
                                            <img src="<?= e($mapMediaSatellite) ?>" alt="<?= e($mapSatelliteAlt) ?>">
                                        </div>
                                    <?php endif; ?>
                                </div>
                            <?php else: ?>
                                <div class="map-placeholder">
                                    <span>Peta Desa Sendangan</span>
                                </div>
                            <?php endif; ?>
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

        <?php if ($mapInitialView !== 'none'): ?>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var mapSection = document.querySelector('.demografi-map-section[data-map-section]');
                    if (!mapSection) {
                        return;
                    }

                    var toggleInput = mapSection.querySelector('[data-map-toggle-input]');
                    var mapItemsArray = Array.prototype.slice.call(mapSection.querySelectorAll('[data-map-view]'));
                    var toggleCaption = mapSection.querySelector('[data-map-toggle-caption]');

                    if (mapItemsArray.length === 0) {
                        return;
                    }

                    var setMapMode = function (mode) {
                        mapSection.setAttribute('data-map-mode', mode);
                    };

                    var updateMapView = function (showSatellite) {
                        var activeView = showSatellite ? 'satellite' : 'default';
                        var hasTarget = mapItemsArray.some(function (item) {
                            return item.getAttribute('data-map-view') === activeView;
                        });

                        if (!hasTarget) {
                            activeView = mapItemsArray[0].getAttribute('data-map-view') || activeView;
                        }

                        mapItemsArray.forEach(function (item) {
                            item.classList.toggle('is-active', item.getAttribute('data-map-view') === activeView);
                        });

                        if (toggleCaption) {
                            var defaultText = toggleCaption.getAttribute('data-default') || toggleCaption.textContent || 'Peta Wilayah';
                            var satelliteText = toggleCaption.getAttribute('data-satellite') || 'Peta Citra';
                            toggleCaption.textContent = activeView === 'satellite' ? satelliteText : defaultText;
                        }

                        setMapMode(activeView);
                    };

                    if (toggleInput && mapItemsArray.length > 1) {
                        updateMapView(toggleInput.checked);
                        toggleInput.addEventListener('change', function () {
                            updateMapView(toggleInput.checked);
                        });
                    } else {
                        var fallbackView = mapItemsArray[0].getAttribute('data-map-view') || 'default';
                        mapItemsArray[0].classList.add('is-active');

                        if (toggleCaption) {
                            var defaultTextFallback = toggleCaption.getAttribute('data-default') || toggleCaption.textContent || 'Peta Wilayah';
                            var satelliteTextFallback = toggleCaption.getAttribute('data-satellite') || 'Peta Citra';
                            toggleCaption.textContent = fallbackView === 'satellite' ? satelliteTextFallback : defaultTextFallback;
                        }

                        setMapMode(fallbackView);
                    }
                });
            </script>
        <?php endif; ?>
        <?php
    },
]);
