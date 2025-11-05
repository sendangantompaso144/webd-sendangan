<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';

try {
    $pdo = db();

    // 🔹 Ambil pengumuman
    $stmt = $pdo->query('
        SELECT 
            pengumuman_id, 
            pengumuman_isi, 
            pengumuman_valid_hingga, 
            pengumuman_created_at, 
            pengumuman_updated_at
        FROM pengumuman
        ORDER BY pengumuman_created_at DESC
    ');
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 🔹 Ambil galeri
    $stmtGaleri = $pdo->query('
        SELECT 
            galeri_id, 
            galeri_keterangan, 
            galeri_gambar, 
            galeri_created_at
        FROM galeri
        ORDER BY galeri_created_at DESC
    ');
    $rowsGaleri = $stmtGaleri->fetchAll(PDO::FETCH_ASSOC);
} catch (Throwable $e) {
    $rows = [];
    $rowsGaleri = [];
}

$pengumuman = [];
foreach ($rows as $row) {
    $pengumuman[] = [
        'id' => (int)($row['pengumuman_id'] ?? 0),
        'isi' => (string)($row['pengumuman_isi'] ?? ''),
        'valid_hingga' => date('d F Y H:i', strtotime((string)($row['pengumuman_valid_hingga'] ?? ''))),
        'updated_at' => date('d F Y H:i', strtotime((string)($row['pengumuman_updated_at'] ?? $row['pengumuman_created_at'] ?? ''))),
    ];
}

$galeri = [];
foreach ($rowsGaleri as $row) {
    $fileName = trim((string)($row['galeri_gambar'] ?? ''));
    $galeri[] = [
        'galeri_id' => (int)($row['galeri_id'] ?? 0),
        'galeri_keterangan' => (string)($row['galeri_keterangan'] ?? ''),
        'gambar' => $fileName !== '' 
            ? base_uri('uploads/galeri/' . ltrim($fileName, '/')) 
            : asset('images/placeholder-gallery.jpg'),
        'created_at' => date('d F Y H:i', strtotime((string)($row['galeri_created_at'] ?? ''))),
    ];
}

return [
    'pengumuman' => $pengumuman,
    'galeri' => $galeri,
];
