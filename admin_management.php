<?php

declare(strict_types=1);

require __DIR__ . '/app/bootstrap.php';

if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start([
        'cookie_httponly' => true,
        'use_strict_mode' => true,
    ]);
}

$adminSession = $_SESSION['admin'] ?? null;
$isAuthorized = is_array($adminSession) && isset($adminSession['id']) && (int) $adminSession['id'] > 0;

if (!$isAuthorized) {
    header('Location: admin.php');
    exit;
}

try {
    $pdo = db();
} catch (Throwable $exception) {
    http_response_code(500);
    echo '<h1>Kesalahan Server</h1>';
    echo '<p>Tidak dapat terhubung ke database: ' . e($exception->getMessage()) . '</p>';
    exit;
}

function fetch_table(PDO $pdo, string $sql, array $params = []): array
{
    try {
        $stmt = $pdo->prepare($sql);
        if ($stmt === false) {
            return [];
        }
        $stmt->execute($params);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return is_array($results) ? $results : [];
    } catch (Throwable) {
        return [];
    }
}

function format_datetime(null|string $value): string
{
    if ($value === null || $value === '') {
        return '-';
    }

    try {
        $ts = strtotime($value);
        if ($ts === false) {
            return $value;
        }
        return date('d M Y H:i', $ts);
    } catch (Throwable) {
        return $value;
    }
}

$apbdes = fetch_table($pdo, 'SELECT apbdes_id, apbdes_judul, apbdes_file, apbdes_edited_by, apbdes_created_at, apbdes_updated_at FROM apbdes ORDER BY apbdes_updated_at DESC LIMIT 50');
$berita = fetch_table($pdo, 'SELECT berita_id, berita_judul, berita_gambar, berita_dilihat, berita_created_at, berita_updated_at FROM berita ORDER BY berita_updated_at DESC LIMIT 50');
$fasilitas = fetch_table($pdo, 'SELECT fasilitas_id, fasilitas_nama, fasilitas_gambar, fasilitas_gmaps_link, fasilitas_created_at, fasilitas_updated_at FROM fasilitas ORDER BY fasilitas_updated_at DESC LIMIT 50');
$galeri = fetch_table($pdo, 'SELECT galeri_id, galeri_namafile, galeri_keterangan, galeri_gambar, galeri_created_at FROM galeri ORDER BY galeri_created_at DESC LIMIT 50');
$gambarPotensi = fetch_table($pdo, 'SELECT gambar_id, potensi_id, gambar_namafile, gambar_created_at FROM gambar_potensi_desa ORDER BY gambar_created_at DESC LIMIT 50');
$potensiDesa = fetch_table($pdo, 'SELECT potensi_id, potensi_judul, potensi_kategori, potensi_gmaps_link, potensi_created_at, potensi_updated_at FROM potensi_desa ORDER BY potensi_updated_at DESC LIMIT 50');
$pengumuman = fetch_table($pdo, 'SELECT pengumuman_id, pengumuman_valid_hingga, pengumuman_created_at, pengumuman_updated_at FROM pengumuman ORDER BY pengumuman_updated_at DESC LIMIT 50');
$permohonanInformasi = fetch_table($pdo, 'SELECT pi_id, pi_email, pi_asal_instansi, pi_selesai, pi_created_at, pi_updated_at FROM permohonan_informasi ORDER BY pi_updated_at DESC LIMIT 50');
$ppidDokumen = fetch_table($pdo, 'SELECT ppid_id, ppid_judul, ppid_kategori, ppid_namafile, ppid_created_at, ppid_updated_at FROM ppid_dokumen ORDER BY ppid_updated_at DESC LIMIT 50');
$programDesa = fetch_table($pdo, 'SELECT program_id, program_nama, program_gambar, program_created_at, program_updated_at FROM program_desa ORDER BY program_updated_at DESC LIMIT 50');
$strukturOrganisasi = fetch_table($pdo, 'SELECT struktur_id, struktur_nama, struktur_jabatan, struktur_foto, struktur_created_at, struktur_updated_at FROM struktur_organisasi ORDER BY struktur_updated_at DESC LIMIT 50');

function section_card(string $title, string $description, array $headers, array $rows, callable $rowRenderer): string
{
    $headerHtml = '';
    foreach ($headers as $header) {
        $headerHtml .= '<th>' . e($header) . '</th>';
    }

    $bodyHtml = '';
    if ($rows === []) {
        $bodyHtml = '<tr><td colspan="' . count($headers) . '" class="empty-state">Belum ada data.</td></tr>';
    } else {
        foreach ($rows as $row) {
            $bodyHtml .= $rowRenderer($row);
        }
    }

    return '
    <section class="card">
        <header class="card__header">
            <div>
                <h2>' . e($title) . '</h2>
                <p>' . e($description) . '</p>
            </div>
            <span class="badge">' . count($rows) . ' item</span>
        </header>
        <div class="table-wrapper">
            <table>
                <thead><tr>' . $headerHtml . '</tr></thead>
                <tbody>' . $bodyHtml . '</tbody>
            </table>
        </div>
    </section>';
}

