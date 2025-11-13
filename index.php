<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$homeData = data_source('home', []);
$latestNews = [];

try {
    $pdo = db();
    $stmt = $pdo->query('SELECT berita_id, berita_judul, berita_isi, berita_gambar, berita_dilihat, berita_created_at FROM berita ORDER BY berita_created_at DESC LIMIT 6');
    if ($stmt !== false) {
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (is_array($rows)) {
            $latestNews = $rows;
        }
    }
} catch (Throwable) {
    // Abaikan, tampilkan state kosong.
}

$headlines = [];

try {
    $pdo = db();
    $stmt = $pdo->query('
        SELECT pengumuman_isi, pengumuman_valid_hingga
        FROM pengumuman
        WHERE pengumuman_valid_hingga >= NOW()
        ORDER BY pengumuman_created_at DESC
        LIMIT 5
    ');

    if ($stmt !== false) {
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($rows as $row) {
            $isi = trim((string) ($row['pengumuman_isi'] ?? ''));
            if ($isi !== '') {
                // Potong kalimat jika terlalu panjang (misalnya headline 120 karakter)
                $excerpt = mb_substr($isi, 0, 120);
                if (mb_strlen($isi) > 120) {
                    $excerpt .= '...';
                }
                $headlines[] = $excerpt;
            }
        }
    }
} catch (Throwable) {
    // Abaikan error, pakai fallback dari data statis
}

$strukturOrganisasi = [];

try {
    $pdo = db();
    $stmt = $pdo->query('
        SELECT struktur_id, struktur_nama, struktur_jabatan, struktur_foto 
        FROM struktur_organisasi
        ORDER BY struktur_id ASC
    ');
    if ($stmt !== false) {
        $strukturOrganisasi = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Throwable) {
    // Jika gagal ambil data, biarkan $strukturOrganisasi kosong
}

render_base_layout([
    'title' => 'Beranda | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Beranda Desa Sendangan: sambutan, data singkat, dan layanan utama untuk warga.',
    'activePage' => 'home',
    'bodyClass' => 'page-home',
    'content' => static function () use ($homeData, $latestNews, $headlines, $strukturOrganisasi): void {
        $profilData = data_source('profil', []);
        $demografiDasar = is_array($profilData['demografi_dasar'] ?? null) ? $profilData['demografi_dasar'] : null;
        $stats = [];

        if ($demografiDasar !== null) {
            // Derive hero stats from demographic base data
            $pendudukJaga = $demografiDasar['penduduk_jaga'] ?? [];
            if (!is_array($pendudukJaga)) {
                $pendudukJaga = [];
            }

            $totalLaki = 0;
            $totalPerempuan = 0;

            foreach ($pendudukJaga as $jaga) {
                if (!is_array($jaga)) {
                    continue;
                }

                $totalLaki += (int) ($jaga['laki_laki'] ?? 0);
                $totalPerempuan += (int) ($jaga['perempuan'] ?? 0);
            }

            $totalPenduduk = $totalLaki + $totalPerempuan;

            if ($totalPenduduk > 0) {
                $stats[] = [
                    'label' => 'Total Penduduk',
                    'value' => number_format($totalPenduduk, 0, ',', '.'),
                    'note' => sprintf('%d laki-laki, %d perempuan', $totalLaki, $totalPerempuan),
                ];
            }

            if (isset($demografiDasar['kepala_keluarga'])) {
                $stats[] = [
                    'label' => 'Kepala Keluarga',
                    'value' => number_format((int) $demografiDasar['kepala_keluarga'], 0, ',', '.') . ' KK',
                    'note' => '',
                ];
            }

            $jumlahJaga = $demografiDasar['jumlah_jaga'] ?? null;
            if ($jumlahJaga !== null) {
                $jumlahJaga = (int) $jumlahJaga;
            } else {
                $jumlahJaga = count($pendudukJaga);
            }

            if ($jumlahJaga > 0) {
                $stats[] = [
                    'label' => 'Jumlah Jaga',
                    'value' => $jumlahJaga . ' Jaga',
                    'note' => '',
                ];
            }

            if (isset($demografiDasar['luas_wilayah_ha'])) {
                $luasWilayahHa = (float) $demografiDasar['luas_wilayah_ha'];
                if ($luasWilayahHa > 0.0) {
                    $luasWilayahFormatted = fmod($luasWilayahHa, 1.0) === 0.0
                        ? number_format((int) $luasWilayahHa, 0, ',', '.')
                        : number_format($luasWilayahHa, 2, ',', '.');

                    $stats[] = [
                        'label' => 'Luas Wilayah',
                        'value' => $luasWilayahFormatted . ' Ha',
                        'note' => '',
                    ];
                }
            }
        }

        if ($stats === []) {
            $stats = $homeData['stats'] ?? [
                ['label' => 'Jumlah Penduduk', 'value' => '550', 'note' => ''],
                ['label' => 'Luas Wilayah', 'value' => '85 Ha', 'note' => ''],
                ['label' => 'Jumlah Jaga', 'value' => '3', 'note' => ''],
            ];
        }
        $features = $homeData['features'] ?? [
            ['title' => 'Profil Desa', 'summary' => 'Sejarah, demografi, dan informasi lengkap tentang desa', 'link' => 'profil.php'],
            ['title' => 'Informasi Publik', 'summary' => 'Berita terkini, pengumuman, dan galeri kegiatan', 'link' => 'info_publik.php'],
            ['title' => 'Transparansi', 'summary' => 'Laporan keuangan dan realisasi APBDes', 'link' => 'transparansi.php'],
            ['title' => 'Potensi Desa', 'summary' => 'UMKM, wisata, seni dan budaya lokal', 'link' => 'potensi.php']
        ];
        $administrasi = $homeData['administrasi'] ?? [
            ['label' => 'Total Penduduk', 'value' => '550'],
            ['label' => 'Kepala Keluarga', 'value' => '180'],
            ['label' => 'Laki-laki', 'value' => '270'],
            ['label' => 'Perempuan', 'value' => '280'],
        ];
        $potensiList = [];
        try {
            $pdo = db();
            $stmt = $pdo->query("
                SELECT 
                    p.potensi_id,
                    p.potensi_judul,
                    p.potensi_isi,
                    p.potensi_kategori,
                    p.potensi_gmaps_link,
                    p.potensi_created_at,
                    gp.gambar_namafile AS potensi_gambar
                FROM potensi_desa p
                LEFT JOIN (
                    SELECT potensi_id, MIN(gambar_id) AS min_id
                    FROM gambar_potensi_desa
                    GROUP BY potensi_id
                ) first_img ON first_img.potensi_id = p.potensi_id
                LEFT JOIN gambar_potensi_desa gp ON gp.gambar_id = first_img.min_id
                ORDER BY p.potensi_created_at DESC
            ");
            if ($stmt !== false) {
                $potensiList = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
            }
        } catch (Throwable) {
            // fallback ke data_source kalau DB error
            $potensiList = [];
        }

        // Fallback ke data_source bila DB kosong
        if ($potensiList === []) {
            $potensiList = data_source('potensi', []);
        }

        $potentials = [];
        if (is_array($potensiList)) {
            if (array_is_list($potensiList)) {
                $potentials = $potensiList;
            } else {
                foreach ($potensiList as $item) {
                    if (is_array($item)) {
                        $potentials[] = $item;
                    }
                }
            }
        }

        if ($potentials === []) {
            $potentials = [
                [
                    'potensi_kategori' => 'Wisata',
                    'potensi_judul' => 'Kolam Air Panas',
                    'potensi_isi' => 'Destinasi wisata air panas dalam tahap pengembangan.',
                    'potensi_gmaps_link' => '#',
                ],
                [
                    'potensi_kategori' => 'UMKM',
                    'potensi_judul' => 'UMKM Lokal',
                    'potensi_isi' => 'Pelatihan dan dukungan bagi pelaku UMKM desa.',
                    'potensi_gmaps_link' => '#',
                ],
                [
                    'potensi_kategori' => 'Budaya',
                    'potensi_judul' => 'Seni & Budaya',
                    'potensi_isi' => 'Festival dan kegiatan budaya rutin desa.',
                    'potensi_gmaps_link' => '#',
                ],
            ];
        }

        $potentialsByCategory = [];
        foreach ($potentials as $entry) {
            if (!is_array($entry)) {
                continue;
            }

            $category = (string) ($entry['potensi_kategori'] ?? 'Lainnya');
            if (!isset($potentialsByCategory[$category])) {
                $potentialsByCategory[$category] = [];
            }

            $potentialsByCategory[$category][] = $entry;
        }

        foreach ($potentialsByCategory as &$categoryItems) {
            usort(
                $categoryItems,
                static function (array $a, array $b): int {
                    return strcmp((string) ($b['potensi_created_at'] ?? ''), (string) ($a['potensi_created_at'] ?? ''));
                }
            );
        }
        unset($categoryItems);

        $categoryPreference = ['Wisata', 'Budaya', 'Kuliner', 'UMKM'];
        $orderedPotentialCategories = [];
        foreach ($categoryPreference as $cat) {
            if (isset($potentialsByCategory[$cat])) {
                $orderedPotentialCategories[] = $cat;
            }
        }
        foreach ($potentialsByCategory as $cat => $_) {
            if (!in_array($cat, $orderedPotentialCategories, true)) {
                $orderedPotentialCategories[] = $cat;
            }
        }
        $orderedPotentialCategories = array_slice($orderedPotentialCategories, 0, 4);
        if (!isset($headlines) || $headlines === []) {
            $headlines = $homeData['headlines'] ?? [
            ];
        }
        $newsItems = $latestNews;
        if ($newsItems === []) {
            $newsItems = $homeData['news'] ?? [
                [
                    'berita_judul' => 'Pelatihan Digital untuk UMKM Sendangan',
                    'berita_isi' => 'Pemerintah desa berkolaborasi dengan komunitas pemuda untuk memberikan pelatihan pemasaran digital kepada para pelaku UMKM. Materi mencakup pengelolaan media sosial, fotografi produk, hingga penggunaan marketplace.',
                    'berita_gambar' => 'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a',
                    'berita_dilihat' => 128,
                    'berita_tanggal' => '10 Oktober 2025',
                ],
                [
                    'berita_judul' => 'Jadwal Layanan Administrasi Desa',
                    'berita_isi' => 'Pelayanan administrasi kependudukan kini tersedia setiap Selasa dan Kamis pukul 09.00-14.00 WITA. Warga diimbau membawa dokumen pendukung yang lengkap untuk mempercepat proses pelayanan.',
                    'berita_gambar' => 'https://images.unsplash.com/photo-1522071820081-009f0129c71c',
                    'berita_dilihat' => 94,
                    'berita_tanggal' => '05 Oktober 2025',
                ],
                [
                    'berita_judul' => 'Gotong Royong Bersih Desa',
                    'berita_isi' => 'Kegiatan gotong royong rutin digelar pada Sabtu pekan pertama di setiap bulan. Warga berkumpul di Balai Desa sebelum bersama-sama membersihkan area publik dan saluran air.',
                    'berita_gambar' => 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d',
                    'berita_dilihat' => 76,
                    'berita_tanggal' => '28 September 2025',
                ],
            ];
        }
        $defaultGreetingMessages = [
            'Selamat datang di website resmi Desa Sendangan. Kami berkomitmen untuk memberikan pelayanan terbaik kepada masyarakat dan membangun desa yang lebih maju, sejahtera, dan bermartabat.',
            'Melalui website ini, kami berharap dapat meningkatkan transparansi dan komunikasi dengan seluruh warga. Mari bersama-sama membangun Desa Sendangan yang lebih baik.',
        ];
        $greetingData = is_array($homeData['greeting'] ?? null) ? $homeData['greeting'] : [];
                $defaultGreetingMessages = [
            'Selamat datang di website resmi Desa Sendangan. Kami berkomitmen untuk memberikan pelayanan terbaik kepada masyarakat dan membangun desa yang lebih maju, sejahtera, dan bermartabat.',
            'Melalui website ini, kami berharap dapat meningkatkan transparansi dan komunikasi dengan seluruh warga. Mari bersama-sama membangun Desa Sendangan yang lebih baik.',
        ];
        $greetingData = is_array($homeData['greeting'] ?? null) ? $homeData['greeting'] : [];
        $greetingBadge = (string) ($greetingData['badge'] ?? 'SAMBUTAN HUKUM TUA');
        $greetingName = trim((string) ($greetingData['name'] ?? 'Johny R. Mandagi'));
        $greetingMessageRaw = $greetingData['message'] ?? $defaultGreetingMessages;

        // ---[ TAMBAHKAN BLOK INI ]-------------------------------------------
        // Ambil nama & foto Hukum Tua dari tabel `data`
        try {
            $pdo = db();
            $stmt = $pdo->prepare('
                SELECT data_key, data_value 
                FROM data 
                WHERE data_key IN ("profile.hukum_tua_nama", "media.hukum_tua_foto")
            ');
            if ($stmt->execute()) {
                $kv = [];
                foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
                    $kv[(string)$row['data_key']] = (string)$row['data_value'];
                }

                // Override nama jika tersedia di DB
                if (!empty($kv['profile.hukum_tua_nama'])) {
                    $greetingName = trim($kv['profile.hukum_tua_nama']);
                }

                // Simpan raw filename foto (tanpa base_uri) agar bisa di-resolve ke URL
                $greetingPhotoRawFromDb = trim($kv['media.hukum_tua_foto'] ?? '');
            }
        } catch (Throwable) {
            // Abaikan kalau gagal; tetap pakai fallback dari $homeData
            $greetingPhotoRawFromDb = '';
        }

        // Helper untuk resolve path foto ke URL (cek uploads/assets/ dulu, baru uploads/)
        $resolveGreetingPhoto = static function (string $raw): string {
            $raw = trim($raw);
            if ($raw === '') return '';
            if (str_starts_with($raw, 'http')) return $raw;

            $relative = ltrim(str_replace('\\', '/', $raw), '/');

            // Prioritas di uploads/assets/
            if (is_file(base_path('uploads/assets/' . $relative))) {
                return base_uri('uploads/assets/' . $relative);
            }
            // Fallback: langsung di uploads/
            if (is_file(base_path('uploads/' . $relative))) {
                return base_uri('uploads/' . $relative);
            }
            // Jika struktur subfolder sudah disertakan di $raw (mis. "assets/xxx.webp")
            if (!str_starts_with($relative, 'uploads/')) {
                return base_uri('uploads/' . $relative);
            }
            return base_uri($relative);
        };
        // ---[ /TAMBAHKAN BLOK INI ]------------------------------------------

        $greetingMessages = [];
        if (is_string($greetingMessageRaw)) {
            $chunks = preg_split("/\r?\n\r?\n|\r?\n/", $greetingMessageRaw) ?: [];
            foreach ($chunks as $chunk) {
                $chunk = trim((string) $chunk);
                if ($chunk !== '') {
                    $greetingMessages[] = $chunk;
                }
            }
        } elseif (is_array($greetingMessageRaw)) {
            foreach ($greetingMessageRaw as $chunk) {
                if (!is_string($chunk)) {
                    continue;
                }
                $chunk = trim($chunk);
                if ($chunk !== '') {
                    $greetingMessages[] = $chunk;
                }
            }
        }
        if ($greetingMessages === []) {
            $greetingMessages = $defaultGreetingMessages;
        }
        $greetingCtaLabel = (string) ($greetingData['cta_label'] ?? 'Profil Desa');
        $greetingCtaLink = (string) ($greetingData['cta_link'] ?? 'profil.php');
        $greetingCtaHref = $greetingCtaLink !== '' && str_starts_with($greetingCtaLink, 'http')
            ? $greetingCtaLink
            : base_uri($greetingCtaLink !== '' ? ltrim($greetingCtaLink, '/') : 'profil.php');

        // ---[ GANTI BAGIAN PENENTU $greetingPhoto MENJADI INI ]--------------
        // Ambil dari DB (jika ada), jika kosong pakai dari $homeData['greeting']['photo']
        $greetingPhotoRaw = '';
        if (!empty($greetingPhotoRawFromDb ?? '')) {
            $greetingPhotoRaw = $greetingPhotoRawFromDb; // contoh: "hukumtua_690a6df3370235.98424889.webp"
        } else {
            $greetingPhotoRaw = (string) ($greetingData['photo'] ?? '');
        }

        $greetingPhoto = $resolveGreetingPhoto($greetingPhotoRaw);
        // ---[ /GANTI ]-------------------------------------------------------

        $greetingAlt = $greetingName !== '' ? $greetingName : 'Hukum Tua Desa Sendangan';

        // $greetingPhoto = (string) ($greetingData['photo'] ?? '');
        // if ($greetingPhoto !== '') {
        //     $greetingPhoto = str_starts_with($greetingPhoto, 'http')
        //         ? $greetingPhoto
        //         : base_uri('uploads/' . ltrim($greetingPhoto, '/'));
        // } else {
        //     $greetingPhoto = '';
        // }
        // $greetingAlt = $greetingName !== '' ? $greetingName : 'Hukum Tua Desa Sendangan';
        $mapData = is_array($homeData['map'] ?? null) ? $homeData['map'] : [];
        $mapTitle = (string) ($mapData['title'] ?? 'Peta Desa Sendangan');
        $mapDescription = (string) ($mapData['description'] ?? 'Lokasi fasilitas umum, batas wilayah, dan potensi desa dalam satu tampilan interaktif.');

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

        $resolvePotensiImage = static function (string $raw): string {
            $raw = trim($raw);
            if ($raw === '') return '';
            if (str_starts_with($raw, 'http')) return $raw;

            $relative = ltrim(str_replace('\\', '/', $raw), '/');

            $candidates = [
                'uploads/potensi/' . $relative,
                'uploads/assets/potensi/' . $relative,
                'uploads/assets/' . $relative,
                'uploads/' . $relative,
                $relative,
            ];

            foreach ($candidates as $rel) {
                $abs = base_path($rel);
                if (is_file($abs)) {
                    // versi cache-busting berdasarkan mtime
                    $ver = (string) @filemtime($abs);
                    return base_uri($rel) . ($ver ? ('?v=' . $ver) : '');
                }
            }
            // fallback URL (tanpa cek fisik)
            return base_uri('uploads/' . $relative);
        };


        $mapMedia = $resolveMapMedia((string) ($mapData['media'] ?? ''));
        $mapMediaSatellite = $resolveMapMedia((string) ($mapData['media_satellite'] ?? ''));

        $mapAlt = $mapTitle !== '' ? $mapTitle : 'Peta Desa Sendangan';
        $mapSatelliteAlt = $mapAlt . ' - Peta Citra';
        $mapHasDefault = $mapMedia !== '';
        $mapHasSatellite = $mapMediaSatellite !== '';
        $mapToggleEnabled = $mapHasDefault && $mapHasSatellite;
        $mapInitialView = $mapHasDefault ? 'default' : ($mapHasSatellite ? 'satellite' : 'none');
        ?>
        
        <!-- Hero Section dengan Gradient -->
        <section class="hero-section">
            <div class="hero-overlay"></div>
            <div class="hero-content-wrapper">
                <div class="hero-main">
                    <div class="hero-badge">Selamat datang</div>
                    <h1 class="hero-title">Website Desa Sendangan</h1>
                    <p class="hero-subtitle">Sumber informasi resmi tentang Desa Sendangan</p>
                </div>
            </div>
            <?php if ($headlines !== []): ?>
                <div class="hero-headline" data-interval="10000">
                    <div class="hero-headline-viewport">
                        <div class="hero-headline-track">
                            <?php foreach ($headlines as $headline): ?>
                                <div class="hero-headline-item">
                                    <span class="hero-headline-text"><?= e((string) $headline) ?></span>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
        </section>

        <!-- Stats Section -->
        <?php if ($stats !== []): ?>
            <section class="stats-section">
                <div class="stats-container">
                    <?php 
                    $icons = ['&#128101;', '&#128106;', '&#128205;', '&#128506;'];
                    foreach ($stats as $index => $stat): ?>
                        <div class="stat-card">
                            <div class="stat-icon"><?= $icons[$index] ?? '&#9733;' ?></div>
                            <div class="stat-content">
                                <div class="stat-value"><?= e($stat['value'] ?? '') ?></div>
                                <div class="stat-label"><?= e($stat['label'] ?? '') ?></div>
                                <?php if (!empty($stat['note'])): ?>
                                    <div class="stat-note"><?= e($stat['note']) ?></div>
                                <?php endif; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </section>
        <?php endif; ?>

        <!-- Sambutan Section dengan Photo -->
        <section class="greeting-section">
            <div class="section-container">
                <div class="greeting-grid">
                    <div class="greeting-photo">
                        <div class="photo-frame">
                            <?php if ($greetingPhoto !== ''): ?>
                                <img src="<?= e($greetingPhoto) ?>" alt="<?= e($greetingAlt) ?>" />
                            <?php else: ?>
                                <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='500'%3E%3Crect fill='%23E3F2FD' width='400' height='500'/%3E%3Ctext x='50%25' y='50%25' font-size='16' fill='%2390CAF9' text-anchor='middle' dominant-baseline='middle'%3E<?= rawurlencode($greetingAlt) ?>%3C/text%3E%3C/svg%3E" alt="<?= e($greetingAlt) ?>" />
                            <?php endif; ?>
                        </div>
                    </div>
                    <div class="greeting-content">
                        <div class="greeting-badge"><?= e($greetingBadge) ?></div>
                        <?php if ($greetingName !== ''): ?>
                            <h2 class="greeting-title"><?= e($greetingName) ?></h2>
                        <?php endif; ?>
                        <?php if ($greetingMessages !== []): ?>
                            <div class="greeting-text">
                                <?php foreach ($greetingMessages as $paragraph): ?>
                                    <p><?= e($paragraph) ?></p>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                        <?php if ($greetingCtaLabel !== ''): ?>
                            <a class="greeting-button" href="<?= e($greetingCtaHref) ?>">
                                <?= e($greetingCtaLabel) ?> <span class="greeting-button-icon">&rarr;</span>
                            </a>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </section>

        <!-- Map Section -->
        <section class="map-section" data-map-section>
            <div class="map-container">
                <div class="map-intro">
                    <h2><?= e($mapTitle) ?></h2>
                    <p><?= e($mapDescription) ?></p>
                    <?php if ($mapToggleEnabled): ?>
                        <div class="map-toggle" data-map-toggle>
                            <span class="map-toggle-label">Tampilan</span>
                            <label class="map-toggle-switch">
                                <input type="checkbox" data-map-toggle-input aria-label="Tampilkan peta citra (satelit)">
                                <span class="map-toggle-slider">
                                    <span class="map-toggle-option map-toggle-option-default">Wilayah</span>
                                    <span class="map-toggle-option map-toggle-option-satellite">Citra</span>
                                </span>
                            </label>
                            <!-- <span class="map-toggle-caption" data-default="Peta Wilayah" data-satellite="Peta Citra" aria-live="polite">Peta Wilayah</span> -->
                        </div>
                    <?php endif; ?>
                </div>
                <div class="map-display" data-map-display>
                    <?php if ($mapHasDefault): ?>
                        <div class="map-image<?= $mapInitialView === 'default' ? ' is-active' : '' ?>" data-map-view="default">
                            <img src="<?= e($mapMedia) ?>" alt="<?= e($mapAlt) ?>" />
                        </div>
                    <?php endif; ?>
                    <?php if ($mapHasSatellite): ?>
                        <div class="map-image<?= $mapInitialView === 'satellite' ? ' is-active' : '' ?>" data-map-view="satellite">
                            <img src="<?= e($mapMediaSatellite) ?>" alt="<?= e($mapSatelliteAlt) ?>" />
                        </div>
                    <?php endif; ?>
                    <?php if (!$mapHasDefault && !$mapHasSatellite): ?>
                        <div class="map-placeholder">
                            <div class="map-icon">&#128205;</div>
                            <p class="map-text">Peta desa akan ditampilkan di sini</p>
                            <p class="map-subtext">Segera hadir dengan informasi lokasi lengkap</p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </section>

        <!-- Structure Section -->
        <section class="content-section structure-section">
            <div class="section-container">
                <div class="section-header-wrapper">
                    <h2 class="section-title">Struktur Organisasi</h2>
                    <p class="section-description">Perangkat Desa Sendangan yang mengabdi untuk masyarakat</p>
                </div>
                <div class="structure-grid">
                    <?php if (!empty($strukturOrganisasi)): ?>
                        <?php foreach ($strukturOrganisasi as $person): ?>
                            <?php
                            $nama = (string)($person['struktur_nama'] ?? '');
                            $jabatan = (string)($person['struktur_jabatan'] ?? '');
                            $foto = trim((string)($person['struktur_foto'] ?? ''));
                            $fotoUrl = $foto !== '' 
                                ? base_uri('uploads/struktur/' . ltrim($foto, '/')) 
                                : 'data:image/svg+xml,' . rawurlencode("
                                    <svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'>
                                        <rect fill='#E3F2FD' width='200' height='200' rx='100'/>
                                        <text x='50%' y='50%' font-size='60' fill='#90CAF9' text-anchor='middle' dominant-baseline='middle'>👤</text>
                                    </svg>
                                ");
                            ?>
                            <div class="structure-card">
                                <div class="structure-photo">
                                    <img src="<?= e($fotoUrl) ?>" alt="<?= e($jabatan ?: 'Perangkat Desa') ?>" />
                                </div>
                                <?php if ($nama !== ''): ?>
                                    <div class="structure-name"><?= e($nama) ?></div>
                                <?php endif; ?>
                                <div class="structure-role"><?= e($jabatan ?: '-') ?></div>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <p style="text-align:center;color:#607D8B;">Belum ada data struktur organisasi yang tersedia.</p>
                    <?php endif; ?>
                </div>
            </div>
        </section>

        <!-- Potensi Section -->
        <?php if ($orderedPotentialCategories !== []): ?>
            <section class="content-section potential-section">
                <div class="section-container">
                    <div class="section-header-flex">
                        <div>
                            <h2 class="section-title">Potensi Desa</h2>
                            <p class="section-description">Potensi dan peluang Desa Sendangan</p>
                        </div>
                        <a class="header-button" href="<?= e(base_uri('potensi.php')) ?>">
                            Selengkapnya untuk Potensi Desa &rarr;
                        </a>
                    </div>
                    <div class="potential-grid">
                        <?php foreach ($orderedPotentialCategories as $category): ?>
                            <?php
                            $entries = $potentialsByCategory[$category] ?? [];
                            if ($entries === []) continue;

                            // Cari entry pertama yang punya gambar; kalau tidak ada, pakai entries[0]
                            $primary = $entries[0];
                            foreach ($entries as $cand) {
                                if (trim((string)($cand['potensi_gambar'] ?? '')) !== '') {
                                    $primary = $cand;
                                    break;
                                }
                            }

                            $title = (string) ($primary['potensi_judul'] ?? '');
                            $description = (string) ($primary['potensi_isi'] ?? '');
                            $summary = mb_substr($description, 0, 140) . (mb_strlen($description) > 140 ? '...' : '');
                            $iconLabel = strtoupper(substr($category, 0, 1));

                            $imgUrl = $resolvePotensiImage((string)($primary['potensi_gambar'] ?? ''));
                            ?>
                            <div class="potential-card">
                                <?php
                                // Ambil nama file gambar pertama dari DB (alias potensi_gambar)
                                $imgUrl = $resolvePotensiImage((string)($primary['potensi_gambar'] ?? ''));
                                ?>
                                <?php if ($imgUrl !== ''): ?>
                                    <div class="potential-thumb">
                                        <img src="<?= e($imgUrl) ?>" alt="<?= e($title !== '' ? $title : $category) ?>">
                                    </div>
                                <?php else: ?>
                                    <div class="potential-icon"><?= e($iconLabel !== '' ? $iconLabel : 'P') ?></div>
                                <?php endif; ?>

                                <div class="potential-category"><?= e($category) ?></div>
                                <h3 class="potential-title"><?= e($title) ?></h3>
                                <!-- <?php if ($summary !== ''): ?>
                                    <p class="potential-status"><?= e($summary) ?></p>
                                <?php endif; ?> -->
                            </div>
                        <?php endforeach; ?>
                    </div>
                    <div class="potential-note">
                        <p>Data potensi bersumber dari basis potensi desa. Kunjungi halaman Potensi Desa untuk informasi selengkapnya.</p>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <?php
        $formatBeritaTanggal = static function (string $value): string {
            $value = trim($value);
            if ($value === '') {
                return '';
            }
            $timestamp = strtotime($value);
            if ($timestamp === false) {
                return $value;
            }
            $bulan = [
                1 => 'Januari',
                2 => 'Februari',
                3 => 'Maret',
                4 => 'April',
                5 => 'Mei',
                6 => 'Juni',
                7 => 'Juli',
                8 => 'Agustus',
                9 => 'September',
                10 => 'Oktober',
                11 => 'November',
                12 => 'Desember',
            ];
            $nomorBulan = (int) date('n', $timestamp);
            $namaBulan = $bulan[$nomorBulan] ?? date('F', $timestamp);
            return date('j', $timestamp) . ' ' . $namaBulan . ' ' . date('Y', $timestamp);
        };
        ?>
        <?php if ($newsItems !== []): ?>
            <!-- News Section -->
            <section class="content-section news-section">
                <div class="section-container">
                    <div class="section-header-flex">
                        <div>
                            <h2 class="section-title">Berita Terbaru</h2>
                            <p class="section-description">Informasi dan pengumuman terkini</p>
                        </div>
                        <a class="header-button" href="<?= e(base_uri('info_publik.php?tab=berita')) ?>">
                            Lihat Semua Berita &rarr;
                        </a>
                    </div>
                    <div class="news-grid">
                        <?php foreach ($newsItems as $news): ?>
                            <?php
                            $newsId = isset($news['berita_id']) ? (int) $news['berita_id'] : 0;
                            $newsTitle = (string) ($news['berita_judul'] ?? '');
                            $newsBody = (string) ($news['berita_isi'] ?? '');
                            $newsRawExcerpt = trim(strip_tags($newsBody));
                            $newsExcerpt = mb_substr($newsRawExcerpt, 0, 160);
                            if (mb_strlen($newsRawExcerpt) > 160) {
                                $newsExcerpt .= '...';
                            }
                            $newsViews = isset($news['berita_dilihat']) ? (int) $news['berita_dilihat'] : 0;
                            $newsDateRaw = (string) ($news['berita_created_at'] ?? $news['berita_tanggal'] ?? '');
                            $newsDate = $newsDateRaw !== '' ? $formatBeritaTanggal($newsDateRaw) : '';
                            $newsImageRaw = (string) ($news['berita_gambar'] ?? '');
                            if ($newsId > 0 && $newsImageRaw !== '') {
                                $newsImage = base_uri('uploads/berita/' . ltrim($newsImageRaw, '/'));
                            } else {
                                $newsImage = $newsImageRaw !== '' ? $newsImageRaw : asset('images/placeholder-media.svg');
                            }
                            $newsLink = $newsId > 0 ? base_uri('baca_berita.php?id=' . $newsId) : base_uri('info_publik.php?tab=berita');
                            ?>
                            <article class="news-card">
                                <?php if ($newsImage !== ''): ?>
                                    <div class="news-card-image">
                                        <img src="<?= e($newsImage) ?>" alt="<?= e($newsTitle === '' ? 'Berita Desa' : $newsTitle) ?>">
                                    </div>
                                <?php endif; ?>
                                <div class="news-card-content">
                                    <div class="news-meta">
                                        <?php if ($newsViews > 0): ?>
                                            <span class="news-views"><?= e(number_format($newsViews)) ?> kali dibaca</span>
                                        <?php endif; ?>
                                        <?php if ($newsDate !== ''): ?>
                                            <span class="news-date"><?= e($newsDate) ?></span>
                                        <?php endif; ?>
                                    </div>
                                    <h3 class="news-title"><?= e($newsTitle) ?></h3>
                                    <p class="news-excerpt"><?= e($newsExcerpt) ?></p>
                                    <a class="news-link" href="<?= e($newsLink) ?>">
                                        Baca Selengkapnya &rarr;
                                    </a>
                                </div>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <style>
            /* Reset dan Base Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                color: #263238;
                line-height: 1.6;
                background-color: #F9FAFB;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                line-height: 1.3;
            }

            /* Hero Section */
            .hero-section {
                position: relative;
                min-height: 560px;
                background: linear-gradient(135deg, rgba(21, 101, 192, 0.05) 0%, rgba(144, 202, 249, 0.08) 100%), url('assets/images/hero-background.webp');
                background-position: center;
                background-size: cover;
                background-repeat: no-repeat;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: stretch;
                text-align: center;
                margin-top: calc(-1 * var(--header-height, 88px));
                padding: calc(40px + var(--header-height, 88px)) 0 0;
                overflow: hidden;
            }

            .hero-overlay {
                position: absolute;
                inset: 0;
                background: rgba(0, 0, 0, 0.45);
            }

            .hero-content-wrapper {
                position: relative;
                z-index: 1;
                width: min(1120px, 92vw);
                margin: 0 auto;
                flex: 0 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: flex-start;
                gap: 24px;
            }

            .hero-main {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 16px;
                width: 100%;
                max-width: 720px;
                margin: 0 auto;
                text-align: center;
            }

            .hero-badge {
                display: inline-block;
                background: rgba(0, 0, 0, 0.55);
                color: #FFFFFF;
                padding: 8px 20px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-shadow:
                    0 0 3px rgba(0, 0, 0, 0.8),
                    0 0 8px rgba(0, 0, 0, 0.6);
            }

            .hero-title {
                font-size: clamp(32px, 5vw, 56px);
                color: #FFFFFF;
                margin-bottom: 16px;
                font-weight: 700;
                text-shadow:
                    0 0 4px rgba(0, 0, 0, 0.85),
                    0 0 12px rgba(0, 0, 0, 0.6),
                    0 0 18px rgba(0, 0, 0, 0.45);
            }

            .hero-subtitle {
                font-size: clamp(16px, 2vw, 20px);
                color: #FFFFFF;
                max-width: 600px;
                margin: 0 auto;
                text-shadow:
                    0 0 3px rgba(0, 0, 0, 0.8),
                    0 0 10px rgba(0, 0, 0, 0.6);
            }

            .hero-headline {
                position: relative;
                z-index: 1;
                align-self: stretch;
                width: 100%;
                margin-top: auto;
                text-align: left;
                color: #FFFFFF;
            }

            .hero-headline-viewport {
                position: relative;
                overflow: hidden;
                background: rgba(255, 193, 7, 0.3);
                height: 30px;
                display: flex;
                align-items: stretch;
            }

            .hero-headline-track {
                display: flex;
                flex-direction: column;
                transition: transform 0.6s ease;
                will-change: transform;
            }

            .hero-headline-item {
                display: flex;
                align-items: center;
                height: 44px;
                padding: 0 clamp(18px, 4vw, 40px);
                font-size: 18px;
                font-weight: 600;
                white-space: nowrap;
                color: inherit;
                text-align: left;
                justify-content: flex-start;
                width: 100%;
            }

            .hero-headline-text {
                display: inline-block;
                will-change: transform;
                transition: transform 0.8s ease;
                text-shadow:
                    0 0 2px rgba(0, 0, 0, 0.9),
                    0 0 4px rgba(0, 0, 0, 0.7);
            }

            /* Stats Section */
            .stats-section {
                background: transparent;
                padding: 24px 0;
                margin-top: -30px;
                position: relative;
                z-index: 2;
            }

            .stats-container {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
            }

            .stat-card {
                display: flex;
                align-items: flex-start;
                gap: 16px;
                padding: 16px 0;
                border-bottom: 1px solid rgba(255, 255, 255, 0.25);
                transition: color 0.3s ease;
            }

            .stat-card:last-child {
                border-bottom: none;
            }

            .stat-card:hover {
                color: rgba(255, 255, 255, 0.85);
            }

            .stat-icon {
                font-size: 48px;
                line-height: 1;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 700;
                color: #90CAF9;
                margin-bottom: 4px;
            }

            .stat-label {
                font-size: 14px;
                color: #607D8B;
                font-weight: 500;
            }

            /* Content Section */
            .content-section {
                padding: 80px 20px;
            }

            .section-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .section-header-wrapper {
                text-align: center;
                margin-bottom: 50px;
            }

            .section-title {
                font-size: clamp(28px, 4vw, 36px);
                color: #263238;
                margin-bottom: 12px;
            }

            .section-description {
                font-size: 18px;
                color: #607D8B;
            }

            /* Feature Grid */
            .feature-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 30px;
            }

            .feature-card {
                background: white;
                padding: 40px 30px;
                border-radius: 16px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: 2px solid #E3F2FD;
            }

            .feature-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 40px rgba(144, 202, 249, 0.2);
                border-color: #90CAF9;
            }

            .feature-icon {
                font-size: 56px;
                margin-bottom: 20px;
            }

            .feature-title {
                font-size: 22px;
                color: #263238;
                margin-bottom: 12px;
            }

            .feature-description {
                font-size: 15px;
                color: #607D8B;
                margin-bottom: 24px;
                line-height: 1.6;
            }

            .feature-link {
                display: inline-block;
                color: #90CAF9;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                transition: transform 0.2s ease;
            }

            .feature-link:hover {
                transform: translateX(5px);
            }

            /* Greeting Section */
            .greeting-section {
                background: linear-gradient(135deg, #E3F2FD 0%, #F9FAFB 100%);
                padding: 80px 20px;
            }

            .greeting-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 60px;
                align-items: center;
            }

            .greeting-photo {
                display: flex;
                justify-content: center;
            }

            .photo-frame {
                width: 100%;
                max-width: 400px;
                aspect-ratio: 4/5;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 20px 60px rgba(144, 202, 249, 0.3);
            }

            .photo-frame img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .greeting-badge {
                display: inline-block;
                background: #90CAF9;
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                letter-spacing: 0.5px;
                margin-bottom: 16px;
            }

            .greeting-title {
                font-size: 32px;
                color: #263238;
                margin-bottom: 24px;
            }

            .greeting-text {
                margin-bottom: 30px;
            }

            .greeting-text p {
                font-size: 16px;
                color: #37474F;
                margin-bottom: 16px;
                line-height: 1.8;
            }

            .greeting-button {
                display: inline-block;
                background: #90CAF9;
                color: white;
                padding: 14px 32px;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(144, 202, 249, 0.3);
            }

            .greeting-button:hover {
                background: #64B5F6;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(144, 202, 249, 0.4);
            }

            .greeting-button-icon {
                margin-left: 8px;
                display: inline-block;
                transition: transform 0.3s ease;
            }

            .greeting-button:hover .greeting-button-icon {
                transform: translateX(4px);
            }

            /* Map Section */
            .map-section {
                background: white;
            }

            .map-container {
                width: min(1120px, 92vw);
                margin: 0 auto;
                display: grid;
                gap: 24px;
            }

            .map-display {
                background: rgba(144, 202, 249, 0.25);
                border-radius: 24px;
                padding: clamp(12px, 2.2vw, 20px);
                box-shadow: 0 18px 38px rgba(21, 101, 192, 0.18);
                display: flex;
                flex-direction: column;
                align-items: stretch;
                justify-content: center;
                overflow: hidden;
            }

            .map-toggle {
                margin-top: 16px;
                display: flex;
                align-items: center;
                gap: 16px;
                flex-wrap: wrap;
            }

            .map-toggle-label {
                font-size: 14px;
                font-weight: 600;
                color: #1565C0;
                text-transform: uppercase;
                letter-spacing: 0.4px;
            }

            .map-toggle-switch {
                position: relative;
                display: inline-flex;
                align-items: center;
                cursor: pointer;
                user-select: none;
            }

            .map-toggle-switch input {
                position: absolute;
                opacity: 0;
                pointer-events: none;
            }

            .map-toggle-slider {
                position: relative;
                display: inline-flex;
                align-items: center;
                justify-content: space-between;
                background: #E3F2FD;
                border-radius: 999px;
                padding: 4px;
                min-width: 160px;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.4px;
                color: #1565C0;
                transition: background 0.3s ease;
            }

            .map-toggle-slider::before {
                content: '';
                position: absolute;
                top: 4px;
                bottom: 4px;
                left: 4px;
                width: calc(50% - 4px);
                border-radius: 999px;
                background: #1565C0;
                transition: transform 0.3s ease;
            }

            .map-toggle-switch input:checked + .map-toggle-slider::before {
                transform: translateX(100%);
            }

            .map-toggle-option {
                position: relative;
                z-index: 1;
                flex: 1;
                text-align: center;
                transition: color 0.3s ease;
            }

            .map-toggle-switch input:not(:checked) + .map-toggle-slider .map-toggle-option-default,
            .map-toggle-switch input:checked + .map-toggle-slider .map-toggle-option-satellite {
                color: #FFFFFF;
            }

            .map-toggle-switch input:not(:checked) + .map-toggle-slider .map-toggle-option-satellite,
            .map-toggle-switch input:checked + .map-toggle-slider .map-toggle-option-default {
                color: #1565C0;
            }

            .map-toggle-caption {
                font-size: 13px;
                color: #546E7A;
                font-weight: 500;
            }

            .map-placeholder {
                background: linear-gradient(135deg, #E3F2FD 0%, #F9FAFB 100%);
                border-radius: inherit;
                padding: clamp(60px, 12vw, 120px) 40px;
                text-align: center;
                border: 2px dashed #90CAF9;
            }

            .map-image {
                flex: 1;
                background: transparent;
                border-radius: inherit;
                padding: 0;
                display: flex;
                align-items: stretch;
                justify-content: center;
                min-height: 360px;
            }

            .map-display[data-map-display] .map-image {
                display: none;
            }

            .map-display[data-map-display] .map-image.is-active {
                display: flex;
            }

            .map-image img {
                width: 100%;
                height: 100%;
                border-radius: inherit;
                object-fit: cover;
                display: block;
            }

            .map-icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            .map-text {
                font-size: 20px;
                color: #263238;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .map-subtext {
                font-size: 16px;
                color: #607D8B;
            }

            /* Structure Section */
            .structure-section {
                background: linear-gradient(135deg, #F9FAFB 0%, #E3F2FD 100%);
            }

            .structure-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 30px;
            }

            .structure-card {
                background: white;
                padding: 30px 20px;
                border-radius: 16px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .structure-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(144, 202, 249, 0.2);
            }

            .structure-photo {
                width: 120px;
                height: 120px;
                margin: 0 auto 20px;
                border-radius: 50%;
                overflow: hidden;
                border: 4px solid #E3F2FD;
            }

            .structure-photo img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .structure-name {
                font-size: 18px;
                font-weight: 600;
                color: #263238;
                margin-bottom: 8px;
            }

            .structure-role {
                font-size: 14px;
                color: #90CAF9;
                font-weight: 500;
            }

            /* Admin Section */
            .admin-section {
                background: #F5F7FA;
            }

            .admin-grid {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 20px;
            }

            .admin-card {
                display: grid;
                grid-template-columns: 160px 1fr;
                align-items: stretch;
                background: #FFFFFF;
                border-radius: 12px;
                box-shadow: 0 10px 24px rgba(15, 45, 60, 0.12);
                overflow: hidden;
                border: 1px solid rgba(226, 232, 240, 0.8);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .admin-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 16px 32px rgba(30, 136, 229, 0.18);
            }

            .admin-value-block {
                background: linear-gradient(135deg, #417dffff 0%, #6467ffff 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 22px;
            }

            .admin-value {
                font-size: 32px;
                font-weight: 700;
                color: #FFFFFF;
            }

            .admin-label {
                font-size: 26px;    
                color: #455A64;
                font-weight: 600;
                letter-spacing: 0.02em;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #FAFBFC;
            }

            @media (max-width: 768px) {
                .admin-grid {
                    grid-template-columns: 1fr;
                }
            }

            /* Potential Section */
            .potential-section {
                background: linear-gradient(135deg, #E3F2FD 0%, #F9FAFB 100%);
            }

            .section-header-flex {
                display: flex;
                justify-content: space-between;
                align-items: flex-end;
                margin-bottom: 50px;
                flex-wrap: wrap;
                gap: 20px;
            }

            .header-button {
                display: inline-block;
                background: white;
                color: #90CAF9;
                padding: 12px 28px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                transition: all 0.3s ease;
                border: 2px solid #90CAF9;
            }

            .header-button:hover {
                background: #90CAF9;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(144, 202, 249, 0.3);
            }

            .potential-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin-bottom: 30px;
            }

            .potential-card {
                background: white;
                padding: 40px 30px;
                border-radius: 16px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .potential-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(144, 202, 249, 0.2);
            }

            .potential-icon {
                font-size: 56px;
                margin-bottom: 20px;
            }

            .potential-category {
                display: inline-block;
                background: #E3F2FD;
                color: #90CAF9;
                padding: 6px 14px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 600;
                margin-bottom: 16px;
            }

            .potential-title {
                font-size: 22px;
                color: #263238;
                margin-bottom: 12px;
            }

            .potential-status {
                font-size: 15px;
                color: #607D8B;
                line-height: 1.6;
            }

            .potential-note {
                text-align: center;
                padding: 20px;
                background: rgba(255, 224, 130, 0.2);
                border-radius: 12px;
            }

            .potential-note p {
                font-size: 14px;
                color: #607D8B;
                font-style: italic;
            }
            .potential-thumb {
                position: relative;
                width: 100%;
                padding-top: 56%; /* 16:9 */
                border-radius: 14px;
                overflow: hidden;
                margin-bottom: 16px;
                background: #f3f6f9;
                border: 1px solid #e9eef5;
            }

            .potential-thumb img {
                position: absolute;
                inset: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            /* News Section */
            .news-section {
                background: white;
            }

            .news-grid {
                display: grid;
                grid-template-columns: repeat(4, minmax(0, 1fr));
                gap: 26px;
                justify-items: center;
            }

            .news-card {
                background: #F9FAFB;
                border-radius: 16px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: 2px solid transparent;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                min-height: 100%;
                width: 100%;
                max-width: 260px;
            }

            @media (max-width: 1280px) {
                .news-grid {
                    grid-template-columns: repeat(3, minmax(0, 1fr));
                }
            }

            @media (max-width: 1024px) {
                .news-grid {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }
            }

            .news-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 40px rgba(144, 202, 249, 0.2);
                background: white;
                border-color: #E3F2FD;
            }

            .news-card-image {
                position: relative;
                width: 100%;
                padding-top: 56%;
                overflow: hidden;
            }

            .news-card-image img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .news-card-content {
                display: flex;
                flex-direction: column;
                gap: 16px;
                padding: 24px 28px 28px;
                height: 100%;
            }

            .news-meta {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 12px;
            }

            .news-views {
                font-size: 12px;
                color: #78909C;
                font-weight: 600;
                white-space: nowrap;
            }

            .news-title {
                font-size: 20px;
                color: #263238;
                line-height: 1.4;
            }

            .news-excerpt {
                font-size: 15px;
                color: #607D8B;
                line-height: 1.7;
            }

            .news-link {
                display: inline-block;
                color: #90CAF9;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                transition: transform 0.2s ease;
                margin-top: auto;
            }

            .news-link:hover {
                transform: translateX(5px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .map-toggle {
                    gap: 12px;
                }

                .map-container {
                    gap: 20px;
                }

                .map-display {
                    padding: clamp(8px, 4vw, 14px);
                    border-radius: 18px;
                }

                .map-image {
                    min-height: 260px;
                }

                .map-toggle-slider {
                    min-width: 140px;
                    font-size: 12px;
                }

                .map-toggle-label,
                .map-toggle-caption {
                    font-size: 12px;
                }

                .hero-section {
                    min-height: 460px;
                    padding: calc(30px + var(--header-height, 88px)) 0 0;
                }

                .hero-content-wrapper {
                    gap: 16px;
                    padding: 0 20px;
                }

                .hero-headline-viewport {
                    height: 25px;
                }

                .hero-headline-item {
                    height: 40px;
                    font-size: 16px;
                    padding: 0 clamp(14px, 5vw, 26px);
                }

                .stats-section {
                    margin-top: -40px;
                    padding: 24px 16px;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .content-section {
                    padding: 50px 20px;
                }

                .section-header-wrapper {
                    margin-bottom: 35px;
                }

                .feature-grid,
                .structure-grid,
                .admin-grid,
                .potential-grid,
                .news-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .greeting-grid {
                    grid-template-columns: 1fr;
                    gap: 40px;
                }

                .greeting-section {
                    padding: 50px 20px;
                }

                .section-header-flex {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 20px;
                }

                .header-button {
                    width: 100%;
                    text-align: center;
                }

                .map-placeholder {
                    padding: 48px 20px;
                }

                .map-icon {
                    font-size: 60px;
                }

                .map-image img {
                    border-radius: inherit;
                }
            }

            @media (max-width: 480px) {
                .hero-badge {
                    font-size: 12px;
                    padding: 6px 16px;
                }

                .hero-headline-viewport {
                    height: 36px;
                }

                .hero-headline-item {
                    height: 36px;
                    font-size: 15px;
                    padding: 0 clamp(12px, 6vw, 20px);
                }

                .stat-icon {
                    font-size: 40px;
                }

                .stat-value {
                    font-size: 28px;
                }

                .map-display {
                    padding: 10px;
                    border-radius: 16px;
                }

                .map-image {
                    min-height: 200px;
                }

                .map-placeholder {
                    padding: 40px 16px;
                }

                .feature-card,
                .news-card {
                    padding: 25px 20px;
                }

                .feature-icon,
                .admin-icon,
                .potential-icon {
                    font-size: 48px;
                }

                .admin-value {
                    font-size: 32px;
                }

                .structure-photo {
                    width: 100px;
                    height: 100px;
                }

                .greeting-title {
                    font-size: 26px;
                }

                .greeting-text p {
                    font-size: 15px;
                }

                .greeting-button {
                    width: 100%;
                    text-align: center;
                }
            }

            /* Smooth Scroll Behavior */
            html {
                scroll-behavior: smooth;
            }

            /* Loading Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .stat-card,
            .feature-card,
            .structure-card,
            .admin-card,
            .potential-card,
            .news-card {
                animation: fadeInUp 0.6s ease-out backwards;
            }

            .stat-card:nth-child(1) { animation-delay: 0.1s; }
            .stat-card:nth-child(2) { animation-delay: 0.2s; }
            .stat-card:nth-child(3) { animation-delay: 0.3s; }

            .feature-card:nth-child(1) { animation-delay: 0.1s; }
            .feature-card:nth-child(2) { animation-delay: 0.2s; }
            .feature-card:nth-child(3) { animation-delay: 0.3s; }
            .feature-card:nth-child(4) { animation-delay: 0.4s; }

            /* Accessibility Improvements */
            a:focus,
            button:focus {
                outline: 3px solid #90CAF9;
                outline-offset: 2px;
            }

            /* Print Styles */
            @media print {
                .hero-section {
                    background: white;
                    color: black;
                    min-height: auto;
                    padding: 20px;
                }

                .stat-card,
                .feature-card,
                .structure-card,
                .admin-card,
                .potential-card,
                .news-card {
                    break-inside: avoid;
                    box-shadow: none;
                    border: 1px solid #ddd;
                }

                .greeting-button,
                .feature-link,
                .news-link,
                .header-button {
                    display: none;
                }
            }

            /* Dark Mode Support (optional) */
            @media (prefers-color-scheme: dark) {
                /* Uncomment to enable dark mode
                body {
                    background-color: #1a1a1a;
                    color: #e0e0e0;
                }

                .hero-section {
                    background: linear-gradient(135deg, #1976D2 0%, #0D47A1 100%);
                }

                .section-title,
                .feature-title,
                .greeting-title,
                .structure-name,
                .news-title {
                    color: #e0e0e0;
                }
                */
            }

            /* Custom Scrollbar */
            ::-webkit-scrollbar {
                width: 10px;
            }

            ::-webkit-scrollbar-track {
                background: #F9FAFB;
            }

            ::-webkit-scrollbar-thumb {
                background: #90CAF9;
                border-radius: 5px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: #64B5F6;
            }

            /* Selection Color */
            ::selection {
                background: #90CAF9;
                color: white;
            }

            ::-moz-selection {
                background: #90CAF9;
                color: white;
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var heroHeadline = document.querySelector('.hero-headline');
                if (heroHeadline) {
                    var viewport = heroHeadline.querySelector('.hero-headline-viewport');
                    var track = heroHeadline.querySelector('.hero-headline-track');
                    var items = Array.prototype.slice.call(heroHeadline.querySelectorAll('.hero-headline-item'));

                    if (viewport && track && items.length > 0) {
                        var intervalAttr = parseInt(heroHeadline.getAttribute('data-interval') || '', 8.5);
                        var interval = Number.isFinite(intervalAttr) && intervalAttr > 0 ? intervalAttr : 10000;

                        var currentIndex = 0;
                        var timerId;
                        var positions = [];
                        var positionIndex = -1;

                        var setTrackPosition = function (index, animate) {
                            var itemHeight = items[0] ? items[0].offsetHeight : 0;
                            var offset = itemHeight * index;
                            if (!animate) {
                                var previousTransition = track.style.transition;
                                track.style.transition = 'none';
                                track.style.transform = 'translateY(-' + offset + 'px)';
                                void track.offsetHeight;
                                track.style.transition = previousTransition || 'transform 0.6s ease';
                            } else {
                                track.style.transition = 'transform 0.6s ease';
                                track.style.transform = 'translateY(-' + offset + 'px)';
                            }
                        };

                        var schedule = function (callback, delay) {
                            window.clearTimeout(timerId);
                            timerId = window.setTimeout(callback, delay);
                        };

                        var resetText = function (textEl) {
                            textEl.style.transition = 'none';
                            textEl.style.transform = 'translateX(0px)';
                            void textEl.offsetWidth;
                            textEl.style.transition = 'transform 0.8s ease';
                        };

                        var prepareText = function (item) {
                            var textEl = item.querySelector('.hero-headline-text');
                            if (!textEl) {
                                return { positions: [] };
                            }

                            resetText(textEl);

                            var viewportWidth = viewport.clientWidth;
                            var textWidth = textEl.scrollWidth;

                            if (textWidth <= viewportWidth + 1) {
                                return { positions: [], element: textEl };
                            }

                            var maxOffset = textWidth - viewportWidth;
                            var stepWidth = viewportWidth;
                            var stepPositions = [];
                            var current = 0;
                            while (current < maxOffset) {
                                current = Math.min(current + stepWidth, maxOffset);
                                stepPositions.push(current);
                            }

                            return { positions: stepPositions, element: textEl };
                        };

                        var playHorizontalShift = function () {
                            positionIndex++;
                            if (positionIndex >= positions.length) {
                                schedule(nextHeadline, interval);
                                return;
                            }

                            var item = items[currentIndex];
                            var textEl = item.querySelector('.hero-headline-text');
                            if (!textEl) {
                                schedule(nextHeadline, interval);
                                return;
                            }

                            textEl.style.transform = 'translateX(-' + positions[positionIndex] + 'px)';
                            schedule(playHorizontalShift, interval);
                        };

                        var nextHeadline = function () {
                            var nextIndex = (currentIndex + 1) % items.length;
                            showHeadline(nextIndex);
                        };

                        var showHeadline = function (index, options) {
                            options = options || {};
                            currentIndex = index;

                            items.forEach(function (item, itemIndex) {
                                var textEl = item.querySelector('.hero-headline-text');
                                if (textEl && itemIndex !== index) {
                                    resetText(textEl);
                                }
                                item.classList.toggle('is-active', itemIndex === index);
                            });

                            setTrackPosition(index, !options.instant);

                            var meta = prepareText(items[index]);
                            positions = meta.positions;
                            positionIndex = -1;

                            if (positions.length === 0) {
                                schedule(nextHeadline, interval);
                            } else {
                                schedule(playHorizontalShift, interval);
                            }
                        };

                        window.addEventListener('resize', function () {
                            window.clearTimeout(timerId);
                            showHeadline(currentIndex, { instant: true });
                        });

                        showHeadline(0, { instant: true });
                    }
                }

                var mapSection = document.querySelector('[data-map-section]');
                if (mapSection) {
                    var toggleInput = mapSection.querySelector('[data-map-toggle-input]');
                    var mapItemsArray = Array.prototype.slice.call(mapSection.querySelectorAll('[data-map-view]'));
                    var toggleCaption = mapSection.querySelector('[data-map-toggle-caption]');

                    if (mapItemsArray.length > 0) {
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
                                var defaultText = toggleCaption.getAttribute('data-default') || toggleCaption.textContent || 'Peta Wilayah';
                                var satelliteText = toggleCaption.getAttribute('data-satellite') || 'Peta Citra';
                                toggleCaption.textContent = fallbackView === 'satellite' ? satelliteText : defaultText;
                            }

                            setMapMode(fallbackView);
                        }
                    }
                }
            });
        </script>
        <?php
    },
]);










