<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$articleId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
$articleId = is_int($articleId) && $articleId > 0 ? $articleId : null;

$article = null;
$relatedNews = [];
$articleError = '';

if ($articleId !== null) {
    try {
        $pdo = db();
        $stmt = $pdo->prepare('SELECT berita_id, berita_judul, berita_isi, berita_gambar, berita_dilihat, berita_created_at FROM berita WHERE berita_id = ? LIMIT 1');
        if ($stmt !== false) {
            $stmt->execute([$articleId]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            if (is_array($row) && $row !== []) {
                $article = $row;
                $article['berita_dilihat'] = (int) ($article['berita_dilihat'] ?? 0);

                $update = $pdo->prepare('UPDATE berita SET berita_dilihat = berita_dilihat + 1 WHERE berita_id = ?');
                if ($update !== false) {
                    $update->execute([$articleId]);
                    $article['berita_dilihat']++;
                }

                $relatedStmt = $pdo->prepare('SELECT berita_id, berita_judul, berita_created_at FROM berita WHERE berita_id <> ? ORDER BY berita_created_at DESC LIMIT 5');
                if ($relatedStmt !== false) {
                    $relatedStmt->execute([$articleId]);
                    $relatedRows = $relatedStmt->fetchAll(PDO::FETCH_ASSOC);
                    if (is_array($relatedRows)) {
                        $relatedNews = $relatedRows;
                    }
                }
            }
        }
    } catch (Throwable) {
        $articleError = 'Berita tidak dapat dimuat saat ini.';
    }
}

if ($article === null) {
    http_response_code(404);
}

$articleTitle = $article['berita_judul'] ?? 'Berita Desa';
$articleDescriptionSource = trim((string) ($article['berita_isi'] ?? ''));
$articleDescription = $articleDescriptionSource !== '' ? mb_substr(strip_tags($articleDescriptionSource), 0, 150) : 'Kumpulan berita terbaru dari Desa Sendangan.';
if (mb_strlen($articleDescriptionSource) > 150) {
    $articleDescription .= '...';
}

render_base_layout([
    'title' => $articleTitle . ' | ' . app_config('name', 'Desa Sendangan'),
    'description' => $articleDescription,
    'activePage' => 'informasi',
    'content' => static function () use ($article, $relatedNews, $articleError): void {
        $formatTanggal = static function (string $value): string {
            $value = trim($value);
            if ($value === '') {
                return '';
            }
            $timestamp = strtotime($value);
            if ($timestamp === false) {
                return $value;
            }
            $bulan = [
                1 => 'Januari',
                2 => 'Februari',
                3 => 'Maret',
                4 => 'April',
                5 => 'Mei',
                6 => 'Juni',
                7 => 'Juli',
                8 => 'Agustus',
                9 => 'September',
                10 => 'Oktober',
                11 => 'November',
                12 => 'Desember',
            ];
            $nomorBulan = (int) date('n', $timestamp);
            $namaBulan = $bulan[$nomorBulan] ?? date('F', $timestamp);
            return date('j', $timestamp) . ' ' . $namaBulan . ' ' . date('Y', $timestamp);
        };

        $heroImage = '';
        if (is_array($article) && isset($article['berita_gambar'])) {
            $heroImage = (string) $article['berita_gambar'];
        }
        if ($heroImage === '') {
            $heroImage = asset('images/placeholder-media.svg');
        } else {
            $heroImage = base_uri('uploads/berita/' . ltrim($heroImage, '/'));
        }

        $contentBlocks = [];
        if (is_array($article)) {
            $rawContent = (string) ($article['berita_isi'] ?? '');
            $normalized = preg_replace("/\r\n|\r/", "\n", $rawContent);
            $segments = preg_split("/\n{2,}/", (string) $normalized) ?: [];
            foreach ($segments as $segment) {
                $trimmed = trim($segment);
                if ($trimmed === '') {
                    continue;
                }
                $contentBlocks[] = '<p>' . nl2br(e($trimmed)) . '</p>';
            }
            if ($contentBlocks === []) {
                $contentBlocks[] = '<p>Belum ada konten yang dapat ditampilkan.</p>';
            }
        }
        ?>
        <section class="section article-hero">
            <div class="container">
                <a class="article-back-link" href="<?= e(base_uri('info_publik.php?tab=berita')) ?>">&larr; Kembali ke daftar berita</a>
                <?php if (!is_array($article)): ?>
                    <h1 class="article-title">Berita tidak ditemukan</h1>
                    <p class="article-empty-text">Maaf, kami tidak menemukan berita yang Anda cari. Silakan kembali ke halaman informasi publik untuk melihat berita lainnya.</p>
                    <?php if ($articleError !== ''): ?>
                        <p class="article-empty-text article-empty-text--muted"><?= e($articleError) ?></p>
                    <?php endif; ?>
                <?php else: ?>
                    <h1 class="article-title"><?= e((string) $article['berita_judul']) ?></h1>
                    <div class="article-meta">
                        <?php
                        $publishedAt = $formatTanggal((string) ($article['berita_created_at'] ?? ''));
                        if ($publishedAt !== ''): ?>
                            <span class="article-meta__item">Dipublikasikan <?= e($publishedAt) ?></span>
                        <?php endif; ?>
                        <?php $views = (int) ($article['berita_dilihat'] ?? 0); ?>
                        <?php if ($views > 0): ?>
                            <span class="article-meta__item"><?= e(number_format($views)) ?> kali dibaca</span>
                        <?php endif; ?>
                    </div>
                <?php endif; ?>
            </div>
        </section>

        <?php if (!is_array($article)): ?>
            <section class="section">
                <div class="container article-layout">
                    <aside class="article-sidebar">
                        <h2>Berita Terbaru</h2>
                        <p>Kembali ke halaman <a href="<?= e(base_uri('info_publik.php?tab=berita')) ?>">Informasi Publik</a> untuk membaca kabar terbaru lainnya.</p>
                    </aside>
                </div>
            </section>
            <?php return; ?>
        <?php endif; ?>

        <section class="section article-media">
            <div class="container">
                <figure class="article-hero-image">
                    <img src="<?= e($heroImage) ?>" alt="<?= e((string) $article['berita_judul']) ?>">
                </figure>
            </div>
        </section>

        <section class="section">
            <div class="container article-layout">
                <article class="article-content">
                    <?= implode("\n", $contentBlocks) ?>
                </article>
                <?php if ($relatedNews !== []): ?>
                    <aside class="article-sidebar">
                        <h2 class="article-sidebar__title">Berita lain</h2>
                        <ul class="article-related-list">
                            <?php foreach ($relatedNews as $item): ?>
                                <?php
                                $relatedId = isset($item['berita_id']) ? (int) $item['berita_id'] : 0;
                                $relatedTitle = (string) ($item['berita_judul'] ?? '');
                                $relatedDate = $formatTanggal((string) ($item['berita_created_at'] ?? ''));
                                $relatedLink = $relatedId > 0
                                    ? base_uri('baca_berita.php?id=' . $relatedId)
                                    : '#';
                                ?>
                                <li>
                                    <a href="<?= e($relatedLink) ?>">
                                        <span><?= e($relatedTitle) ?></span>
                                        <?php if ($relatedDate !== ''): ?>
                                            <small><?= e($relatedDate) ?></small>
                                        <?php endif; ?>
                                    </a>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                    </aside>
                <?php endif; ?>
            </div>
        </section>
        <?php
    },
    'styles' => [
        asset('css/berita-detail.css'),
    ],
]);
