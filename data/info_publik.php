<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';

try {
    $pdo = db();
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
} catch (Throwable $e) {
    $rows = [];
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

return [
    'pengumuman' => $pengumuman,
];
