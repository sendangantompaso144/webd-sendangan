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
            'berita_gambar' => ['label' => 'URL Gambar', 'type' => 'text', 'required' => false],
            'berita_dilihat' => ['label' => 'Jumlah Dilihat', 'type' => 'number', 'required' => false, 'default' => 0],
        ],
    ],
    'fasilitas' => [
        'table' => 'fasilitas',
        'title' => 'Fasilitas Desa',
        'fields' => [
            'fasilitas_nama' => ['label' => 'Nama Fasilitas', 'type' => 'text', 'required' => true],
            'fasilitas_gambar' => ['label' => 'URL Gambar', 'type' => 'text', 'required' => false],
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
        'title' => 'Media Potensi Desa',
        'fields' => [
            'potensi_id' => ['label' => 'ID Potensi', 'type' => 'number', 'required' => false],
            'gambar_namafile' => ['label' => 'Nama File', 'type' => 'text', 'required' => true],
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
            'program_gambar' => ['label' => 'URL Gambar', 'type' => 'text', 'required' => false],
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

    $formId = (string) ($_POST['form_id'] ?? '');
    if (isset($tableForms[$formId])) {
        $definition = $tableForms[$formId];
        $fieldsDefinition = $definition['fields'];
        $inputData = [];
        $errors = [];

        foreach ($fieldsDefinition as $fieldName => $fieldMeta) {
            if (($fieldMeta['type'] ?? '') === 'file_pdf') {
                $required = !empty($fieldMeta['required']);
                $fileInfo = $_FILES[$fieldName] ?? null;
                if (!is_array($fileInfo) || ($fileInfo['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
                    if ($required) {
                        $errors[$fieldName] = 'Silakan unggah file PDF.';
                    }
                } else {
                    if (($fileInfo['error'] ?? UPLOAD_ERR_OK) !== UPLOAD_ERR_OK) {
                        $errors[$fieldName] = 'Gagal mengunggah file.';
                    } else {
                        $finfo = finfo_open(FILEINFO_MIME_TYPE);
                        $mime = $finfo ? finfo_file($finfo, $fileInfo['tmp_name']) : '';
                        if ($finfo) {
                            finfo_close($finfo);
                        }
                        $ext = strtolower(pathinfo($fileInfo['name'], PATHINFO_EXTENSION));
                        if ($mime !== 'application/pdf' || $ext !== 'pdf') {
                            $errors[$fieldName] = 'File harus berupa PDF.';
                        } else {
                            $inputData[$fieldName] = $fileInfo;
                        }
                    }
                }
                continue;
            }

            $type = $fieldMeta['type'] ?? 'text';
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
                    } elseif (!in_array($raw, $options, true)) {
                        $errors[$fieldName] = 'Opsi tidak valid.';
                    } else {
                        $inputData[$fieldName] = $raw;
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
                    $targetDir = base_path('uploads/' . $formId);
                    if (!is_dir($targetDir) && !mkdir($targetDir, 0755, true) && !is_dir($targetDir)) {
                        $errors['_general'] = 'Folder unggahan tidak dapat dibuat.';
                        break;
                    }

                    $uniqueName = uniqid($formId . '_', true) . '.pdf';
                    $targetPath = $targetDir . DIRECTORY_SEPARATOR . $uniqueName;
                    if (!move_uploaded_file($fileInfo['tmp_name'], $targetPath)) {
                        $errors['_general'] = 'Gagal memindahkan file unggahan.';
                        break;
                    }

                    $fileInfo['_stored'] = $uniqueName;
                    $fileUploads[$column] = $fileInfo;
                }

                if (($errors['_general'] ?? '') === '') {
                    if ($formId === 'apbdes' && isset($adminSession['name'])) {
                        $inputData['apbdes_edited_by'] = (string) $adminSession['name'];
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
                    header('Location: admin_management.php#' . rawurlencode($formId));
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
            case 'textarea':
                $inputHtml = '<textarea name="' . e($name) . '" rows="4"' . $requiredAttr . '>' . e((string) $value) . '</textarea>';
                break;
            case 'select':
                $optionsHtml = '';
                $options = $meta['options'] ?? [];
                foreach ($options as $option) {
                    $optionsHtml .= '<option value="' . e($option) . '"' . ((string) $value === (string) $option ? ' selected' : '') . '>' . e($option) . '</option>';
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
                <h3 class="modal__title">Tambah ' . e($definition['title'] ?? 'Data') . '</h3>
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

        .modal__header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
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

        .modal__field input:focus,
        .modal__field select:focus,
        .modal__field textarea:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
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
            <a class="sidebar-link" href="#potensi-media" data-section="potensi-media">Media Potensi</a>
            <a class="sidebar-link" href="#pengumuman" data-section="pengumuman">Pengumuman</a>
            <a class="sidebar-link" href="#permohonan" data-section="permohonan">Permohonan Informasi</a>
            <a class="sidebar-link" href="#ppid" data-section="ppid">PPID Dokumen</a>
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
                    $actionsHtml = $rowId > 0
                        ? '<form method="post" action="admin_management.php#apbdes" class="table-actions__form" onsubmit="return confirm(\'Hapus dokumen ini?\');">'
                            . '<input type="hidden" name="action" value="delete_apbdes">'
                            . '<input type="hidden" name="apbdes_id" value="' . e((string) $rowId) . '">'
                            . '<button type="submit" class="btn-danger">Hapus</button>'
                        . '</form>'
                        : '-';
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

            <?= section_card(
                'fasilitas',
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

            <?= section_card(
                'potensi',
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
                'potensi-media',
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

            <?= section_card(
                'pengumuman',
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

            <?= section_card(
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
            ) ?>

            <?= section_card(
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
            ) ?>

            <?= section_card(
                'program',
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
        var showUploadOverlay = function () {
            if (!uploadOverlay) {
                return;
            }
            uploadOverlay.classList.add('is-visible');
            uploadOverlay.setAttribute('aria-hidden', 'false');
        };
        Array.from(document.querySelectorAll('form')).forEach(function (form) {
            var formIdInput = form.querySelector('input[name="form_id"]');
            if (!formIdInput || formIdInput.value !== 'apbdes') {
                return;
            }
            form.addEventListener('submit', function () {
                var fileInput = form.querySelector('input[type="file"][name="apbdes_file"]');
                if (fileInput && fileInput.files && fileInput.files.length > 0) {
                    showUploadOverlay();
                }
            });
        });
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

        openButtons.forEach(function (btn) {
            btn.addEventListener('click', function () {
                var targetId = btn.getAttribute('data-open-modal');
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