?><!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manajemen Konten | Desa Sendangan</title>
    <style>
        :root {
            color-scheme: light;
            font-family: "Inter", system-ui, -apple-system, "Segoe UI", sans-serif;
            background-color: #f1f5f9;
        }

        body {
            margin: 0;
            background: #f8fafc;
            color: #0f172a;
        }

        a {
            color: inherit;
        }

        .layout {
            min-height: 100vh;
        }

        .sidebar {
            position: fixed;
            inset: 0 auto 0 0;
            width: 280px;
            background: #1d4ed8;
            color: #ffffff;
            padding: 32px 28px;
            display: flex;
            flex-direction: column;
            gap: 40px;
            overflow-y: auto;
            box-shadow: 10px 0 30px rgba(29, 78, 216, 0.25);
            /* scrollbar-width: none; */
        }

        .sidebar::-webkit-scrollbar {
            /* display: none; */
        }

        .sidebar h1 {
            margin: 0;
            font-size: 28px;
            letter-spacing: -0.02em;
        }

        .sidebar nav {
            display: grid;
            gap: 14px;
        }

        .sidebar a {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            font-size: 15px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            padding: 10px 12px;
            border-radius: 10px;
            transition: background 0.2s ease, transform 0.2s ease;
        }

        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(4px);
        }

        .sidebar footer {
            margin-top: auto;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.65);
        }

        .content {
            margin-left: calc(280px + 20px);
            padding: 32px clamp(24px, 4vw, 48px);
        }

        .content-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 36px;
            flex-wrap: wrap;
        }

        .content-header h2 {
            margin: 0;
            font-size: 32px;
            letter-spacing: -0.02em;
        }

        .content-header span {
            color: #4b5563;
            font-size: 14px;
        }

        .cards-grid {
            display: grid;
            gap: 24px;
        }

        .card {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
            border: 1px solid rgba(226, 232, 240, 0.7);
            padding: 24px 24px 28px;
        }

        .card__header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 18px;
        }

        .card__header h2 {
            margin: 0;
            font-size: 22px;
            letter-spacing: -0.01em;
        }

        .card__header p {
            margin: 4px 0 0;
            color: #64748b;
            font-size: 13px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 14px;
            border-radius: 999px;
            background: rgba(59, 130, 246, 0.12);
            color: #1d4ed8;
            font-weight: 600;
            font-size: 12px;
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 520px;
            font-size: 14px;
        }

        th, td {
            text-align: left;
            padding: 12px 14px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.2);
        }

        thead th {
            background: rgba(226, 232, 240, 0.65);
            font-weight: 600;
            color: #1f2937;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        tbody tr:nth-child(odd) {
            background: rgba(248, 250, 252, 0.8);
        }

        .empty-state {
            text-align: center;
            color: #9ca3af;
            font-style: italic;
        }

        .table-actions {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 12px;
            color: #1d4ed8;
        }

        .table-actions a {
            color: inherit;
            text-decoration: none;
            font-weight: 600;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-pill--done {
            background: rgba(34, 197, 94, 0.15);
            color: #15803d;
        }

        .status-pill--pending {
            background: rgba(250, 204, 21, 0.18);
            color: #b45309;
        }

        .media-thumb {
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .media-thumb img {
            width: 42px;
            height: 42px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid rgba(148, 163, 184, 0.45);
        }

        .media-thumb span {
            display: inline-block;
            color: #475569;
        }

        .table small {
            display: block;
            color: #9ca3af;
            margin-top: 4px;
        }

        @media (max-width: 1024px) {
            .sidebar {
                position: relative;
                inset: auto;
                width: 100%;
                flex-direction: row;
                align-items: center;
                gap: 18px;
                box-shadow: none;
            }

            .sidebar nav {
                flex: 1;
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            .sidebar footer {
                display: none;
            }

            .content {
                margin-left: 0;
            }
        }

        @media (max-width: 640px) {
            .content {
                padding: 24px 16px 40px;
            }

            .content-header h2 {
                font-size: 26px;
            }

            table {
                min-width: 420px;
            }
        }
    </style>
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <div>
            <h1>Admin Desa</h1>
            <span><?= e($adminSession['email'] ?? 'admin@desa.id') ?></span>
        </div>
        <nav>
            <a href="#apbdes">APBDes</a>
            <a href="#berita">Berita</a>
            <a href="#fasilitas">Fasilitas</a>
            <a href="#potensi">Potensi Desa</a>
            <a href="#pengumuman">Pengumuman</a>
            <a href="#permohonan">Permohonan Informasi</a>
            <a href="#ppid">PPID Dokumen</a>
            <a href="#program">Program Desa</a>
            <a href="#galeri">Galeri</a>
            <a href="#struktur">Struktur Organisasi</a>
        </nav>
        <footer>© <?= date('Y') ?> Desa Sendangan</footer>
    </aside>

    <main class="content">
        <div class="content-header">
            <div>
                <h2>Ringkasan Konten</h2>
                <span>Versi baca saja. Silakan kembangkan CRUD sesuai kebutuhan.</span>
            </div>
            <span>Total sumber konten: 10 tabel</span>
        </div>

        <div class="cards-grid">
            <div id="apbdes">
                <?= section_card(
                    'Dokumen APBDes',
                    'Daftar dokumen APBDes terbaru.',
                    ['ID', 'Judul', 'Berkas', 'Diubah oleh', 'Dibuat', 'Diperbarui'],
                    $apbdes,
                    static function (array $row): string {
                        $file = (string) ($row['apbdes_file'] ?? '');
                        $fileLink = $file !== '' ? '<a href="' . e(base_uri('uploads/' . ltrim($file, '/'))) . '" target="_blank" rel="noopener">Lihat</a>' : '-';
                        return '<tr>'
                            . '<td>#' . e((string) $row['apbdes_id']) . '</td>'
                            . '<td>' . e((string) $row['apbdes_judul']) . '</td>'
                            . '<td>' . $fileLink . '</td>'
                            . '<td>' . e((string) ($row['apbdes_edited_by'] ?? '')) . '</td>'
                            . '<td>' . e(format_datetime($row['apbdes_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['apbdes_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="berita">
                <?= section_card(
                    'Berita Desa',
                    'Artikel dan berita dari info publik.',
                    ['ID', 'Judul', 'Gambar', 'Dibaca', 'Dibuat', 'Diperbarui'],
                    $berita,
                    static function (array $row): string {
                        $thumb = (string) ($row['berita_gambar'] ?? '');
                        $thumbHtml = $thumb !== '' ? '<div class="media-thumb"><img src="' . e($thumb) . '" alt="thumb"><span>Lihat</span></div>' : '-';
                        return '<tr>'
                            . '<td>#' . e((string) $row['berita_id']) . '</td>'
                            . '<td>' . e((string) $row['berita_judul']) . '</td>'
                            . '<td>' . $thumbHtml . '</td>'
                            . '<td>' . e((string) ($row['berita_dilihat'] ?? 0)) . ' kali</td>'
                            . '<td>' . e(format_datetime($row['berita_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['berita_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="fasilitas">
                <?= section_card(
                    'Fasilitas Desa',
                    'Data fasilitas publik dan link lokasi.',
                    ['ID', 'Nama', 'Gambar', 'Google Maps', 'Dibuat', 'Diperbarui'],
                    $fasilitas,
                    static function (array $row): string {
                        $img = (string) ($row['fasilitas_gambar'] ?? '');
                        $maps = (string) ($row['fasilitas_gmaps_link'] ?? '');
                        $imgHtml = $img !== '' ? '<div class="media-thumb"><img src="' . e($img) . '" alt="fasilitas"><span>Foto</span></div>' : '-';
                        $mapsHtml = $maps !== '' ? '<a href="' . e($maps) . '" target="_blank" rel="noopener">Buka Maps</a>' : '-';
                        return '<tr>'
                            . '<td>#' . e((string) $row['fasilitas_id']) . '</td>'
                            . '<td>' . e((string) $row['fasilitas_nama']) . '</td>'
                            . '<td>' . $imgHtml . '</td>'
                            . '<td>' . $mapsHtml . '</td>'
                            . '<td>' . e(format_datetime($row['fasilitas_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['fasilitas_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="potensi">
                <?= section_card(
                    'Potensi Desa',
                    'Daftar potensi desa beserta kategori.',
                    ['ID', 'Judul', 'Kategori', 'Google Maps', 'Dibuat', 'Diperbarui'],
                    $potensiDesa,
                    static function (array $row): string {
                        $maps = (string) ($row['potensi_gmaps_link'] ?? '');
                        $mapsHtml = $maps !== '' ? '<a href="' . e($maps) . '" target="_blank" rel="noopener">Lokasi</a>' : '-';
                        return '<tr>'
                            . '<td>#' . e((string) $row['potensi_id']) . '</td>'
                            . '<td>' . e((string) $row['potensi_judul']) . '</td>'
                            . '<td>' . e((string) $row['potensi_kategori']) . '</td>'
                            . '<td>' . $mapsHtml . '</td>'
                            . '<td>' . e(format_datetime($row['potensi_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['potensi_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="galeri">
                <?= section_card(
                    'Galeri Desa',
                    'Koleksi media foto galeri.',
                    ['ID', 'Nama File', 'Keterangan', 'Preview', 'Dibuat'],
                    $galeri,
                    static function (array $row): string {
                        $preview = (string) ($row['galeri_gambar'] ?? '');
                        $previewHtml = $preview !== '' ? '<div class="media-thumb"><img src="' . e($preview) . '" alt="galeri"><span>Preview</span></div>' : '-';
                        return '<tr>'
                            . '<td>#' . e((string) $row['galeri_id']) . '</td>'
                            . '<td>' . e((string) $row['galeri_namafile']) . '</td>'
                            . '<td>' . e((string) ($row['galeri_keterangan'] ?? '')) . '</td>'
                            . '<td>' . $previewHtml . '</td>'
                            . '<td>' . e(format_datetime($row['galeri_created_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="potensi-media">
                <?= section_card(
                    'Media Potensi Desa',
                    'Daftar gambar terkait konten potensi.',
                    ['ID', 'Potensi ID', 'Nama File', 'Dibuat'],
                    $gambarPotensi,
                    static function (array $row): string {
                        return '<tr>'
                            . '<td>#' . e((string) $row['gambar_id']) . '</td>'
                            . '<td>' . e((string) ($row['potensi_id'] ?? '-')) . '</td>'
                            . '<td>' . e((string) $row['gambar_namafile']) . '</td>'
                            . '<td>' . e(format_datetime($row['gambar_created_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="pengumuman">
                <?= section_card(
                    'Pengumuman',
                    'Informasi dan pengumuman penting desa.',
                    ['ID', 'Berlaku sampai', 'Dibuat', 'Diperbarui'],
                    $pengumuman,
                    static function (array $row): string {
                        return '<tr>'
                            . '<td>#' . e((string) $row['pengumuman_id']) . '</td>'
                            . '<td>' . e(format_datetime($row['pengumuman_valid_hingga'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['pengumuman_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['pengumuman_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="permohonan">
                <?= section_card(
                    'Permohonan Informasi',
                    'Riwayat permintaan informasi publik.',
                    ['ID', 'Email', 'Instansi', 'Status', 'Dibuat', 'Diperbarui'],
                    $permohonanInformasi,
                    static function (array $row): string {
                        $status = (int) ($row['pi_selesai'] ?? 0) === 1
                            ? '<span class="status-pill status-pill--done">Selesai</span>'
                            : '<span class="status-pill status-pill--pending">Menunggu</span>';

                        return '<tr>'
                            . '<td>#' . e((string) $row['pi_id']) . '</td>'
                            . '<td>' . e((string) ($row['pi_email'] ?? '-')) . '</td>'
                            . '<td>' . e((string) ($row['pi_asal_instansi'] ?? '-')) . '</td>'
                            . '<td>' . $status . '</td>'
                            . '<td>' . e(format_datetime($row['pi_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['pi_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="ppid">
                <?= section_card(
                    'Dokumen PPID',
                    'Daftar dokumen layanan informasi publik.',
                    ['ID', 'Judul', 'Kategori', 'Nama File', 'Dibuat', 'Diperbarui'],
                    $ppidDokumen,
                    static function (array $row): string {
                        return '<tr>'
                            . '<td>#' . e((string) $row['ppid_id']) . '</td>'
                            . '<td>' . e((string) $row['ppid_judul']) . '</td>'
                            . '<td>' . e((string) ($row['ppid_kategori'] ?? '-')) . '</td>'
                            . '<td>' . e((string) $row['ppid_namafile']) . '</td>'
                            . '<td>' . e(format_datetime($row['ppid_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['ppid_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>

            <div id="program">
                <?= section_card(
                    'Program Desa',
                    'Program kerja dan kegiatan desa.',
                    ['ID', 'Nama Program', 'Gambar', 'Dibuat', 'Diperbarui'],
                    $programDesa,
                    static function (array $row): string {
                        $img = (string) ($row['program_gambar'] ?? '');
                        $imgHtml = $img !== '' ? '<div class="media-thumb"><img src="' . e($img) . '" alt="program"><span>Media</span></div>' : '-';
                        return '<tr>'
                            . '<td>#' . e((string) $row['program_id']) . '</td>'
                            . '<td>' . e((string) $row['program_nama']) . '</td>'
                            . '<td>' . $imgHtml . '</td>'
                            . '<td>' . e(format_datetime($row['program_created_at'] ?? null)) . '</td>'
                            . '<td>' . e(format_datetime($row['program_updated_at'] ?? null)) . '</td>'
                            . '</tr>';
                    }
                ) ?>
            </div>
