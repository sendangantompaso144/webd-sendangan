<?php

declare(strict_types=1);

$pdo = null;
try {
    $pdo = db();
} catch (Throwable) {
    $pdo = null;
}

$sejarah = [];

if ($pdo !== null) {
    try {
        $stmt = $pdo->query("SELECT data_key, data_value FROM data WHERE data_key LIKE 'profil.sejarah_%' ORDER BY data_key ASC");
        if ($stmt !== false) {
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $paragraph = trim((string) ($row['data_value'] ?? ''));
                if ($paragraph !== '') {
                    $sejarah[] = $paragraph;
                }
            }
        }
    } catch (Throwable) {
        $sejarah = [];
    }
}

$demografiDasar = (static function (): array {
    $baseDefaults = [
        'demografi.luas_wilayah_ha' => 0,
        'demografi.jumlah_jaga' => 0,
        'demografi.kepala_keluarga' => 0,
    ];

    $demografi = data_values($baseDefaults) + $baseDefaults;

    $jumlahJaga = max(0, (int) ($demografi['demografi.jumlah_jaga'] ?? 0));
    $pendudukDefaults = [];

    if ($jumlahJaga > 0) {
        for ($index = 1; $index <= $jumlahJaga; $index++) {
            $pendudukDefaults[sprintf('demografi.jaga_%d_laki', $index)] = 0;
            $pendudukDefaults[sprintf('demografi.jaga_%d_perempuan', $index)] = 0;
        }
    }

    $pendudukValues = $pendudukDefaults === []
        ? []
        : data_values($pendudukDefaults) + $pendudukDefaults;

    $pendudukJaga = [];
    if ($jumlahJaga > 0) {
        for ($index = 1; $index <= $jumlahJaga; $index++) {
            $laki = (int) ($pendudukValues[sprintf('demografi.jaga_%d_laki', $index)] ?? 0);
            $perempuan = (int) ($pendudukValues[sprintf('demografi.jaga_%d_perempuan', $index)] ?? 0);

            $pendudukJaga[] = [
                'nama' => 'Jaga ' . $index,
                'laki_laki' => $laki,
                'perempuan' => $perempuan,
            ];
        }
    }

    return [
        'luas_wilayah_ha' => (float) ($demografi['demografi.luas_wilayah_ha'] ?? 0),
        'jumlah_jaga' => $jumlahJaga,
        'penduduk_jaga' => $pendudukJaga,
        'kepala_keluarga' => (int) ($demografi['demografi.kepala_keluarga'] ?? 0),
    ];
})();

$fasilitas = [];
$program = [];
$sotkImage = '';

if ($pdo !== null) {
    try {
        $stmt = $pdo->query('SELECT fasilitas_id, fasilitas_nama, fasilitas_gambar, fasilitas_gmaps_link FROM fasilitas ORDER BY fasilitas_updated_at DESC');
        if ($stmt !== false) {
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (is_array($rows)) {
                $fasilitas = $rows;
            }
        }
    } catch (Throwable) {
        $fasilitas = [];
    }

    try {
        $stmt = $pdo->query('SELECT program_id, program_nama, program_deskripsi, program_gambar FROM program_desa ORDER BY program_updated_at DESC');
        if ($stmt !== false) {
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (is_array($rows)) {
                $program = $rows;
            }
        }
    } catch (Throwable) {
        $program = [];
    }
}

$sotkValues = data_values([
    'profile.sotk' => 'sotk-image.webp',
]);
$sotkFilename = trim((string) ($sotkValues['profile.sotk'] ?? ''));

if ($sotkFilename !== '') {
    $sotkImage = base_uri('uploads/struktur/' . ltrim($sotkFilename, '/'));
}

return [
    'sejarah' => $sejarah,
    'demografi_dasar' => $demografiDasar,
    'fasilitas' => $fasilitas,
    'program' => $program,
    'sotk_image' => $sotkImage,
];
