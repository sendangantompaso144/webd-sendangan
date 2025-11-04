<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php'; // sesuaikan path config database

try {
    $pdo = db();
    $stmt = $pdo->query('SELECT pengumuman_id, pengumuman_isi, pengumuman_valid_hingga, pengumuman_created_at FROM pengumuman ORDER BY pengumuman_created_at DESC');
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (Throwable $e) {
    $rows = [];
}

// Ubah hasilnya agar cocok dengan format sebelumnya
$pengumuman = [];
foreach ($rows as $row) {
    $pengumuman[] = [
        'judul' => mb_strimwidth(strip_tags((string)($row['pengumuman_isi'] ?? '')), 0, 60, '...'),
        'tanggal' => date('d F Y', strtotime((string)($row['pengumuman_valid_hingga'] ?? $row['pengumuman_created_at'] ?? 'now'))),
        'tautan' => '#', // nanti bisa diganti kalau ada halaman detail
        'isi' => (string)($row['pengumuman_isi'] ?? ''),
    ];
}

return [
    'pengumuman' => $pengumuman
];
