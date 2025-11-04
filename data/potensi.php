<?php
declare(strict_types=1);

// Pastikan fungsi db() tersedia
if (!function_exists('db')) {
    // 1) Coba require koneksi langsung di root: /database.php
    $dbPath = __DIR__ . '/../database.php';
    if (is_file($dbPath)) {
        require_once $dbPath;
    } else {
        // 2) Fallback ke bootstrap (seperti di admin_manager.php)
        $bootstrapPath = __DIR__ . '/../app/bootstrap.php';
        if (is_file($bootstrapPath)) {
            require_once $bootstrapPath;
        }
    }
}

try {
    $pdo = db();
} catch (Throwable $e) {
    // Jika gagal koneksi, kembalikan array kosong agar halaman tetap jalan
    return [];
}

// Ambil potensi
$stmtPotensi = $pdo->query('
    SELECT potensi_id, potensi_judul, potensi_isi, potensi_kategori, potensi_gmaps_link,
           potensi_created_at, potensi_updated_at
    FROM potensi_desa
    ORDER BY potensi_kategori ASC, potensi_judul ASC
');
$potensiList = $stmtPotensi->fetchAll(PDO::FETCH_ASSOC) ?: [];

// Ambil gambar potensi
$stmtGambar = $pdo->query('
    SELECT gambar_id, potensi_id, gambar_namafile, gambar_created_at
    FROM gambar_potensi_desa
    ORDER BY gambar_created_at ASC
');
$gambarList = $stmtGambar->fetchAll(PDO::FETCH_ASSOC) ?: [];

// Kelompokkan gambar per potensi
$gambarByPotensi = [];
foreach ($gambarList as $row) {
    $pid = (int)($row['potensi_id'] ?? 0);
    if ($pid <= 0) continue;

    $file = trim((string)($row['gambar_namafile'] ?? ''));
    if ($file === '') continue;

    // Simpan url relatif ke folder uploads/potensi/
    $gambarByPotensi[$pid][] = [
        'gambar_id' => (int)$row['gambar_id'],
        'potensi_id' => $pid,
        'gambar_namafile' => 'uploads/potensi/' . ltrim($file, '/'),
        'gambar_created_at' => $row['gambar_created_at'] ?? null,
    ];
}

// Satukan
$potensiData = [];
foreach ($potensiList as $row) {
    $pid = (int)$row['potensi_id'];
    $row['gambar'] = $gambarByPotensi[$pid] ?? [];
    $potensiData[] = $row;
}

return $potensiData;
