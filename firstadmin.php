<?php

declare(strict_types=1);

require __DIR__ . '/app/bootstrap.php';

$errors = [];
$success = '';
$hasSuperadmin = false;

try {
    $pdo = db();

    $checkStmt = $pdo->query('SELECT admin_id, admin_nama FROM admin WHERE admin_is_superadmin = 1 AND admin_is_deleted = 0 LIMIT 1');
    $existingSuperadmin = $checkStmt !== false ? $checkStmt->fetch() : false;
    if ($existingSuperadmin) {
        $hasSuperadmin = true;
        $success = sprintf(
            'Sudah ada superadmin terdaftar%s.',
            isset($existingSuperadmin['admin_nama']) && $existingSuperadmin['admin_nama'] !== ''
                ? ' dengan nama ' . $existingSuperadmin['admin_nama']
                : ''
        );
    }
} catch (Throwable $exception) {
    $errors[] = 'Tidak dapat terhubung ke database: ' . $exception->getMessage();
    $pdo = null;
}

if (!$hasSuperadmin && $_SERVER['REQUEST_METHOD'] === 'POST' && $pdo instanceof PDO) {
    $name = trim((string) ($_POST['admin_nama'] ?? ''));
    $email = trim((string) ($_POST['admin_email'] ?? ''));
    $phone = trim((string) ($_POST['admin_no_hp'] ?? ''));
    $password = (string) ($_POST['admin_password'] ?? '');

    if ($name === '') {
        $errors[] = 'Nama admin wajib diisi.';
    }

    if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Email tidak valid.';
    }

    if ($password === '' || strlen($password) < 8) {
        $errors[] = 'Password harus minimal 8 karakter.';
    }

    if ($errors === []) {
        try {
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            if ($hashedPassword === false) {
                throw new RuntimeException('Gagal membuat hash password.');
            }

            $insertStmt = $pdo->prepare(
                'INSERT INTO admin (admin_nama, admin_password, admin_no_hp, admin_email, admin_is_superadmin) 
                 VALUES (:name, :password, :phone, :email, 1)'
            );

            $insertStmt->bindValue(':name', $name);
            $insertStmt->bindValue(':password', $hashedPassword);
            $insertStmt->bindValue(':phone', $phone !== '' ? $phone : null);
            $insertStmt->bindValue(':email', $email);

            $insertStmt->execute();

            $success = 'Superadmin pertama berhasil dibuat. Demi keamanan, hapus atau nonaktifkan file ini setelah digunakan.';
            $hasSuperadmin = true;
        } catch (Throwable $exception) {
            if ((int) ($exception->errorInfo[1] ?? 0) === 1062) {
                // Duplicate entry for unique key (email or phone).
                $errors[] = 'Email atau nomor HP sudah digunakan. Gunakan data lain.';
            } else {
                $errors[] = 'Terjadi kesalahan saat menyimpan data: ' . $exception->getMessage();
            }
        }
    }
}

?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <title>Inisialisasi Superadmin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            color-scheme: light dark;
            font-family: "Inter", system-ui, -apple-system, "Segoe UI", sans-serif;
            line-height: 1.6;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1f5f9;
        }

        .wrapper {
            width: min(480px, 92vw);
            background: #ffffff;
            padding: 32px;
            border-radius: 18px;
            box-shadow: 0 22px 70px rgba(15, 23, 42, 0.15);
        }

        h1 {
            margin-top: 0;
            font-size: 24px;
            color: #0f172a;
        }

        p.note {
            font-size: 14px;
            color: #475569;
        }

        .alert {
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 18px;
            font-size: 14px;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.12);
            color: #b91c1c;
        }

        .alert-success {
            background: rgba(34, 197, 94, 0.14);
            color: #166534;
        }

        form {
            display: grid;
            gap: 16px;
            margin-top: 20px;
        }

        label {
            font-weight: 600;
            color: #1e293b;
            font-size: 14px;
            display: block;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"] {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #cbd5f5;
            font-size: 15px;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="tel"]:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
        }

        button {
            border: none;
            border-radius: 12px;
            padding: 12px 18px;
            background: #2563eb;
            color: #ffffff;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        button:hover {
            transform: translateY(-1px);
            box-shadow: 0 16px 30px rgba(37, 99, 235, 0.22);
        }

        button:disabled {
            background: #94a3b8;
            cursor: not-allowed;
            box-shadow: none;
        }

        footer {
            margin-top: 26px;
            font-size: 12px;
            color: #94a3b8;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <h1>Inisialisasi Superadmin</h1>
    <p class="note">
        Gunakan formulir ini sekali saja untuk membuat akun superadmin pertama. Setelah berhasil, hapus file <code>firstadmin.php</code> dari server Anda.
    </p>

    <?php foreach ($errors as $error): ?>
        <div class="alert alert-error"><?= e($error) ?></div>
    <?php endforeach; ?>

    <?php if ($success !== ''): ?>
        <div class="alert alert-success"><?= e($success) ?></div>
    <?php endif; ?>

    <?php if (!$hasSuperadmin && $pdo instanceof PDO): ?>
        <form method="post" autocomplete="off">
            <div>
                <label for="admin_nama">Nama Lengkap</label>
                <input type="text" id="admin_nama" name="admin_nama" required value="<?= e($_POST['admin_nama'] ?? '') ?>">
            </div>
            <div>
                <label for="admin_email">Email</label>
                <input type="email" id="admin_email" name="admin_email" required value="<?= e($_POST['admin_email'] ?? '') ?>">
            </div>
            <div>
                <label for="admin_no_hp">Nomor HP (opsional)</label>
                <input type="tel" id="admin_no_hp" name="admin_no_hp" value="<?= e($_POST['admin_no_hp'] ?? '') ?>">
            </div>
            <div>
                <label for="admin_password">Password</label>
                <input type="password" id="admin_password" name="admin_password" minlength="8" required>
            </div>
            <button type="submit">Buat Superadmin</button>
        </form>
    <?php else: ?>
        <p class="note">Formulir dinonaktifkan karena superadmin pertama sudah ada atau terjadi kesalahan koneksi.</p>
    <?php endif; ?>

    <footer>
        &copy; <?= date('Y') ?> Desa Sendangan
    </footer>
</div>
</body>
</html>
