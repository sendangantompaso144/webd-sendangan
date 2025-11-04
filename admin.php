<?php

declare(strict_types=1);

require __DIR__ . '/app/bootstrap.php';

if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start([
        'cookie_httponly' => true,
        'use_strict_mode' => true,
    ]);
}

$errors = [];
$statusMessage = '';

$isLoggedIn = isset($_SESSION['admin']) && is_array($_SESSION['admin']);
$currentAdmin = $isLoggedIn ? $_SESSION['admin'] : null;

if (isset($_GET['action']) && $_GET['action'] === 'logout' && $isLoggedIn) {
    unset($_SESSION['admin']);
    $isLoggedIn = false;
    $currentAdmin = null;
    $statusMessage = 'Anda telah keluar.';
}

if (!$isLoggedIn && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $identity = trim((string) ($_POST['identity'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');

    if ($identity === '') {
        $errors[] = 'Email atau nomor HP wajib diisi.';
    }
    if ($password === '') {
        $errors[] = 'Password wajib diisi.';
    }

    if ($errors === []) {
        try {
            $pdo = db();
            $stmt = $pdo->prepare(
                'SELECT admin_id, admin_nama, admin_email, admin_no_hp, admin_password, admin_is_superadmin
                 FROM admin
                 WHERE admin_is_deleted = 0 AND (admin_email = :identity OR admin_no_hp = :identity)
                 LIMIT 1'
            );
            $stmt->bindValue(':identity', $identity);
            $stmt->execute();

            $admin = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$admin || !isset($admin['admin_password']) || !password_verify($password, (string) $admin['admin_password'])) {
                $errors[] = 'Kredensial tidak valid. Periksa kembali email/nomor HP dan password Anda.';
            } else {
                $_SESSION['admin'] = [
                    'id' => (int) $admin['admin_id'],
                    'name' => (string) ($admin['admin_nama'] ?? ''),
                    'email' => (string) ($admin['admin_email'] ?? ''),
                    'phone' => (string) ($admin['admin_no_hp'] ?? ''),
                    'is_superadmin' => (int) ($admin['admin_is_superadmin'] ?? 0),
                    'logged_in_at' => time(),
                ];

                header('Location: admin_management.php');
                exit;
            }
        } catch (Throwable $exception) {
            $errors[] = 'Terjadi kesalahan pada server: ' . $exception->getMessage();
        }
    }
}

?><!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel Admin Desa Sendangan</title>
    <style>
        :root {
            color-scheme: light;
            font-family: "Inter", system-ui, -apple-system, "Segoe UI", sans-serif;
            line-height: 1.6;
            background: #e2e8f0;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #cbd5f5, #f7fafc);
        }

        .panel {
            width: min(460px, 90vw);
            background: #ffffff;
            border-radius: 20px;
            padding: clamp(26px, 4vw, 36px);
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.18);
            border: 1px solid rgba(226, 232, 240, 0.7);
        }

        h1 {
            margin: 0;
            font-size: clamp(26px, 4vw, 32px);
            color: #0f172a;
            letter-spacing: -0.01em;
        }

        .subtitle {
            margin: 6px 0 24px;
            color: #475569;
            font-size: 14px;
        }

        .status,
        .error {
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 18px;
            font-size: 14px;
            border: 1px solid transparent;
        }

        .status {
            background: rgba(37, 99, 235, 0.12);
            color: #1d4ed8;
            border-color: rgba(37, 99, 235, 0.32);
        }

        .error {
            background: rgba(239, 68, 68, 0.12);
            color: #b91c1c;
            border-color: rgba(239, 68, 68, 0.3);
        }

        form {
            display: grid;
            gap: 18px;
            margin-top: 26px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            font-weight: 600;
            color: #1e293b;
            font-size: 14px;
            letter-spacing: 0.01em;
        }

        .input-wrapper {
            display: flex;
            align-items: center;
            background: #f8fafc;
            border: 1px solid rgba(148, 163, 184, 0.35);
            border-radius: 12px;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .input-wrapper:focus-within {
            border-color: rgba(37, 99, 235, 0.65);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.18);
        }

        .input-icon {
            width: 44px;
            display: grid;
            place-items: center;
            color: rgba(100, 116, 139, 0.75);
            flex: 0 0 44px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"] {
            flex: 1;
            border: none;
            background: transparent;
            color: #0f172a;
            padding: 14px 12px;
            font-size: 15px;
            letter-spacing: 0.01em;
        }

        input::placeholder {
            color: rgba(148, 163, 184, 0.62);
        }

        input:focus {
            outline: none;
        }

        .input-addon {
            position: relative;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0 14px;
            height: 100%;
            background: transparent;
            border: none;
            color: #2563eb;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            text-transform: none;
            letter-spacing: 0.02em;
            border-left: 1px solid rgba(148, 163, 184, 0.35);
            border-radius: 0 12px 12px 0;
            white-space: nowrap;
        }

        .input-addon:hover,
        .input-addon:focus-visible {
            color: #1d4ed8;
        }

        .form-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            font-size: 12px;
            color: #6b7280;
        }

        .form-footer label {
            font-size: 12px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            color: inherit;
        }

        .form-footer input[type="checkbox"] {
            accent-color: #38bdf8;
        }

        button {
            margin-top: 4px;
            width: 100%;
            border: none;
            border-radius: 12px;
            padding: 14px 18px;
            background: #2563eb;
            color: #ffffff;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            letter-spacing: 0.04em;
        }

        button:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 32px rgba(37, 99, 235, 0.24);
        }

        .logout-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 26px;
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            font-size: 12px;
        }

        .logout-link:hover {
            color: #1d4ed8;
        }

        .admin-summary {
            background: rgba(148, 163, 184, 0.12);
            padding: 18px 20px;
            border-radius: 14px;
            margin: 22px 0;
            color: #1f2937;
            font-size: 14px;
            border: 1px solid rgba(148, 163, 184, 0.2);
        }

        .admin-summary strong {
            font-size: 15px;
            color: #0f172a;
        }

        footer {
            margin-top: 30px;
            color: rgba(148, 163, 184, 0.7);
            font-size: 12px;
            text-align: center;
            letter-spacing: 0.08em;
        }

        .btn-secondary-link {
            display: inline-block;
            text-align: center;
            padding: 12px 18px;
            border-radius: 10px;
            font-weight: 700;
            text-decoration: none;
            letter-spacing: 0.03em;
            background: rgba(148, 163, 184, 0.18);
            color: #334155;
            border: 1px solid rgba(148,163,184,0.35);
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }
        .btn-secondary-link:hover{
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(15,23,42,0.12);
            background: rgba(148, 163, 184, 0.28);
        }

    </style>
