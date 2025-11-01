<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$homeData = data_source('home', []);

render_base_layout([
    'title' => 'Beranda | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Beranda Desa Sendangan: sambutan, data singkat, dan layanan utama untuk warga.',
    'activePage' => 'home',
    'bodyClass' => 'page-home',
    'content' => static function () use ($homeData): void {
        $stats = $homeData['stats'] ?? [
            ['label' => 'Jumlah Penduduk', 'value' => '550', 'note' => ''],
            ['label' => 'Luas Wilayah', 'value' => '85 Ha', 'note' => ''],
            ['label' => 'Jumlah Jaga', 'value' => '3', 'note' => '']
        ];
        $features = $homeData['features'] ?? [
            ['title' => 'Profil Desa', 'summary' => 'Sejarah, demografi, dan informasi lengkap tentang desa', 'link' => 'profil.php'],
            ['title' => 'Informasi Publik', 'summary' => 'Berita terkini, pengumuman, dan galeri kegiatan', 'link' => 'info_publik.php'],
            ['title' => 'Transparansi', 'summary' => 'Laporan keuangan dan realisasi APBDes', 'link' => 'transparansi.php'],
            ['title' => 'Potensi Desa', 'summary' => 'UMKM, wisata, seni dan budaya lokal', 'link' => 'potensi.php']
        ];
        $administrasi = $homeData['administrasi'] ?? [
            ['label' => 'Total Penduduk', 'value' => '550'],
            ['label' => 'Jumlah RT/Jaga', 'value' => '3'],
            ['label' => 'Anak-anak', 'value' => '18%'],
            ['label' => 'Dewasa', 'value' => '62%'],
            ['label' => 'Lansia', 'value' => '20%']
        ];
        $potentials = $homeData['potentials'] ?? [
            ['category' => 'Wisata', 'title' => 'Kolam Air Panas', 'status' => 'Direncanakan'],
            ['category' => 'UMKM', 'title' => 'UMKM Lokal', 'status' => 'Dukungan dan pelatihan untuk UMKM'],
            ['category' => 'Budaya', 'title' => 'Seni & Budaya', 'status' => 'Pelestarian tradisi dan festival lokal']
        ];
        $headlines = $homeData['headlines'] ?? [
            'Pelayanan administrasi desa buka Senin-Jumat pukul 08.00 - 15.00 WITA.',
            'Pengumuman: Kerja bakti lingkungan akan dilaksanakan pada Sabtu, 16 November mulai pukul 07.00 WITA.',
            'Program bantuan pupuk subsidi dibuka kembali, segera daftar di kantor desa sebelum 25 November.'
        ];
        ?>
        
        <!-- Hero Section dengan Gradient -->
        <section class="hero-section">
            <div class="hero-overlay"></div>
            <div class="hero-content-wrapper">
                <div class="hero-main">
                    <div class="hero-badge">Selamat datang</div>
                    <h1 class="hero-title">Website Desa Sendangan</h1>
                    <p class="hero-subtitle">Sumber informasi resmi tentang Desa Sendangan</p>
                </div>
            </div>
            <?php if ($headlines !== []): ?>
                <div class="hero-headline" data-interval="10000">
                    <div class="hero-headline-viewport">
                        <div class="hero-headline-track">
                            <?php foreach ($headlines as $headline): ?>
                                <div class="hero-headline-item">
                                    <span class="hero-headline-text"><?= e((string) $headline) ?></span>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
        </section>

        <!-- Stats Section -->
        <?php if ($stats !== []): ?>
            <section class="stats-section">
                <div class="stats-container">
                    <?php 
                    $icons = ['👥', '📍', '🏘️'];
                    foreach ($stats as $index => $stat): ?>
                        <div class="stat-card">
                            <div class="stat-icon"><?= $icons[$index] ?? '📊' ?></div>
                            <div class="stat-content">
                                <div class="stat-value"><?= e($stat['value'] ?? '') ?></div>
                                <div class="stat-label"><?= e($stat['label'] ?? '') ?></div>
                                <?php if (!empty($stat['note'])): ?>
                                    <div class="stat-note"><?= e($stat['note']) ?></div>
                                <?php endif; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </section>
        <?php endif; ?>
        <!-- Features Section -->
        <?php if ($features !== []): ?>
            <section class="explore-section">
                <div class="explore-container">
                    <div class="explore-intro">
                        <h2 class="explore-title">Jelajahi Desa Sendangan</h2>
                        <p class="explore-description">
                            Kenali lebih dekat berbagai aspek desa melalui menu-menu berikut.
                        </p>
                    </div>
                    <?php
                        $featureIcons = [
                            'Profil Desa' => '🏛️',
                            'Informasi Publik' => '📢',
                            'Transparansi' => '💰',
                            'Potensi Desa' => '🌾',
                        ];
                    ?>
                    <div class="explore-grid">
                        <?php foreach ($features as $feature): ?>
                            <?php
                                $title = (string) ($feature['title'] ?? '');
                                $summary = (string) ($feature['summary'] ?? '');
                                $href = base_uri($feature['link'] ?? '#');
                                $icon = $featureIcons[$title] ?? '➡️';
                            ?>
                            <a class="explore-card" href="<?= e($href) ?>">
                                <span class="explore-icon"><?= e($icon) ?></span>
                                <h3><?= e($title) ?></h3>
                                <p><?= e($summary) ?></p>
                            </a>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <!-- Sambutan Section dengan Photo -->
        <section class="greeting-section">
            <div class="section-container">
                <div class="greeting-grid">
                    <div class="greeting-photo">
                        <div class="photo-frame">
                            <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='500'%3E%3Crect fill='%23E3F2FD' width='400' height='500'/%3E%3Ctext x='50%25' y='50%25' font-size='16' fill='%2390CAF9' text-anchor='middle' dominant-baseline='middle'%3EJohny R. Mandagi%3C/text%3E%3C/svg%3E" alt="Johny R. Mandagi" />
                        </div>
                    </div>
                    <div class="greeting-content">
                        <div class="greeting-badge">SAMBUTAN HUKUM TUA</div>
                        <h2 class="greeting-title">Johny R. Mandagi</h2>
                        <div class="greeting-text">
                            <p>Selamat datang di website resmi Desa Sendangan. Kami berkomitmen untuk memberikan pelayanan terbaik kepada masyarakat dan membangun desa yang lebih maju, sejahtera, dan bermartabat.</p>
                            <p>Melalui website ini, kami berharap dapat meningkatkan transparansi dan komunikasi dengan seluruh warga. Mari bersama-sama membangun Desa Sendangan yang lebih baik.</p>
                        </div>
                        <a class="greeting-button" href="<?= e(base_uri('profil.php')) ?>">
                            Profil Desa →
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Map Section -->
        <section class="map-section">
            <div class="map-container">
                <div class="map-intro">
                    <h2>Peta Desa Sendangan</h2>
                    <p>Lokasi fasilitas umum, batas wilayah, dan potensi desa dalam satu tampilan interaktif.</p>
                </div>
                <div class="map-display">
                    <div class="map-placeholder">
                        <div class="map-icon">🗺️</div>
                        <p class="map-text">Peta desa akan ditampilkan di sini</p>
                        <p class="map-subtext">Segera hadir dengan informasi lokasi lengkap</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Structure Section -->
        <section class="content-section structure-section">
            <div class="section-container">
                <div class="section-header-wrapper">
                    <h2 class="section-title">Struktur Organisasi</h2>
                    <p class="section-description">Perangkat Desa Sendangan yang mengabdi untuk masyarakat</p>
                </div>
                <div class="structure-grid">
                    <?php 
                    $positions = [
                        ['name' => 'Johny R. Mandagi', 'role' => 'Kepala Desa'],
                        ['name' => 'Maria S. Wenas', 'role' => 'Sekretaris Desa'],
                        ['name' => '', 'role' => 'Kaur Pemerintahan'],
                        ['name' => '', 'role' => 'Kaur Pembangunan'],
                        ['name' => '', 'role' => 'Kaur Keuangan'],
                        ['name' => '', 'role' => 'Kaur Umum']
                    ];
                    foreach ($positions as $position): ?>
                        <div class="structure-card">
                            <div class="structure-photo">
                                <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Crect fill='%23E3F2FD' width='200' height='200' rx='100'/%3E%3Ctext x='50%25' y='50%25' font-size='60' text-anchor='middle' dominant-baseline='middle'%3E👤%3C/text%3E%3C/svg%3E" alt="<?= e($position['role']) ?>" />
                            </div>
                            <?php if (!empty($position['name'])): ?>
                                <div class="structure-name"><?= e($position['name']) ?></div>
                            <?php endif; ?>
                            <div class="structure-role"><?= e($position['role']) ?></div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <!-- Administrasi Section -->
        <?php if ($administrasi !== []): ?>
            <section class="content-section admin-section">
                <div class="section-container">
                    <div class="section-header-wrapper">
                        <h2 class="section-title">Administrasi Penduduk</h2>
                        <p class="section-description">Data kependudukan Desa Sendangan</p>
                    </div>
                    <div class="admin-grid">
                        <?php 
                        $adminIcons = ['👨‍👩‍👧‍👦', '🏘️', '👶', '👔', '👴'];
                        foreach ($administrasi as $index => $item): ?>
                            <div class="admin-card">
                                <div class="admin-icon"><?= $adminIcons[$index] ?? '📊' ?></div>
                                <div class="admin-value"><?= e($item['value'] ?? '') ?></div>
                                <div class="admin-label"><?= e($item['label'] ?? '') ?></div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <!-- Potensi Section -->
        <?php if ($potentials !== []): ?>
            <section class="content-section potential-section">
                <div class="section-container">
                    <div class="section-header-flex">
                        <div>
                            <h2 class="section-title">Potensi Desa</h2>
                            <p class="section-description">Potensi dan peluang Desa Sendangan</p>
                        </div>
                        <a class="header-button" href="<?= e(base_uri('potensi.php')) ?>">
                            Lihat Semua Potensi →
                        </a>
                    </div>
                    <div class="potential-grid">
                        <?php 
                        $potentialIcons = ['🌊', '🛍️', '🎭'];
                        foreach ($potentials as $index => $potential): ?>
                            <div class="potential-card">
                                <div class="potential-icon"><?= $potentialIcons[$index] ?? '🌟' ?></div>
                                <div class="potential-category"><?= e($potential['category'] ?? '') ?></div>
                                <h3 class="potential-title"><?= e($potential['title'] ?? '') ?></h3>
                                <?php if (!empty($potential['status'])): ?>
                                    <p class="potential-status"><?= e($potential['status']) ?></p>
                                <?php endif; ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                    <div class="potential-note">
                        <p>Keterangan: Potensi desa akan ditambahkan nanti</p>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <!-- News Section -->
        <section class="content-section news-section">
            <div class="section-container">
                <div class="section-header-flex">
                    <div>
                        <h2 class="section-title">Berita Terbaru</h2>
                        <p class="section-description">Informasi dan pengumuman terkini</p>
                    </div>
                    <a class="header-button" href="<?= e(base_uri('info_publik.php?tab=berita')) ?>">
                        Lihat Semua Berita →
                    </a>
                </div>
                <div class="news-grid">
                    <article class="news-card">
                        <div class="news-badge">Berita</div>
                        <h3 class="news-title">Pelatihan Digital untuk UMKM Sendangan</h3>
                        <p class="news-excerpt">Pemerintah desa bersama komunitas pemuda mengadakan pelatihan pemasaran digital bagi pelaku UMKM.</p>
                        <a class="news-link" href="#">Baca Selengkapnya →</a>
                    </article>
                    <article class="news-card">
                        <div class="news-badge badge-announcement">Pengumuman</div>
                        <h3 class="news-title">Jadwal Pelayanan Administrasi</h3>
                        <p class="news-excerpt">Pelayanan administrasi kependudukan tersedia setiap Selasa dan Kamis pukul 09.00-14.00 WITA.</p>
                        <a class="news-link" href="#">Baca Selengkapnya →</a>
                    </article>
                    <article class="news-card">
                        <div class="news-badge badge-agenda">Agenda</div>
                        <h3 class="news-title">Gotong Royong Bersama Warga</h3>
                        <p class="news-excerpt">Agenda bersih lingkungan dilaksanakan setiap Sabtu pekan pertama, dimulai dari Balai Desa.</p>
                        <a class="news-link" href="#">Baca Selengkapnya →</a>
                    </article>
                </div>
            </div>
        </section>

        <style>
            /* Reset dan Base Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                color: #263238;
                line-height: 1.6;
                background-color: #F9FAFB;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                line-height: 1.3;
            }

            /* Hero Section */
            .hero-section {
                position: relative;
                min-height: 560px;
                background: linear-gradient(135deg, rgba(21, 101, 192, 0.05) 0%, rgba(144, 202, 249, 0.08) 100%), url('assets/images/hero-background.jpg');
                background-position: center;
                background-size: cover;
                background-repeat: no-repeat;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: stretch;
                text-align: center;
                margin-top: calc(-1 * var(--header-height, 88px));
                padding: calc(40px + var(--header-height, 88px)) 0 0;
                overflow: hidden;
            }

            .hero-overlay {
                position: absolute;
                inset: 0;
                background: rgba(0, 0, 0, 0.45);
            }

            .hero-content-wrapper {
                position: relative;
                z-index: 1;
                width: min(1120px, 92vw);
                margin: 0 auto;
                flex: 0 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: flex-start;
                gap: 24px;
            }

            .hero-main {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 16px;
                width: 100%;
                max-width: 720px;
                margin: 0 auto;
                text-align: center;
            }

            .hero-badge {
                display: inline-block;
                background: rgba(0, 0, 0, 0.55);
                color: #FFFFFF;
                padding: 8px 20px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-shadow:
                    0 0 3px rgba(0, 0, 0, 0.8),
                    0 0 8px rgba(0, 0, 0, 0.6);
            }

            .hero-title {
                font-size: clamp(32px, 5vw, 56px);
                color: #FFFFFF;
                margin-bottom: 16px;
                font-weight: 700;
                text-shadow:
                    0 0 4px rgba(0, 0, 0, 0.85),
                    0 0 12px rgba(0, 0, 0, 0.6),
                    0 0 18px rgba(0, 0, 0, 0.45);
            }

            .hero-subtitle {
                font-size: clamp(16px, 2vw, 20px);
                color: #FFFFFF;
                max-width: 600px;
                margin: 0 auto;
                text-shadow:
                    0 0 3px rgba(0, 0, 0, 0.8),
                    0 0 10px rgba(0, 0, 0, 0.6);
            }

            .hero-headline {
                position: relative;
                z-index: 1;
                align-self: stretch;
                width: 100%;
                margin-top: auto;
                text-align: left;
                color: #FFFFFF;
            }

            .hero-headline-viewport {
                position: relative;
                overflow: hidden;
                background: rgba(255, 193, 7, 0.3);
                height: 30px;
                display: flex;
                align-items: stretch;
            }

            .hero-headline-track {
                display: flex;
                flex-direction: column;
                transition: transform 0.6s ease;
                will-change: transform;
            }

            .hero-headline-item {
                display: flex;
                align-items: center;
                height: 44px;
                padding: 0 clamp(18px, 4vw, 40px);
                font-size: 18px;
                font-weight: 600;
                white-space: nowrap;
                color: inherit;
                text-align: left;
                justify-content: flex-start;
                width: 100%;
            }

            .hero-headline-text {
                display: inline-block;
                will-change: transform;
                transition: transform 0.8s ease;
                text-shadow:
                    0 0 2px rgba(0, 0, 0, 0.9),
                    0 0 4px rgba(0, 0, 0, 0.7);
            }

            /* Stats Section */
            .stats-section {
                background: transparent;
                padding: 24px 0;
                margin-top: -30px;
                position: relative;
                z-index: 2;
            }

            .stats-container {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
            }

            .stat-card {
                display: flex;
                align-items: flex-start;
                gap: 16px;
                padding: 16px 0;
                border-bottom: 1px solid rgba(255, 255, 255, 0.25);
                transition: color 0.3s ease;
            }

            .stat-card:last-child {
                border-bottom: none;
            }

            .stat-card:hover {
                color: rgba(255, 255, 255, 0.85);
            }

            .stat-icon {
                font-size: 48px;
                line-height: 1;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 700;
                color: #90CAF9;
                margin-bottom: 4px;
            }

            .stat-label {
                font-size: 14px;
                color: #607D8B;
                font-weight: 500;
            }

            /* Content Section */
            .content-section {
                padding: 80px 20px;
            }

            .section-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .section-header-wrapper {
                text-align: center;
                margin-bottom: 50px;
            }

            .section-title {
                font-size: clamp(28px, 4vw, 36px);
                color: #263238;
                margin-bottom: 12px;
            }

            .section-description {
                font-size: 18px;
                color: #607D8B;
            }

            /* Feature Grid */
            .feature-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 30px;
            }

            .feature-card {
                background: white;
                padding: 40px 30px;
                border-radius: 16px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: 2px solid #E3F2FD;
            }

            .feature-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 40px rgba(144, 202, 249, 0.2);
                border-color: #90CAF9;
            }

            .feature-icon {
                font-size: 56px;
                margin-bottom: 20px;
            }

            .feature-title {
                font-size: 22px;
                color: #263238;
                margin-bottom: 12px;
            }

            .feature-description {
                font-size: 15px;
                color: #607D8B;
                margin-bottom: 24px;
                line-height: 1.6;
            }

            .feature-link {
                display: inline-block;
                color: #90CAF9;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                transition: transform 0.2s ease;
            }

            .feature-link:hover {
                transform: translateX(5px);
            }

            /* Greeting Section */
            .greeting-section {
                background: linear-gradient(135deg, #E3F2FD 0%, #F9FAFB 100%);
                padding: 80px 20px;
            }

            .greeting-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 60px;
                align-items: center;
            }

            .greeting-photo {
                display: flex;
                justify-content: center;
            }

            .photo-frame {
                width: 100%;
                max-width: 400px;
                aspect-ratio: 4/5;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 20px 60px rgba(144, 202, 249, 0.3);
            }

            .photo-frame img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .greeting-badge {
                display: inline-block;
                background: #90CAF9;
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                letter-spacing: 0.5px;
                margin-bottom: 16px;
            }

            .greeting-title {
                font-size: 32px;
                color: #263238;
                margin-bottom: 24px;
            }

            .greeting-text {
                margin-bottom: 30px;
            }

            .greeting-text p {
                font-size: 16px;
                color: #37474F;
                margin-bottom: 16px;
                line-height: 1.8;
            }

            .greeting-button {
                display: inline-block;
                background: #90CAF9;
                color: white;
                padding: 14px 32px;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(144, 202, 249, 0.3);
            }

            .greeting-button:hover {
                background: #64B5F6;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(144, 202, 249, 0.4);
            }

            /* Map Section */
            .map-section {
                background: white;
            }

            .map-placeholder {
                background: linear-gradient(135deg, #E3F2FD 0%, #F9FAFB 100%);
                border-radius: 20px;
                padding: 100px 40px;
                text-align: center;
                border: 2px dashed #90CAF9;
            }

            .map-icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            .map-text {
                font-size: 20px;
                color: #263238;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .map-subtext {
                font-size: 16px;
                color: #607D8B;
            }

            /* Structure Section */
            .structure-section {
                background: linear-gradient(135deg, #F9FAFB 0%, #E3F2FD 100%);
            }

            .structure-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 30px;
            }

            .structure-card {
                background: white;
                padding: 30px 20px;
                border-radius: 16px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .structure-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(144, 202, 249, 0.2);
            }

            .structure-photo {
                width: 120px;
                height: 120px;
                margin: 0 auto 20px;
                border-radius: 50%;
                overflow: hidden;
                border: 4px solid #E3F2FD;
            }

            .structure-photo img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .structure-name {
                font-size: 18px;
                font-weight: 600;
                color: #263238;
                margin-bottom: 8px;
            }

            .structure-role {
                font-size: 14px;
                color: #90CAF9;
                font-weight: 500;
            }

            /* Admin Section */
            .admin-section {
                background: white;
            }

            .admin-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 30px;
            }

            .admin-card {
                background: #F9FAFB;
                padding: 40px 20px;
                border-radius: 16px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .admin-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(144, 202, 249, 0.15);
                background: white;
            }

            .admin-icon {
                font-size: 56px;
                margin-bottom: 16px;
            }

            .admin-value {
                font-size: 36px;
                font-weight: 700;
                color: #90CAF9;
                margin-bottom: 8px;
            }

            .admin-label {
                font-size: 14px;
                color: #607D8B;
                font-weight: 500;
            }

            /* Potential Section */
            .potential-section {
                background: linear-gradient(135deg, #E3F2FD 0%, #F9FAFB 100%);
            }

            .section-header-flex {
                display: flex;
                justify-content: space-between;
                align-items: flex-end;
                margin-bottom: 50px;
                flex-wrap: wrap;
                gap: 20px;
            }

            .header-button {
                display: inline-block;
                background: white;
                color: #90CAF9;
                padding: 12px 28px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                transition: all 0.3s ease;
                border: 2px solid #90CAF9;
            }

            .header-button:hover {
                background: #90CAF9;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(144, 202, 249, 0.3);
            }

            .potential-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin-bottom: 30px;
            }

            .potential-card {
                background: white;
                padding: 40px 30px;
                border-radius: 16px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .potential-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(144, 202, 249, 0.2);
            }

            .potential-icon {
                font-size: 56px;
                margin-bottom: 20px;
            }

            .potential-category {
                display: inline-block;
                background: #E3F2FD;
                color: #90CAF9;
                padding: 6px 14px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 600;
                margin-bottom: 16px;
            }

            .potential-title {
                font-size: 22px;
                color: #263238;
                margin-bottom: 12px;
            }

            .potential-status {
                font-size: 15px;
                color: #607D8B;
                line-height: 1.6;
            }

            .potential-note {
                text-align: center;
                padding: 20px;
                background: rgba(255, 224, 130, 0.2);
                border-radius: 12px;
            }

            .potential-note p {
                font-size: 14px;
                color: #607D8B;
                font-style: italic;
            }

            /* News Section */
            .news-section {
                background: white;
            }

            .news-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                gap: 30px;
            }

            .news-card {
                background: #F9FAFB;
                padding: 35px;
                border-radius: 16px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: 2px solid transparent;
            }

            .news-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 40px rgba(144, 202, 249, 0.2);
                background: white;
                border-color: #E3F2FD;
            }

            .news-badge {
                display: inline-block;
                background: #90CAF9;
                color: white;
                padding: 6px 16px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 600;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .badge-announcement {
                background: #FFE082;
                color: #F57C00;
            }

            .badge-agenda {
                background: #CE93D8;
                color: #6A1B9A;
            }

            .news-title {
                font-size: 20px;
                color: #263238;
                margin-bottom: 16px;
                line-height: 1.4;
            }

            .news-excerpt {
                font-size: 15px;
                color: #607D8B;
                line-height: 1.7;
                margin-bottom: 24px;
            }

            .news-link {
                display: inline-block;
                color: #90CAF9;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                transition: transform 0.2s ease;
            }

            .news-link:hover {
                transform: translateX(5px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .hero-section {
                    min-height: 460px;
                    padding: calc(30px + var(--header-height, 88px)) 0 0;
                }

                .hero-content-wrapper {
                    gap: 16px;
                    padding: 0 20px;
                }

                .hero-headline-viewport {
                    height: 25px;
                }

                .hero-headline-item {
                    height: 40px;
                    font-size: 16px;
                    padding: 0 clamp(14px, 5vw, 26px);
                }

                .stats-section {
                    margin-top: -40px;
                    padding: 24px 16px;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .content-section {
                    padding: 50px 20px;
                }

                .section-header-wrapper {
                    margin-bottom: 35px;
                }

                .feature-grid,
                .structure-grid,
                .admin-grid,
                .potential-grid,
                .news-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .greeting-grid {
                    grid-template-columns: 1fr;
                    gap: 40px;
                }

                .greeting-section {
                    padding: 50px 20px;
                }

                .section-header-flex {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 20px;
                }

                .header-button {
                    width: 100%;
                    text-align: center;
                }

                .map-placeholder {
                    padding: 60px 20px;
                }

                .map-icon {
                    font-size: 60px;
                }
            }

            @media (max-width: 480px) {
                .hero-badge {
                    font-size: 12px;
                    padding: 6px 16px;
                }

                .hero-headline-viewport {
                    height: 36px;
                }

                .hero-headline-item {
                    height: 36px;
                    font-size: 15px;
                    padding: 0 clamp(12px, 6vw, 20px);
                }

                .stat-icon {
                    font-size: 40px;
                }

                .stat-value {
                    font-size: 28px;
                }

                .feature-card,
                .news-card {
                    padding: 25px 20px;
                }

                .feature-icon,
                .admin-icon,
                .potential-icon {
                    font-size: 48px;
                }

                .admin-value {
                    font-size: 32px;
                }

                .structure-photo {
                    width: 100px;
                    height: 100px;
                }

                .greeting-title {
                    font-size: 26px;
                }

                .greeting-text p {
                    font-size: 15px;
                }

                .greeting-button {
                    width: 100%;
                    text-align: center;
                }
            }
            }

            /* Smooth Scroll Behavior */
            html {
                scroll-behavior: smooth;
            }

            /* Loading Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .stat-card,
            .feature-card,
            .structure-card,
            .admin-card,
            .potential-card,
            .news-card {
                animation: fadeInUp 0.6s ease-out backwards;
            }

            .stat-card:nth-child(1) { animation-delay: 0.1s; }
            .stat-card:nth-child(2) { animation-delay: 0.2s; }
            .stat-card:nth-child(3) { animation-delay: 0.3s; }

            .feature-card:nth-child(1) { animation-delay: 0.1s; }
            .feature-card:nth-child(2) { animation-delay: 0.2s; }
            .feature-card:nth-child(3) { animation-delay: 0.3s; }
            .feature-card:nth-child(4) { animation-delay: 0.4s; }

            /* Accessibility Improvements */
            a:focus,
            button:focus {
                outline: 3px solid #90CAF9;
                outline-offset: 2px;
            }

            /* Print Styles */
            @media print {
                .hero-section {
                    background: white;
                    color: black;
                    min-height: auto;
                    padding: 20px;
                }

                .stat-card,
                .feature-card,
                .structure-card,
                .admin-card,
                .potential-card,
                .news-card {
                    break-inside: avoid;
                    box-shadow: none;
                    border: 1px solid #ddd;
                }

                .greeting-button,
                .feature-link,
                .news-link,
                .header-button {
                    display: none;
                }
            }

            /* Dark Mode Support (optional) */
            @media (prefers-color-scheme: dark) {
                /* Uncomment to enable dark mode
                body {
                    background-color: #1a1a1a;
                    color: #e0e0e0;
                }

                .hero-section {
                    background: linear-gradient(135deg, #1976D2 0%, #0D47A1 100%);
                }

                .section-title,
                .feature-title,
                .greeting-title,
                .structure-name,
                .news-title {
                    color: #e0e0e0;
                }
                */
            }

            /* Custom Scrollbar */
            ::-webkit-scrollbar {
                width: 10px;
            }

            ::-webkit-scrollbar-track {
                background: #F9FAFB;
            }

            ::-webkit-scrollbar-thumb {
                background: #90CAF9;
                border-radius: 5px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: #64B5F6;
            }

            /* Selection Color */
            ::selection {
                background: #90CAF9;
                color: white;
            }

            ::-moz-selection {
                background: #90CAF9;
                color: white;
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var heroHeadline = document.querySelector('.hero-headline');
                if (!heroHeadline) {
                    return;
                }

                var viewport = heroHeadline.querySelector('.hero-headline-viewport');
                var track = heroHeadline.querySelector('.hero-headline-track');
                var items = Array.prototype.slice.call(heroHeadline.querySelectorAll('.hero-headline-item'));

                if (!viewport || !track || items.length === 0) {
                    return;
                }

                var intervalAttr = parseInt(heroHeadline.getAttribute('data-interval') || '', 8.5);
                var interval = Number.isFinite(intervalAttr) && intervalAttr > 0 ? intervalAttr : 10000;

                var currentIndex = 0;
                var timerId;
                var positions = [];
                var positionIndex = -1;

                var setTrackPosition = function (index, animate) {
                    var itemHeight = items[0] ? items[0].offsetHeight : 0;
                    var offset = itemHeight * index;
                    if (!animate) {
                        var previousTransition = track.style.transition;
                        track.style.transition = 'none';
                        track.style.transform = 'translateY(-' + offset + 'px)';
                        void track.offsetHeight;
                        track.style.transition = previousTransition || 'transform 0.6s ease';
                    } else {
                        track.style.transition = 'transform 0.6s ease';
                        track.style.transform = 'translateY(-' + offset + 'px)';
                    }
                };

                var schedule = function (callback, delay) {
                    window.clearTimeout(timerId);
                    timerId = window.setTimeout(callback, delay);
                };

                var resetText = function (textEl) {
                    textEl.style.transition = 'none';
                    textEl.style.transform = 'translateX(0px)';
                    void textEl.offsetWidth;
                    textEl.style.transition = 'transform 0.8s ease';
                };

                var prepareText = function (item) {
                    var textEl = item.querySelector('.hero-headline-text');
                    if (!textEl) {
                        return { positions: [] };
                    }

                    resetText(textEl);

                    var viewportWidth = viewport.clientWidth;
                    var textWidth = textEl.scrollWidth;

                    if (textWidth <= viewportWidth + 1) {
                        return { positions: [], element: textEl };
                    }

                    var maxOffset = textWidth - viewportWidth;
                    var stepWidth = viewportWidth;
                    var stepPositions = [];
                    var current = 0;
                    while (current < maxOffset) {
                        current = Math.min(current + stepWidth, maxOffset);
                        stepPositions.push(current);
                    }

                    return { positions: stepPositions, element: textEl };
                };

                var playHorizontalShift = function () {
                    positionIndex++;
                    if (positionIndex >= positions.length) {
                        schedule(nextHeadline, interval);
                        return;
                    }

                    var item = items[currentIndex];
                    var textEl = item.querySelector('.hero-headline-text');
                    if (!textEl) {
                        schedule(nextHeadline, interval);
                        return;
                    }

                    textEl.style.transform = 'translateX(-' + positions[positionIndex] + 'px)';
                    schedule(playHorizontalShift, interval);
                };

                var nextHeadline = function () {
                    var nextIndex = (currentIndex + 1) % items.length;
                    showHeadline(nextIndex);
                };

                var showHeadline = function (index, options) {
                    options = options || {};
                    currentIndex = index;

                    items.forEach(function (item, itemIndex) {
                        var textEl = item.querySelector('.hero-headline-text');
                        if (textEl && itemIndex !== index) {
                            resetText(textEl);
                        }
                        item.classList.toggle('is-active', itemIndex === index);
                    });

                    setTrackPosition(index, !options.instant);

                    var meta = prepareText(items[index]);
                    positions = meta.positions;
                    positionIndex = -1;

                    if (positions.length === 0) {
                        schedule(nextHeadline, interval);
                    } else {
                        schedule(playHorizontalShift, interval);
                    }
                };

                window.addEventListener('resize', function () {
                    window.clearTimeout(timerId);
                    showHeadline(currentIndex, { instant: true });
                });

                showHeadline(0, { instant: true });
            });
        </script>
        <?php
    },
]);





