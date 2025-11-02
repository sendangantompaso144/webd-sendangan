<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$infoPublik = data_source('info_publik', []);
$tab = strtolower((string) filter_input(INPUT_GET, 'tab', FILTER_SANITIZE_FULL_SPECIAL_CHARS));

$tabs = [
    'berita' => 'Berita Desa',
    'pengumuman' => 'Pengumuman',
    'galeri' => 'Galeri',
];

if (!array_key_exists($tab, $tabs)) {
    $tab = 'berita';
}

render_base_layout([
    'title' => $tabs[$tab] . ' | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Informasi publik Desa Sendangan: berita terbaru, pengumuman penting, dan galeri kegiatan.',
    'activePage' => 'informasi',
    'content' => static function () use ($tabs, $tab, $infoPublik): void {
        $berita = $infoPublik['berita'] ?? [];
        $pengumuman = $infoPublik['pengumuman'] ?? [];
        $galeri = $infoPublik['galeri'] ?? [];
        ?>
        <section class="section">
            <div class="container page-header">
                <div>
                    <span class="chip">Informasi Publik</span>
                    <h1><?= e($tabs[$tab]) ?></h1>
                    <p>Pusat informasi resmi Desa Sendangan untuk warga dan masyarakat umum.</p>
                </div>
            </div>

            <div class="container tab-nav">
                <?php foreach ($tabs as $key => $label): ?>
                    <a class="<?= $tab === $key ? 'active' : '' ?>"
                       href="<?= e(base_uri('info_publik.php?tab=' . $key)) ?>">
                        <?= e($label) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        </section>

        <?php if ($tab === 'berita'): ?>
            <section class="section section-info-content">
                <div class="container info-content">
                    <div class="news-grid">
                        <?php foreach ($berita as $item): ?>
                            <?php
                            $beritaJudul = (string) ($item['judul'] ?? '');
                            $beritaRingkasan = (string) ($item['ringkasan'] ?? '');
                            $excerpt = mb_substr(trim(strip_tags($beritaRingkasan)), 0, 160);
                            if (mb_strlen($beritaRingkasan) > 160) {
                                $excerpt .= '...';
                            }
                            $beritaTanggal = (string) ($item['tanggal'] ?? '');
                            $beritaTautan = (string) ($item['tautan'] ?? '#');
                            $beritaViews = isset($item['berita_dilihat']) ? (int) $item['berita_dilihat'] : 0;
                            ?>
                            <article class="news-card">
                                <?php if (!empty($item['gambar'])): ?>
                                    <div class="news-card-image">
                                        <img src="<?= e((string) $item['gambar']) ?>" alt="<?= e($beritaJudul === '' ? 'Berita Desa' : $beritaJudul) ?>">
                                    </div>
                                <?php endif; ?>
                                <div class="news-card-content">
                                    <div class="news-meta">
                                        <span class="news-views"><?= e(number_format($beritaViews)) ?> kali dibaca</span>
                                        <?php if ($beritaTanggal !== ''): ?>
                                            <span class="news-date"><?= e($beritaTanggal) ?></span>
                                        <?php endif; ?>
                                    </div>
                                    <h3 class="news-title"><?= e($beritaJudul) ?></h3>
                                    <p class="news-excerpt"><?= e($excerpt) ?></p>
                                    <a class="news-link" href="<?= e($beritaTautan) ?>">
                                        Baca Selengkapnya &rarr;
                                    </a>
                                </div>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php elseif ($tab === 'pengumuman'): ?>
            <section class="section section-info-content">
                <div class="container info-content">
                    <ul class="announcement-list">
                        <?php foreach ($pengumuman as $item): ?>
                            <li>
                                <div>
                                    <strong><?= e($item['judul'] ?? '') ?></strong>
                                    <span><?= e($item['tanggal'] ?? '') ?></span>
                                </div>
                                <a class="btn btn-secondary" href="<?= e($item['tautan'] ?? '#') ?>">Detail</a>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            </section>
        <?php elseif ($tab === 'galeri'): ?>
            <section class="section section-info-content">
                <div class="container info-content">
                    <div class="gallery-grid gallery-grid--plain" data-gallery-grid>
                        <?php foreach ($galeri as $index => $item): ?>
                            <?php
                            $galleryCaption = (string) ($item['galeri_keterangan'] ?? $item['judul'] ?? '');
                            $galleryImage = (string) ($item['gambar'] ?? asset('images/placeholder-gallery.jpg'));
                            $downloadUrl = (string) ($item['galeri_download'] ?? $galleryImage);
                            ?>
                            <button
                                class="gallery-plain-card"
                                type="button"
                                data-gallery-item
                                data-gallery-index="<?= e((string) $index) ?>"
                                data-gallery-src="<?= e($galleryImage) ?>"
                                data-gallery-caption="<?= e($galleryCaption) ?>"
                                data-gallery-download="<?= e($downloadUrl) ?>"
                            >
                                <img src="<?= e($galleryImage) ?>" alt="<?= e($galleryCaption !== '' ? $galleryCaption : 'Galeri Desa Sendangan') ?>">
                                <?php if ($galleryCaption !== ''): ?>
                                    <figcaption><?= e($galleryCaption) ?></figcaption>
                                <?php endif; ?>
                            </button>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
            <div class="gallery-modal" data-gallery-modal hidden>
                <div class="gallery-modal__overlay" data-gallery-close></div>
                <div class="gallery-modal__dialog" role="dialog" aria-modal="true" aria-label="Pratinjau Galeri">
                    <div class="gallery-modal__media">
                        <button class="gallery-modal__close" type="button" data-gallery-close aria-label="Tutup galeri">&times;</button>
                        <img src="" alt="" data-gallery-modal-image>
                    </div>
                    <div class="gallery-modal__sidebar">
                        <p class="gallery-modal__caption" data-gallery-modal-caption></p>
                        <div class="gallery-modal__controls">
                            <button class="btn btn-secondary" type="button" data-gallery-prev>&larr; Sebelumnya</button>
                            <button class="btn btn-secondary" type="button" data-gallery-next>Selanjutnya &rarr;</button>
                            <a class="btn btn-primary" data-gallery-download href="#" download>
                                Unduh Gambar
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var galleryGrid = document.querySelector('[data-gallery-grid]');
                    var modal = document.querySelector('[data-gallery-modal]');

                    if (!galleryGrid || !modal) {
                        return;
                    }

                    var items = Array.from(galleryGrid.querySelectorAll('[data-gallery-item]'));
                    var modalImage = modal.querySelector('[data-gallery-modal-image]');
                    var modalCaption = modal.querySelector('[data-gallery-modal-caption]');
                    var closeButtons = modal.querySelectorAll('[data-gallery-close]');
                    var prevButton = modal.querySelector('[data-gallery-prev]');
                    var nextButton = modal.querySelector('[data-gallery-next]');
                    var downloadLink = modal.querySelector('[data-gallery-download]');

                    var activeIndex = -1;

                    function updateModal(index) {
                        if (!items[index]) {
                            return;
                        }
                        var trigger = items[index];
                        var src = trigger.getAttribute('data-gallery-src') || '';
                        var caption = trigger.getAttribute('data-gallery-caption') || '';
                        var download = trigger.getAttribute('data-gallery-download') || src;

                        if (modalImage) {
                            modalImage.src = src;
                            modalImage.alt = caption || 'Galeri Desa Sendangan';
                        }

                        if (modalCaption) {
                            modalCaption.textContent = caption;
                        }

                        if (downloadLink) {
                            downloadLink.href = download;
                        }

                        activeIndex = index;
                        updateControlsState();
                    }

                    function updateControlsState() {
                        if (!prevButton || !nextButton) {
                            return;
                        }

                        prevButton.disabled = activeIndex <= 0;
                        nextButton.disabled = activeIndex >= items.length - 1;
                    }

                    function openModal(index) {
                        updateModal(index);
                        modal.removeAttribute('hidden');
                        document.body.classList.add('modal-open');
                    }

                    function closeModal() {
                        modal.setAttribute('hidden', 'hidden');
                        document.body.classList.remove('modal-open');
                        if (modalImage) {
                            modalImage.src = '';
                        }
                        activeIndex = -1;
                    }

                    items.forEach(function (item, index) {
                        item.addEventListener('click', function () {
                            openModal(index);
                        });
                    });

                    closeButtons.forEach(function (btn) {
                        btn.addEventListener('click', closeModal);
                    });

                    if (prevButton) {
                        prevButton.addEventListener('click', function () {
                            if (activeIndex > 0) {
                                updateModal(activeIndex - 1);
                            }
                        });
                    }

                    if (nextButton) {
                        nextButton.addEventListener('click', function () {
                            if (activeIndex < items.length - 1) {
                                updateModal(activeIndex + 1);
                            }
                        });
                    }

                    document.addEventListener('keydown', function (event) {
                        if (modal.hasAttribute('hidden')) {
                            return;
                        }

                        if (event.key === 'Escape') {
                            closeModal();
                        } else if (event.key === 'ArrowLeft' && activeIndex > 0) {
                            updateModal(activeIndex - 1);
                        } else if (event.key === 'ArrowRight' && activeIndex < items.length - 1) {
                            updateModal(activeIndex + 1);
                        }
                    });
                });
            </script>
        <?php endif; ?>
        <?php
    },
]);
