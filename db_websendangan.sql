-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Waktu pembuatan: 05 Nov 2025 pada 04.37
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_websendangan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_nama` varchar(100) NOT NULL,
  `admin_password` varchar(255) NOT NULL,
  `admin_no_hp` varchar(15) DEFAULT NULL,
  `admin_email` varchar(100) DEFAULT NULL,
  `admin_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `admin_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `admin_is_deleted` smallint(6) DEFAULT 0,
  `admin_is_superadmin` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_nama`, `admin_password`, `admin_no_hp`, `admin_email`, `admin_created_at`, `admin_updated_at`, `admin_is_deleted`, `admin_is_superadmin`) VALUES
(1, 'Superadmin', '$2y$10$nwEoy3th6k2Si7.tGzV7j.qkv3cqpUJ97fhG3DIp1N1pU6.ExWVyG', '082325960260', 'yeftakun34@gmail.com', '2025-11-03 01:03:44', '2025-11-04 23:11:27', 0, 1),
(3, 'Yefta', '$2y$10$nwEoy3th6k2Si7.tGzV7j.qkv3cqpUJ97fhG3DIp1N1pU6.ExWVyG', '085775471308', 'yeftaasyel026@student.unsrat.ac.id', '2025-11-05 01:03:47', '2025-11-05 02:51:46', 1, 0),
(4, 'Shiroko', '$2y$10$fxg.FgRsePsu3XoIEYW1ZezFNQgKXCrCbk6T/YLsTfpgBKvArBMm2', NULL, 'shironeko34@gmail.com', '2025-11-05 01:50:03', '2025-11-05 01:50:03', 0, 0),
(5, 'Asyel', '$2y$10$SfOJMkZr/lABisA1ap8tp.WEDDJI0AEbWl8U/RO3FdpXoGSz2DLh2', NULL, 'admin@gmail.com', '2025-11-05 02:09:52', '2025-11-05 02:09:52', 0, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `apbdes`
--

CREATE TABLE `apbdes` (
  `apbdes_id` int(11) NOT NULL,
  `apbdes_judul` varchar(255) NOT NULL,
  `apbdes_file` varchar(255) NOT NULL,
  `apbdes_edited_by` varchar(100) DEFAULT NULL,
  `apbdes_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `apbdes_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `berita`
--

CREATE TABLE `berita` (
  `berita_id` int(11) NOT NULL,
  `berita_judul` varchar(255) NOT NULL,
  `berita_isi` text NOT NULL,
  `berita_gambar` varchar(255) DEFAULT NULL,
  `berita_dilihat` int(11) DEFAULT 0,
  `berita_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `berita_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `berita`
--

INSERT INTO `berita` (`berita_id`, `berita_judul`, `berita_isi`, `berita_gambar`, `berita_dilihat`, `berita_created_at`, `berita_updated_at`) VALUES
(4, 'Test Berita 1', 'dasdas sdasda dasdasdasdas dasdasdas dasdasdasdsa dasdsa dsad asd asddsadasd asdasd', 'berita_690897b6383957.34743644.webp', 3, '2025-11-03 11:53:26', '2025-11-04 14:45:14'),
(5, 'OK', 'dsadas', 'berita_69089b500cb604.41501677.webp', 3, '2025-11-03 12:08:48', '2025-11-04 14:45:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data`
--

CREATE TABLE `data` (
  `data_key` varchar(255) NOT NULL,
  `data_value` text NOT NULL,
  `data_type` enum('string','integer','float','boolean','date') NOT NULL DEFAULT 'string',
  `data_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `data_updated_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `data`
--

INSERT INTO `data` (`data_key`, `data_value`, `data_type`, `data_updated_at`, `data_updated_by`) VALUES
('demografi.jaga_1_laki', '74', 'integer', '2025-11-04 21:35:14', 'Superadmin'),
('demografi.jaga_1_perempuan', '78', 'integer', '2025-11-02 19:21:55', NULL),
('demografi.jaga_2_laki', '98', 'integer', '2025-11-02 19:21:55', NULL),
('demografi.jaga_2_perempuan', '102', 'integer', '2025-11-02 19:21:55', NULL),
('demografi.jumlah_jaga', '2', 'integer', '2025-11-04 20:31:59', 'Superadmin'),
('demografi.kepala_keluarga', '137', 'integer', '2025-11-02 19:21:55', NULL),
('demografi.luas_wilayah_ha', '103', 'integer', '2025-11-02 19:21:55', NULL),
('greeting.hukum_tua', 'Sebagai Hukum Tua Desa Sendangan, saya mengucapkan selamat datang di platform resmi desa kami. Website ini hadir sebagai upaya untuk mempermudah masyarakat dalam mengakses berbagai informasi penting terkait Desa Sendangan. Saya selaku Hukum Tua Desa berkomitmen untuk terus mendorong kemajuan dan pembangunan digital, guna menciptakan pelayanan yang lebih baik dan transparan bagi seluruh warga desa. Semoga website ini dapat menjadi sarana yang efektif dalam mempererat hubungan dan komunikasi antara pemerintah desa dan masyarakat.  Terima kasih atas partisipasi dan dukungan Anda dalam membangun Desa Sendangan yang lebih maju.', 'string', '2025-11-04 21:20:47', 'Superadmin'),
('kontak.email_desa', 'abc123@example.com', 'string', '2025-11-04 21:21:29', 'Superadmin'),
('kontak.telepon_desa', '+628xxxx', 'string', '2025-11-05 02:42:05', 'Superadmin'),
('media.hukum_tua_foto', 'hukumtua_690a76bba64901.35923132.webp', 'string', '2025-11-04 21:57:15', 'Superadmin'),
('media.peta_desa_sendangan', 'peta-desa-sendangan.jpg', 'string', '2025-11-02 19:21:55', NULL),
('media.peta_desa_sendangan_citra', 'peta-desa-sendangan-citra.jpg', 'string', '2025-11-02 20:58:56', NULL),
('profile.hukum_tua_nama', 'Deske Kaawoan', 'string', '2025-11-04 21:09:50', 'Superadmin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `fasilitas`
--

CREATE TABLE `fasilitas` (
  `fasilitas_id` int(11) NOT NULL,
  `fasilitas_nama` varchar(255) NOT NULL,
  `fasilitas_gambar` varchar(255) DEFAULT NULL,
  `fasilitas_gmaps_link` varchar(255) DEFAULT NULL,
  `fasilitas_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `fasilitas_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `fasilitas`
--

INSERT INTO `fasilitas` (`fasilitas_id`, `fasilitas_nama`, `fasilitas_gambar`, `fasilitas_gmaps_link`, `fasilitas_created_at`, `fasilitas_updated_at`) VALUES
(1, 'GMIM Efata Sentrum Tompaso', 'fasilitas_6908a3f12dc512.42697311.webp', 'https://maps.app.goo.gl/GZMYwsXLRvdcKBZX9', '2025-11-03 12:45:37', '2025-11-03 13:03:06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `galeri`
--

CREATE TABLE `galeri` (
  `galeri_id` int(11) NOT NULL,
  `galeri_keterangan` text DEFAULT NULL,
  `galeri_gambar` varchar(50) DEFAULT NULL,
  `galeri_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `galeri`
--

INSERT INTO `galeri` (`galeri_id`, `galeri_keterangan`, `galeri_gambar`, `galeri_created_at`) VALUES
(2, 'dasddasdsad', 'galeri_690a43531b3ef7.60756853.webp', '2025-11-04 18:17:55'),
(3, 'dad', 'galeri_690a47f1c91de6.40770175.webp', '2025-11-04 18:37:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `gambar_potensi_desa`
--

CREATE TABLE `gambar_potensi_desa` (
  `gambar_id` int(11) NOT NULL,
  `potensi_id` int(11) DEFAULT NULL,
  `gambar_namafile` varchar(255) NOT NULL,
  `gambar_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `gambar_potensi_desa`
--

INSERT INTO `gambar_potensi_desa` (`gambar_id`, `potensi_id`, `gambar_namafile`, `gambar_created_at`) VALUES
(11, 3, 'potensi_690991d28f9194.84766867.webp', '2025-11-04 05:40:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengumuman`
--

CREATE TABLE `pengumuman` (
  `pengumuman_id` int(11) NOT NULL,
  `pengumuman_isi` text NOT NULL,
  `pengumuman_valid_hingga` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pengumuman_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `pengumuman_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengumuman`
--

INSERT INTO `pengumuman` (`pengumuman_id`, `pengumuman_isi`, `pengumuman_valid_hingga`, `pengumuman_created_at`, `pengumuman_updated_at`) VALUES
(2, 'dasdsddsd dasdsad asddasdsd', '2025-11-02 12:46:00', '2025-11-04 11:08:06', '2025-11-04 12:46:20'),
(3, 'adssdad', '2025-11-02 12:46:00', '2025-11-04 12:19:41', '2025-11-04 12:46:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `permohonan_informasi`
--

CREATE TABLE `permohonan_informasi` (
  `pi_id` int(11) NOT NULL,
  `pi_isi_permintaan` text NOT NULL,
  `pi_email` varchar(100) DEFAULT NULL,
  `pi_asal_instansi` varchar(255) DEFAULT NULL,
  `pi_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `pi_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pi_selesai` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `potensi_desa`
--

CREATE TABLE `potensi_desa` (
  `potensi_id` int(11) NOT NULL,
  `potensi_judul` varchar(255) NOT NULL,
  `potensi_isi` text NOT NULL,
  `potensi_kategori` enum('Wisata','Budaya','Kuliner','UMKM') NOT NULL,
  `potensi_gmaps_link` varchar(255) DEFAULT NULL,
  `potensi_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `potensi_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `potensi_desa`
--

INSERT INTO `potensi_desa` (`potensi_id`, `potensi_judul`, `potensi_isi`, `potensi_kategori`, `potensi_gmaps_link`, `potensi_created_at`, `potensi_updated_at`) VALUES
(1, 'Test', 'asdasd', 'Budaya', 'https://github.com', '2025-11-03 22:42:53', '2025-11-03 22:42:53'),
(3, 'dasdad fasdad', 'dasdasdsd', 'UMKM', 'sdadas', '2025-11-04 05:39:50', '2025-11-04 05:39:50'),
(4, 'dasdasdasd', 'asdasd', 'UMKM', 'dasdsa', '2025-11-04 05:40:05', '2025-11-04 05:40:05'),
(5, 'dasd', 'dsad', 'Wisata', 'dasd', '2025-11-04 05:48:31', '2025-11-04 05:48:31'),
(6, 'fasdfsaf', 'fsdf', 'Wisata', 'fsdf', '2025-11-04 06:53:44', '2025-11-04 06:53:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ppid_dokumen`
--

CREATE TABLE `ppid_dokumen` (
  `ppid_id` int(11) NOT NULL,
  `ppid_judul` varchar(255) NOT NULL,
  `ppid_namafile` varchar(255) NOT NULL,
  `ppid_kategori` varchar(100) DEFAULT NULL,
  `ppid_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ppid_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ppid_pi_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `program_desa`
--

CREATE TABLE `program_desa` (
  `program_id` int(11) NOT NULL,
  `program_nama` varchar(255) NOT NULL,
  `program_deskripsi` text NOT NULL,
  `program_gambar` varchar(255) DEFAULT NULL,
  `program_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `program_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `program_desa`
--

INSERT INTO `program_desa` (`program_id`, `program_nama`, `program_deskripsi`, `program_gambar`, `program_created_at`, `program_updated_at`) VALUES
(1, 'dasdasda', 'dsadasd', 'program_690a2f978b1217.83818026.webp', '2025-11-04 16:53:44', '2025-11-04 16:53:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `struktur_organisasi`
--

CREATE TABLE `struktur_organisasi` (
  `struktur_id` int(11) NOT NULL,
  `struktur_nama` varchar(255) NOT NULL,
  `struktur_jabatan` varchar(100) NOT NULL,
  `struktur_foto` varchar(255) DEFAULT NULL,
  `struktur_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `struktur_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `struktur_organisasi`
--

INSERT INTO `struktur_organisasi` (`struktur_id`, `struktur_nama`, `struktur_jabatan`, `struktur_foto`, `struktur_created_at`, `struktur_updated_at`) VALUES
(1, 'dasdsa', 'dasd', NULL, '2025-11-04 18:54:40', '2025-11-04 18:54:40'),
(2, 'dasd', 'dasdsad', 'struktur_690a4bf843db77.67641947.webp', '2025-11-04 18:54:48', '2025-11-04 18:54:48');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_no_hp` (`admin_no_hp`),
  ADD UNIQUE KEY `admin_email` (`admin_email`);

--
-- Indeks untuk tabel `apbdes`
--
ALTER TABLE `apbdes`
  ADD PRIMARY KEY (`apbdes_id`);

--
-- Indeks untuk tabel `berita`
--
ALTER TABLE `berita`
  ADD PRIMARY KEY (`berita_id`);

--
-- Indeks untuk tabel `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`data_key`);

--
-- Indeks untuk tabel `fasilitas`
--
ALTER TABLE `fasilitas`
  ADD PRIMARY KEY (`fasilitas_id`);

--
-- Indeks untuk tabel `galeri`
--
ALTER TABLE `galeri`
  ADD PRIMARY KEY (`galeri_id`);

--
-- Indeks untuk tabel `gambar_potensi_desa`
--
ALTER TABLE `gambar_potensi_desa`
  ADD PRIMARY KEY (`gambar_id`),
  ADD KEY `potensi_id` (`potensi_id`);

--
-- Indeks untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`pengumuman_id`);

--
-- Indeks untuk tabel `permohonan_informasi`
--
ALTER TABLE `permohonan_informasi`
  ADD PRIMARY KEY (`pi_id`);

--
-- Indeks untuk tabel `potensi_desa`
--
ALTER TABLE `potensi_desa`
  ADD PRIMARY KEY (`potensi_id`);

--
-- Indeks untuk tabel `ppid_dokumen`
--
ALTER TABLE `ppid_dokumen`
  ADD PRIMARY KEY (`ppid_id`),
  ADD KEY `ppid_pi_id` (`ppid_pi_id`);

--
-- Indeks untuk tabel `program_desa`
--
ALTER TABLE `program_desa`
  ADD PRIMARY KEY (`program_id`);

--
-- Indeks untuk tabel `struktur_organisasi`
--
ALTER TABLE `struktur_organisasi`
  ADD PRIMARY KEY (`struktur_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `apbdes`
--
ALTER TABLE `apbdes`
  MODIFY `apbdes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `berita`
--
ALTER TABLE `berita`
  MODIFY `berita_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `fasilitas`
--
ALTER TABLE `fasilitas`
  MODIFY `fasilitas_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `galeri`
--
ALTER TABLE `galeri`
  MODIFY `galeri_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `gambar_potensi_desa`
--
ALTER TABLE `gambar_potensi_desa`
  MODIFY `gambar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `pengumuman_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `permohonan_informasi`
--
ALTER TABLE `permohonan_informasi`
  MODIFY `pi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `potensi_desa`
--
ALTER TABLE `potensi_desa`
  MODIFY `potensi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `ppid_dokumen`
--
ALTER TABLE `ppid_dokumen`
  MODIFY `ppid_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `program_desa`
--
ALTER TABLE `program_desa`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `struktur_organisasi`
--
ALTER TABLE `struktur_organisasi`
  MODIFY `struktur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `gambar_potensi_desa`
--
ALTER TABLE `gambar_potensi_desa`
  ADD CONSTRAINT `gambar_potensi_desa_ibfk_1` FOREIGN KEY (`potensi_id`) REFERENCES `potensi_desa` (`potensi_id`);

--
-- Ketidakleluasaan untuk tabel `ppid_dokumen`
--
ALTER TABLE `ppid_dokumen`
  ADD CONSTRAINT `ppid_dokumen_ibfk_1` FOREIGN KEY (`ppid_pi_id`) REFERENCES `permohonan_informasi` (`pi_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