</head>
<body>
<div class="panel">
    <h1>Panel Admin</h1>
    <p class="subtitle">Kelola konten website Desa Sendangan.</p>

    <?php if ($statusMessage !== ''): ?>
        <div class="status"><?= e($statusMessage) ?></div>
    <?php endif; ?>

    <?php foreach ($errors as $message): ?>
        <div class="error"><?= e($message) ?></div>
    <?php endforeach; ?>

    <?php if ($isLoggedIn && $currentAdmin !== null): ?>
        <div class="admin-summary">
            <strong>Halo, <?= e($currentAdmin['name'] !== '' ? $currentAdmin['name'] : 'Administrator') ?>!</strong><br>
            Email: <?= e($currentAdmin['email']) ?><br>
            <?= (int) ($currentAdmin['is_superadmin'] ?? 0) === 1 ? 'Status: Superadmin' : 'Status: Admin' ?><br>
            Login terakhir: <?= date('d M Y H:i', (int) ($currentAdmin['logged_in_at'] ?? time())) ?>
        </div>
        <p class="subtitle">
            Gunakan tombol di bawah untuk mengelola data website.
        </p>

        <div style="display:flex; flex-direction:column; gap:10px; margin-top:18px;">
            <a href="admin_management.php" style="
                display:inline-block;
                background:#2563eb;
                color:#fff;
                text-align:center;
                padding:12px 18px;
                border-radius:10px;
                font-weight:600;
                text-decoration:none;
                letter-spacing:0.03em;
                box-shadow:0 6px 16px rgba(37,99,235,0.25);
                transition:transform 0.2s ease, box-shadow 0.2s ease;">
                Kelola Data
            </a>

            <!-- ✅ Tambahan -->
            <a href="<?= e(base_uri('/')) ?>" class="btn-secondary-link">Kembali Ke Website Desa</a>

            <a class="logout-link" href="admin.php?action=logout">Keluar</a>
        </div>

    <?php else: ?>
        <form method="post" autocomplete="off">
            <div class="input-group">
                <label for="identity">Email atau Nomor HP</label>
                <div class="input-wrapper">
                    <span class="input-icon">
                        <svg viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path d="M2.94 6.94a1.5 1.5 0 0 1 1.5-1.5h11.12a1.5 1.5 0 0 1 1.06 2.56l-5.56 4.72a1.5 1.5 0 0 1-1.97 0L3.5 8a1.5 1.5 0 0 1-.56-1.06z"/>
                            <path d="M3 6.5v7a1.5 1.5 0 0 0 1.5 1.5h11A1.5 1.5 0 0 0 17 13.5v-7l-6.03 5.13a2.5 2.5 0 0 1-3.24 0L3 6.5z"/>
                        </svg>
                    </span>
                    <input type="text" id="identity" name="identity" value="<?= e($_POST['identity'] ?? '') ?>" required placeholder="contoh: admin@desa.go.id">
                </div>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <span class="input-icon">
                        <svg viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M10 3a5 5 0 0 0-5 5v2H4a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2h-1V8a5 5 0 0 0-5-5zm3 7V8A3 3 0 1 0 7 8v2h6z"/>
                        </svg>
                    </span>
                    <input type="password" id="password" name="password" required placeholder="Minimal 8 karakter" data-password-field>
                    <button type="button" class="input-addon" data-toggle-password aria-controls="password" aria-label="Tampilkan password">lihat</button>
                </div>
            </div>
            <div class="form-footer">
                <label>
                    <input type="checkbox" name="remember" disabled>
                    Ingat saya (segera hadir)
                </label>
                <span>Butuh bantuan? Hubungi superadmin.</span>
            </div>
            <button type="submit">Masuk</button>
            <a href="<?= e(base_uri('/')) ?>" class="btn-secondary-link" style="margin-top:8px;">Kembali Ke Website Desa</a>
        </form   rm>
    <?php endif; ?>
    <footer>&copy; <?= date('Y') ?> Pemerintah Desa Sendangan</footer>
</div>
<script>
    (function () {
        var toggleBtn = document.querySelector('[data-toggle-password]');
        var passwordInput = document.querySelector('[data-password-field]');

        if (!toggleBtn || !passwordInput) {
            return;
        }

        toggleBtn.addEventListener('click', function () {
            var isHidden = passwordInput.getAttribute('type') === 'password';
            passwordInput.setAttribute('type', isHidden ? 'text' : 'password');
            toggleBtn.textContent = isHidden ? 'sembunyikan' : 'lihat';
            toggleBtn.setAttribute('aria-label', isHidden ? 'Sembunyikan password' : 'Tampilkan password');
        });
    })();
</script>
</body>
</html>
