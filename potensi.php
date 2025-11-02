<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$potensiData = data_source('potensi', []);

render_base_layout([
    'title' => 'Potensi Desa | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Potensi unggulan Desa Sendangan meliputi UMKM, destinasi wisata, serta seni dan budaya.',
    'activePage' => 'potensi',
    'content' => static function () use ($potensiData): void {
        $potensiList = [];

        if (is_array($potensiData)) {
            if (array_is_list($potensiData)) {
                $potensiList = $potensiData;
            } else {
                foreach ($potensiData as $group) {
                    if (!is_array($group)) {
                        continue;
                    }
                    if (array_is_list($group)) {
                        $potensiList = array_merge($potensiList, $group);
                    } else {
                        $potensiList[] = $group;
                    }
                }
            }
        }

        $categoryDescriptions = [
            'Wisata' => 'Destinasi wisata alam dan sejarah kebanggaan Desa Sendangan.',
            'Budaya' => 'Pelestarian tradisi dan seni budaya oleh komunitas desa.',
            'Kuliner' => 'Ragam kuliner khas yang menjadi daya tarik kuliner Desa Sendangan.',
            'UMKM' => 'Unit usaha mikro dan kecil yang menggerakkan ekonomi warga.',
        ];

        $groupedPotensi = [];
        foreach ($potensiList as $item) {
            if (!is_array($item)) {
                continue;
            }

            $category = (string) ($item['potensi_kategori'] ?? 'Lainnya');
            if (!isset($groupedPotensi[$category])) {
                $groupedPotensi[$category] = [];
            }

            $images = [];
            if (isset($item['gambar']) && is_array($item['gambar'])) {
                foreach ($item['gambar'] as $image) {
                    if (!is_array($image)) {
                        continue;
                    }
                    $url = (string) ($image['gambar_namafile'] ?? '');
                    if ($url === '') {
                        continue;
                    }
                    $images[] = [
                        'url' => $url,
                        'alt' => (string) ($item['potensi_judul'] ?? 'Potensi Desa'),
                    ];
                }
            } elseif (!empty($item['potensi_gambar'])) {
                $images[] = [
                    'url' => (string) $item['potensi_gambar'],
                    'alt' => (string) ($item['potensi_judul'] ?? 'Potensi Desa'),
                ];
            }

            if ($images === []) {
                $images[] = [
                    'url' => asset('images/placeholder-media.svg'),
                    'alt' => 'Ilustrasi Potensi Desa',
                ];
            }

            $groupedPotensi[$category][] = [
                'id' => (int) ($item['potensi_id'] ?? 0),
                'judul' => (string) ($item['potensi_judul'] ?? ''),
                'deskripsi' => (string) ($item['potensi_isi'] ?? ''),
                'kategori' => $category,
                'gmaps' => (string) ($item['potensi_gmaps_link'] ?? ''),
                'gambar' => $images,
            ];
        }

        $orderedCategories = array_keys($categoryDescriptions);
        $remainingCategories = array_diff(array_keys($groupedPotensi), $orderedCategories);
        $allCategories = array_merge($orderedCategories, $remainingCategories);

        $hasGallery = false;

        ?>
        <section class="section">
            <div class="container page-header">
                <div>
                    <span class="chip">Potensi Desa</span>
                    <h1>Potensi Unggulan Sendangan</h1>
                    <p>Kembangkan potensi lokal menuju Desa Sendangan yang berdaya dan berkelanjutan.</p>
                </div>
            </div>
        </section>

        <?php foreach ($allCategories as $category): ?>
            <?php
            $items = $groupedPotensi[$category] ?? [];
            if ($items === []) {
                continue;
            }
            ?>
            <section class="section">
                <div class="container">
                    <div class="section-header">
                        <h2><?= e($category) ?></h2>
                        <p><?= e($categoryDescriptions[$category] ?? 'Potensi dari kategori ini.') ?></p>
                    </div>
                    <div class="potensi-list">
                        <?php foreach ($items as $item): ?>
                            <?php
                            $images = $item['gambar'] ?? [];
                            $hasMultipleImages = count($images) > 1;
                            if ($hasMultipleImages) {
                                $hasGallery = true;
                            }
                            $mediaClasses = 'potensi-card__media' . ($hasMultipleImages ? '' : ' is-static');
                            ?>
                            <article class="potensi-card">
                                <div class="<?= e($mediaClasses) ?>" data-gallery>
                                    <button class="potensi-gallery-btn prev" type="button" aria-label="Gambar sebelumnya"<?= $hasMultipleImages ? '' : ' disabled' ?>>&lsaquo;</button>
                                    <div class="potensi-gallery-viewport">
                                        <?php foreach ($images as $index => $image): ?>
                                            <img
                                                class="potensi-gallery-image<?= $index === 0 ? ' is-active' : '' ?>"
                                                src="<?= e($image['url']) ?>"
                                                alt="<?= e($image['alt']) ?> (<?= $index + 1 ?>)"
                                            >
                                        <?php endforeach; ?>
                                    </div>
                                    <button class="potensi-gallery-btn next" type="button" aria-label="Gambar selanjutnya"<?= $hasMultipleImages ? '' : ' disabled' ?>>&rsaquo;</button>
                                </div>
                                <div class="potensi-card__body">
                                    <h3><?= e($item['judul']) ?></h3>
                                    <p class="potensi-card__description"><?= e($item['deskripsi']) ?></p>
                                    <?php if ($item['gmaps'] !== ''): ?>
                                        <a class="btn btn-secondary" href="<?= e($item['gmaps']) ?>" target="_blank" rel="noopener">
                                            Buka di Google Maps
                                        </a>
                                    <?php endif; ?>
                                </div>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endforeach; ?>

        <?php if ($hasGallery): ?>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    document.querySelectorAll('[data-gallery]').forEach(function (gallery) {
                        const images = gallery.querySelectorAll('.potensi-gallery-image');
                        if (images.length === 0) {
                            return;
                        }

                        let activeIndex = 0;
                        const prevBtn = gallery.querySelector('.potensi-gallery-btn.prev');
                        const nextBtn = gallery.querySelector('.potensi-gallery-btn.next');

                        function showImage(newIndex) {
                            if (images.length === 0) {
                                return;
                            }
                            images[activeIndex].classList.remove('is-active');
                            activeIndex = (newIndex + images.length) % images.length;
                            images[activeIndex].classList.add('is-active');
                        }

                        if (images.length <= 1) {
                            if (prevBtn) {
                                prevBtn.setAttribute('disabled', 'disabled');
                            }
                            if (nextBtn) {
                                nextBtn.setAttribute('disabled', 'disabled');
                            }
                            gallery.classList.add('is-static');
                            return;
                        }

                        if (prevBtn) {
                            prevBtn.addEventListener('click', function () {
                                showImage(activeIndex - 1);
                            });
                        }
                        if (nextBtn) {
                            nextBtn.addEventListener('click', function () {
                                showImage(activeIndex + 1);
                            });
                        }
                    });
                });
            </script>
        <?php endif; ?>
        <?php
    },
]);
