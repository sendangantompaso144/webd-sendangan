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

function resolve_potensi_media_url(string $path): string
{
    $path = trim($path);
    if ($path === '') {
        return '';
    }

    $lower = strtolower($path);
    if (str_starts_with($lower, 'http://') || str_starts_with($lower, 'https://') || str_starts_with($path, '//')) {
        return $path;
    }

    $normalized = ltrim(str_replace('\\', '/', $path), '/');

    $candidates = [
        $normalized,
        'uploads/' . $normalized,
        'uploads/potensi/' . $normalized,
        'uploads/potensi_desa/' . $normalized,
        'uploads/assets/' . $normalized,
    ];

    foreach ($candidates as $candidate) {
        if (is_file(base_path($candidate))) {
            return base_uri($candidate);
        }
    }

    return base_uri($normalized);
}

$tableForms = [
    'apbdes' => [
        'table' => 'apbdes',
        'title' => 'Dokumen APBDes',
        'fields' => [
            'apbdes_judul' => ['label' => 'Judul', 'type' => 'text', 'required' => true],
            'apbdes_file' => ['label' => 'Nama Berkas', 'type' => 'file_pdf', 'required' => true],
        ],
    ],
    'berita' => [
        'table' => 'berita',
        'title' => 'Berita Desa',
        'fields' => [
            'berita_judul' => ['label' => 'Judul', 'type' => 'text', 'required' => true],
            'berita_isi' => ['label' => 'Isi Berita', 'type' => 'textarea', 'required' => true],
            'berita_gambar' => ['label' => 'Gambar', 'type' => 'file_image', 'required' => false],
        ],
    ],
    'fasilitas' => [
        'table' => 'fasilitas',
        'title' => 'Fasilitas Desa',
        'fields' => [
            'fasilitas_nama' => ['label' => 'Nama Fasilitas', 'type' => 'text', 'required' => true],
            'fasilitas_gambar' => ['label' => 'Gambar', 'type' => 'file_image', 'required' => true],
            'fasilitas_gmaps_link' => ['label' => 'Link Google Maps', 'type' => 'text', 'required' => false],
        ],
    ],
    'potensi' => [
        'table' => 'potensi_desa',
        'title' => 'Potensi Desa',
        'fields' => [
            'potensi_judul' => ['label' => 'Judul Potensi', 'type' => 'text', 'required' => true],
            'potensi_isi' => ['label' => 'Deskripsi', 'type' => 'textarea', 'required' => true],
            'potensi_kategori' => ['label' => 'Kategori', 'type' => 'select', 'required' => true, 'options' => ['Wisata', 'Budaya', 'Kuliner', 'UMKM']],
            'potensi_gmaps_link' => ['label' => 'Link Google Maps', 'type' => 'text', 'required' => false],
        ],
    ],
    'galeri' => [
        'table' => 'galeri',
        'title' => 'Galeri Desa',
        'fields' => [
            'galeri_namafile' => ['label' => 'Nama File', 'type' => 'text', 'required' => true],
            'galeri_keterangan' => ['label' => 'Keterangan', 'type' => 'textarea', 'required' => false],
            'galeri_gambar' => ['label' => 'URL Gambar', 'type' => 'text', 'required' => false],
        ],
    ],
    'potensi-media' => [
        'table' => 'gambar_potensi_desa',
        'title' => 'Tambah Foto Potensi',
        'fields' => [
            // potensi_id tidak tampil di form, dikirim otomatis dari JS
            'gambar_namafile' => ['label' => 'Upload Foto', 'type' => 'file_image', 'required' => true],
        ],
    ],
    'pengumuman' => [
        'table' => 'pengumuman',
        'title' => 'Pengumuman',
        'fields' => [
            'pengumuman_isi' => ['label' => 'Isi Pengumuman', 'type' => 'textarea', 'required' => true],
            'pengumuman_valid_hingga' => ['label' => 'Berlaku Hingga', 'type' => 'datetime', 'required' => true],
        ],
    ],
    'permohonan' => [
        'table' => 'permohonan_informasi',
        'title' => 'Permohonan Informasi',
        'fields' => [
            'pi_isi_permintaan' => ['label' => 'Isi Permintaan', 'type' => 'textarea', 'required' => true],
            'pi_email' => ['label' => 'Email Pemohon', 'type' => 'email', 'required' => false],
            'pi_asal_instansi' => ['label' => 'Asal Instansi', 'type' => 'text', 'required' => false],
            'pi_selesai' => ['label' => 'Ditandai Selesai', 'type' => 'checkbox', 'required' => false, 'default' => 0],
        ],
    ],
    'ppid' => [
        'table' => 'ppid_dokumen',
        'title' => 'Dokumen PPID',
        'fields' => [
            'ppid_judul' => ['label' => 'Judul Dokumen', 'type' => 'text', 'required' => true],
            'ppid_namafile' => ['label' => 'Nama File', 'type' => 'text', 'required' => true],
            'ppid_kategori' => ['label' => 'Kategori', 'type' => 'text', 'required' => false],
            'ppid_pi_id' => ['label' => 'Terkait Permohonan ID', 'type' => 'number', 'required' => false],
        ],
    ],
    'program' => [
        'table' => 'program_desa',
        'title' => 'Program Desa',
        'fields' => [
            'program_nama' => ['label' => 'Nama Program', 'type' => 'text', 'required' => true],
            'program_deskripsi' => ['label' => 'Deskripsi', 'type' => 'textarea', 'required' => true],
            'program_gambar' => ['label' => 'Gambar Program', 'type' => 'file_image', 'required' => false],
        ],
    ],
    'struktur' => [
        'table' => 'struktur_organisasi',
        'title' => 'Struktur Organisasi',
        'fields' => [
            'struktur_nama' => ['label' => 'Nama', 'type' => 'text', 'required' => true],
            'struktur_jabatan' => ['label' => 'Jabatan', 'type' => 'text', 'required' => true],
            'struktur_foto' => ['label' => 'URL Foto', 'type' => 'text', 'required' => false],
        ],
    ],
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = (string) ($_POST['action'] ?? '');
    if ($action === 'delete_apbdes') {
        $apbdesId = isset($_POST['apbdes_id']) ? (int) $_POST['apbdes_id'] : 0;
        if ($apbdesId <= 0) {
            $_SESSION['flash_error'][] = 'Data APBDes tidak ditemukan.';
            header('Location: admin_management.php#apbdes');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT apbdes_file FROM apbdes WHERE apbdes_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $stmt->execute([$apbdesId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data APBDes: ' . $exception->getMessage();
            header('Location: admin_management.php#apbdes');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data APBDes tidak ditemukan.';
            header('Location: admin_management.php#apbdes');
            exit;
        }

        $fileName = trim((string) ($row['apbdes_file'] ?? ''));
        if ($fileName !== '') {
            $filePath = base_path('uploads/apbdes/' . ltrim($fileName, "/\\"));
            if (is_file($filePath) && !unlink($filePath)) {
                $_SESSION['flash_error'][] = 'Gagal menghapus berkas APBDes.';
                header('Location: admin_management.php#apbdes');
                exit;
            }
        }

        try {
            $stmt = $pdo->prepare('DELETE FROM apbdes WHERE apbdes_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $executed = $stmt->execute([$apbdesId]);
            if ($executed) {
                $_SESSION['flash'][] = 'Dokumen APBDes berhasil dihapus.';
            } else {
                $_SESSION['flash_error'][] = 'Gagal menghapus data APBDes.';
            }
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal menghapus data APBDes: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#apbdes');
        exit;
    }

    if ($action === 'delete_berita') {
        $beritaId = isset($_POST['berita_id']) ? (int) $_POST['berita_id'] : 0;
        if ($beritaId <= 0) {
            $_SESSION['flash_error'][] = 'Data berita tidak ditemukan.';
            header('Location: admin_management.php#berita');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT berita_gambar FROM berita WHERE berita_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $stmt->execute([$beritaId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data berita: ' . $exception->getMessage();
            header('Location: admin_management.php#berita');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data berita tidak ditemukan.';
            header('Location: admin_management.php#berita');
            exit;
        }

        $fileName = trim((string) ($row['berita_gambar'] ?? ''));
        if ($fileName !== '') {
            $filePath = base_path('uploads/berita/' . ltrim($fileName, "/\\"));
            if (is_file($filePath) && !unlink($filePath)) {
                $_SESSION['flash_error'][] = 'Gagal menghapus file gambar berita.';
                header('Location: admin_management.php#berita');
                exit;
            }
        }

        try {
            $stmt = $pdo->prepare('DELETE FROM berita WHERE berita_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $executed = $stmt->execute([$beritaId]);
            if ($executed) {
                $_SESSION['flash'][] = 'Berita berhasil dihapus.';
            } else {
                $_SESSION['flash_error'][] = 'Gagal menghapus data berita.';
            }
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal menghapus data berita: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#berita');
        exit;
    }

        if ($action === 'delete_program') {
        $programId = isset($_POST['program_id']) ? (int) $_POST['program_id'] : 0;
        if ($programId <= 0) {
            $_SESSION['flash_error'][] = 'Data program tidak ditemukan.';
            header('Location: admin_management.php#program');
            exit;
        }

        // 1️⃣ Ambil data gambar program terlebih dahulu
        try {
            $stmt = $pdo->prepare('SELECT program_gambar FROM program_desa WHERE program_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Gagal menyiapkan query.');
            }
            $stmt->execute([$programId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $e) {
            $_SESSION['flash_error'][] = 'Gagal memuat data program: ' . $e->getMessage();
            header('Location: admin_management.php#program');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data program tidak ditemukan.';
            header('Location: admin_management.php#program');
            exit;
        }

        // 2️⃣ Hapus file gambar (jika ada)
        $fileName = trim((string) ($row['program_gambar'] ?? ''));
        if ($fileName !== '') {
            // Pastikan hanya nama file, bukan URL
            $fileName = basename($fileName);
            $filePath = base_path('uploads/program/' . $fileName);

            if (is_file($filePath)) {
                if (!@unlink($filePath)) {
                    $_SESSION['flash_error'][] = 'Gagal menghapus file gambar program: ' . e($fileName);
                    header('Location: admin_management.php#program');
                    exit;
                }
            }
        }

        // 3️⃣ Hapus data program dari database
        try {
            $stmt = $pdo->prepare('DELETE FROM program_desa WHERE program_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Gagal menyiapkan query penghapusan.');
            }
            $stmt->execute([$programId]);
            $_SESSION['flash'][] = 'Program Desa berhasil dihapus.';
        } catch (Throwable $e) {
            $_SESSION['flash_error'][] = 'Gagal menghapus data program: ' . $e->getMessage();
        }

        header('Location: admin_management.php#program');
        exit;
    }

    if ($action === 'delete_fasilitas') {
        $fasilitasId = isset($_POST['fasilitas_id']) ? (int) $_POST['fasilitas_id'] : 0;
        if ($fasilitasId <= 0) {
            $_SESSION['flash_error'][] = 'Data fasilitas tidak ditemukan.';
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT fasilitas_gambar FROM fasilitas WHERE fasilitas_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $stmt->execute([$fasilitasId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data fasilitas: ' . $exception->getMessage();
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data fasilitas tidak ditemukan.';
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        $fileName = trim((string) ($row['fasilitas_gambar'] ?? ''));
        if ($fileName !== '') {
            $filePath = base_path('uploads/fasilitas/' . ltrim($fileName, "/\\"));
            if (is_file($filePath) && !unlink($filePath)) {
                $_SESSION['flash_error'][] = 'Gagal menghapus file gambar fasilitas.';
                header('Location: admin_management.php#fasilitas');
                exit;
            }
        }

        try {
            $stmt = $pdo->prepare('DELETE FROM fasilitas WHERE fasilitas_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $executed = $stmt->execute([$fasilitasId]);
            if ($executed) {
                $_SESSION['flash'][] = 'Fasilitas berhasil dihapus.';
            } else {
                $_SESSION['flash_error'][] = 'Gagal menghapus data fasilitas.';
            }
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal menghapus data fasilitas: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#fasilitas');
        exit;
    }

    if ($action === 'delete_potensi') {
        $potensiId = isset($_POST['potensi_id']) ? (int) $_POST['potensi_id'] : 0;
        if ($potensiId <= 0) {
            $_SESSION['flash_error'][] = 'Data potensi tidak ditemukan.';
            header('Location: admin_management.php#potensi');
            exit;
        }

        // 1️⃣ Ambil semua gambar yang terkait
        try {
            $stmt = $pdo->prepare('SELECT gambar_namafile FROM gambar_potensi_desa WHERE potensi_id = ?');
            $stmt->execute([$potensiId]);
            $images = $stmt->fetchAll(PDO::FETCH_COLUMN);
        } catch (Throwable $e) {
            $_SESSION['flash_error'][] = 'Gagal memuat gambar potensi: ' . $e->getMessage();
            header('Location: admin_management.php#potensi');
            exit;
        }

        // 2️⃣ Hapus file di folder uploads/potensi/
        if (is_array($images)) {
            foreach ($images as $img) {
                $file = basename(trim((string)$img));
                if ($file === '') continue;
                $path = base_path('uploads/potensi/' . $file);
                if (is_file($path)) {
                    @unlink($path);
                }
            }
        }

        // 3️⃣ Hapus gambar dari tabel gambar_potensi_desa
        try {
            $stmt = $pdo->prepare('DELETE FROM gambar_potensi_desa WHERE potensi_id = ?');
            $stmt->execute([$potensiId]);
        } catch (Throwable $e) {
            $_SESSION['flash_error'][] = 'Gagal menghapus foto potensi: ' . $e->getMessage();
            header('Location: admin_management.php#potensi');
            exit;
        }

        // 4️⃣ Hapus data potensi
        try {
            $stmt = $pdo->prepare('DELETE FROM potensi_desa WHERE potensi_id = ?');
            $stmt->execute([$potensiId]);
            $_SESSION['flash'][] = 'Data potensi dan semua foto terkait berhasil dihapus.';
        } catch (Throwable $e) {
            $_SESSION['flash_error'][] = 'Gagal menghapus data potensi: ' . $e->getMessage();
        }

        header('Location: admin_management.php#potensi');
        exit;
    }

    if ($action === 'delete_gambar_potensi') {
        $gambarId = isset($_POST['gambar_id']) ? (int) $_POST['gambar_id'] : 0;
        if ($gambarId <= 0) {
            $_SESSION['flash_error'][] = 'Data foto potensi tidak ditemukan.';
            header('Location: admin_management.php#potensi');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT gambar_namafile FROM gambar_potensi_desa WHERE gambar_id = ? LIMIT 1');
            $stmt->execute([$gambarId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data foto potensi: ' . $exception->getMessage();
            header('Location: admin_management.php#potensi');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data foto potensi tidak ditemukan di database.';
            header('Location: admin_management.php#potensi');
            exit;
        }

        $fileName = trim((string) ($row['gambar_namafile'] ?? ''));
        if ($fileName !== '') {
            // pastikan hanya nama file, bukan path
            $fileName = basename($fileName);
            $filePath = base_path('uploads/potensi/' . $fileName);
            if (is_file($filePath)) {
                if (!@unlink($filePath)) {
                    $_SESSION['flash_error'][] = 'Gagal menghapus file gambar: ' . e($fileName);
                    header('Location: admin_management.php#potensi');
                    exit;
                }
            }
        }

        try {
            $stmt = $pdo->prepare('DELETE FROM gambar_potensi_desa WHERE gambar_id = ?');
            $stmt->execute([$gambarId]);
            $_SESSION['flash'][] = 'Foto potensi berhasil dihapus.';
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal menghapus data foto potensi: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#potensi');
        exit;
    }

    if ($action === 'delete_pengumuman') {
        $pengumumanId = isset($_POST['pengumuman_id']) ? (int) $_POST['pengumuman_id'] : 0;
        if ($pengumumanId <= 0) {
            $_SESSION['flash_error'][] = 'Data pengumuman tidak ditemukan.';
            header('Location: admin_management.php#pengumuman');
            exit;
        }

        try {
            $stmt = $pdo->prepare('DELETE FROM pengumuman WHERE pengumuman_id = ?');
            $stmt->execute([$pengumumanId]);
            $_SESSION['flash'][] = 'Pengumuman berhasil dihapus.';
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal menghapus pengumuman: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#pengumuman');
        exit;
    }

    if ($action === 'edit_pengumuman') {
        $pengumumanId = isset($_POST['pengumuman_id']) ? (int) $_POST['pengumuman_id'] : 0;
        $isi = trim((string) ($_POST['pengumuman_isi'] ?? ''));
        $validHinggaRaw = trim((string) ($_POST['pengumuman_valid_hingga'] ?? ''));
        $validHingga = null;

        if ($validHinggaRaw !== '') {
            $timestamp = strtotime($validHinggaRaw);
            if ($timestamp !== false) {
                $validHingga = date('Y-m-d H:i:s', $timestamp);
            }
        }

        if ($pengumumanId <= 0) {
            $_SESSION['flash_error'][] = 'Data pengumuman tidak ditemukan.';
            header('Location: admin_management.php#pengumuman');
            exit;
        }

        if ($isi === '' || $validHingga === null) {
            $_SESSION['flash_error'][] = 'Isi pengumuman dan tanggal berlaku wajib diisi.';
            header('Location: admin_management.php#pengumuman');
            exit;
        }

        try {
            $stmt = $pdo->prepare('UPDATE pengumuman SET pengumuman_isi = ?, pengumuman_valid_hingga = ?, pengumuman_updated_at = NOW() WHERE pengumuman_id = ?');
            $stmt->execute([$isi, $validHingga, $pengumumanId]);
            $_SESSION['flash'][] = 'Pengumuman berhasil diperbarui.';
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memperbarui pengumuman: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#pengumuman');
        exit;
    }

    if ($action === 'edit_fasilitas') {
        $fasilitasId = isset($_POST['fasilitas_id']) ? (int) $_POST['fasilitas_id'] : 0;
        $newName = trim((string) ($_POST['fasilitas_nama'] ?? ''));
        $newMaps = trim((string) ($_POST['fasilitas_gmaps_link'] ?? ''));

        if ($fasilitasId <= 0) {
            $_SESSION['flash_error'][] = 'Data fasilitas tidak ditemukan.';
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        if ($newName === '') {
            $_SESSION['flash_error'][] = 'Nama fasilitas wajib diisi.';
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT fasilitas_gambar FROM fasilitas WHERE fasilitas_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $stmt->execute([$fasilitasId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data fasilitas: ' . $exception->getMessage();
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data fasilitas tidak ditemukan.';
            header('Location: admin_management.php#fasilitas');
            exit;
        }

        $currentImage = trim((string) ($row['fasilitas_gambar'] ?? ''));
        $newImageName = null;
        $newImagePath = null;

        $fileInfo = $_FILES['fasilitas_gambar'] ?? null;
        $hasNewImage = is_array($fileInfo) && ($fileInfo['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;

        if ($hasNewImage) {
            if (($fileInfo['error'] ?? UPLOAD_ERR_OK) !== UPLOAD_ERR_OK) {
                $_SESSION['flash_error'][] = 'Gagal mengunggah gambar baru.';
                header('Location: admin_management.php#fasilitas');
                exit;
            }

            $finfo = finfo_open(FILEINFO_MIME_TYPE);
            $mime = $finfo ? (string) finfo_file($finfo, $fileInfo['tmp_name']) : '';
            if ($finfo) {
                finfo_close($finfo);
            }

            $ext = strtolower(pathinfo((string) ($fileInfo['name'] ?? ''), PATHINFO_EXTENSION));
            $allowedExt = ['jpg', 'jpeg', 'png', 'webp'];
            $allowedMime = ['image/jpeg', 'image/png', 'image/webp'];

            if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) {
                $_SESSION['flash_error'][] = 'Format gambar tidak didukung. Gunakan JPG, JPEG, PNG, atau WEBP.';
                header('Location: admin_management.php#fasilitas');
                exit;
            }

            $imageMeta = @getimagesize($fileInfo['tmp_name']);
            if ($imageMeta === false) {
                $_SESSION['flash_error'][] = 'File gambar tidak valid.';
                header('Location: admin_management.php#fasilitas');
                exit;
            }

            $targetDir = base_path('uploads/fasilitas');
            if (!is_dir($targetDir) && !mkdir($targetDir, 0755, true) && !is_dir($targetDir)) {
                $_SESSION['flash_error'][] = 'Folder unggahan tidak dapat dibuat.';
                header('Location: admin_management.php#fasilitas');
                exit;
            }

            $uniqueName = uniqid('fasilitas_', true) . '.webp';
            $targetPath = $targetDir . DIRECTORY_SEPARATOR . $uniqueName;

            $conversionSuccess = false;
            if ($mime === 'image/webp') {
                $conversionSuccess = move_uploaded_file($fileInfo['tmp_name'], $targetPath);
            } else {
                if (!function_exists('imagewebp')) {
                    $_SESSION['flash_error'][] = 'Konversi gambar ke WebP tidak tersedia di server.';
                    header('Location: admin_management.php#fasilitas');
                    exit;
                }

                $image = null;
                switch ($mime) {
                    case 'image/jpeg':
                        $image = @imagecreatefromjpeg($fileInfo['tmp_name']);
                        break;
                    case 'image/png':
                        $image = @imagecreatefrompng($fileInfo['tmp_name']);
                        if ($image !== false) {
                            imagepalettetotruecolor($image);
                            imagealphablending($image, false);
                            imagesavealpha($image, true);
                        }
                        break;
                }

                if ($image !== false && $image !== null) {
                    $conversionSuccess = imagewebp($image, $targetPath, 90);
                    imagedestroy($image);
                }
            }

            if (!$conversionSuccess) {
                if (is_file($targetPath)) {
                    @unlink($targetPath);
                }
                $_SESSION['flash_error'][] = 'Gagal memproses gambar baru.';
                header('Location: admin_management.php#fasilitas');
                exit;
            }

            $newImageName = $uniqueName;
            $newImagePath = $targetPath;
        }

        $setParts = ['fasilitas_nama = ?', 'fasilitas_gmaps_link = ?'];
        $params = [$newName, $newMaps !== '' ? $newMaps : null];

        if ($newImageName !== null) {
            $setParts[] = 'fasilitas_gambar = ?';
            $params[] = $newImageName;
        }

        $params[] = $fasilitasId;
        $setClause = implode(', ', $setParts);

        try {
            $stmt = $pdo->prepare('UPDATE fasilitas SET ' . $setClause . ' WHERE fasilitas_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $executed = $stmt->execute($params);
            if ($executed) {
                if ($newImageName !== null && $currentImage !== '') {
                    $oldPath = base_path('uploads/fasilitas/' . ltrim($currentImage, "/\\"));
                    if (is_file($oldPath)) {
                        @unlink($oldPath);
                    }
                }
                $_SESSION['flash'][] = 'Fasilitas berhasil diperbarui.';
            } else {
                if ($newImagePath !== null && is_file($newImagePath)) {
                    @unlink($newImagePath);
                }
                $_SESSION['flash_error'][] = 'Gagal memperbarui fasilitas.';
            }
        } catch (Throwable $exception) {
            if ($newImagePath !== null && is_file($newImagePath)) {
                @unlink($newImagePath);
            }
            $_SESSION['flash_error'][] = 'Gagal memperbarui fasilitas: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#fasilitas');
        exit;
    }

    if ($action === 'edit_berita') {
        $beritaId = isset($_POST['berita_id']) ? (int) $_POST['berita_id'] : 0;
        $newTitle = trim((string) ($_POST['berita_judul'] ?? ''));
        $newContent = trim((string) ($_POST['berita_isi'] ?? ''));

        if ($beritaId <= 0) {
            $_SESSION['flash_error'][] = 'Data berita tidak ditemukan.';
            header('Location: admin_management.php#berita');
            exit;
        }

        if ($newTitle === '' || $newContent === '') {
            $_SESSION['flash_error'][] = 'Judul dan isi berita wajib diisi.';
            header('Location: admin_management.php#berita');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT berita_gambar FROM berita WHERE berita_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $stmt->execute([$beritaId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data berita: ' . $exception->getMessage();
            header('Location: admin_management.php#berita');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data berita tidak ditemukan.';
            header('Location: admin_management.php#berita');
            exit;
        }

        $currentImage = trim((string) ($row['berita_gambar'] ?? ''));
        $newImageName = null;
        $newImagePath = null;

        $fileInfo = $_FILES['berita_gambar'] ?? null;
        $hasNewImage = is_array($fileInfo) && ($fileInfo['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;

        if ($hasNewImage) {
            if (($fileInfo['error'] ?? UPLOAD_ERR_OK) !== UPLOAD_ERR_OK) {
                $_SESSION['flash_error'][] = 'Gagal mengunggah gambar baru.';
                header('Location: admin_management.php#berita');
                exit;
            }

            $finfo = finfo_open(FILEINFO_MIME_TYPE);
            $mime = $finfo ? (string) finfo_file($finfo, $fileInfo['tmp_name']) : '';
            if ($finfo) {
                finfo_close($finfo);
            }

            $ext = strtolower(pathinfo((string) ($fileInfo['name'] ?? ''), PATHINFO_EXTENSION));
            $allowedExt = ['jpg', 'jpeg', 'png', 'webp'];
            $allowedMime = ['image/jpeg', 'image/png', 'image/webp'];

            if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) {
                $_SESSION['flash_error'][] = 'Format gambar tidak didukung. Gunakan JPG, JPEG, PNG, atau WEBP.';
                header('Location: admin_management.php#berita');
                exit;
            }

            $imageMeta = @getimagesize($fileInfo['tmp_name']);
            if ($imageMeta === false) {
                $_SESSION['flash_error'][] = 'File gambar tidak valid.';
                header('Location: admin_management.php#berita');
                exit;
            }

            $targetDir = base_path('uploads/berita');
            if (!is_dir($targetDir) && !mkdir($targetDir, 0755, true) && !is_dir($targetDir)) {
                $_SESSION['flash_error'][] = 'Folder unggahan tidak dapat dibuat.';
                header('Location: admin_management.php#berita');
                exit;
            }

            $uniqueName = uniqid('berita_', true) . '.webp';
            $targetPath = $targetDir . DIRECTORY_SEPARATOR . $uniqueName;

            $conversionSuccess = false;
            if ($mime === 'image/webp') {
                $conversionSuccess = move_uploaded_file($fileInfo['tmp_name'], $targetPath);
            } else {
                if (!function_exists('imagewebp')) {
                    $_SESSION['flash_error'][] = 'Konversi gambar ke WebP tidak tersedia di server.';
                    header('Location: admin_management.php#berita');
                    exit;
                }

                $image = null;
                switch ($mime) {
                    case 'image/jpeg':
                        $image = @imagecreatefromjpeg($fileInfo['tmp_name']);
                        break;
                    case 'image/png':
                        $image = @imagecreatefrompng($fileInfo['tmp_name']);
                        if ($image !== false) {
                            imagepalettetotruecolor($image);
                            imagealphablending($image, false);
                            imagesavealpha($image, true);
                        }
                        break;
                }

                if ($image !== false && $image !== null) {
                    $conversionSuccess = imagewebp($image, $targetPath, 90);
                    imagedestroy($image);
                }
            }

            if (!$conversionSuccess) {
                if (is_file($targetPath)) {
                    @unlink($targetPath);
                }
                $_SESSION['flash_error'][] = 'Gagal memproses gambar baru.';
                header('Location: admin_management.php#berita');
                exit;
            }

            $newImageName = $uniqueName;
            $newImagePath = $targetPath;
        }

        $setParts = ['berita_judul = ?', 'berita_isi = ?'];
        $params = [$newTitle, $newContent];

        if ($newImageName !== null) {
            $setParts[] = 'berita_gambar = ?';
            $params[] = $newImageName;
        }

        $params[] = $beritaId;
        $setClause = implode(', ', $setParts);

        try {
            $stmt = $pdo->prepare('UPDATE berita SET ' . $setClause . ' WHERE berita_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $executed = $stmt->execute($params);
            if ($executed) {
                if ($newImageName !== null && $currentImage !== '') {
                    $oldPath = base_path('uploads/berita/' . ltrim($currentImage, "/\\"));
                    if (is_file($oldPath)) {
                        @unlink($oldPath);
                    }
                }
                $_SESSION['flash'][] = 'Berita berhasil diperbarui.';
            } else {
                if ($newImagePath !== null && is_file($newImagePath)) {
                    @unlink($newImagePath);
                }
                $_SESSION['flash_error'][] = 'Gagal memperbarui berita.';
            }
        } catch (Throwable $exception) {
            if ($newImagePath !== null && is_file($newImagePath)) {
                @unlink($newImagePath);
            }
            $_SESSION['flash_error'][] = 'Gagal memperbarui berita: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#berita');
        exit;
    }

        if ($action === 'edit_program') {
        $programId = isset($_POST['program_id']) ? (int) $_POST['program_id'] : 0;
        $newName = trim((string) ($_POST['program_nama'] ?? ''));
        $newDesc = trim((string) ($_POST['program_deskripsi'] ?? ''));

        if ($programId <= 0) {
            $_SESSION['flash_error'][] = 'Data program tidak ditemukan.';
            header('Location: admin_management.php#program');
            exit;
        }

        if ($newName === '' || $newDesc === '') {
            $_SESSION['flash_error'][] = 'Nama dan deskripsi program wajib diisi.';
            header('Location: admin_management.php#program');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT program_gambar FROM program_desa WHERE program_id = ? LIMIT 1');
            $stmt->execute([$programId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $e) {
            $_SESSION['flash_error'][] = 'Gagal memuat data program: ' . $e->getMessage();
            header('Location: admin_management.php#program');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data program tidak ditemukan.';
            header('Location: admin_management.php#program');
            exit;
        }

        $currentImage = trim((string) ($row['program_gambar'] ?? ''));
        $newImageName = null;
        $newImagePath = null;

        $fileInfo = $_FILES['program_gambar'] ?? null;
        $hasNewImage = is_array($fileInfo) && ($fileInfo['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;

        if ($hasNewImage) {
            if (($fileInfo['error'] ?? UPLOAD_ERR_OK) !== UPLOAD_ERR_OK) {
                $_SESSION['flash_error'][] = 'Gagal mengunggah gambar baru.';
                header('Location: admin_management.php#program');
                exit;
            }

            $finfo = finfo_open(FILEINFO_MIME_TYPE);
            $mime = $finfo ? (string) finfo_file($finfo, $fileInfo['tmp_name']) : '';
            if ($finfo) finfo_close($finfo);

            $ext = strtolower(pathinfo((string) ($fileInfo['name'] ?? ''), PATHINFO_EXTENSION));
            $allowedExt = ['jpg', 'jpeg', 'png', 'webp'];
            $allowedMime = ['image/jpeg', 'image/png', 'image/webp'];

            if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) {
                $_SESSION['flash_error'][] = 'Format gambar tidak didukung. Gunakan JPG, JPEG, PNG, atau WEBP.';
                header('Location: admin_management.php#program');
                exit;
            }

            $targetDir = base_path('uploads/program');
            if (!is_dir($targetDir) && !mkdir($targetDir, 0755, true) && !is_dir($targetDir)) {
                $_SESSION['flash_error'][] = 'Folder unggahan tidak dapat dibuat.';
                header('Location: admin_management.php#program');
                exit;
            }

            $uniqueName = uniqid('program_', true) . '.webp';
            $targetPath = $targetDir . DIRECTORY_SEPARATOR . $uniqueName;

            $conversionSuccess = false;
            if ($mime === 'image/webp') {
                $conversionSuccess = move_uploaded_file($fileInfo['tmp_name'], $targetPath);
            } else {
                if (!function_exists('imagewebp')) {
                    $_SESSION['flash_error'][] = 'Konversi gambar ke WebP tidak tersedia di server.';
                    header('Location: admin_management.php#program');
                    exit;
                }

                $image = null;
                switch ($mime) {
                    case 'image/jpeg':
                        $image = @imagecreatefromjpeg($fileInfo['tmp_name']);
                        break;
                    case 'image/png':
                        $image = @imagecreatefrompng($fileInfo['tmp_name']);
                        if ($image !== false) {
                            imagepalettetotruecolor($image);
                            imagealphablending($image, false);
                            imagesavealpha($image, true);
                        }
                        break;
                }

                if ($image !== false && $image !== null) {
                    $conversionSuccess = imagewebp($image, $targetPath, 90);
                    imagedestroy($image);
                }
            }

            if (!$conversionSuccess) {
                if (is_file($targetPath)) @unlink($targetPath);
                $_SESSION['flash_error'][] = 'Gagal memproses gambar baru.';
                header('Location: admin_management.php#program');
                exit;
            }

            $newImageName = $uniqueName;
            $newImagePath = $targetPath;
        }

        $setParts = ['program_nama = ?', 'program_deskripsi = ?'];
        $params = [$newName, $newDesc];

        if ($newImageName !== null) {
            $setParts[] = 'program_gambar = ?';
            $params[] = $newImageName;
        }

        $params[] = $programId;
        $setClause = implode(', ', $setParts);

        try {
            $stmt = $pdo->prepare('UPDATE program_desa SET ' . $setClause . ' WHERE program_id = ?');
            $stmt->execute($params);

            if ($newImageName !== null && $currentImage !== '') {
                $oldPath = base_path('uploads/program/' . ltrim($currentImage, "/\\"));
                if (is_file($oldPath)) @unlink($oldPath);
            }

            $_SESSION['flash'][] = 'Program Desa berhasil diperbarui.';
        } catch (Throwable $e) {
            if ($newImagePath !== null && is_file($newImagePath)) {
                @unlink($newImagePath);
            }
            $_SESSION['flash_error'][] = 'Gagal memperbarui data program: ' . $e->getMessage();
        }

        header('Location: admin_management.php#program');
        exit;
    }

    if ($action === 'edit_apbdes') {
        $apbdesId = isset($_POST['apbdes_id']) ? (int) $_POST['apbdes_id'] : 0;
        $newTitle = trim((string) ($_POST['apbdes_judul'] ?? ''));

        if ($apbdesId <= 0) {
            $_SESSION['flash_error'][] = 'Data APBDes tidak ditemukan.';
            header('Location: admin_management.php#apbdes');
            exit;
        }

        if ($newTitle === '') {
            $_SESSION['flash_error'][] = 'Judul APBDes wajib diisi.';
            header('Location: admin_management.php#apbdes');
            exit;
        }

        try {
            $stmt = $pdo->prepare('SELECT apbdes_edited_by FROM apbdes WHERE apbdes_id = ? LIMIT 1');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $stmt->execute([$apbdesId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memuat data APBDes: ' . $exception->getMessage();
            header('Location: admin_management.php#apbdes');
            exit;
        }

        if (!$row) {
            $_SESSION['flash_error'][] = 'Data APBDes tidak ditemukan.';
            header('Location: admin_management.php#apbdes');
            exit;
        }

        $editedBy = isset($adminSession['name']) ? (string) $adminSession['name'] : (string) ($row['apbdes_edited_by'] ?? '');

        try {
            $stmt = $pdo->prepare('UPDATE apbdes SET apbdes_judul = ?, apbdes_edited_by = ? WHERE apbdes_id = ?');
            if ($stmt === false) {
                throw new RuntimeException('Tidak dapat menyiapkan kueri.');
            }
            $executed = $stmt->execute([$newTitle, $editedBy, $apbdesId]);
            if ($executed) {
                $_SESSION['flash'][] = 'Judul APBDes berhasil diperbarui.';
            } else {
                $_SESSION['flash_error'][] = 'Gagal memperbarui judul APBDes.';
            }
        } catch (Throwable $exception) {
            $_SESSION['flash_error'][] = 'Gagal memperbarui judul APBDes: ' . $exception->getMessage();
        }

        header('Location: admin_management.php#apbdes');
        exit;
    }

    $formId = (string) ($_POST['form_id'] ?? '');
    if (isset($tableForms[$formId])) {
        $definition = $tableForms[$formId];
        $fieldsDefinition = $definition['fields'];
        $inputData = [];
        $errors = [];

        foreach ($fieldsDefinition as $fieldName => $fieldMeta) {
            $type = $fieldMeta['type'] ?? 'text';

            if (in_array($type, ['file_pdf', 'file_image'], true)) {
                $required = !empty($fieldMeta['required']);
                $fileInfo = $_FILES[$fieldName] ?? null;

                if (!is_array($fileInfo) || ($fileInfo['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
                    if ($required) {
                        $errors[$fieldName] = $type === 'file_pdf'
                            ? 'Silakan unggah file PDF.'
                            : 'Silakan pilih gambar.';
                    }
                    continue;
                }

                if (($fileInfo['error'] ?? UPLOAD_ERR_OK) !== UPLOAD_ERR_OK) {
                    $errors[$fieldName] = 'Gagal mengunggah file.';
                    continue;
                }

                $finfo = finfo_open(FILEINFO_MIME_TYPE);
                $mime = $finfo ? (string) finfo_file($finfo, $fileInfo['tmp_name']) : '';
                if ($finfo) {
                    finfo_close($finfo);
                }

                $ext = strtolower(pathinfo((string) ($fileInfo['name'] ?? ''), PATHINFO_EXTENSION));

                if ($type === 'file_pdf') {
                    if ($mime !== 'application/pdf' || $ext !== 'pdf') {
                        $errors[$fieldName] = 'File harus berupa PDF.';
                        continue;
                    }
                } else {
                    $allowedExt = ['jpg', 'jpeg', 'png', 'webp'];
                    $allowedMime = ['image/jpeg', 'image/png', 'image/webp'];

                    if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) {
                        $errors[$fieldName] = 'Format gambar tidak didukung. Gunakan JPG, JPEG, PNG, atau WEBP.';
                        continue;
                    }

                    $imageMeta = @getimagesize($fileInfo['tmp_name']);
                    if ($imageMeta === false) {
                        $errors[$fieldName] = 'File gambar tidak valid.';
                        continue;
                    }

                    $fileInfo['_width'] = (int) ($imageMeta[0] ?? 0);
                    $fileInfo['_height'] = (int) ($imageMeta[1] ?? 0);
                }

                $fileInfo['_mime'] = $mime;
                $fileInfo['_extension'] = $ext;
                $fileInfo['_field_type'] = $type;
                $inputData[$fieldName] = $fileInfo;
                continue;
            }

            $required = !empty($fieldMeta['required']);
            $rawValue = $_POST[$fieldName] ?? null;
            $value = null;

            switch ($type) {
                case 'checkbox':
                    $value = isset($_POST[$fieldName]) ? 1 : 0;
                    if ($required && $value !== 1) {
                        $errors[$fieldName] = 'Harus dicentang.';
                    } elseif ($value === 1 || !empty($fieldMeta['default'])) {
                        $inputData[$fieldName] = $value;
                    } elseif ($required) {
                        $inputData[$fieldName] = 0;
                    }
                    continue 2;

                case 'number':
                    $raw = is_array($rawValue) ? '' : trim((string) $rawValue);
                    if ($raw === '') {
                        if ($required) {
                            $errors[$fieldName] = 'Data wajib diisi.';
                        } elseif (array_key_exists('default', $fieldMeta)) {
                            $inputData[$fieldName] = (int) $fieldMeta['default'];
                        }
                    } else {
                        $filtered = filter_var($raw, FILTER_VALIDATE_INT);
                        if ($filtered === false) {
                            $errors[$fieldName] = 'Masukkan angka yang valid.';
                        } else {
                            $inputData[$fieldName] = $filtered;
                        }
                    }
                    continue 2;

                case 'select':
                    $options = $fieldMeta['options'] ?? [];
                    $raw = is_array($rawValue) ? '' : trim((string) $rawValue);
                    if ($raw === '') {
                        if ($required) {
                            $errors[$fieldName] = 'Pilih salah satu opsi.';
                        }
                    } else {
                        $allowedValues = [];
                        $isList = array_is_list($options);
                        foreach ($options as $optionValue => $optionLabel) {
                            if ($isList || is_int($optionValue)) {
                                $allowedValues[] = (string) $optionLabel;
                            } else {
                                $allowedValues[] = (string) $optionValue;
                            }
                        }

                        if (!in_array($raw, $allowedValues, true)) {
                            $errors[$fieldName] = 'Opsi tidak valid.';
                        } else {
                            $inputData[$fieldName] = ctype_digit($raw) ? (int) $raw : $raw;
                        }
                    }
                    continue 2;

                case 'datetime':
                    $raw = is_array($rawValue) ? '' : trim((string) $rawValue);
                    if ($raw === '') {
                        if ($required) {
                            $errors[$fieldName] = 'Tanggal dan waktu wajib diisi.';
                        }
                    } else {
                        $timestamp = strtotime($raw);
                        if ($timestamp === false) {
                            $errors[$fieldName] = 'Format tanggal dan waktu tidak valid.';
                        } else {
                            $inputData[$fieldName] = date('Y-m-d H:i:s', $timestamp);
                        }
                    }
                    continue 2;

                case 'email':
                    $raw = is_array($rawValue) ? '' : trim((string) $rawValue);
                    if ($raw === '') {
                        if ($required) {
                            $errors[$fieldName] = 'Email wajib diisi.';
                        }
                    } elseif (!filter_var($raw, FILTER_VALIDATE_EMAIL)) {
                        $errors[$fieldName] = 'Email tidak valid.';
                    } else {
                        $inputData[$fieldName] = $raw;
                    }
                    continue 2;

                case 'textarea':
                case 'text':
                case 'file_pdf':
                default:
                    $raw = is_array($rawValue) ? '' : trim((string) $rawValue);
                    if ($raw === '') {
                        if ($required) {
                            $errors[$fieldName] = 'Data wajib diisi.';
                        } elseif (array_key_exists('default', $fieldMeta)) {
                            $inputData[$fieldName] = (string) $fieldMeta['default'];
                        }
                    } else {
                        $inputData[$fieldName] = $raw;
                    }
                    continue 2;
            }
        }

        if ($errors === []) {
            if ($inputData === []) {
                $errors['_general'] = 'Tidak ada data yang diisi.';
            } else {
                $fileUploads = [];
                foreach ($inputData as $column => $value) {
                    if (is_array($value) && isset($value['tmp_name'])) {
                        $fileUploads[$column] = $value;
                    }
                }

                foreach ($fileUploads as $column => $fileInfo) {
                    $uploadFolder = 'uploads/' . $formId;
                    $filenamePrefix = $formId . '_';
                    $storedPrefix = '';

                    if ($formId === 'potensi-media') {
                        $uploadFolder = 'uploads/potensi';
                        $filenamePrefix = 'potensi_';
                        $storedPrefix = '';
                    }

                    if ($formId === 'program') {
                        $uploadFolder = 'uploads/program';
                        $filenamePrefix = 'program_';
                    }

                    $targetDir = base_path($uploadFolder);
                    if (!is_dir($targetDir) && !mkdir($targetDir, 0755, true) && !is_dir($targetDir)) {
                        $errors['_general'] = 'Folder unggahan tidak dapat dibuat.';
                        break;
                    }

                    $fieldType = $fieldsDefinition[$column]['type'] ?? '';
                    if ($fieldType === 'file_image') {
                        $uniqueName = uniqid($filenamePrefix, true) . '.webp';
                        $targetPath = $targetDir . DIRECTORY_SEPARATOR . $uniqueName;
                        $mime = (string) ($fileInfo['_mime'] ?? '');

                        if ($mime === 'image/webp') {
                            if (!move_uploaded_file($fileInfo['tmp_name'], $targetPath)) {
                                $errors['_general'] = 'Gagal menyimpan gambar.';
                                break;
                            }
                        } else {
                            if (!function_exists('imagewebp')) {
                                $errors['_general'] = 'Konversi gambar ke WebP tidak tersedia di server.';
                                break;
                            }

                            $image = null;
                            switch ($mime) {
                                case 'image/jpeg':
                                    $image = @imagecreatefromjpeg($fileInfo['tmp_name']);
                                    break;
                                case 'image/png':
                                    $image = @imagecreatefrompng($fileInfo['tmp_name']);
                                    if ($image !== false) {
                                        imagepalettetotruecolor($image);
                                        imagealphablending($image, false);
                                        imagesavealpha($image, true);
                                    }
                                    break;
                            }

                            if ($image === false || $image === null) {
                                $errors['_general'] = 'Gagal memproses gambar yang diunggah.';
                                break;
                            }

                            if (!imagewebp($image, $targetPath, 90)) {
                                imagedestroy($image);
                                $errors['_general'] = 'Gagal mengonversi gambar ke WebP.';
                                break;
                            }

                            imagedestroy($image);
                            @unlink($fileInfo['tmp_name']);
                        }

                        $fileInfo['_stored'] = $storedPrefix !== '' ? $storedPrefix . $uniqueName : $uniqueName;
                        $fileUploads[$column] = $fileInfo;
                        continue;
                    }

                    $uniqueName = uniqid($filenamePrefix, true) . '.pdf';
                    $targetPath = $targetDir . DIRECTORY_SEPARATOR . $uniqueName;
                    if (!move_uploaded_file($fileInfo['tmp_name'], $targetPath)) {
                        $errors['_general'] = 'Gagal memindahkan file unggahan.';
                        break;
                    }

                    $fileInfo['_stored'] = $storedPrefix !== '' ? $storedPrefix . $uniqueName : $uniqueName;
                    $fileUploads[$column] = $fileInfo;
                }

                if (($errors['_general'] ?? '') === '') {
                    if ($formId === 'apbdes' && isset($adminSession['name'])) {
                        $inputData['apbdes_edited_by'] = (string) $adminSession['name'];
                    }
                    // Pastikan potensi_id ikut tersimpan saat upload foto potensi
                    if ($formId === 'potensi-media') {
                        $potensiId = isset($_POST['potensi_id']) ? (int) $_POST['potensi_id'] : 0;
                        if ($potensiId > 0) {
                            $inputData['potensi_id'] = $potensiId;
                        } else {
                            // Jika tidak dikirim, beri peringatan agar tidak null
                            $errors['_general'] = 'Potensi ID tidak ditemukan. Silakan ulangi dari tombol "Foto".';
                        }
                    }


                    foreach ($fileUploads as $column => $fileInfo) {
                        $inputData[$column] = $fileInfo['_stored'] ?? '';
                    }

                    $columns = array_keys($inputData);
                    $placeholders = implode(', ', array_fill(0, count($columns), '?'));
                    $query = 'INSERT INTO ' . $definition['table'] . ' (' . implode(', ', $columns) . ') VALUES (' . $placeholders . ')';
                try {
                    $stmt = $pdo->prepare($query);
                    $stmt->execute(array_values($inputData));
                    $_SESSION['flash'][] = $definition['title'] . ' berhasil ditambahkan.';
                    unset($_SESSION['form_errors'][$formId], $_SESSION['form_old'][$formId]);

                    // Jika form yang dikirim adalah potensi-media, arahkan kembali ke tab Potensi Desa
                    $redirectSection = $formId;
                    if ($formId === 'potensi-media') {
                        $redirectSection = 'potensi';
                    }

                    header('Location: admin_management.php#' . rawurlencode($redirectSection));
                    exit;

                } catch (Throwable $exception) {
                    $errors['_general'] = 'Gagal menyimpan data: ' . $exception->getMessage();
                }
            }
        }

        $_SESSION['form_errors'][$formId] = $errors;
        $_SESSION['form_old'][$formId] = array_intersect_key($_POST, $fieldsDefinition);
        header('Location: admin_management.php#' . rawurlencode($formId));
        exit;
    }
}}

$apbdes = fetch_table($pdo, 'SELECT apbdes_id, apbdes_judul, apbdes_file, apbdes_edited_by, apbdes_created_at, apbdes_updated_at FROM apbdes ORDER BY apbdes_updated_at DESC LIMIT 50');
$berita = fetch_table($pdo, 'SELECT berita_id, berita_judul, berita_isi, berita_gambar, berita_dilihat, berita_created_at, berita_updated_at FROM berita ORDER BY berita_updated_at DESC LIMIT 50');
$fasilitas = fetch_table($pdo, 'SELECT fasilitas_id, fasilitas_nama, fasilitas_gambar, fasilitas_gmaps_link, fasilitas_created_at, fasilitas_updated_at FROM fasilitas ORDER BY fasilitas_updated_at DESC LIMIT 50');
$galeri = fetch_table($pdo, 'SELECT galeri_id, galeri_namafile, galeri_keterangan, galeri_gambar, galeri_created_at FROM galeri ORDER BY galeri_created_at DESC LIMIT 50');
$gambarPotensi = fetch_table($pdo, 'SELECT g.gambar_id, g.potensi_id, g.gambar_namafile, g.gambar_created_at, p.potensi_judul FROM gambar_potensi_desa g LEFT JOIN potensi_desa p ON p.potensi_id = g.potensi_id ORDER BY g.gambar_created_at DESC');
$gambarPotensiByPotensi = [];
foreach ($gambarPotensi as $mediaRow) {
    $potensiId = isset($mediaRow['potensi_id']) ? (int) $mediaRow['potensi_id'] : 0;
    if ($potensiId <= 0) {
        continue;
    }
    if (!isset($gambarPotensiByPotensi[$potensiId])) {
        $gambarPotensiByPotensi[$potensiId] = [];
    }
    $mediaUrl = resolve_potensi_media_url((string) ($mediaRow['gambar_namafile'] ?? ''));
    $gambarPotensiByPotensi[$potensiId][] = [
        'id' => (int) ($mediaRow['gambar_id'] ?? 0),
        'judul' => (string) ($mediaRow['potensi_judul'] ?? ''),
        'file' => $mediaUrl,
        'raw' => (string) ($mediaRow['gambar_namafile'] ?? ''),
        'created_at' => $mediaRow['gambar_created_at'] ?? null,
        'created_label' => format_datetime($mediaRow['gambar_created_at'] ?? null),
    ];
}
$potensiDesa = fetch_table($pdo, 'SELECT potensi_id, potensi_judul, potensi_isi, potensi_kategori, potensi_gmaps_link, potensi_created_at, potensi_updated_at FROM potensi_desa ORDER BY potensi_updated_at DESC LIMIT 50');
if (isset($tableForms['potensi-media']['fields']['potensi_id'])) {
    $potensiSelectOptions = ['' => '-- Pilih Potensi --'];
    foreach ($potensiDesa as $potensiRow) {
        $id = isset($potensiRow['potensi_id']) ? (int) $potensiRow['potensi_id'] : 0;
        if ($id <= 0) {
            continue;
        }
        $title = trim((string) ($potensiRow['potensi_judul'] ?? ''));
        if ($title === '') {
            $title = 'Potensi #' . $id;
        }
        $potensiSelectOptions[(string) $id] = $title;
    }
    $tableForms['potensi-media']['fields']['potensi_id']['options'] = $potensiSelectOptions;
}
$pengumuman = fetch_table($pdo, 'SELECT pengumuman_id, pengumuman_isi, pengumuman_valid_hingga, pengumuman_created_at, pengumuman_updated_at FROM pengumuman ORDER BY pengumuman_updated_at DESC LIMIT 50');
$permohonanInformasi = fetch_table($pdo, 'SELECT pi_id, pi_email, pi_asal_instansi, pi_selesai, pi_created_at, pi_updated_at FROM permohonan_informasi ORDER BY pi_updated_at DESC LIMIT 50');
$ppidDokumen = fetch_table($pdo, 'SELECT ppid_id, ppid_judul, ppid_kategori, ppid_namafile, ppid_created_at, ppid_updated_at FROM ppid_dokumen ORDER BY ppid_updated_at DESC LIMIT 50');
$programDesa = fetch_table($pdo, 'SELECT program_id, program_nama, program_deskripsi, program_gambar, program_created_at, program_updated_at FROM program_desa ORDER BY program_updated_at DESC LIMIT 50');
$strukturOrganisasi = fetch_table($pdo, 'SELECT struktur_id, struktur_nama, struktur_jabatan, struktur_foto, struktur_created_at, struktur_updated_at FROM struktur_organisasi ORDER BY struktur_updated_at DESC LIMIT 50');

$flashMessages = $_SESSION['flash'] ?? [];
$flashErrors = $_SESSION['flash_error'] ?? [];
$formErrors = $_SESSION['form_errors'] ?? [];
$formOld = $_SESSION['form_old'] ?? [];
unset($_SESSION['flash'], $_SESSION['flash_error'], $_SESSION['form_errors'], $_SESSION['form_old']);

function section_card(string $sectionId, string $title, string $description, array $headers, array $rows, callable $rowRenderer): string
{
    global $tableForms;

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

    $toolsHtml = '<span class="badge">' . count($rows) . ' item</span>';
    if (isset($tableForms[$sectionId])) {
        $toolsHtml .= '<button type="button" class="btn-add" data-open-modal="' . e($sectionId) . '">Tambah Data</button>';
    }

    return '
    <section class="card section-card" data-section="' . e($sectionId) . '" id="' . e($sectionId) . '">
        <header class="card__header">
            <div>
                <h2>' . e($title) . '</h2>
                <p>' . e($description) . '</p>
            </div>
            <div class="card__tools">' . $toolsHtml . '</div>
        </header>
        <div class="table-wrapper">
            <table>
                <thead><tr>' . $headerHtml . '</tr></thead>
                <tbody>' . $bodyHtml . '</tbody>
            </table>
        </div>
    </section>';
}

function render_modal(string $formId, array $definition, array $oldInputs, array $errors): string
{
    $title = $definition['title'] ?? ucfirst(str_replace('-', ' ', $formId));
    $fields = $definition['fields'] ?? [];

    $errorList = '';
    if ($errors !== []) {
        $items = '';
        foreach ($errors as $name => $message) {
            if ($name === '_general') {
                continue;
            }
            $items .= '<li>' . e($message) . '</li>';
        }
        if (isset($errors['_general'])) {
            $items = '<li>' . e($errors['_general']) . '</li>' . $items;
        }
        $errorList = '<div class="modal-alert"><strong>Periksa kembali:</strong><ul>' . $items . '</ul></div>';
    }

    $fieldsHtml = '';

    foreach ($fields as $name => $meta) {
        $type = $meta['type'] ?? 'text';
        $label = $meta['label'] ?? ucfirst(str_replace('_', ' ', $name));
        $required = !empty($meta['required']);
        $default = $meta['default'] ?? null;
        $value = $oldInputs[$name] ?? ($default ?? '');
        $fieldError = $errors[$name] ?? '';

        if ($type === 'datetime' && $value !== '') {
            $timestamp = strtotime((string) $value);
            if ($timestamp !== false) {
                $value = date('Y-m-d\TH:i', $timestamp);
            }
        }

        if ($type === 'checkbox') {
            $isChecked = isset($oldInputs[$name])
                ? in_array((string) $oldInputs[$name], ['1', 'on', 'true'], true)
                : (!empty($default));

            $fieldsHtml .= '
            <div class="modal__field modal__field--checkbox">
                <label>
                    <input type="checkbox" name="' . e($name) . '"' . ($isChecked ? ' checked' : '') . '>
                    ' . e($label) . '
                </label>'
                . ($fieldError !== '' ? '<div class="field-error">' . e($fieldError) . '</div>' : '')
            . '</div>';
            continue;
        }

        $inputHtml = '';
        $requiredAttr = $required ? ' required' : '';

        switch ($type) {
            case 'file_pdf':
                $inputHtml = '<input type="file" name="' . e($name) . '" accept="application/pdf"' . $requiredAttr . '>';
                break;
            case 'file_image':
                $inputHtml = '<input type="file" name="' . e($name) . '" accept="image/jpeg,image/png,image/webp"' . $requiredAttr . '>';
                break;
            case 'textarea':
                $inputHtml = '<textarea name="' . e($name) . '" rows="4"' . $requiredAttr . '>' . e((string) $value) . '</textarea>';
                break;
            case 'select':
                $options = $meta['options'] ?? [];
                $optionsHtml = '';
                $isList = array_is_list($options);

                foreach ($options as $optionValue => $optionLabel) {
                    if ($isList || is_int($optionValue)) {
                        $optionValue = (string) $optionLabel;
                        $optionLabel = (string) $optionLabel;
                    } else {
                        $optionValue = (string) $optionValue;
                        $optionLabel = (string) $optionLabel;
                    }
                    $optionsHtml .= '<option value="' . e($optionValue) . '"' . ((string) $value === $optionValue ? ' selected' : '') . '>' . e($optionLabel) . '</option>';
                }

                $inputHtml = '<select name="' . e($name) . '"' . $requiredAttr . '>' . $optionsHtml . '</select>';
                break;
            case 'number':
                $inputHtml = '<input type="number" name="' . e($name) . '" value="' . e($value !== '' ? (string) $value : '') . '"' . $requiredAttr . '>';
                break;
            case 'email':
                $inputHtml = '<input type="email" name="' . e($name) . '" value="' . e((string) $value) . '"' . $requiredAttr . '>';
                break;
            case 'datetime':
                $inputHtml = '<input type="datetime-local" name="' . e($name) . '" value="' . e((string) $value) . '"' . $requiredAttr . '>';
                break;
            default:
                    $inputHtml = '<input type="text" name="' . e($name) . '" value="' . e((string) (is_array($value) ? '' : $value)) . '"' . $requiredAttr . '>';
                break;
        }

        $fieldsHtml .= '
            <div class="modal__field">
                <label for="' . e($formId . '_' . $name) . '">' . e($label) . ($required ? ' <span class="required">*</span>' : '') . '</label>
                ' . str_replace('name="' . e($name) . '"', 'name="' . e($name) . '" id="' . e($formId . '_' . $name) . '"', $inputHtml) . '
                ' . ($fieldError !== '' ? '<div class="field-error">' . e($fieldError) . '</div>' : '') . '
            </div>';
    }

    $backdropAttr = 'class="modal-backdrop" data-modal="' . e($formId) . '"';
    if ($errors !== []) {
        $backdropAttr .= ' data-open-on-load="1"';
    }

    return '
    <div ' . $backdropAttr . '>
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">' . e($definition['title'] ?? 'Data') . '</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                ' . $errorList . '
                <form method="post" action="admin_management.php#' . e($formId) . '" autocomplete="off" enctype="multipart/form-data">
                    <input type="hidden" name="form_id" value="' . e($formId) . '">
                    ' . $fieldsHtml . '
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>';
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
            scrollbar-width: none;
        }

        .sidebar::-webkit-scrollbar {
            width: 0;
            height: 0;
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

        .sidebar a.is-active {
            background: rgba(255, 255, 255, 0.24);
            color: #ffffff;
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
            display: block;
            gap: 24px;
        }

        .section-card {
            display: block;
            margin-bottom: 24px;
        }

        .js-enabled .section-card {
            display: none;
        }

        .js-enabled .section-card.is-active {
            display: block;
            animation: fadeIn 0.25s ease;
        }

        .card {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
            border: 1px solid rgba(226, 232, 240, 0.7);
            padding: 24px 24px 28px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
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

        .card__tools {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-add {
            border: none;
            border-radius: 10px;
            padding: 10px 16px;
            background: #2563eb;
            color: #ffffff;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }

        .btn-add:hover {
            transform: translateY(-1px);
            background: #1d4ed8;
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.28);
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
        }

        .flash {
            margin-bottom: 20px;
            padding: 14px 18px;
            border-radius: 12px;
            font-size: 14px;
        }

        .flash--success {
            background: rgba(22, 163, 74, 0.12);
            color: #166534;
            border: 1px solid rgba(22, 163, 74, 0.3);
        }

        .flash--error {
            background: rgba(239, 68, 68, 0.12);
            color: #b91c1c;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .upload-overlay {
            position: fixed;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(15, 23, 42, 0.65);
            z-index: 9999;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.2s ease;
        }

        .upload-overlay.is-visible {
            opacity: 1;
            pointer-events: auto;
        }

        .upload-overlay__content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 16px;
            padding: 32px 40px;
            border-radius: 16px;
            background: rgba(15, 23, 42, 0.85);
            color: #f8fafc;
            text-align: center;
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.4);
        }

        .upload-overlay__spinner {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            border: 5px solid rgba(148, 163, 184, 0.35);
            border-top-color: #60a5fa;
            animation: upload-overlay-spin 0.9s linear infinite;
        }

        .upload-overlay__content p {
            margin: 0;
            font-size: 16px;
            letter-spacing: 0.02em;
        }

        @keyframes upload-overlay-spin {
            from {
                transform: rotate(0);
            }
            to {
                transform: rotate(360deg);
            }
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .table-actions__form {
            margin: 0;
        }

        .table-actions a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .modal-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.55);
            display: none;
            align-items: center;
            justify-content: center;
            padding: 24px;
            z-index: 100;
        }

        .modal-backdrop.is-open {
            display: flex;
        }

        .modal {
            background: #ffffff;
            border-radius: 18px;
            width: min(520px, 92vw);
            max-height: 90vh;
            overflow-y: auto;
            padding: 28px 28px 32px;
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.25);
            border: 1px solid rgba(226, 232, 240, 0.85);
        }

        .modal--wide {
            width: min(720px, 96vw);
        }

        .modal__header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
        }

        .modal__toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }

        .modal__subtitle {
            margin: 0;
            font-size: 14px;
            color: #475569;
        }

        .modal__title {
            margin: 0;
            font-size: 20px;
            letter-spacing: -0.01em;
        }

        .modal__close {
            border: none;
            background: transparent;
            font-size: 24px;
            line-height: 1;
            cursor: pointer;
            color: #64748b;
        }

        .modal__body {
            display: grid;
            gap: 18px;
        }

        .modal-empty {
            margin: 0;
            padding: 16px;
            text-align: center;
            font-size: 14px;
            color: #475569;
            background: rgba(148, 163, 184, 0.16);
            border-radius: 12px;
        }

        .modal__field label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #1f2937;
            margin-bottom: 6px;
        }

        .modal__field input,
        .modal__field select,
        .modal__field textarea {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid rgba(100, 116, 139, 0.35);
            font-size: 14px;
            font-family: inherit;
            transition: border 0.2s ease, box-shadow 0.2s ease;
        }

        .modal__field textarea {
            resize: vertical;
            min-height: 120px;
        }

        .is-hidden {
            display: none !important;
        }

        .modal__field input:focus,
        .modal__field select:focus,
        .modal__field textarea:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }

        .field-hint {
            display: block;
            margin-top: 6px;
            font-size: 12px;
            color: #64748b;
        }

        .modal__field--checkbox label {
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .modal__field--checkbox input {
            width: 18px;
            height: 18px;
        }

        .modal__actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 10px;
        }

        .btn-primary,
        .btn-secondary {
            border: none;
            border-radius: 10px;
            padding: 10px 18px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-primary {
            background: #2563eb;
            color: #ffffff;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .btn-secondary {
            background: rgba(148, 163, 184, 0.2);
            color: #334155;
        }

        .btn-secondary:hover {
            background: rgba(148, 163, 184, 0.35);
        }

        .btn-outline {
            border: 1px solid rgba(37, 99, 235, 0.4);
            border-radius: 8px;
            padding: 8px 14px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            background: transparent;
            color: #2563eb;
            line-height: 1.2;
            transition: background 0.2s ease, color 0.2s ease, border-color 0.2s ease;
        }

        .btn-outline:hover {
            background: rgba(37, 99, 235, 0.1);
            color: #1d4ed8;
            border-color: rgba(37, 99, 235, 0.6);
        }

        .btn-danger {
            border: none;
            border-radius: 8px;
            padding: 8px 14px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            background: rgba(220, 38, 38, 0.15);
            color: #b91c1c;
            line-height: 1.2;
            transition: background 0.2s ease, color 0.2s ease;
        }

        .btn-danger:hover {
            background: rgba(220, 38, 38, 0.25);
            color: #991b1b;
        }

        .modal-alert {
            padding: 12px 14px;
            border-radius: 10px;
            background: rgba(239, 68, 68, 0.12);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #b91c1c;
            font-size: 13px;
        }

        .modal-alert ul {
            margin: 8px 0 0;
            padding-left: 18px;
        }

        .field-error {
            margin-top: 6px;
            color: #b91c1c;
            font-size: 12px;
        }

        .required {
            color: #dc2626;
        }

        body.modal-open {
            overflow: hidden;
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
            <a class="sidebar-link" href="#apbdes" data-section="apbdes">APBDes</a>
            <a class="sidebar-link" href="#berita" data-section="berita">Berita</a>
            <a class="sidebar-link" href="#fasilitas" data-section="fasilitas">Fasilitas</a>
            <a class="sidebar-link" href="#potensi" data-section="potensi">Potensi Desa</a>
            <a class="sidebar-link" href="#pengumuman" data-section="pengumuman">Pengumuman</a>
            <!-- <a class="sidebar-link" href="#permohonan" data-section="permohonan">Permohonan Informasi</a> -->
            <!-- <a class="sidebar-link" href="#ppid" data-section="ppid">PPID Dokumen</a> -->
            <a class="sidebar-link" href="#program" data-section="program">Program Desa</a>
            <a class="sidebar-link" href="#galeri" data-section="galeri">Galeri</a>
            <a class="sidebar-link" href="#struktur" data-section="struktur">Struktur Organisasi</a>
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
            <?php foreach ($flashErrors as $msg): ?>
                <div class="flash flash--error"><?= e($msg) ?></div>
            <?php endforeach; ?>
            <?php foreach ($flashMessages as $msg): ?>
                <div class="flash flash--success"><?= e($msg) ?></div>
            <?php endforeach; ?>


        <div class="cards-grid">
            <?= section_card(
                'apbdes',
                'Dokumen APBDes',
                'Daftar dokumen APBDes terbaru.',
                ['ID', 'Judul', 'Berkas', 'Diubah oleh', 'Dibuat', 'Diperbarui', 'Aksi'],
                $apbdes,
                static function (array $row): string {
                    $file = (string) ($row['apbdes_file'] ?? '');
                    $fileLink = $file !== '' ? '<a href="' . e(base_uri('uploads/apbdes/' . ltrim($file, '/'))) . '" target="_blank" rel="noopener">Lihat</a>' : '-';
                    $rowId = (int) ($row['apbdes_id'] ?? 0);
                    $actionsHtml = '-';
                    if ($rowId > 0) {
                        $actionsHtml = '<button type="button" class="btn-outline" data-open-modal="apbdes-edit"'
                            . ' data-apbdes-id="' . e((string) $rowId) . '"'
                            . ' data-apbdes-judul="' . e((string) ($row['apbdes_judul'] ?? '')) . '"'
                            . ' title="Ubah Judul">Ubah</button>'
                            . '<form method="post" action="admin_management.php#apbdes" class="table-actions__form" onsubmit="return confirm(\'Hapus dokumen ini?\');">'
                            . '<input type="hidden" name="action" value="delete_apbdes">'
                            . '<input type="hidden" name="apbdes_id" value="' . e((string) $rowId) . '">'
                            . '<button type="submit" class="btn-danger">Hapus</button>'
                            . '</form>';
                    }
                    return '<tr>'
                        . '<td>#' . e((string) $row['apbdes_id']) . '</td>'
                        . '<td>' . e((string) $row['apbdes_judul']) . '</td>'
                        . '<td>' . $fileLink . '</td>'
                        . '<td>' . e((string) ($row['apbdes_edited_by'] ?? '')) . '</td>'
                        . '<td>' . e(format_datetime($row['apbdes_created_at'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['apbdes_updated_at'] ?? null)) . '</td>'
                        . '<td class="table-actions">' . $actionsHtml . '</td>'
                        . '</tr>';
                }
            ) ?>

            <?= section_card(
                'berita',
                'Berita Desa',
                'Artikel dan berita dari info publik.',
                ['ID', 'Judul', 'Gambar', 'Dibaca', 'Dibuat', 'Diperbarui', 'Aksi'],
                $berita,
                static function (array $row): string {
                    $thumb = (string) ($row['berita_gambar'] ?? '');
                    $thumbHtml = $thumb !== '' ? '<a href="' . e(base_uri('uploads/berita/' . ltrim($thumb, '/'))) . '" target="_blank" rel="noopener">Buka</a>' : '-';
                    $rowId = isset($row['berita_id']) ? (int) $row['berita_id'] : 0;
                    $payload = [
                        'id' => $rowId,
                        'judul' => (string) ($row['berita_judul'] ?? ''),
                        'isi' => (string) ($row['berita_isi'] ?? ''),
                    ];
                    $dataAttr = e((string) json_encode($payload, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE));
                    $actionsHtml = $rowId > 0
                        ? '<button type="button" class="btn-outline" data-open-modal="berita-edit" data-berita="' . $dataAttr . '">Ubah</button>'
                            . '<form method="post" action="admin_management.php#berita" class="table-actions__form" onsubmit="return confirm(\'Hapus berita ini?\');">'
                            . '<input type="hidden" name="action" value="delete_berita">'
                            . '<input type="hidden" name="berita_id" value="' . e((string) $rowId) . '">'
                            . '<button type="submit" class="btn-danger">Hapus</button>'
                            . '</form>'
                        : '-';
                    return '<tr>'
                        . '<td>#' . e((string) $row['berita_id']) . '</td>'
                        . '<td>' . e((string) $row['berita_judul']) . '</td>'
                        . '<td>' . $thumbHtml . '</td>'
                        . '<td>' . e((string) ($row['berita_dilihat'] ?? 0)) . ' kali</td>'
                        . '<td>' . e(format_datetime($row['berita_created_at'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['berita_updated_at'] ?? null)) . '</td>'
                        . '<td class="table-actions">' . $actionsHtml . '</td>'
                        . '</tr>';
                }
            ) ?>

            <?= section_card(
                'fasilitas',
                'Fasilitas Desa',
                'Data fasilitas publik dan link lokasi.',
                ['ID', 'Nama', 'Gambar', 'Google Maps', 'Dibuat', 'Diperbarui', 'Aksi'],
                $fasilitas,
                static function (array $row): string {
                    $img = (string) ($row['fasilitas_gambar'] ?? '');
                    $maps = (string) ($row['fasilitas_gmaps_link'] ?? '');
                    $imgHtml = $img !== '' ? '<a href="' . e(base_uri('uploads/fasilitas/' . ltrim($img, '/'))) . '" target="_blank" rel="noopener">Lihat</a>' : '-';
                    $mapsHtml = $maps !== '' ? '<a href="' . e($maps) . '" target="_blank" rel="noopener">Buka Maps</a>' : '-';
                    $rowId = isset($row['fasilitas_id']) ? (int) $row['fasilitas_id'] : 0;
                    $payload = [
                        'id' => $rowId,
                        'nama' => (string) ($row['fasilitas_nama'] ?? ''),
                        'gmaps' => (string) ($row['fasilitas_gmaps_link'] ?? ''),
                    ];
                    $dataAttr = e((string) json_encode($payload, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE));
                    $actionsHtml = $rowId > 0
                        ? '<button type="button" class="btn-outline" data-open-modal="fasilitas-edit" data-fasilitas="' . $dataAttr . '">Ubah</button>'
                            . '<form method="post" action="admin_management.php#fasilitas" class="table-actions__form" onsubmit="return confirm(\'Hapus fasilitas ini?\');">'
                            . '<input type="hidden" name="action" value="delete_fasilitas">'
                            . '<input type="hidden" name="fasilitas_id" value="' . e((string) $rowId) . '">'
                            . '<button type="submit" class="btn-danger">Hapus</button>'
                        . '</form>'
                    : '-';
                    return '<tr>'
                        . '<td>#' . e((string) $row['fasilitas_id']) . '</td>'
                        . '<td>' . e((string) $row['fasilitas_nama']) . '</td>'
                        . '<td>' . $imgHtml . '</td>'
                        . '<td>' . $mapsHtml . '</td>'
                        . '<td>' . e(format_datetime($row['fasilitas_created_at'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['fasilitas_updated_at'] ?? null)) . '</td>'
                        . '<td class="table-actions">' . $actionsHtml . '</td>'
                        . '</tr>';
                }
            ) ?>

            <?= section_card(
                'potensi',
                'Potensi Desa',
                'Daftar potensi desa beserta kategori.',
                ['ID', 'Judul', 'Kategori', 'Google Maps', 'Foto', 'Dibuat', 'Diperbarui', 'Aksi'],
                $potensiDesa,
                static function (array $row) use ($gambarPotensiByPotensi): string {
                $maps = (string) ($row['potensi_gmaps_link'] ?? '');
                $mapsHtml = $maps !== '' ? '<a href="' . e($maps) . '" target="_blank" rel="noopener">Lokasi</a>' : '-';
                $potensiId = isset($row['potensi_id']) ? (int) $row['potensi_id'] : 0;
                $images = $potensiId > 0 && isset($gambarPotensiByPotensi[$potensiId]) ? $gambarPotensiByPotensi[$potensiId] : [];
                $payload = [
                    'id' => $potensiId,
                    'judul' => (string) ($row['potensi_judul'] ?? ''),
                    'isi' => (string) ($row['potensi_isi'] ?? ''),
                    'kategori' => (string) ($row['potensi_kategori'] ?? ''),
                    'gmaps' => (string) ($row['potensi_gmaps_link'] ?? ''),
                ];
                $dataAttr = e(json_encode($payload, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

                $photosButton = $potensiId > 0
                    ? '<button type="button" class="btn-outline" data-open-modal="potensi-gallery" data-potensi-gallery="' . $dataAttr . '">Foto (' . count($images) . ')</button>'
                    : '-';

                $actionsHtml = $potensiId > 0
                    ? '<button type="button" class="btn-outline" data-open-modal="potensi-edit" data-potensi=\'' . $dataAttr . '\'>Ubah</button>'
                        . '<form method="post" action="admin_management.php#potensi" class="table-actions__form" onsubmit="return confirm(\'Hapus potensi ini beserta semua fotonya?\');">'
                        . '<input type="hidden" name="action" value="delete_potensi">'
                        . '<input type="hidden" name="potensi_id" value="' . e((string) $potensiId) . '">'
                        . '<button type="submit" class="btn-danger">Hapus</button>'
                        . '</form>'
                    : '-';

                return '<tr>'
                    . '<td>#' . e((string) $row['potensi_id']) . '</td>'
                    . '<td>' . e((string) $row['potensi_judul']) . '</td>'
                    . '<td>' . e((string) $row['potensi_kategori']) . '</td>'
                    . '<td>' . $mapsHtml . '</td>'
                    . '<td>' . $photosButton . '</td>'
                    . '<td>' . e(format_datetime($row['potensi_created_at'] ?? null)) . '</td>'
                    . '<td>' . e(format_datetime($row['potensi_updated_at'] ?? null)) . '</td>'
                    . '<td class="table-actions">' . $actionsHtml . '</td>'
                    . '</tr>';
            }
            ) ?>

            <?= section_card(
                'galeri',
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

            <?= section_card(
                'pengumuman',
                'Pengumuman',
                'Informasi dan pengumuman penting desa.',
                ['ID', 'Berlaku sampai', 'Dibuat', 'Diperbarui', 'Aksi'],
                $pengumuman,
                static function (array $row): string {
                    $id = (int) ($row['pengumuman_id'] ?? 0);
                    $payload = [
                        'id' => $id,
                        'isi' => (string) ($row['pengumuman_isi'] ?? ''),
                    ];
                    $dataAttr = e(json_encode($payload, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE));

                    $aksi = $id > 0
                    ? '<div class="table-actions">'
                        . '<button type="button" class="btn-outline" data-open-modal="pengumuman-view" data-pengumuman="' . $dataAttr . '">Lihat Isi</button>'
                        . '<button type="button" class="btn-outline" data-open-modal="pengumuman-edit" data-pengumuman=\'' . $dataAttr . '\'>Ubah</button>'
                        . '<form method="post" action="admin_management.php#pengumuman" class="table-actions__form" onsubmit="return confirm(\'Hapus pengumuman ini?\');">'
                        . '<input type="hidden" name="action" value="delete_pengumuman">'
                        . '<input type="hidden" name="pengumuman_id" value="' . e((string) $id) . '">'
                        . '<button type="submit" class="btn-danger">Hapus</button>'
                        . '</form>'
                        . '</div>'
                    : '-';

                    return '<tr>'
                        . '<td>#' . e((string) $id) . '</td>'
                        . '<td>' . e(format_datetime($row['pengumuman_valid_hingga'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['pengumuman_created_at'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['pengumuman_updated_at'] ?? null)) . '</td>'
                        . '<td class="table-actions">' . $aksi . '</td>'
                        . '</tr>';
                }
            ) ?>

            <!-- <?= section_card(
                'permohonan',
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
            ) ?> -->

            <!-- <?= section_card(
                'ppid',
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
            ) ?> -->

            <?= section_card(
                'program',
                'Program Desa',
                'Program kerja dan kegiatan desa.',
                ['ID', 'Nama Program', 'Gambar', 'Dibuat', 'Diperbarui', 'Aksi'],
                $programDesa,
                static function (array $row): string {
                    $img = (string) ($row['program_gambar'] ?? '');
                    $imgHtml = $img !== '' ? '<a href="' . e(base_uri('uploads/program/' . ltrim($img, '/'))) . '" target="_blank" rel="noopener">Lihat</a>' : '-';
                    $rowId = (int) ($row['program_id'] ?? 0);
                    $payload = [
                        'id' => $rowId,
                        'nama' => (string) ($row['program_nama'] ?? ''),
                        'deskripsi' => (string) ($row['program_deskripsi'] ?? ''), // ✅ pastikan ini ada
                    ];
                    $dataAttr = e(json_encode($payload, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE));

                    $actionsHtml = $rowId > 0
                        ? '<button type="button" class="btn-outline" data-open-modal="program-edit" data-program="' . $dataAttr . '">Ubah</button>'
                        . '<form method="post" action="admin_management.php#program" class="table-actions__form" onsubmit="return confirm(\'Hapus program ini?\');">'
                        . '<input type="hidden" name="action" value="delete_program">'
                        . '<input type="hidden" name="program_id" value="' . e((string) $rowId) . '">'
                        . '<button type="submit" class="btn-danger">Hapus</button>'
                        . '</form>'
                        : '-';

                    return '<tr>'
                        . '<td>#' . e((string) $row['program_id']) . '</td>'
                        . '<td>' . e((string) $row['program_nama']) . '</td>'
                        . '<td>' . $imgHtml . '</td>'
                        . '<td>' . e(format_datetime($row['program_created_at'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['program_updated_at'] ?? null)) . '</td>'
                        . '<td class="table-actions">' . $actionsHtml . '</td>'
                        . '</tr>';
                }
            ) ?>

            <?= section_card(
                'struktur',
                'Struktur Organisasi',
                'Susunan perangkat desa.',
                ['ID', 'Nama', 'Jabatan', 'Foto', 'Dibuat', 'Diperbarui'],
                $strukturOrganisasi,
                static function (array $row): string {
                    $foto = (string) ($row['struktur_foto'] ?? '');
                    $fotoHtml = $foto !== '' ? '<div class="media-thumb"><img src="' . e($foto) . '" alt="struktur"><span>Foto</span></div>' : '-';
                    return '<tr>'
                        . '<td>#' . e((string) $row['struktur_id']) . '</td>'
                        . '<td>' . e((string) $row['struktur_nama']) . '</td>'
                        . '<td>' . e((string) $row['struktur_jabatan']) . '</td>'
                        . '<td>' . $fotoHtml . '</td>'
                        . '<td>' . e(format_datetime($row['struktur_created_at'] ?? null)) . '</td>'
                        . '<td>' . e(format_datetime($row['struktur_updated_at'] ?? null)) . '</td>'
                        . '</tr>';
                }
            ) ?>

        </div>
    </main>
    <?php foreach ($tableForms as $modalId => $definition): ?>
        <?= render_modal($modalId, $definition, $formOld[$modalId] ?? [], $formErrors[$modalId] ?? []) ?>
    <?php endforeach; ?>
    <div class="modal-backdrop" data-modal="potensi-gallery">
        <div class="modal modal--wide">
            <div class="modal__header">
                <h3 class="modal__title" data-potensi-gallery-title>Foto Potensi</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <div class="modal__toolbar">
                    <p class="modal__subtitle" data-potensi-gallery-subtitle></p>
                    <button type="button" class="btn-primary" data-open-modal="potensi-media" data-potensi-media-id="" disabled="disabled">Tambah Foto</button>
                </div>
                <div class="table-wrapper is-hidden" data-potensi-gallery-table>
                    <table>
                        <thead>
                            <tr>
                                <th>Potensi</th>
                                <th>File</th>
                                <th>Diupload</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody data-potensi-gallery-tbody></tbody>
                    </table>
                </div>
                <p class="modal-empty" data-potensi-gallery-empty>Belum ada foto untuk potensi ini.</p>
            </div>
        </div>
    </div>
    <div class="modal-backdrop" data-modal="pengumuman-view">
        <div class="modal modal--wide">
            <div class="modal__header">
                <h3 class="modal__title">Isi Pengumuman</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <div class="modal__field">
                    <label>Isi Pengumuman</label>
                    <textarea id="pengumuman_view_isi" rows="10" readonly style="resize:none; background:#f9fafb;"></textarea>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-backdrop" data-modal="pengumuman-edit">
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">Ubah Pengumuman</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <form method="post" action="admin_management.php#pengumuman" autocomplete="off" id="pengumuman-edit-form">
                    <input type="hidden" name="action" value="edit_pengumuman">
                    <input type="hidden" name="pengumuman_id" id="pengumuman_edit_id">
                    <div class="modal__field">
                        <label for="pengumuman_edit_isi">Isi Pengumuman <span class="required">*</span></label>
                        <textarea name="pengumuman_isi" id="pengumuman_edit_isi" rows="6" required></textarea>
                    </div>
                    <div class="modal__field">
                        <label for="pengumuman_edit_valid">Berlaku Hingga <span class="required">*</span></label>
                        <input type="datetime-local" name="pengumuman_valid_hingga" id="pengumuman_edit_valid" required>
                    </div>
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal-backdrop" data-modal="apbdes-edit">
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">Ubah Judul Dokumen</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <form method="post" action="admin_management.php#apbdes" autocomplete="off" id="apbdes-edit-form">
                    <input type="hidden" name="action" value="edit_apbdes">
                    <input type="hidden" name="apbdes_id" id="apbdes_edit_id">
                    <div class="modal__field">
                        <label for="apbdes_edit_judul">Judul Dokumen <span class="required">*</span></label>
                        <input type="text" name="apbdes_judul" id="apbdes_edit_judul" required>
                    </div>
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal-backdrop" data-modal="berita-edit">
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">Ubah Berita</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <form method="post" action="admin_management.php#berita" autocomplete="off" enctype="multipart/form-data" id="berita-edit-form">
                    <input type="hidden" name="action" value="edit_berita">
                    <input type="hidden" name="berita_id" id="berita_edit_id">
                    <div class="modal__field">
                        <label for="berita_edit_judul">Judul Berita <span class="required">*</span></label>
                        <input type="text" name="berita_judul" id="berita_edit_judul" required>
                    </div>
                    <div class="modal__field">
                        <label for="berita_edit_isi">Isi Berita <span class="required">*</span></label>
                        <textarea name="berita_isi" id="berita_edit_isi" rows="6" required></textarea>
                    </div>
                    <div class="modal__field">
                        <label for="berita_edit_gambar">Gambar (opsional)</label>
                        <input type="file" name="berita_gambar" id="berita_edit_gambar" accept="image/jpeg,image/png,image/webp">
                        <small class="field-hint">Kosongkan jika tidak ingin mengganti gambar.</small>
                    </div>
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal-backdrop" data-modal="fasilitas-edit">
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">Ubah Fasilitas</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <form method="post" action="admin_management.php#fasilitas" autocomplete="off" enctype="multipart/form-data" id="fasilitas-edit-form">
                    <input type="hidden" name="action" value="edit_fasilitas">
                    <input type="hidden" name="fasilitas_id" id="fasilitas_edit_id">
                    <div class="modal__field">
                        <label for="fasilitas_edit_nama">Nama Fasilitas <span class="required">*</span></label>
                        <input type="text" name="fasilitas_nama" id="fasilitas_edit_nama" required>
                    </div>
                    <div class="modal__field">
                        <label for="fasilitas_edit_gmaps">Link Google Maps</label>
                        <input type="text" name="fasilitas_gmaps_link" id="fasilitas_edit_gmaps">
                    </div>
                    <div class="modal__field">
                        <label for="fasilitas_edit_gambar">Gambar (opsional)</label>
                        <input type="file" name="fasilitas_gambar" id="fasilitas_edit_gambar" accept="image/jpeg,image/png,image/webp">
                        <small class="field-hint">Kosongkan jika tidak ingin mengganti gambar.</small>
                    </div>
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal-backdrop" data-modal="program-edit">
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">Ubah Program Desa</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <form method="post" action="admin_management.php#program" autocomplete="off" enctype="multipart/form-data" id="program-edit-form">
                    <input type="hidden" name="action" value="edit_program">
                    <input type="hidden" name="program_id" id="program_edit_id">
                    <div class="modal__field">
                        <label for="program_edit_nama">Nama Program <span class="required">*</span></label>
                        <input type="text" name="program_nama" id="program_edit_nama" required>
                    </div>
                    <div class="modal__field">
                        <label for="program_edit_deskripsi">Deskripsi <span class="required">*</span></label>
                        <textarea name="program_deskripsi" id="program_edit_deskripsi" rows="5" required></textarea>
                    </div>
                    <div class="modal__field">
                        <label for="program_edit_gambar">Gambar (opsional)</label>
                        <input type="file" name="program_gambar" id="program_edit_gambar" accept="image/jpeg,image/png,image/webp">
                        <small class="field-hint">Kosongkan jika tidak ingin mengganti gambar.</small>
                    </div>
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal-backdrop" data-modal="potensi-edit">
        <div class="modal">
            <div class="modal__header">
                <h3 class="modal__title">Ubah Potensi Desa</h3>
                <button type="button" class="modal__close" data-close-modal aria-label="Tutup">&times;</button>
            </div>
            <div class="modal__body">
                <form method="post" action="admin_management.php#potensi" autocomplete="off" id="potensi-edit-form">
                    <input type="hidden" name="action" value="edit_potensi">
                    <input type="hidden" name="potensi_id" id="potensi_edit_id">
                    <div class="modal__field">
                        <label for="potensi_edit_judul">Judul Potensi <span class="required">*</span></label>
                        <input type="text" name="potensi_judul" id="potensi_edit_judul" required>
                    </div>
                    <div class="modal__field">
                        <label for="potensi_edit_kategori">Kategori <span class="required">*</span></label>
                        <select name="potensi_kategori" id="potensi_edit_kategori" required>
                            <option value="Wisata">Wisata</option>
                            <option value="Budaya">Budaya</option>
                            <option value="Kuliner">Kuliner</option>
                            <option value="UMKM">UMKM</option>
                        </select>
                    </div>
                    <div class="modal__field">
                        <label for="potensi_edit_isi">Deskripsi <span class="required">*</span></label>
                        <textarea name="potensi_isi" id="potensi_edit_isi" rows="6" required></textarea>
                    </div>
                    <div class="modal__field">
                        <label for="potensi_edit_gmaps">Link Google Maps</label>
                        <input type="text" name="potensi_gmaps_link" id="potensi_edit_gmaps">
                    </div>
                    <div class="modal__actions">
                        <button type="button" class="btn-secondary" data-close-modal>Batal</button>
                        <button type="submit" class="btn-primary">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="upload-overlay" id="upload-overlay" role="alert" aria-live="assertive" aria-hidden="true">
    <div class="upload-overlay__content">
        <div class="upload-overlay__spinner" aria-hidden="true"></div>
        <p>Mengupload file...</p>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var bodyEl = document.body;
        bodyEl.classList.add('js-enabled');
        var uploadOverlay = document.getElementById('upload-overlay');
        if (uploadOverlay) {
            uploadOverlay.classList.remove('is-visible');
            uploadOverlay.setAttribute('aria-hidden', 'true');
        }
        var apbdesEditIdInput = document.getElementById('apbdes_edit_id');
        var apbdesEditTitleInput = document.getElementById('apbdes_edit_judul');
        var beritaEditForm = document.getElementById('berita-edit-form');
        var beritaEditIdInput = document.getElementById('berita_edit_id');
        var beritaEditTitleInput = document.getElementById('berita_edit_judul');
        var beritaEditBodyInput = document.getElementById('berita_edit_isi');
        var beritaEditFileInput = document.getElementById('berita_edit_gambar');
        var showUploadOverlay = function () {
            if (!uploadOverlay) {
                return;
            }
            uploadOverlay.classList.add('is-visible');
            uploadOverlay.setAttribute('aria-hidden', 'false');
        };
        Array.from(document.querySelectorAll('form')).forEach(function (form) {
            var formIdInput = form.querySelector('input[name="form_id"]');
            var formIdValue = formIdInput ? (formIdInput.value || '') : '';
            if (!formIdValue) {
                return;
            }
            if (['apbdes', 'berita', 'fasilitas', 'potensi-media'].indexOf(formIdValue) === -1) {
                return;
            }
            form.addEventListener('submit', function () {
                var selector = 'input[type="file"]';
                if (formIdValue === 'apbdes') {
                    selector = 'input[type="file"][name="apbdes_file"]';
                } else if (formIdValue === 'berita') {
                    selector = 'input[type="file"][name="berita_gambar"]';
                } else if (formIdValue === 'fasilitas') {
                    selector = 'input[type="file"][name="fasilitas_gambar"]';
                } else if (formIdValue === 'potensi-media') {
                    selector = 'input[type="file"][name="gambar_namafile"]';
                }
                var fileInput = form.querySelector(selector);
                if (fileInput && fileInput.files && fileInput.files.length > 0) {
                    showUploadOverlay();
                }
            });
        });
        if (beritaEditForm) {
            beritaEditForm.addEventListener('submit', function () {
                if (beritaEditFileInput && beritaEditFileInput.files && beritaEditFileInput.files.length > 0) {
                    showUploadOverlay();
                }
            });
        }
        var fasilitasEditForm = document.getElementById('fasilitas-edit-form');
        var fasilitasEditIdInput = document.getElementById('fasilitas_edit_id');
        var fasilitasEditNameInput = document.getElementById('fasilitas_edit_nama');
        var fasilitasEditMapsInput = document.getElementById('fasilitas_edit_gmaps');
        var fasilitasEditFileInput = document.getElementById('fasilitas_edit_gambar');
        if (fasilitasEditForm) {
            fasilitasEditForm.addEventListener('submit', function () {
                if (fasilitasEditFileInput && fasilitasEditFileInput.files && fasilitasEditFileInput.files.length > 0) {
                    showUploadOverlay();
                }
            });
        }
        var potensiMediaPotensiField = null;
        var potensiGalleryTitle;
        var potensiGallerySubtitle;
        var potensiGalleryTable;
        var potensiGalleryBody;
        var potensiGalleryEmpty;
        var potensiGalleryAddButton;
        var navLinks = Array.from(document.querySelectorAll('.sidebar-link[data-section]'));
        var sectionMap = {};
        Array.from(document.querySelectorAll('.section-card[data-section]')).forEach(function (section) {
            var id = section.getAttribute('data-section');
            if (id) {
                sectionMap[id] = section;
            }
        });

        var activateSection = function (id) {
            if (!sectionMap[id]) {
                return;
            }

            Object.keys(sectionMap).forEach(function (key) {
                sectionMap[key].classList.toggle('is-active', key === id);
            });

            navLinks.forEach(function (link) {
                var match = link.getAttribute('data-section') === id;
                link.classList.toggle('is-active', match);
            });
        };

        navLinks.forEach(function (link) {
            link.addEventListener('click', function (event) {
                event.preventDefault();
                var targetId = link.getAttribute('data-section');
                activateSection(targetId);
                if (history.replaceState) {
                    history.replaceState(null, '', '#' + targetId);
                } else {
                    window.location.hash = targetId;
                }
            });
        });

        var initial = window.location.hash ? window.location.hash.slice(1) : null;
        if (!initial || !sectionMap[initial]) {
            initial = navLinks.length ? navLinks[0].getAttribute('data-section') : null;
        }

        if (initial) {
            activateSection(initial);
        }

        window.addEventListener('hashchange', function () {
            var target = window.location.hash ? window.location.hash.slice(1) : null;
            if (target && sectionMap[target]) {
                activateSection(target);
            }
        });

        var modalBackdrops = Array.from(document.querySelectorAll('.modal-backdrop'));
        var openButtons = Array.from(document.querySelectorAll('[data-open-modal]'));
        var activeModal = null;

        var findBackdrop = function (id) {
            return modalBackdrops.find(function (backdrop) {
                return backdrop.getAttribute('data-modal') === id;
            });
        };

        var potensiGalleryBackdrop = findBackdrop('potensi-gallery');
        if (potensiGalleryBackdrop) {
            potensiGalleryTitle = potensiGalleryBackdrop.querySelector('[data-potensi-gallery-title]');
            potensiGallerySubtitle = potensiGalleryBackdrop.querySelector('[data-potensi-gallery-subtitle]');
            potensiGalleryTable = potensiGalleryBackdrop.querySelector('[data-potensi-gallery-table]');
            potensiGalleryBody = potensiGalleryBackdrop.querySelector('[data-potensi-gallery-tbody]');
            potensiGalleryEmpty = potensiGalleryBackdrop.querySelector('[data-potensi-gallery-empty]');
            potensiGalleryAddButton = potensiGalleryBackdrop.querySelector('[data-open-modal="potensi-media"]');
        }

        var potensiMediaBackdrop = findBackdrop('potensi-media');
        if (potensiMediaBackdrop) {
            var potensiMediaForm = potensiMediaBackdrop.querySelector('form');
            if (potensiMediaForm) {
                potensiMediaPotensiField = potensiMediaForm.querySelector('[name="potensi_id"]');
            }
        }

        var openModal = function (id) {
            var backdrop = findBackdrop(id);
            if (!backdrop) {
                return;
            }
            modalBackdrops.forEach(function (item) {
                item.classList.remove('is-open');
            });
            backdrop.classList.add('is-open');
            bodyEl.classList.add('modal-open');
            activeModal = backdrop;
            var firstInput = backdrop.querySelector('input, textarea, select');
            if (firstInput) {
                setTimeout(function () {
                    firstInput.focus({ preventScroll: true });
                }, 80);
            }
        };

        var closeModal = function () {
            if (!activeModal) {
                return;
            }
            activeModal.classList.remove('is-open');
            bodyEl.classList.remove('modal-open');
            activeModal = null;
        };

        var populatePotensiGallery = function (payload) {
            if (!potensiGalleryBody || !potensiGalleryTable || !potensiGalleryEmpty) {
                return;
            }
            var safePayload = (payload && typeof payload === 'object') ? payload : {};
            var potensiTitle = safePayload.judul ? String(safePayload.judul) : 'Potensi Desa';
            if (potensiGalleryTitle) {
                potensiGalleryTitle.textContent = 'Foto Potensi — ' + potensiTitle;
            }
            if (potensiGallerySubtitle) {
                var count = Array.isArray(safePayload.images) ? safePayload.images.length : 0;
                potensiGallerySubtitle.textContent = potensiTitle + ' · ' + (count > 0 ? count + ' foto' : 'belum ada foto');
            }
            var images = Array.isArray(safePayload.images) ? safePayload.images : [];
            potensiGalleryBody.innerHTML = '';
            images.forEach(function (image) {
                var tr = document.createElement('tr');
                var titleTd = document.createElement('td');
                titleTd.textContent = image && image.judul ? String(image.judul) : potensiTitle;
                var fileTd = document.createElement('td');
                var fileUrl = image && image.file ? String(image.file) : '';
                var fileLabel = image && image.raw ? String(image.raw) : '';
                if (fileUrl !== '') {
                    var link = document.createElement('a');
                    link.href = fileUrl;
                    link.target = '_blank';
                    link.rel = 'noopener';
                    link.textContent = fileLabel !== '' ? fileLabel : fileUrl;
                    fileTd.appendChild(link);
                } else {
                    fileTd.textContent = fileLabel !== '' ? fileLabel : '-';
                }
                var createdTd = document.createElement('td');
                var createdLabel = image && image.created_label ? String(image.created_label) : '';
                if (createdLabel === '' && image && image.created_at) {
                    createdLabel = String(image.created_at);
                }
                createdTd.textContent = createdLabel !== '' ? createdLabel : '-';
                tr.appendChild(titleTd);
                tr.appendChild(fileTd);
                tr.appendChild(createdTd);
                    // Tambahkan tombol hapus
                var actionsTd = document.createElement('td');
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'admin_management.php#potensi';
                form.className = 'table-actions__form'; 
                form.onsubmit = function() {
                    return confirm('Hapus foto ini?');
                };

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete_gambar_potensi';
                form.appendChild(actionInput);

                var idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'gambar_id';
                idInput.value = image && image.id ? String(image.id) : '';
                form.appendChild(idInput);

                var button = document.createElement('button');
                button.type = 'submit';
                button.className = 'btn-danger';
                button.textContent = 'Hapus';
                form.appendChild(button);

                actionsTd.appendChild(form);
                tr.appendChild(actionsTd);

                potensiGalleryBody.appendChild(tr);
            });
            if (potensiGalleryTable) {
                potensiGalleryTable.classList.toggle('is-hidden', images.length === 0);
            }
            if (potensiGalleryEmpty) {
                potensiGalleryEmpty.classList.toggle('is-hidden', images.length > 0);
            }
            if (potensiGalleryAddButton) {
                if (safePayload.id) {
                    potensiGalleryAddButton.removeAttribute('disabled');
                    potensiGalleryAddButton.setAttribute('data-potensi-media-id', String(safePayload.id));
                } else {
                    potensiGalleryAddButton.setAttribute('disabled', 'disabled');
                    potensiGalleryAddButton.removeAttribute('data-potensi-media-id');
                }
            }
        };

        openButtons.forEach(function (btn) {
            btn.addEventListener('click', function () {
                var targetId = btn.getAttribute('data-open-modal');
                if (targetId === 'apbdes-edit') {
                    if (apbdesEditIdInput) {
                        apbdesEditIdInput.value = btn.getAttribute('data-apbdes-id') || '';
                    }
                    if (apbdesEditTitleInput) {
                        apbdesEditTitleInput.value = btn.getAttribute('data-apbdes-judul') || '';
                    }
                }
                if (targetId === 'berita-edit') {
                    if (beritaEditFileInput) {
                        beritaEditFileInput.value = '';
                    }
                    var payloadRaw = btn.getAttribute('data-berita') || '';
                    var payload = {};
                    if (payloadRaw !== '') {
                        try {
                            payload = JSON.parse(payloadRaw);
                        } catch (error) {
                            payload = {};
                        }
                    }
                    if (beritaEditIdInput) {
                        beritaEditIdInput.value = payload.id ? String(payload.id) : '';
                    }
                    if (beritaEditTitleInput) {
                        beritaEditTitleInput.value = payload.judul ? String(payload.judul) : '';
                    }
                    if (beritaEditBodyInput) {
                        beritaEditBodyInput.value = payload.isi ? String(payload.isi) : '';
                    }
                }
                if (targetId === 'fasilitas-edit') {
                    if (fasilitasEditFileInput) {
                        fasilitasEditFileInput.value = '';
                    }
                    var fasilitasPayloadRaw = btn.getAttribute('data-fasilitas') || '';
                    var fasilitasPayload = {};
                    if (fasilitasPayloadRaw !== '') {
                        try {
                            fasilitasPayload = JSON.parse(fasilitasPayloadRaw);
                        } catch (error) {
                            fasilitasPayload = {};
                        }
                    }
                    if (fasilitasEditIdInput) {
                        fasilitasEditIdInput.value = fasilitasPayload.id ? String(fasilitasPayload.id) : '';
                    }
                    if (fasilitasEditNameInput) {
                        fasilitasEditNameInput.value = fasilitasPayload.nama ? String(fasilitasPayload.nama) : '';
                    }
                    if (fasilitasEditMapsInput) {
                        fasilitasEditMapsInput.value = fasilitasPayload.gmaps ? String(fasilitasPayload.gmaps) : '';
                    }
                }
                if (targetId === 'potensi-gallery') {
                    var galleryPayloadRaw = btn.getAttribute('data-potensi-gallery') || '';
                    var galleryPayload = {};
                    if (galleryPayloadRaw !== '') {
                        try {
                            galleryPayload = JSON.parse(galleryPayloadRaw);
                        } catch (error) {
                            galleryPayload = {};
                        }
                    }
                    populatePotensiGallery(galleryPayload);
                }
                if (targetId === 'potensi-edit') {
                    var potensiPayloadRaw = btn.getAttribute('data-potensi') || '';
                    var potensiPayload = {};
                    if (potensiPayloadRaw !== '') {
                        try {
                            potensiPayload = JSON.parse(potensiPayloadRaw);
                        } catch (error) {
                            potensiPayload = {};
                        }
                    }
                    // Isi value awal form edit potensi
                    document.getElementById('potensi_edit_id').value = potensiPayload.id || '';
                    document.getElementById('potensi_edit_judul').value = potensiPayload.judul || '';
                    document.getElementById('potensi_edit_kategori').value = potensiPayload.kategori || 'Wisata';
                    document.getElementById('potensi_edit_isi').value = potensiPayload.isi || '';
                    document.getElementById('potensi_edit_gmaps').value = potensiPayload.gmaps || '';
                }
                if (targetId === 'pengumuman-view') {
                    var pengumumanRaw = btn.getAttribute('data-pengumuman') || '';
                    var pengumuman = {};
                    if (pengumumanRaw !== '') {
                        try {
                            pengumuman = JSON.parse(pengumumanRaw);
                        } catch (error) {
                            pengumuman = {};
                        }
                    }
                    var textArea = document.getElementById('pengumuman_view_isi');
                    if (textArea) {
                        textArea.value = pengumuman.isi || '(Belum ada isi pengumuman)';
                    }
                }
                if (targetId === 'pengumuman-edit') {
                    var pengumumanRaw = btn.getAttribute('data-pengumuman') || '';
                    var pengumuman = {};
                    if (pengumumanRaw !== '') {
                        try {
                            pengumuman = JSON.parse(pengumumanRaw);
                        } catch (error) {
                            pengumuman = {};
                        }
                    }
                    document.getElementById('pengumuman_edit_id').value = pengumuman.id || '';
                    document.getElementById('pengumuman_edit_isi').value = pengumuman.isi || '';
                    if (pengumuman.valid_hingga) {
                        var date = new Date(pengumuman.valid_hingga);
                        if (!isNaN(date)) {
                            document.getElementById('pengumuman_edit_valid').value = date.toISOString().slice(0, 16);
                        }
                    }
                }
                if (targetId === 'potensi-media') {
                    var potensiTargetId = btn.getAttribute('data-potensi-media-id') || '';
                    // tambahkan hidden input potensi_id agar ikut terkirim saat submit
                    var potensiMediaForm = potensiMediaBackdrop.querySelector('form');
                    if (potensiMediaForm) {
                        var hidden = potensiMediaForm.querySelector('input[name="potensi_id"]');
                        if (!hidden) {
                            hidden = document.createElement('input');
                            hidden.type = 'hidden';
                            hidden.name = 'potensi_id';
                            potensiMediaForm.appendChild(hidden);
                        }
                        hidden.value = potensiTargetId;
                    }
                }
                if (targetId === 'program-edit') {
                    const raw = btn.getAttribute('data-program') || '';
                    let data = {};
                    try { data = JSON.parse(raw); } catch {}
                    document.getElementById('program_edit_id').value = data.id || '';
                    document.getElementById('program_edit_nama').value = data.nama || '';
                    document.getElementById('program_edit_deskripsi').value = data.deskripsi || '';
                    const inputFile = document.getElementById('program_edit_gambar');
                    if (inputFile) inputFile.value = '';
                }
                if (targetId) {
                    openModal(targetId);
                }
            });
        });

        modalBackdrops.forEach(function (backdrop) {
            backdrop.addEventListener('click', function (event) {
                if (event.target === backdrop) {
                    closeModal();
                }
            });
            Array.from(backdrop.querySelectorAll('[data-close-modal]')).forEach(function (btn) {
                btn.addEventListener('click', function () {
                    closeModal();
                });
            });
        });

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });

        var initialModal = modalBackdrops.find(function (backdrop) {
            return backdrop.getAttribute('data-open-on-load') === '1';
        });
        if (initialModal) {
            openModal(initialModal.getAttribute('data-modal'));
            initialModal.removeAttribute('data-open-on-load');
        }
    });
</script>
</body>
</html>
