<?php

declare(strict_types=1);

$greetingDefaultParagraphs = [
    'Selamat datang di website resmi Desa Sendangan. Kami berkomitmen untuk memberikan pelayanan terbaik kepada masyarakat dan membangun desa yang lebih maju, sejahtera, dan bermartabat.',
    'Melalui website ini, kami berharap dapat meningkatkan transparansi dan komunikasi dengan seluruh warga. Mari bersama-sama membangun Desa Sendangan yang lebih baik.',
];

$dynamicDefaults = [
    'greeting.hukum_tua' => implode("\n\n", $greetingDefaultParagraphs),
    'media.peta_desa_sendangan' => 'peta-desa-sendangan.jpg',
    'media.peta_desa_sendangan_citra' => 'peta-desa-sendangan-citra.jpg',
];

$dynamicValues = data_values($dynamicDefaults) + $dynamicDefaults;

$rawGreeting = (string) $dynamicValues['greeting.hukum_tua'];
$paragraphs = array_values(
    array_filter(
        array_map(
            static fn (string $line): string => trim($line),
            preg_split("/\r?\n\r?\n|\r?\n/", $rawGreeting) ?: []
        ),
        static fn (string $line): bool => $line !== ''
    )
);

if ($paragraphs === []) {
    $paragraphs = $greetingDefaultParagraphs;
}

$mapMedia = trim((string) $dynamicValues['media.peta_desa_sendangan']);
$mapMedia = $mapMedia !== '' ? $mapMedia : null;

$mapMediaSatellite = trim((string) ($dynamicValues['media.peta_desa_sendangan_citra'] ?? ''));
$mapMediaSatellite = $mapMediaSatellite !== '' ? $mapMediaSatellite : null;

return [
    'greeting' => [
        'badge' => 'SAMBUTAN HUKUM TUA',
        'name' => 'Johny R. Mandagi',
        'message' => $paragraphs,
        'cta_label' => 'Profil Desa',
        'cta_link' => 'profil.php',
        'photo' => null,
    ],
    'map' => [
        'title' => 'Peta Desa Sendangan',
        'description' => 'Lokasi fasilitas umum, batas wilayah, dan potensi desa dalam satu tampilan interaktif.',
        'media' => $mapMedia,
        'media_satellite' => $mapMediaSatellite,
    ],
    'stats' => [
        ['label' => 'Jumlah Penduduk', 'value' => '1.234', 'note' => 'Data 2024'],
        ['label' => 'Jumlah KK', 'value' => '345', 'note' => ''],
        ['label' => 'Luas Wilayah', 'value' => '420 ha', 'note' => ''],
        ['label' => 'Jumlah Jaga', 'value' => '8', 'note' => ''],
    ],
    'features' => [
        [
            'title' => 'Profil Desa',
            'summary' => 'Kenali sejarah, visi misi, dan kondisi sosial Desa Sendangan.',
            'link' => 'profil.php',
        ],
        [
            'title' => 'Informasi Publik',
            'summary' => 'Dokumen, berita, dan pengumuman resmi pemerintahan desa.',
            'link' => 'info_publik.php',
        ],
        [
            'title' => 'Transparansi APBDes',
            'summary' => 'Lihat ringkasan pendapatan dan belanja desa secara berkala.',
            'link' => 'apbdes.php',
        ],
        [
            'title' => 'Potensi Desa',
            'summary' => 'UMKM unggulan, wisata desa, dan potensi budaya.',
            'link' => 'potensi.php',
        ],
    ],
    'potentials' => [
        [
            'title' => 'Kolam Air Panas',
            'category' => 'Wisata',
            'status' => 'Perencanaan 2025',
        ],
        [
            'title' => 'Waruga',
            'category' => 'Situs Sejarah',
            'status' => 'Pelestarian',
        ],
        [
            'title' => 'Tukang Urut',
            'category' => 'UMKM',
            'status' => 'Aktif',
        ],
    ],
    'news' => [
        [
            'berita_judul' => 'Pelatihan Digital untuk UMKM Sendangan',
            'berita_isi' => 'Pemerintah desa berkolaborasi dengan komunitas pemuda untuk memberikan pelatihan pemasaran digital kepada para pelaku UMKM. Materi mencakup pengelolaan media sosial, fotografi produk, hingga penggunaan marketplace.',
            'berita_gambar' => 'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a',
            'berita_dilihat' => 128,
        ],
        [
            'berita_judul' => 'Jadwal Layanan Administrasi Desa',
            'berita_isi' => 'Pelayanan administrasi kependudukan kini tersedia setiap Selasa dan Kamis pukul 09.00-14.00 WITA. Warga diimbau membawa dokumen pendukung yang lengkap untuk mempercepat proses pelayanan.',
            'berita_gambar' => 'https://images.unsplash.com/photo-1522071820081-009f0129c71c',
            'berita_dilihat' => 94,
        ],
        [
            'berita_judul' => 'Gotong Royong Bersih Desa',
            'berita_isi' => 'Kegiatan gotong royong rutin digelar pada Sabtu pekan pertama di setiap bulan. Warga berkumpul di Balai Desa sebelum bersama-sama membersihkan area publik dan saluran air.',
            'berita_gambar' => 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d',
            'berita_dilihat' => 76,
        ],
    ],
    'administrasi' => [
        ['label' => 'Data Penduduk', 'value' => 'Terintegrasi Dukcapil'],
        ['label' => 'Layanan Online', 'value' => 'Mandiri & On-site'],
        ['label' => 'Jam Pelayanan', 'value' => 'Senin - Jumat, 08.00 - 15.00 WITA'],
    ],
];

