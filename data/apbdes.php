<?php

declare(strict_types=1);

/**
 * Sumber data APBDes untuk data_source('apbdes')
 * Mengambil data dari tabel `apbdes`
 */

$hasil = [];

// Jika helper db() belum tersedia (tergantung cara include), coba muat bootstrap.
if (!function_exists('db')) {
    $bootstrap = __DIR__ . '/../app/bootstrap.php';
    if (is_file($bootstrap)) {
        require $bootstrap;
    }
}

try {
    if (function_exists('db')) {
        $pdo = db();

        // Ambil kolom yang dipakai di view
        $sql = "
            SELECT apbdes_judul, apbdes_file, apbdes_edited_by
            FROM apbdes
            ORDER BY apbdes_updated_at DESC, apbdes_created_at DESC
        ";
        $stmt = $pdo->query($sql);

        if ($stmt !== false) {
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if (is_array($rows)) {
                foreach ($rows as $r) {
                    $hasil[] = [
                        'apbdes_judul'     => isset($r['apbdes_judul']) ? (string)$r['apbdes_judul'] : 'Dokumen APBDes',
                        'apbdes_file'      => isset($r['apbdes_file']) ? (string)$r['apbdes_file'] : '#',
                        'apbdes_edited_by' => $r['apbdes_edited_by'] !== null ? (string)$r['apbdes_edited_by'] : null,
                    ];
                }
            }
        }
    }
} catch (Throwable $e) {
    // Biarkan kosong supaya di halaman muncul "Belum ada dokumen..."
    // atau Anda bisa log error jika perlu.
}

// Kembalikan array (bisa kosong -> akan muncul empty state di view)
return $hasil;
