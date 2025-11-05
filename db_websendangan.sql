-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Waktu pembuatan: 05 Nov 2025 pada 04.16
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
-- Database: `absensi_db`
--
CREATE DATABASE IF NOT EXISTS `absensi_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `absensi_db`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `attendance_sessions`
--

CREATE TABLE `attendance_sessions` (
  `as_id` int(11) NOT NULL,
  `as_name` varchar(200) NOT NULL,
  `as_type` enum('class','event') NOT NULL,
  `as_start_time` timestamp NULL DEFAULT NULL,
  `as_end_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `number_of_student` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `attendance_sessions`
--

INSERT INTO `attendance_sessions` (`as_id`, `as_name`, `as_type`, `as_start_time`, `as_end_time`, `created_at`, `updated_at`, `number_of_student`) VALUES
(27, 'Matematika', 'class', '2025-06-10 23:20:00', '2025-06-11 15:40:00', '2025-06-11 12:48:38', '2025-06-11 12:48:38', 10),
(28, 'Sosialisasi Unsrat', 'class', '2025-06-11 01:50:00', '2025-06-11 13:51:00', '2025-06-11 12:51:17', '2025-06-11 12:51:17', 10),
(29, 'rd4dr4', 'class', '2025-06-15 22:03:00', '2025-06-15 23:03:00', '2025-06-15 22:03:38', '2025-06-15 22:03:51', 44),
(30, 'Pembekalan KKT', 'event', '2025-10-03 03:58:00', '2025-10-03 05:58:00', '2025-10-03 03:58:17', '2025-10-03 03:58:17', 100),
(31, 'Matematika Pertemuan 2', 'class', '2025-10-03 04:00:00', '2025-10-03 08:00:00', '2025-10-03 03:58:44', '2025-10-03 04:15:19', 30);

-- --------------------------------------------------------

--
-- Struktur dari tabel `parents`
--

CREATE TABLE `parents` (
  `parent_id` int(11) NOT NULL,
  `parent_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `parents`
--

INSERT INTO `parents` (`parent_id`, `parent_name`, `created_at`, `updated_at`, `user_id`) VALUES
(16, 'Orang Tua 1', '2025-05-20 05:48:35', '2025-05-20 05:48:35', 32),
(17, 'Orang Tua 2', '2025-05-20 05:48:51', '2025-05-20 05:48:51', 33);

-- --------------------------------------------------------

--
-- Struktur dari tabel `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `nis` varchar(50) NOT NULL,
  `nisn` varchar(50) NOT NULL,
  `student_name` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `pob` varchar(50) NOT NULL,
  `photo_path` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `rfid` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `students`
--

INSERT INTO `students` (`student_id`, `nis`, `nisn`, `student_name`, `dob`, `pob`, `photo_path`, `address`, `rfid`, `created_at`, `updated_at`, `user_id`, `parent_id`) VALUES
(23, '22', '2', 'Budi', '2025-05-20', 'N/A', '1749646368452_59.webp', 'N/A', NULL, '2025-05-20 06:20:05', '2025-06-11 12:52:48', 34, 17),
(24, '3', '3', 'Siswa 1', '2025-05-20', 'N/A', 'default/default.jpg', 'N/A', '2C 7C D7 00', '2025-05-20 06:44:26', '2025-05-20 07:19:18', 35, NULL),
(28, '2131', '2131', 'Yefta Asyel', '2004-10-03', 'Manado', 'default/default.jpg', 'Manado', 'BD C6 5E 21', '2025-10-03 04:14:36', '2025-10-03 04:14:36', 29, 16);

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_attendances`
--

CREATE TABLE `student_attendances` (
  `sa_id` int(11) NOT NULL,
  `sa_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `sa_photo_path` varchar(200) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `as_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `pos` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `student_attendances`
--

INSERT INTO `student_attendances` (`sa_id`, `sa_time`, `sa_photo_path`, `updated_at`, `as_id`, `student_id`, `pos`) VALUES
(118, '2025-06-11 12:50:14', '1749646214670_41.jpg', '2025-06-11 12:50:14', 27, 24, 'Pos A'),
(120, '2025-06-11 12:51:33', '1749646293681_73.jpg', '2025-06-11 12:51:33', 28, 24, 'Pos A'),
(123, '2025-06-15 22:06:44', '1750025204259_40.jpg', '2025-06-15 22:06:44', 29, 24, 'Pos A'),
(129, '2025-10-03 04:16:50', '1759465010725_13.jpg', '2025-10-03 04:16:50', 30, 28, 'Pos A'),
(130, '2025-10-03 04:17:01', '1759465021577_48.jpg', '2025-10-03 04:17:01', 30, 24, 'Pos A'),
(131, '2025-10-03 04:17:43', '1759465063544_58.jpg', '2025-10-03 04:17:43', 31, 28, 'Pos A'),
(132, '2025-10-03 04:17:45', '1759465065898_58.jpg', '2025-10-03 04:17:45', 31, 24, 'Pos A');

-- --------------------------------------------------------

--
-- Struktur dari tabel `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `teacher_name` varchar(50) NOT NULL,
  `nip` varchar(50) DEFAULT NULL,
  `photo_path` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `teacher_name`, `nip`, `photo_path`, `created_at`, `updated_at`, `user_id`) VALUES
(25, 'Guru 1', '-', 'default/default.jpg', '2025-05-20 05:48:08', '2025-05-20 05:48:08', 30),
(26, 'Guru 2', '-', 'default/default.jpg', '2025-05-20 05:48:21', '2025-05-20 05:48:21', 31);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `role` enum('admin','teacher','parent','student','scanner') NOT NULL,
  `wa_num` varchar(20) NOT NULL,
  `is_online` tinyint(1) DEFAULT 0,
  `last_active` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `created_at`, `updated_at`, `role`, `wa_num`, `is_online`, `last_active`) VALUES
(28, 'admin', '$2b$10$o0fg8kyABCvoJobh/JE1bedg/WSK/cQJdeO3D.6FCRiIdk0Al0jAO', 'admin@example.com', '2025-05-20 05:05:18', '2025-05-20 05:05:18', 'admin', '081234567890', 0, NULL),
(29, 'yeftaasyel', '$2b$10$7JIdK.5gkCAGixFtDyzgJu2wv5Uv3Fj1XLbK7/03woFiwfctIs4Iq', 'N/A', '2025-05-20 05:06:20', '2025-05-20 05:06:20', 'student', '6282325960260', 0, NULL),
(30, 'guru1', '$2b$10$1Y88L50UdijahJzEGY7IbuM.T9eHG9YUOv31A48uixEp44ZV7NfoS', 'N/A', '2025-05-20 05:46:04', '2025-05-20 05:46:40', 'teacher', '1', 0, NULL),
(31, 'guru2', '$2b$10$nALy/g.Nt.AsNiNt8eMBv.d89HdGQn5JEg542BlkuumKgriBGjg6G', 'N/A', '2025-05-20 05:46:51', '2025-05-20 05:46:51', 'teacher', '2', 0, NULL),
(32, 'orangtua1', '$2b$10$P89cryj7vy2D5HH1fiObGe6JmiFnq3XK1s7hM0OoGBUIz5L6s5xe.', 'N/A', '2025-05-20 05:47:19', '2025-05-20 05:47:19', 'parent', '6285775471308', 0, NULL),
(33, 'orangtua2', '$2b$10$9ABPNJrc1TMBrGyT/Mn6X.sydzaGH9dHB35m6aiPXYTrvm7d4rBQW', 'N/A', '2025-05-20 05:47:43', '2025-05-20 05:47:43', 'parent', '3', 0, NULL),
(34, 'budi', '$2b$10$RV5rQj/.BAtYIy7xtaOsp.R8dNk.apFPfUt44L0c3DR61exGy7CxK', 'N/A', '2025-05-20 05:52:48', '2025-05-20 05:52:48', 'student', '4', 0, NULL),
(35, 'siswa1', '$2b$10$9K1XdgzsgMz5zPLnZQRTPe0oV.aynUEkeLH7qlHF6VQZjqBuy9iIm', 'N/A', '2025-05-20 06:43:12', '2025-05-20 06:43:12', 'student', '5', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `attendance_sessions`
--
ALTER TABLE `attendance_sessions`
  ADD PRIMARY KEY (`as_id`);

--
-- Indeks untuk tabel `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`parent_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `nis` (`nis`),
  ADD UNIQUE KEY `nisn` (`nisn`),
  ADD UNIQUE KEY `rfid` (`rfid`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indeks untuk tabel `student_attendances`
--
ALTER TABLE `student_attendances`
  ADD PRIMARY KEY (`sa_id`),
  ADD KEY `as_id` (`as_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indeks untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `attendance_sessions`
--
ALTER TABLE `attendance_sessions`
  MODIFY `as_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT untuk tabel `parents`
--
ALTER TABLE `parents`
  MODIFY `parent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `student_attendances`
--
ALTER TABLE `student_attendances`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT untuk tabel `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `parents`
--
ALTER TABLE `parents`
  ADD CONSTRAINT `parents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`parent_id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `student_attendances`
--
ALTER TABLE `student_attendances`
  ADD CONSTRAINT `student_attendances_ibfk_1` FOREIGN KEY (`as_id`) REFERENCES `attendance_sessions` (`as_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_attendances_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;
--
-- Database: `absen_kppm`
--
CREATE DATABASE IF NOT EXISTS `absen_kppm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `absen_kppm`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `absen`
--

CREATE TABLE `absen` (
  `id_absen` int(11) NOT NULL,
  `id_peserta` int(11) DEFAULT NULL,
  `id_sesi` int(11) DEFAULT NULL,
  `waktu_absen` datetime DEFAULT NULL,
  `via_admin` varchar(255) DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peserta`
--

CREATE TABLE `peserta` (
  `id_peserta` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `hotel` varchar(100) DEFAULT NULL,
  `ketua_rombongan` varchar(100) DEFAULT NULL,
  `status` enum('pk','pu','lain') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sesi`
--

CREATE TABLE `sesi` (
  `id_sesi` int(11) NOT NULL,
  `nama_sesi` varchar(100) DEFAULT NULL,
  `waktu_mulai` datetime DEFAULT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `target` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `absen`
--
ALTER TABLE `absen`
  ADD PRIMARY KEY (`id_absen`),
  ADD KEY `id_peserta` (`id_peserta`),
  ADD KEY `id_sesi` (`id_sesi`);

--
-- Indeks untuk tabel `peserta`
--
ALTER TABLE `peserta`
  ADD PRIMARY KEY (`id_peserta`);

--
-- Indeks untuk tabel `sesi`
--
ALTER TABLE `sesi`
  ADD PRIMARY KEY (`id_sesi`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `absen`
--
ALTER TABLE `absen`
  MODIFY `id_absen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `peserta`
--
ALTER TABLE `peserta`
  MODIFY `id_peserta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sesi`
--
ALTER TABLE `sesi`
  MODIFY `id_sesi` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `absen`
--
ALTER TABLE `absen`
  ADD CONSTRAINT `absen_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `peserta` (`id_peserta`),
  ADD CONSTRAINT `absen_ibfk_2` FOREIGN KEY (`id_sesi`) REFERENCES `sesi` (`id_sesi`);
--
-- Database: `booking_room`
--
CREATE DATABASE IF NOT EXISTS `booking_room` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `booking_room`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking`
--

CREATE TABLE `booking` (
  `bk_id` int(11) NOT NULL,
  `bk_user_id` int(11) NOT NULL,
  `bk_room_id` int(11) NOT NULL,
  `bk_start_time` datetime NOT NULL,
  `bk_end_time` datetime NOT NULL,
  `bk_name` varchar(100) NOT NULL,
  `bk_desc` text NOT NULL,
  `bk_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `bk_approved_by` int(11) DEFAULT NULL,
  `bk_approved_at` timestamp NULL DEFAULT NULL,
  `bk_rejection_reason` text DEFAULT NULL,
  `bk_softdel` smallint(1) DEFAULT 0,
  `bk_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `bk_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `booking`
--

INSERT INTO `booking` (`bk_id`, `bk_user_id`, `bk_room_id`, `bk_start_time`, `bk_end_time`, `bk_name`, `bk_desc`, `bk_status`, `bk_approved_by`, `bk_approved_at`, `bk_rejection_reason`, `bk_softdel`, `bk_created_at`, `bk_updated_at`) VALUES
(1, 2, 1, '2025-08-09 09:00:00', '2025-08-09 10:00:00', 'Meeting Tim Teknik', 'Rapat evaluasi proyek pembangkit listrik bulan Juli', 'approved', 1, '2025-08-09 12:50:02', NULL, 0, '2025-08-08 19:44:29', '2025-08-09 12:50:02'),
(2, 3, 2, '2025-08-09 14:00:00', '2025-08-09 15:00:00', 'Presentasi Proposal', 'Presentasi proposal modernisasi jaringan distribusi', 'approved', 1, '2025-08-08 08:45:00', NULL, 0, '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(3, 4, 4, '2025-08-09 10:00:00', '2025-08-09 13:00:00', 'Rapat Evaluasi Kinerja', 'Evaluasi kinerja semester pertama 2025', 'approved', 1, '2025-08-08 03:20:00', NULL, 0, '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(4, 5, 3, '2025-08-09 16:00:00', '2025-08-09 17:30:00', 'Meeting dengan Vendor', 'Diskusi kontrak pemeliharaan peralatan', 'approved', 1, '2025-08-09 12:50:12', NULL, 0, '2025-08-08 19:44:29', '2025-08-09 12:50:12'),
(5, 2, 2, '2025-08-10 08:00:00', '2025-08-10 09:32:00', 'Daily Standup', 'Meeting harian tim pengembangan sistem', 'approved', 1, '2025-08-09 14:12:28', '', 0, '2025-08-08 19:44:29', '2025-08-09 14:12:28'),
(6, 3, 1, '2025-08-10 13:00:00', '2025-08-10 15:00:00', 'Workshop Keselamatan', 'Workshop safety procedure untuk teknisi lapangan', 'approved', 1, '2025-08-09 13:45:41', NULL, 0, '2025-08-08 19:44:29', '2025-08-09 13:45:41'),
(7, 4, 6, '2025-08-10 09:00:00', '2025-08-10 17:00:00', 'Training Sistem Baru', 'Pelatihan penggunaan sistem informasi terintegrasi', 'approved', 1, '2025-08-10 19:11:44', '', 0, '2025-08-08 19:44:29', '2025-08-10 19:11:44'),
(8, 5, 5, '2025-08-10 10:30:00', '2025-08-10 11:30:00', 'Brainstorming Session', 'Diskusi ide inovasi untuk efisiensi operasional', 'approved', 1, '2025-08-09 02:45:00', NULL, 1, '2025-08-08 19:44:29', '2025-08-10 19:47:39'),
(9, 2, 7, '2025-08-11 14:00:00', '2025-08-11 15:00:00', 'Board Meeting', 'Rapat dewan direksi bulanan', 'approved', 1, '2025-08-09 14:09:44', NULL, 0, '2025-08-08 19:44:29', '2025-08-09 14:09:44'),
(10, 3, 4, '2025-08-12 09:00:00', '2025-08-12 12:00:00', 'Seminar Internal', 'Seminar teknologi terbaru di bidang kelistrikan', 'rejected', 1, '2025-08-13 12:14:44', '', 0, '2025-08-08 19:44:29', '2025-08-13 12:14:44'),
(11, 5, 3, '2025-08-09 07:00:00', '2025-08-09 08:30:00', 'Meeting Personal', 'Diskusi masalah pribadi dengan atasan', 'rejected', 1, '2025-08-08 05:15:00', NULL, 0, '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(12, 2, 1, '2025-08-10 14:00:00', '2025-08-10 16:00:00', 'Video Call Client', 'Meeting online dengan klien internasional', 'approved', 1, '2025-08-09 13:58:53', NULL, 1, '2025-08-08 19:44:29', '2025-09-28 09:35:51'),
(13, 1, 7, '2025-08-09 09:01:00', '2025-08-09 10:30:00', 'aaa', 'aaa', 'approved', 1, '2025-08-09 12:47:45', NULL, 0, '2025-08-09 02:01:49', '2025-08-09 12:47:45'),
(14, 1, 5, '2025-08-09 08:06:00', '2025-08-09 08:58:00', '111', '111', 'approved', 1, '2025-08-09 06:32:54', NULL, 1, '2025-08-09 02:07:19', '2025-08-10 19:47:39'),
(15, 1, 1, '2025-08-09 15:30:00', '2025-08-09 16:30:00', 'Test Booking Auto', 'Test booking untuk debugging', 'approved', 1, '2025-08-09 12:47:45', NULL, 0, '2025-08-09 02:15:34', '2025-08-09 12:47:45'),
(16, 1, 2, '2025-08-09 17:00:00', '2025-08-09 17:15:00', 'Admin Test Booking', 'Test auto approve', 'approved', 1, '2025-08-09 12:47:45', NULL, 1, '2025-08-09 02:32:17', '2025-09-28 13:14:51'),
(17, 2, 2, '2025-08-09 18:00:00', '2025-08-09 19:00:00', 'User Test Booking', 'Test pending', 'rejected', 1, '2025-08-09 12:50:29', '', 0, '2025-08-09 02:32:17', '2025-08-09 12:50:29'),
(18, 1, 2, '2025-08-09 09:00:00', '2025-08-09 10:00:00', 'aaa', 'aaa', 'approved', NULL, NULL, NULL, 1, '2025-08-09 02:35:31', '2025-10-01 23:45:30'),
(19, 1, 1, '2025-08-10 09:00:00', '2025-08-10 10:30:00', 'Admin Test Booking', 'Test auto-approval untuk admin', 'rejected', 1, '2025-08-09 14:14:30', '', 0, '2025-08-09 06:44:06', '2025-08-09 14:14:30'),
(20, 6, 1, '2025-08-10 11:00:00', '2025-08-10 12:30:00', 'Superadmin Test Booking', 'Test auto-approval untuk superadmin', 'approved', 6, '2025-08-09 00:44:06', NULL, 0, '2025-08-09 06:44:06', '2025-08-09 06:44:06'),
(21, 1, 1, '2025-08-09 13:00:00', '2025-08-09 14:02:00', 'ABC', 'sdadsad', 'approved', 1, '2025-08-09 12:47:45', NULL, 1, '2025-08-09 07:02:59', '2025-09-28 13:50:32'),
(22, 1, 7, '2025-08-09 19:00:00', '2025-08-09 21:00:00', 'aaaaaaaaa', 'aaasdaddsd', 'approved', 1, '2025-08-09 12:47:45', NULL, 1, '2025-08-09 12:24:26', '2025-09-28 12:27:54'),
(23, 2, 1, '2025-08-10 19:00:00', '2025-08-10 20:00:00', 'Test Edit Booking (Updated by User)', 'Updated by regular user - should go to pending', 'pending', NULL, NULL, NULL, 1, '2025-08-09 12:30:29', '2025-08-09 12:30:29'),
(24, 2, 1, '2025-08-10 19:00:00', '2025-08-10 20:00:00', 'Test Edit Booking (Updated by User)', 'Updated by regular user - should go to pending', 'pending', NULL, NULL, NULL, 1, '2025-08-09 12:30:58', '2025-08-09 12:30:58'),
(25, 2, 5, '2025-08-10 14:37:00', '2025-08-10 15:37:00', 'dsad', 'dasd', 'rejected', 1, '2025-08-09 13:59:15', '', 1, '2025-08-09 12:37:29', '2025-08-10 19:47:39'),
(26, 2, 1, '2025-08-10 06:00:00', '2025-08-10 07:00:00', 'Test Pending Management', 'Test booking untuk pending management', 'approved', 1, '2025-08-09 12:46:24', NULL, 1, '2025-08-09 12:46:24', '2025-08-09 12:46:24'),
(27, 2, 1, '2025-08-10 08:00:00', '2025-08-10 09:00:00', 'Test Pending Rejection', 'Test booking untuk rejection', 'rejected', 1, '2025-08-09 12:46:24', 'Testing rejection functionality', 1, '2025-08-09 12:46:24', '2025-08-09 12:46:24'),
(28, 2, 2, '2025-08-11 14:00:00', '2025-08-11 16:00:00', 'Workshop Anime', '...', 'rejected', 1, '2025-10-01 23:50:27', '', 1, '2025-08-11 04:28:03', '2025-10-01 23:50:39'),
(29, 1, 1, '2025-08-11 15:06:00', '2025-08-11 18:06:00', 'Event Workshop', 'Test', 'approved', 1, '2025-08-11 08:29:51', '', 1, '2025-08-11 08:17:50', '2025-10-02 02:25:15'),
(30, 2, 2, '2025-09-27 09:30:00', '2025-09-27 12:00:00', 'Pelatihan Karyawan PLN', 'Untuk seluruh perwakilan divisi', 'approved', 1, '2025-09-26 07:05:03', '', 0, '2025-09-26 01:34:04', '2025-09-26 07:05:03'),
(31, 2, 4, '2025-09-27 09:19:00', '2025-09-27 10:19:00', 'Test', 'aa', 'rejected', 1, '2025-09-26 07:20:24', '', 1, '2025-09-26 07:19:25', '2025-10-01 23:49:05'),
(32, 1, 1, '2025-09-28 11:30:00', '2025-09-28 12:30:00', 'AAB', 'aaaa', 'approved', 1, '2025-09-28 09:37:04', '', 1, '2025-09-28 09:33:23', '2025-09-28 12:27:44'),
(33, 2, 7, '2025-10-02 09:00:00', '2025-10-02 10:00:00', 'Test', 'Test', 'pending', NULL, NULL, NULL, 1, '2025-10-01 23:49:36', '2025-10-01 23:49:44'),
(34, 2, 4, '2025-10-02 11:00:00', '2025-10-02 12:00:00', 'Seminar PLN', '-', 'approved', 1, '2025-10-02 02:24:32', NULL, 0, '2025-10-02 02:23:21', '2025-10-02 02:24:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notification`
--

CREATE TABLE `notification` (
  `notif_id` int(11) NOT NULL,
  `notif_user_id` int(11) NOT NULL,
  `notif_booking_id` int(11) DEFAULT NULL,
  `notif_title` varchar(100) NOT NULL,
  `notif_message` text NOT NULL,
  `notif_read` smallint(1) DEFAULT 0,
  `notif_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `notification`
--

INSERT INTO `notification` (`notif_id`, `notif_user_id`, `notif_booking_id`, `notif_title`, `notif_message`, `notif_read`, `notif_created_at`) VALUES
(142, 1, 34, 'Booking Baru', 'Ada permintaan booking baru yang memerlukan persetujuan', 1, '2025-10-02 02:23:21'),
(143, 2, 34, 'Booking Disetujui', 'Booking \'Seminar PLN\' telah disetujui oleh admin', 1, '2025-10-02 02:24:32'),
(144, 1, 29, 'Booking Dibatalkan', 'Booking \'Event Workshop\' dibatalkan oleh Administrator', 1, '2025-10-02 02:25:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `room`
--

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(100) NOT NULL,
  `room_desc` text NOT NULL,
  `room_capacity` int(11) NOT NULL,
  `room_location` varchar(100) NOT NULL,
  `room_softdel` smallint(1) DEFAULT 0,
  `room_status` enum('available','disabled') DEFAULT 'available',
  `room_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `room_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `room`
--

INSERT INTO `room` (`room_id`, `room_name`, `room_desc`, `room_capacity`, `room_location`, `room_softdel`, `room_status`, `room_created_at`, `room_updated_at`) VALUES
(1, 'Ruang Meeting A', 'Ruang meeting standar dengan proyektor dan whiteboard untuk diskusi tim', 8, 'Lantai 2, Wing A', 0, 'available', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(2, 'Ruang Meeting B', 'Ruang meeting besar dengan fasilitas presentasi lengkap', 12, 'Lantai 2, Wing B', 0, 'available', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(3, 'Ruang Rapat Direksi', 'Ruang rapat eksekutif dengan fasilitas teleconference dan sound system', 6, 'Lantai 3, Executive Floor', 0, 'available', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(4, 'Ruang Presentasi', 'Ruang presentasi besar untuk acara dan seminar internal', 20, 'Lantai 1, Main Hall', 0, 'available', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(5, 'Ruang Diskusi', 'Ruang diskusi kecil untuk brainstorming dan meeting informal', 4, 'Lantai 2, Wing A', 1, 'available', '2025-08-08 19:44:29', '2025-08-10 19:47:39'),
(6, 'Ruang Training', 'Ruang pelatihan dengan kapasitas besar dan fasilitas multimedia', 25, 'Lantai 1, Training Center', 0, 'available', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(7, 'Ruang Board Room', 'Ruang rapat dewan dengan fasilitas premium dan privacy tinggi', 10, 'Lantai 4, Executive Suite', 0, 'available', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(8, 'Ruang Video Conference', 'Ruang khusus video conference dengan teknologi canggih', 8, 'Lantai 3, IT Center', 0, 'disabled', '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(9, 'Aula Mahesa', 'dsd', 122, '2aasd', 1, 'available', '2025-08-10 19:48:49', '2025-08-10 19:49:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_phone` varchar(15) NOT NULL,
  `user_role` enum('user','admin','superadmin') DEFAULT 'user',
  `user_softdel` smallint(1) DEFAULT 0,
  `user_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `name`, `user_email`, `user_password`, `user_phone`, `user_role`, `user_softdel`, `user_created_at`, `user_updated_at`) VALUES
(1, 'admin', 'Administrator', 'mradmin@pln.co.id', '$2y$10$F8tW2jIYAuiq9y7wk1HTBO8dkam7Q1gzsQPTNjmpNzOaSEu/nrtIS', '081234567890', 'admin', 0, '2025-08-08 19:44:29', '2025-10-01 23:52:12'),
(2, 'johndoe', 'John Doe', 'john.doe@pln.co.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567891', 'user', 0, '2025-08-08 19:44:29', '2025-08-08 19:44:29'),
(3, 'janesmith', 'Jane Smith', 'jane.smith@pln.co.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567892', 'user', 1, '2025-08-08 19:44:29', '2025-08-10 19:40:35'),
(4, 'ahmadrizki', 'Ahmad Rizki', 'ahmad.rizki@pln.co.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567893', 'admin', 1, '2025-08-08 19:44:29', '2025-08-10 19:38:51'),
(5, 'sitinur1', 'Siti Nurhaliza', 'siti.nur@pln.co.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567894', 'user', 1, '2025-08-08 19:44:29', '2025-09-28 09:34:46'),
(6, 'budisantoso', 'Budi Santoso', 'budi.santoso@pln.co.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567895', 'superadmin', 1, '2025-08-08 19:44:29', '2025-09-28 09:35:07'),
(7, 'shiroko', 'Shiroko Sunaookami', 'shiroko@gmail.com', '$2y$10$BsmIQ9/hqQYryLYyCLcFoO09a17ub2L/IaocRVUKpZBM8QFaoCnUG', '0823243934', 'user', 1, '2025-08-10 19:36:53', '2025-08-10 19:41:46');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`bk_id`),
  ADD KEY `bk_approved_by` (`bk_approved_by`),
  ADD KEY `idx_booking_user_id` (`bk_user_id`),
  ADD KEY `idx_booking_room_id` (`bk_room_id`),
  ADD KEY `idx_booking_start_time` (`bk_start_time`),
  ADD KEY `idx_booking_status` (`bk_status`),
  ADD KEY `idx_booking_room_time` (`bk_room_id`,`bk_start_time`,`bk_end_time`);

--
-- Indeks untuk tabel `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notif_id`),
  ADD KEY `notif_booking_id` (`notif_booking_id`),
  ADD KEY `idx_notification_user_id` (`notif_user_id`),
  ADD KEY `idx_notification_read` (`notif_read`),
  ADD KEY `idx_notification_user_read` (`notif_user_id`,`notif_read`);

--
-- Indeks untuk tabel `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `booking`
--
ALTER TABLE `booking`
  MODIFY `bk_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `notification`
--
ALTER TABLE `notification`
  MODIFY `notif_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT untuk tabel `room`
--
ALTER TABLE `room`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`bk_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`bk_room_id`) REFERENCES `room` (`room_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`bk_approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`notif_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`notif_booking_id`) REFERENCES `booking` (`bk_id`) ON DELETE CASCADE;
--
-- Database: `cfs_db`
--
CREATE DATABASE IF NOT EXISTS `cfs_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cfs_db`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `target_type` enum('file','folder','user','project','comment','permission') DEFAULT NULL,
  `target_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `target_type`, `target_id`, `timestamp`) VALUES
(13, 3, 'login', 'user', 3, '2025-05-11 10:28:04'),
(14, 23, 'verifikasi akun', 'user', 23, '2025-05-11 10:34:28'),
(15, 23, 'login', 'user', 23, '2025-05-11 10:34:37'),
(16, 23, 'upload file', 'folder', 20, '2025-05-11 10:41:16'),
(17, 23, 'create subfolder', 'folder', 23, '2025-05-11 10:42:01'),
(18, 3, 'login', 'user', 3, '2025-05-11 13:12:55'),
(19, 3, 'upload file', 'folder', 20, '2025-05-11 13:14:19'),
(20, 24, 'login', 'user', 24, '2025-05-11 13:15:50'),
(21, 24, 'Kirim pesan Telegram', '', 0, '2025-05-11 13:16:44'),
(22, 23, 'update folder permission to editor', 'folder', 25, '2025-05-11 13:18:06'),
(23, 24, 'create subfolder', 'folder', 26, '2025-05-11 13:19:14'),
(24, 24, 'upload file', 'folder', 25, '2025-05-11 13:19:36'),
(25, 3, 'login', 'user', 3, '2025-05-11 13:21:12'),
(26, 23, 'login', 'user', 23, '2025-05-11 13:21:38'),
(27, 23, 'login', 'user', 23, '2025-05-11 13:45:02'),
(28, 23, 'Kirim pesan Telegram', '', 0, '2025-05-11 14:08:13'),
(29, 23, 'Kirim pesan Telegram', '', 0, '2025-05-11 14:08:16'),
(30, 23, 'login', 'user', 23, '2025-05-11 20:11:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `size` bigint(20) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `files`
--

INSERT INTO `files` (`id`, `name`, `filename`, `uploaded_by`, `folder_id`, `created_at`, `size`, `updated_at`) VALUES
(4, 'daftar vaksin.docx', '20250511124116_68207ecc10283.docx', 23, 20, '2025-05-11 10:41:16', 76, '2025-05-11 10:42:12'),
(5, 'sertifikat.pdf', '20250511124116_68207ecc121e0.pdf', 23, 20, '2025-05-11 10:41:16', 58, '2025-05-11 10:41:16'),
(6, 'bootstrap-5.3.6-dist.zip', '20250511151419_6820a2abd3bf3.zip', 3, 20, '2025-05-11 13:14:19', 1500308, '2025-05-11 13:14:19'),
(7, 'TrafficMonitor_V1.85.1_x64.zip', '20250511151936_6820a3e87441c.zip', 24, 25, '2025-05-11 13:19:36', 1372508, '2025-05-11 13:22:27');

-- --------------------------------------------------------

--
-- Struktur dari tabel `file_permissions`
--

CREATE TABLE `file_permissions` (
  `id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `access_level` enum('viewer','editor') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `folders`
--

CREATE TABLE `folders` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `visibility` enum('public','private','shared') NOT NULL DEFAULT 'private',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `folders`
--

INSERT INTO `folders` (`id`, `name`, `parent_id`, `created_by`, `created_at`, `visibility`, `updated_at`) VALUES
(19, 'Kantor Desa', NULL, 23, '2025-05-11 10:34:54', 'shared', '2025-05-11 10:34:54'),
(20, 'File Umum', NULL, 23, '2025-05-11 10:35:08', 'public', '2025-05-11 10:35:08'),
(21, 'Penyimpanan Sementara', NULL, 23, '2025-05-11 10:35:39', 'private', '2025-05-11 10:35:39'),
(22, 'Penyimpanan Bersama', NULL, 3, '2025-05-11 10:38:08', 'public', '2025-05-11 10:38:08'),
(23, 'Lainnya', 20, 23, '2025-05-11 10:42:01', 'private', '2025-05-11 10:42:01'),
(24, 'Penyimpanan Admin', NULL, 3, '2025-05-11 13:13:17', 'private', '2025-05-11 13:13:17'),
(25, 'Folder Bersama', NULL, 24, '2025-05-11 13:16:22', 'shared', '2025-05-11 13:16:22'),
(26, 'folder 1', 25, 24, '2025-05-11 13:19:14', 'private', '2025-05-11 13:19:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `folder_permissions`
--

CREATE TABLE `folder_permissions` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `access_level` enum('viewer','editor') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `folder_permissions`
--

INSERT INTO `folder_permissions` (`id`, `folder_id`, `user_id`, `access_level`) VALUES
(15, 19, 23, 'editor'),
(16, 20, 23, 'editor'),
(17, 22, 3, 'editor'),
(18, 25, 24, 'editor'),
(19, 25, 23, 'editor'),
(20, 25, 3, 'viewer'),
(21, 19, 3, 'viewer'),
(22, 19, 24, 'editor');

-- --------------------------------------------------------

--
-- Struktur dari tabel `otp`
--

CREATE TABLE `otp` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `otp_code` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `keterangan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL,
  `telegram_chat_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('verified','unverified','suspend') NOT NULL DEFAULT 'unverified'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `role`, `telegram_chat_id`, `created_at`, `status`) VALUES
(3, 'admin', '$2y$10$v9OTzpdNp55YhXsv/83XheIS41gZxp5W8pg5ehGSxBUhfF26VuK2e', 'admin', NULL, '2025-05-09 03:25:31', 'verified'),
(23, 'timoty', '$2y$10$yhTaK0sTT/WPbrLjo4gohOIJGaja6fSLKIzX1LxKOb3uFtJKS2tyC', 'user', '7194340434', '2025-05-11 10:33:48', 'verified'),
(24, 'user1', '$2y$10$LiWcL3Y.WmAoS.bw2VxnROn4C9PEQDOF.jBxr7l7qPK0DB3gcF/lq', 'user', NULL, '2025-05-11 13:14:55', 'verified');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_ibfk_1` (`user_id`);

--
-- Indeks untuk tabel `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `folder_id` (`folder_id`);

--
-- Indeks untuk tabel `file_permissions`
--
ALTER TABLE `file_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `file_id` (`file_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indeks untuk tabel `folder_permissions`
--
ALTER TABLE `folder_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `folder_id` (`folder_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `otp`
--
ALTER TABLE `otp`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `file_permissions`
--
ALTER TABLE `file_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `folders`
--
ALTER TABLE `folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `folder_permissions`
--
ALTER TABLE `folder_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `otp`
--
ALTER TABLE `otp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `files_ibfk_2` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `file_permissions`
--
ALTER TABLE `file_permissions`
  ADD CONSTRAINT `file_permissions_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `file_permissions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `folders_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `folders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `folders_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `folder_permissions`
--
ALTER TABLE `folder_permissions`
  ADD CONSTRAINT `folder_permissions_ibfk_1` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `folder_permissions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `db_a`
--
CREATE DATABASE IF NOT EXISTS `db_a` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_a`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `absen`
--

CREATE TABLE `absen` (
  `id_absen` int(11) NOT NULL,
  `id_peserta` int(11) DEFAULT NULL,
  `id_sesi` int(11) DEFAULT NULL,
  `waktu_absen` datetime DEFAULT NULL,
  `via_admin` varchar(255) DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjemputan`
--

CREATE TABLE `penjemputan` (
  `id_penjemputan` int(11) NOT NULL,
  `id_req_jemput` int(11) DEFAULT NULL,
  `id_kendaraan` int(11) DEFAULT NULL,
  `waktu_jemput` datetime DEFAULT NULL,
  `status_keberangkatan` enum('pending','penjemputan','pengantaran','selesai') DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peserta`
--

CREATE TABLE `peserta` (
  `id_peserta` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `hotel` varchar(100) DEFAULT NULL,
  `ketua_rombongan` varchar(100) DEFAULT NULL,
  `status` enum('pk','pu','lain') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `req_jemput`
--

CREATE TABLE `req_jemput` (
  `id_req_jemput` int(11) NOT NULL,
  `id_peserta` int(11) DEFAULT NULL,
  `waktu_req` datetime DEFAULT NULL,
  `lokasi_jemput` varchar(255) DEFAULT NULL,
  `banyak_orang` int(11) DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sesi`
--

CREATE TABLE `sesi` (
  `id_sesi` int(11) NOT NULL,
  `nama_sesi` varchar(100) DEFAULT NULL,
  `waktu_mulai` datetime DEFAULT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `target` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `absen`
--
ALTER TABLE `absen`
  ADD PRIMARY KEY (`id_absen`);

--
-- Indeks untuk tabel `penjemputan`
--
ALTER TABLE `penjemputan`
  ADD PRIMARY KEY (`id_penjemputan`);

--
-- Indeks untuk tabel `peserta`
--
ALTER TABLE `peserta`
  ADD PRIMARY KEY (`id_peserta`);

--
-- Indeks untuk tabel `req_jemput`
--
ALTER TABLE `req_jemput`
  ADD PRIMARY KEY (`id_req_jemput`);

--
-- Indeks untuk tabel `sesi`
--
ALTER TABLE `sesi`
  ADD PRIMARY KEY (`id_sesi`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `absen`
--
ALTER TABLE `absen`
  MODIFY `id_absen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `penjemputan`
--
ALTER TABLE `penjemputan`
  MODIFY `id_penjemputan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `peserta`
--
ALTER TABLE `peserta`
  MODIFY `id_peserta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `req_jemput`
--
ALTER TABLE `req_jemput`
  MODIFY `id_req_jemput` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sesi`
--
ALTER TABLE `sesi`
  MODIFY `id_sesi` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `db_futsal_booking`
--
CREATE DATABASE IF NOT EXISTS `db_futsal_booking` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_futsal_booking`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `created_at`) VALUES
(77, 1, 'delete_all_activity_logs', 'Menghapus semua log aktivitas (1 records)', '2025-07-21 08:41:10'),
(78, 1, 'create_fields', 'Menambah lapangan baru: Test (Indoor)', '2025-07-21 08:41:29'),
(79, 1, 'update_fields', 'Memperbarui lapangan: Test (ID: 13)', '2025-07-21 08:45:28'),
(80, 1, 'delete_fields', 'Menghapus lapangan: Test (ID: 13)', '2025-07-21 09:18:49'),
(81, 1, 'delete_fields', NULL, '2025-07-21 09:18:50'),
(82, 1, 'delete_fields', NULL, '2025-07-21 09:18:56'),
(83, 1, 'delete_fields', NULL, '2025-07-21 09:19:05'),
(84, 1, 'delete_fields', NULL, '2025-07-21 09:19:10'),
(85, 1, 'delete_fields', NULL, '2025-07-21 09:19:14'),
(86, 1, 'delete_fields', NULL, '2025-07-21 09:19:17'),
(87, 1, 'create_fields', 'Menambah lapangan baru: Lapangan A (Indoor)', '2025-07-21 09:20:14'),
(88, 1, 'delete_fields', 'Menghapus lapangan: Lapangan A (ID: 14)', '2025-07-21 09:20:19'),
(89, 1, 'delete_users', 'Menghapus pengguna: Yefta Asyel (yeftas2) (ID: 10)', '2025-07-21 09:20:45'),
(90, 1, 'delete_users', 'Menghapus pengguna: Yefta Asyel (ss) (ID: 7)', '2025-07-21 09:20:46'),
(91, 1, 'delete_users', 'Menghapus pengguna: Yefta Asyel (aa) (ID: 6)', '2025-07-21 09:20:48'),
(92, 1, 'delete_users', NULL, '2025-07-21 09:20:49'),
(93, 1, 'delete_users', NULL, '2025-07-21 09:20:52'),
(94, 1, 'delete_users', 'Menghapus pengguna: Administrator (admin) (ID: 2)', '2025-07-21 09:20:56'),
(95, 1, 'delete_users', 'Menghapus pengguna: Ahmad Rizki (Kasir) (kasir1) (ID: 3)', '2025-07-21 09:21:00'),
(96, 1, 'delete_users', 'Menghapus pengguna: Budi Santoso (Kasir) (kasir2) (ID: 4)', '2025-07-21 09:21:05'),
(97, 1, 'delete_users', 'Menghapus pengguna: Citra Dewi (Manager) (manager) (ID: 5)', '2025-07-21 09:21:07'),
(98, 1, 'create_users', 'Menambah pengguna baru: Kasir 1 (kasir1) sebagai admin', '2025-07-21 09:21:44'),
(99, 1, 'logout', 'User logged out', '2025-07-21 09:21:54'),
(100, 12, 'login', 'User logged in', '2025-07-21 09:22:07'),
(101, 12, 'logout', 'User logged out', '2025-07-21 09:22:22'),
(102, 1, 'login', 'User logged in', '2025-07-21 09:31:36'),
(103, 1, 'create_fields', 'Menambah lapangan baru: Lapangan A (Outdoor)', '2025-07-21 09:32:12'),
(104, 1, 'DELETE_SESSION', 'Menghapus session untuk guest: Shiroko', '2025-07-21 09:42:18'),
(105, 1, 'DELETE_SESSION', 'Menghapus session untuk guest: Shiroko', '2025-07-21 09:47:55'),
(106, 1, 'DELETE_SESSION', 'Menghapus session untuk guest: Shiroko', '2025-07-21 09:50:42'),
(107, 1, 'create_users', 'Menambah pengguna baru: Kasir 2 (kasir2) sebagai admin', '2025-07-21 13:15:31'),
(108, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000001 (Shiroko) menjadi Lunas', '2025-07-21 13:24:20'),
(109, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000001 (Shiroko) menjadi Lunas', '2025-07-21 13:24:46'),
(110, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000001 (Shiroko) menjadi Lunas', '2025-07-21 13:28:09'),
(111, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000001 (Shiroko) menjadi Lunas', '2025-07-21 13:34:10'),
(112, 1, 'create_fields', 'Menambah lapangan baru: Lapangan B (Indoor)', '2025-07-21 14:16:28'),
(113, 1, 'create_fields', 'Menambah lapangan baru: Lapangan C (Futsal Court)', '2025-07-21 14:17:11'),
(114, 1, 'create_fields', 'Menambah lapangan baru: dsda (Outdoor)', '2025-07-21 14:18:29'),
(115, 1, 'update_fields', 'Memperbarui lapangan: Lapangan C (ID: 17)', '2025-07-21 14:18:43'),
(116, 1, 'delete_fields', 'Menghapus lapangan: dsda (ID: 18)', '2025-07-21 14:19:40'),
(117, 1, 'update_fields', 'Memperbarui lapangan: Lapangan C (ID: 17)', '2025-07-21 14:30:31'),
(118, 1, 'update_fields', 'Memperbarui lapangan: Lapangan C (ID: 17)', '2025-07-21 14:30:58'),
(119, 1, 'update_fields', 'Memperbarui lapangan: Lapangan C (ID: 17)', '2025-07-21 14:36:44'),
(120, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000003 (Serika) menjadi Lunas', '2025-07-21 14:38:06'),
(121, 1, 'update_fields', 'Memperbarui lapangan: Lapangan B (ID: 16)', '2025-07-21 14:38:13'),
(122, 1, 'update_fields', 'Memperbarui lapangan: Lapangan C (ID: 17)', '2025-07-21 14:38:30'),
(123, 1, 'update_fields', 'Memperbarui lapangan: Lapangan B (ID: 16)', '2025-07-21 14:38:36'),
(124, 1, 'logout', 'User logged out', '2025-07-21 14:39:17'),
(125, 1, 'login', 'User logged in', '2025-07-21 14:40:19'),
(126, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000004 (Hoshimi) menjadi Lunas', '2025-07-21 21:40:30'),
(127, 1, 'logout', 'User logged out', '2025-07-21 22:15:52'),
(128, 1, 'login', 'User logged in', '2025-07-22 08:45:03'),
(129, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000005 (Paul Harris) menjadi Lunas', '2025-07-22 08:47:23'),
(130, 1, 'profile_update', 'User updated profile information', '2025-07-22 08:49:45'),
(131, 1, 'login', 'User logged in', '2025-07-28 04:15:12'),
(132, 1, 'login', 'User logged in', '2025-07-29 02:16:49'),
(133, 1, 'UPDATE_PAYMENT', 'Mengubah status pembayaran sesi FS2025000006 (Shiroko) menjadi Lunas', '2025-07-29 02:17:23'),
(134, 1, 'logout', 'User logged out', '2025-07-29 02:17:49'),
(135, 1, 'login', 'User logged in', '2025-07-29 02:33:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `fields`
--

CREATE TABLE `fields` (
  `id` int(11) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_type` varchar(50) NOT NULL,
  `price_per_hour` decimal(10,2) NOT NULL,
  `status` enum('available','maintenance','booked') DEFAULT 'available',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `fields`
--

INSERT INTO `fields` (`id`, `field_name`, `field_type`, `price_per_hour`, `status`, `description`, `created_at`, `updated_at`) VALUES
(15, 'Lapangan A', 'Outdoor', 75000.00, 'available', 'Lapangan A dengan fasilitas apalah', '2025-07-21 09:32:12', '2025-07-21 09:32:12'),
(16, 'Lapangan B', 'Indoor', 100000.00, 'available', 'Lapangan Indoor', '2025-07-21 14:16:28', '2025-07-21 14:38:36'),
(17, 'Lapangan C', 'Futsal Court', 110000.00, 'available', 'Ini lapangan', '2025-07-21 14:17:11', '2025-07-21 14:38:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `session_number` varchar(20) NOT NULL,
  `field_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `guest_name` varchar(100) NOT NULL,
  `guest_phone` varchar(20) DEFAULT NULL,
  `guest_email` varchar(100) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','paid','cancelled') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `final_amount` decimal(10,2) NOT NULL,
  `status` enum('upcoming','ongoing','completed','cancelled') DEFAULT 'upcoming',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `session_number`, `field_id`, `user_id`, `guest_name`, `guest_phone`, `guest_email`, `start_time`, `end_time`, `duration`, `total_price`, `payment_status`, `payment_method`, `discount_amount`, `final_amount`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(36, 'FS2025000001', 15, NULL, 'Shiroko', '0823233333', 'shiroko@gmail.com', '2025-07-21 18:16:00', '2025-07-21 19:16:00', 1, 75000.00, 'paid', 'cash', 0.00, 75000.00, 'ongoing', 1, '2025-07-21 09:50:59', '2025-07-21 13:34:10'),
(37, 'FS2025000002', 15, NULL, 'Shiroko', '0823233333', 'shiroko@gmail.com', '2025-07-21 22:44:00', '2025-07-21 23:44:00', 1, 75000.00, 'paid', 'cash', 0.00, 75000.00, 'upcoming', 1, '2025-07-21 12:46:26', '2025-07-21 14:42:31'),
(38, 'FS2025000003', 16, NULL, 'Serika', '08232333332', 'serika@gmail.com', '2025-07-22 08:30:00', '2025-07-22 10:30:00', 2, 200000.00, 'paid', 'transfer', 0.00, 200000.00, 'upcoming', 1, '2025-07-21 14:37:59', '2025-07-21 14:38:06'),
(39, 'FS2025000004', 16, NULL, 'Hoshimi', '0978323222', 'hoshimi@gmail.com', '2025-07-22 05:39:00', '2025-07-22 07:39:00', 2, 200000.00, 'paid', 'cash', 0.00, 200000.00, 'upcoming', 1, '2025-07-21 21:40:13', '2025-07-21 21:40:30'),
(40, 'FS2025000005', 16, NULL, 'Paul Harris', '0823233333', 'we@gamil.com', '2025-07-22 16:46:00', '2025-07-22 17:46:00', 1, 100000.00, 'paid', 'cash', 0.00, 100000.00, 'upcoming', 1, '2025-07-22 08:47:09', '2025-07-22 08:47:23'),
(41, 'FS2025000006', 15, NULL, 'Shiroko', '0823233333', 'dasddsad@gmail.com', '2025-07-29 14:00:00', '2025-07-29 16:00:00', 2, 150000.00, 'paid', 'cash', 0.00, 150000.00, 'upcoming', 1, '2025-07-22 08:50:51', '2025-07-29 02:34:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('superadmin','admin') DEFAULT 'admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `role`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'superadmin@futsal.com', '$2y$10$b80LMxA.krx00B.yb5c8Ku1J2cI03qMCFn5NRg/43WgPBe6WJx0KO', 'Mas Yefta', '081234567890', 'superadmin', '2025-07-09 08:57:59', '2025-07-22 08:49:45'),
(12, 'kasir1', 'kasir1@futsal.com', '$2y$10$K0T.4I0DHb7JfiauIo52YOsl4/3GEXhtzeBjXY4eiRXMxQaqItL26', 'Kasir 1', '08232333333', 'admin', '2025-07-21 09:21:44', '2025-07-21 09:21:44'),
(13, 'kasir2', 'kasir2@futsal.com', '$2y$10$q88LjRUfFg3nUpA5HdSb9.RHI2A7Tb4tEjDn2xyTm4ax1Bcd8UOAK', 'Kasir 2', '08232423234', 'admin', '2025-07-21 13:15:31', '2025-07-21 13:15:31');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_number` (`session_number`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT untuk tabel `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sessions_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
--
-- Database: `db_intern_net`
--
CREATE DATABASE IF NOT EXISTS `db_intern_net` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_intern_net`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `achivements`
--

CREATE TABLE `achivements` (
  `achivement_id` int(11) NOT NULL,
  `achivement_name` varchar(100) NOT NULL,
  `achivement_desc` varchar(500) NOT NULL,
  `achivement_icon` varchar(255) NOT NULL,
  `achivement_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `badges`
--

CREATE TABLE `badges` (
  `badge_id` int(11) NOT NULL,
  `badge_name` varchar(100) NOT NULL,
  `badge_desc` varchar(500) NOT NULL,
  `badge_icon` varchar(255) NOT NULL,
  `badge_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `groups`
--

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `group_desc` varchar(500) NOT NULL,
  `group_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `group_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `notif_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notif_type` enum('like','comment','badge','achievement','group','post') NOT NULL,
  `notif_content` varchar(1000) NOT NULL,
  `notif_is_read` smallint(1) DEFAULT 0,
  `notif_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `otp`
--

CREATE TABLE `otp` (
  `otp_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `otp_code` varchar(10) NOT NULL,
  `otp_cat` enum('register','reset_pass') NOT NULL,
  `otp_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `otp_expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `post_caption` varchar(2000) NOT NULL,
  `post_img` varchar(255) DEFAULT NULL,
  `post_feed_cat` enum('public','group','draft') NOT NULL,
  `post_is_deleted` smallint(1) DEFAULT 0,
  `post_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `post_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_badges_list`
--

CREATE TABLE `post_badges_list` (
  `pbl_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `badge_id` int(11) NOT NULL,
  `badge_earned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `user_from` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_phone_num` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_dob` date NOT NULL,
  `user_bio` varchar(500) DEFAULT NULL,
  `user_pic` varchar(255) DEFAULT NULL,
  `user_role` enum('admin','mentor','intern') DEFAULT NULL,
  `user_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_has_deleted` smallint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_achivements_list`
--

CREATE TABLE `user_achivements_list` (
  `ual_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `achivement_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_group_list`
--

CREATE TABLE `user_group_list` (
  `ugl_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_logs`
--

CREATE TABLE `user_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `log_action` varchar(255) NOT NULL,
  `log_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_post_comments`
--

CREATE TABLE `user_post_comments` (
  `upc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `the_comment` varchar(2000) NOT NULL,
  `parent_comment_id` int(11) DEFAULT NULL,
  `comment_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_post_likes`
--

CREATE TABLE `user_post_likes` (
  `upl_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `like_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `achivements`
--
ALTER TABLE `achivements`
  ADD PRIMARY KEY (`achivement_id`);

--
-- Indeks untuk tabel `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`badge_id`);

--
-- Indeks untuk tabel `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notif_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `otp`
--
ALTER TABLE `otp`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_group_id` (`group_id`);

--
-- Indeks untuk tabel `post_badges_list`
--
ALTER TABLE `post_badges_list`
  ADD PRIMARY KEY (`pbl_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `badge_id` (`badge_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`user_email`),
  ADD KEY `idx_phone_num` (`user_phone_num`);

--
-- Indeks untuk tabel `user_achivements_list`
--
ALTER TABLE `user_achivements_list`
  ADD PRIMARY KEY (`ual_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `achivement_id` (`achivement_id`);

--
-- Indeks untuk tabel `user_group_list`
--
ALTER TABLE `user_group_list`
  ADD PRIMARY KEY (`ugl_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indeks untuk tabel `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `user_post_comments`
--
ALTER TABLE `user_post_comments`
  ADD PRIMARY KEY (`upc_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_post_id` (`post_id`),
  ADD KEY `idx_parent_comment_id` (`parent_comment_id`),
  ADD KEY `idx_comment_created_at` (`comment_created_at`);

--
-- Indeks untuk tabel `user_post_likes`
--
ALTER TABLE `user_post_likes`
  ADD PRIMARY KEY (`upl_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_post_id` (`post_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `achivements`
--
ALTER TABLE `achivements`
  MODIFY `achivement_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `badges`
--
ALTER TABLE `badges`
  MODIFY `badge_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notif_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `otp`
--
ALTER TABLE `otp`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `post_badges_list`
--
ALTER TABLE `post_badges_list`
  MODIFY `pbl_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_achivements_list`
--
ALTER TABLE `user_achivements_list`
  MODIFY `ual_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_group_list`
--
ALTER TABLE `user_group_list`
  MODIFY `ugl_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_post_comments`
--
ALTER TABLE `user_post_comments`
  MODIFY `upc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user_post_likes`
--
ALTER TABLE `user_post_likes`
  MODIFY `upl_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `otp`
--
ALTER TABLE `otp`
  ADD CONSTRAINT `otp_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_badges_list`
--
ALTER TABLE `post_badges_list`
  ADD CONSTRAINT `post_badges_list_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_badges_list_ibfk_2` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`badge_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_achivements_list`
--
ALTER TABLE `user_achivements_list`
  ADD CONSTRAINT `user_achivements_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_achivements_list_ibfk_2` FOREIGN KEY (`achivement_id`) REFERENCES `achivements` (`achivement_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_group_list`
--
ALTER TABLE `user_group_list`
  ADD CONSTRAINT `user_group_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_group_list_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_logs`
--
ALTER TABLE `user_logs`
  ADD CONSTRAINT `user_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_post_comments`
--
ALTER TABLE `user_post_comments`
  ADD CONSTRAINT `user_post_comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_post_comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_post_comments_ibfk_3` FOREIGN KEY (`parent_comment_id`) REFERENCES `user_post_comments` (`upc_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_post_likes`
--
ALTER TABLE `user_post_likes`
  ADD CONSTRAINT `user_post_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_post_likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE;
--
-- Database: `db_miawshare`
--
CREATE DATABASE IF NOT EXISTS `db_miawshare` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_miawshare`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `config`
--

CREATE TABLE `config` (
  `token_bot` varchar(200) DEFAULT NULL,
  `owner_chat_id` varchar(20) DEFAULT NULL,
  `img_size` int(11) NOT NULL DEFAULT 1024000,
  `profile_size` int(11) NOT NULL DEFAULT 1024000,
  `limit_beranda` int(11) NOT NULL DEFAULT 30,
  `nsfw_detect` tinyint(1) NOT NULL DEFAULT 0,
  `host_main` varchar(200) NOT NULL DEFAULT 'http://localhost/miawshare',
  `host_api` varchar(200) DEFAULT 'http://localhost:5000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `config`
--

INSERT INTO `config` (`token_bot`, `owner_chat_id`, `img_size`, `profile_size`, `limit_beranda`, `nsfw_detect`, `host_main`, `host_api`) VALUES
('6906279097:AAGdApVCVqDEJ9q6Ybc3Kh-0-afK5FOb-L8', '1627790263', 1024000, 1024000, 50, 0, 'http://localhost/miawshare', 'http://localhost:5000');

-- --------------------------------------------------------

--
-- Struktur dari tabel `level`
--

CREATE TABLE `level` (
  `level_id` int(11) NOT NULL,
  `level_name` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `level`
--

INSERT INTO `level` (`level_id`, `level_name`) VALUES
(1, 'Admin'),
(2, 'User');

-- --------------------------------------------------------

--
-- Struktur dari tabel `likes`
--

CREATE TABLE `likes` (
  `liked_post_id` int(11) NOT NULL,
  `liked_user_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `likes`
--

INSERT INTO `likes` (`liked_post_id`, `liked_user_name`) VALUES
(41, 'yefta'),
(42, 'admin'),
(42, 'yefta'),
(44, 'yefta'),
(46, 'admin'),
(46, 'yefta'),
(47, 'admin'),
(47, 'yefta'),
(48, 'admin'),
(48, 'yefta'),
(49, 'yefta'),
(50, 'admin'),
(50, 'yefta'),
(54, 'admin'),
(54, 'yefta'),
(56, 'yefta'),
(79, 'yefta'),
(85, 'admin'),
(85, 'yefta'),
(176, 'admin'),
(176, 'yefta'),
(185, 'bocchi'),
(185, 'yefta');

-- --------------------------------------------------------

--
-- Struktur dari tabel `otp`
--

CREATE TABLE `otp` (
  `user_name` varchar(30) DEFAULT NULL,
  `otp_code` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `to_use` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `post_img_path` varchar(200) DEFAULT NULL,
  `post_title` varchar(100) DEFAULT NULL,
  `post_description` varchar(300) DEFAULT NULL,
  `post_link` varchar(300) DEFAULT NULL,
  `classify` varchar(10) DEFAULT NULL,
  `create_in` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `post_img_path`, `post_title`, `post_description`, `post_link`, `classify`, `create_in`) VALUES
(40, 123, 'HitoriGotou.jpg', 'Bocchi Glasses', '#animegirl #kawaii #waifu', '', 'sfw', '2024-07-19 17:28:22'),
(41, 123, 'shiroko.jpg', 'Shiroko', '#animegirl #waifu #kawaii', '', 'sfw', '2024-07-19 17:28:49'),
(42, 123, '4e0f5bb9-dd98-4fe6-83f8-c86d86001b48.jpg', 'CPP for Beginer', '#meme #book', '', 'sfw', '2024-07-19 17:29:23'),
(43, 123, 'Rocking 4K Anime Crew by BinsentoOmosura (1).jpg', 'Kessoku Band Wallpaper', '#desktop #wallpaper', '', 'sfw', '2024-07-19 17:29:58'),
(44, 123, 'Astolfo_reading_ABAP_objects.png', 'Astolfo Reading', '#book #trap', '', 'sfw', '2024-07-19 17:30:28'),
(46, 123, 'sunaookami-shiroko-blue-archive-v0-mnsvdd9qraw91.png', 'Shiroko Winter', 'Pov me, wkwk #shiroko #winter', '', 'sfw', '2024-07-19 17:31:40'),
(47, 123, 'Bocchi_the_rock_Hitori_Gotoh_the_c++_programming_language.png', 'Bocchi Holding CPP Book', '', '', 'sfw', '2024-07-19 17:32:31'),
(48, 123, 'Kawaii Shiroko - pixiv.jpg', 'Shiroko', '#animegirl', '', 'sfw', '2024-07-19 17:33:00'),
(49, 123, 'Bocchi Py.jpg', 'Python Is Bocchi Reference?!', '#anime #python #meme', '', 'sfw', '2024-07-19 17:33:34'),
(50, 123, 'Polite cat.jpeg', 'Beluga Cat', '#beluga #cat', '', 'sfw', '2024-07-19 17:34:02'),
(54, 123, 'FB_IMG_1718369577280.jpg', 'Miaw Cosplay', '', '', 'sfw', '2024-07-21 16:16:13'),
(55, 123, 'download.jpeg', 'Java', '', '', 'sfw', '2024-07-21 16:16:39'),
(56, 123, 'FB_IMG_1721570386958.jpg', 'Jawir?!', '', '', 'sfw', '2024-07-21 16:17:08'),
(79, 127, 'migu gaming.jpeg', 'Migu Gaming', '#miku #gaming', '', 'sfw', '2024-07-27 11:18:09'),
(82, 127, 'Keqing.600.3538467.jpg', 'Keqing', '#game #animegirl', '', 'sfw', '2024-07-27 12:23:47'),
(85, 127, 'animegirl-purple-hair-yellow-eyes-catgirl-city-279171890.jpg', 'Cat Girl', '#animegirl', '', 'sfw', '2024-07-27 12:27:30'),
(176, 123, 'IMG_20240913_171411_316.jpg', 'Shiroko icon', '', NULL, 'sfw', '2024-09-16 00:47:42'),
(184, 123, 'Confused-scared-anime-girl-meme-10.jpg', 'Halo guys (ceritanya judul)', '#tag_cuma_gimmick', NULL, 'sfw', '2024-09-18 05:51:50'),
(185, 123, 'download (2).jpeg', 'Uwuuuu', '', NULL, 'sfw', '2024-10-13 14:36:32'),
(186, 123, 'WhatsApp Image 2025-05-12 at 10.42.15_b7e72e01.jpg', 'Shiroko Kawaii', 'Alamak lucunyee', NULL, 'pending', '2025-06-13 00:35:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `posts_tags`
--

CREATE TABLE `posts_tags` (
  `tag_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_likes`
--

CREATE TABLE `post_likes` (
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_liked` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `user_name_reported` varchar(30) DEFAULT NULL,
  `post_id_reported` int(11) DEFAULT NULL,
  `post_reported` varchar(100) DEFAULT NULL,
  `user_name_reporter` varchar(30) DEFAULT NULL,
  `reason` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL,
  `tag_title` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `user_profile_path` varchar(200) DEFAULT NULL,
  `user_bio` varchar(300) DEFAULT NULL,
  `level_id` int(11) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `status` varchar(10) NOT NULL,
  `create_in` timestamp NOT NULL DEFAULT current_timestamp(),
  `delete_in` timestamp NOT NULL DEFAULT (current_timestamp() + interval 3 minute),
  `tele_chat_id` varchar(11) DEFAULT NULL,
  `to_suspend` int(11) DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `name`, `user_profile_path`, `user_bio`, `level_id`, `password`, `status`, `create_in`, `delete_in`, `tele_chat_id`, `to_suspend`) VALUES
(87, 'admin', 'Admin', 'admin-1.jpg', 'Ini akun admin', 1, '123', 'Aktif', '2024-06-07 06:39:18', '2024-06-07 06:42:18', '0', 3),
(123, 'yefta', 'Yefta Asyel', 'yefta.jpg', 'Admin MiawShare', 2, '111', 'Aktif', '2024-06-09 09:58:30', '2024-06-09 10:01:30', '0', 3),
(127, 'bocchi', 'Hitori Gotou', 'bocchi.jpg', 'Guitar Hero🎸', 2, '123', 'Aktif', '2024-07-24 00:02:39', '2024-07-24 00:05:39', '0', 3),
(139, 'shironeko', 'Shiroko Sunaookami', 'shironeko.jpg', 'Iwak🐡', 2, '123', 'Aktif', '2025-06-13 00:39:15', '2025-06-13 00:42:15', '1627790263', 3);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`level_id`);

--
-- Indeks untuk tabel `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`liked_post_id`,`liked_user_name`),
  ADD KEY `liked_user_name` (`liked_user_name`);

--
-- Indeks untuk tabel `otp`
--
ALTER TABLE `otp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name_2` (`user_name`);

--
-- Indeks untuk tabel `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indeks untuk tabel `posts_tags`
--
ALTER TABLE `posts_tags`
  ADD KEY `idx_tag_id` (`tag_id`),
  ADD KEY `idx_post_id` (`post_id`);

--
-- Indeks untuk tabel `post_likes`
--
ALTER TABLE `post_likes`
  ADD KEY `idx_post_id` (`post_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indeks untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_post_id` (`post_id_reported`);

--
-- Indeks untuk tabel `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `user_name_2` (`user_name`),
  ADD UNIQUE KEY `user_name_3` (`user_name`),
  ADD KEY `idx_level_id` (`level_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `level`
--
ALTER TABLE `level`
  MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `otp`
--
ALTER TABLE `otp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT untuk tabel `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT untuk tabel `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT untuk tabel `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`liked_post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`liked_user_name`) REFERENCES `users` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `otp`
--
ALTER TABLE `otp`
  ADD CONSTRAINT `fk_user_name` FOREIGN KEY (`user_name`) REFERENCES `users` (`user_name`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `posts_tags`
--
ALTER TABLE `posts_tags`
  ADD CONSTRAINT `posts_tags_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`),
  ADD CONSTRAINT `posts_tags_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`);

--
-- Ketidakleluasaan untuk tabel `post_likes`
--
ALTER TABLE `post_likes`
  ADD CONSTRAINT `post_likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  ADD CONSTRAINT `post_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_post_id` FOREIGN KEY (`post_id_reported`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `level` (`level_id`);
--
-- Database: `db_websendangan`
--
CREATE DATABASE IF NOT EXISTS `db_websendangan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_websendangan`;

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
--
-- Database: `futsal`
--
CREATE DATABASE IF NOT EXISTS `futsal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `futsal`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `album`
--

CREATE TABLE `album` (
  `id_album` int(11) NOT NULL,
  `nama_album` char(50) NOT NULL,
  `slug_album` char(50) NOT NULL,
  `foto` text NOT NULL,
  `created_by` char(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` char(20) DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `album`
--

INSERT INTO `album` (`id_album`, `nama_album`, `slug_album`, `foto`, `created_by`, `created_at`, `modified_by`, `modified_at`) VALUES
(1, 'Percobaan', 'percobaan', 'percobaan20180411012221.jpg', 'amperakoding', '2018-04-11 06:14:08', 'amperakoding', '2021-05-17 19:57:25'),
(2, 'Percobaan ke2', 'percobaan-ke2', 'percobaan-ke220180414141810.jpg', 'amperakoding', '2018-04-11 06:20:52', 'amperakoding', '2021-05-17 19:57:25'),
(3, 'Coba Lagi', 'coba-lagi', 'coba-lagi20180414141800.jpg', 'amperakoding', '2018-04-11 06:23:01', 'amperakoding', '2021-05-17 19:57:25'),
(4, 'Lagi coba', 'lagi-coba', 'lagi-coba20180414141618.jpg', 'amperakoding', '2018-04-11 06:23:11', 'amperakoding', '2021-05-17 19:57:25'),
(5, 'Scenery', 'scenery', 'scenery20180414141646.jpg', 'amperakoding', '2018-04-14 19:16:46', 'amperakoding', '2021-05-17 19:57:28'),
(6, 'Lake House', 'lake-house', 'lake-house20180414141705.jpg', 'amperakoding', '2018-04-14 19:17:05', 'amperakoding', '2021-05-17 19:57:28'),
(7, 'House', 'house', 'house20180414141719.jpg', 'amperakoding', '2018-04-14 19:17:19', 'amperakoding', '2021-05-17 19:57:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `nama_bank` varchar(100) NOT NULL,
  `atas_nama` varchar(100) NOT NULL,
  `norek` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `atas_nama`, `norek`, `logo`) VALUES
(1, 'BNI', 'Microtron', '12345678', 'bni.png'),
(2, 'BRI', 'Microtron', '87873412323', 'bri.png'),
(3, 'Mandiri', 'Microtron', '778734098', 'mandiri.png'),
(4, 'BCA', 'Microtron', '998980342487', 'bca.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `company`
--

CREATE TABLE `company` (
  `id_company` int(11) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `company_desc` text NOT NULL,
  `company_address` text NOT NULL,
  `company_maps` text NOT NULL,
  `company_phone` char(30) NOT NULL,
  `company_phone2` char(30) NOT NULL,
  `company_fax` char(30) NOT NULL,
  `company_email` char(30) NOT NULL,
  `foto` text NOT NULL,
  `foto_type` char(10) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` datetime DEFAULT NULL,
  `created_by` char(50) NOT NULL,
  `modified_by` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `company`
--

INSERT INTO `company` (`id_company`, `company_name`, `company_desc`, `company_address`, `company_maps`, `company_phone`, `company_phone2`, `company_fax`, `company_email`, `foto`, `foto_type`, `created`, `modified`, `created_by`, `modified_by`) VALUES
(1, 'FUTSAL MERDEKA JAYA', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vel nibh ac nisl porttitor tempus sit amet et diam. Etiam sed leo eu elit varius venenatis sed ac arcu. Praesent malesuada gravida diam et tincidunt. Mauris quis metus eget magna efficitur scelerisque. Sed mollis porttitor erat ullamcorper sodales. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse congue, dolor ultricies mollis molestie, libero diam auctor mauris, ultrices euismod leo justo vel enim. Etiam non rutrum arcu. Maecenas at dictum dui, sit amet gravida mauris. Vivamus sagittis neque in purus dapibus, ut pellentesque purus pulvinar. Nunc pretium porta ipsum, at iaculis felis elementum in. Duis cursus ex vitae nunc hendrerit blandit.\r\n\r\nMorbi vel est sed dui tristique elementum sed sed purus. Ut interdum nisi et felis vulputate, quis tempus diam blandit. Mauris tincidunt tellus faucibus, posuere turpis a, consectetur lacus. Nullam quis ipsum neque. Praesent sapien tellus, molestie et diam vel, cursus tristique neque. Nullam sit amet ornare odio. Ut vehicula risus id lacus blandit rutrum. Duis non molestie purus. Etiam turpis ligula, tincidunt sit amet dolor at, rutrum viverra orci. Etiam egestas urna id velit bibendum mollis.\r\n\r\nSed eu sem cursus, congue massa at, bibendum leo. Praesent cursus in nulla a egestas. Fusce aliquam leo eu enim feugiat ullamcorper. Nullam pulvinar dolor eu lacinia bibendum. Integer id ipsum cursus, luctus enim nec, fringilla dolor. Sed sit amet ipsum sit amet quam suscipit gravida vitae ut elit. Donec pellentesque non tortor vitae euismod. Praesent suscipit tempor ex ac viverra. Nunc ut sapien eu velit tempor hendrerit. Vestibulum posuere nisl massa, ornare commodo lorem sagittis ultrices. Sed eget rutrum neque, sed ullamcorper dui. Sed ultricies purus vitae lectus cursus, vestibulum faucibus quam posuere. Donec cursus vitae ipsum nec ullamcorper. Donec maximus orci finibus ante hendrerit, vitae maximus quam facilisis. Cras commodo fringilla porttitor.\r\n\r\nNam pharetra a tortor quis venenatis. Nunc lectus nibh, auctor id ante vel, interdum maximus felis. Cras libero est, mattis a sollicitudin sit amet, ultricies sed tellus. Ut augue lacus, luctus convallis enim quis, ultricies aliquet sem. Sed venenatis eros sit amet velit varius, ac rhoncus nibh sodales. Etiam sit amet efficitur est, vel pretium arcu. Morbi diam nulla, dictum quis ornare ultrices, pharetra quis mi. Nam sollicitudin pharetra congue. Praesent sed mauris at ante tincidunt blandit. Aliquam cursus ante efficitur, iaculis turpis eget, ornare quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla quis lobortis leo. Cras ut risus orci. Sed mattis purus ac libero suscipit, nec venenatis tortor semper. Aliquam sodales massa eget dignissim pharetra.\r\n\r\nNam sed enim vitae erat vulputate feugiat in tempus metus. In maximus erat risus. Donec et viverra nibh. Maecenas hendrerit, sapien id suscipit fermentum, tellus nisl sollicitudin erat, non laoreet dui ex sit amet odio. Nullam sit amet arcu sed felis tempor dapibus. Aliquam erat volutpat. Aenean malesuada a eros sed aliquet. Phasellus condimentum lobortis sapien, sit amet viverra sem iaculis venenatis. Morbi interdum nulla ut nulla fringilla commodo. In eu magna ornare libero pellentesque congue. Vestibulum ultrices congue feugiat.', 'Jl. Maju Mundur Kec. Camat Kel. Lurahan, Kab. Bupaten, Dunia Lain', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d16327777.649419477!2d108.84621849858628!3d-2.415291213289622!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2c4c07d7496404b7%3A0xe37b4de71badf485!2sIndonesia!5e0!3m2!1sen!2sid!4v1506312173230\" width=\"100%\" height=\"200\" frameborder=\"0\" style=\"border:0\" allowfullscreen></iframe>', '081241412', '0711412402', '12414', 'toko@gmail.com', 'company-profile20180414070824', '.PNG', '2017-11-09 06:45:34', NULL, 'amperakoding', 'amperakoding');

-- --------------------------------------------------------

--
-- Struktur dari tabel `diskon`
--

CREATE TABLE `diskon` (
  `id` int(11) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `diskon`
--

INSERT INTO `diskon` (`id`, `harga`) VALUES
(1, 50000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `event`
--

CREATE TABLE `event` (
  `id_event` int(11) NOT NULL,
  `nama_event` varchar(100) NOT NULL,
  `slug_event` varchar(100) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `kategori` int(11) DEFAULT NULL,
  `foto` text DEFAULT NULL,
  `foto_type` char(10) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` char(50) NOT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `modified_by` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `event`
--

INSERT INTO `event` (`id_event`, `nama_event`, `slug_event`, `deskripsi`, `kategori`, `foto`, `foto_type`, `created_at`, `created_by`, `modified_at`, `modified_by`) VALUES
(2, 'What is Lorem Ipsum?', 'what-is-lorem-ipsum', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p><img src=\"http://localhost/olshop2/assets/images/upload/Screenshot_from_2018-03-22_20-37-321.png\" width=\"500\" height=\"200\"></p>\r\n<p>Why do we use it?<br>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p>Why do we use it?<br>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>', 1, 'what-is-lorem-ipsum20180723083417', '.jpg', '2018-04-02 20:21:59', 'amperakoding', '2021-05-17 19:58:08', 'amperakoding'),
(3, 'Why do we use it?', 'why-do-we-use-it', '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>', 2, 'why-do-we-use-it20180723083427', '.jpg', '2018-04-02 21:13:48', 'amperakoding', '2021-05-17 19:58:08', 'amperakoding'),
(4, 'Where does it come from?', 'where-does-it-come-from', '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>', 1, 'where-does-it-come-from20180723083441', '.jpg', '2018-04-02 21:14:39', 'amperakoding', '2021-05-17 19:58:08', 'amperakoding'),
(5, 'Where does it come froms?', 'where-does-it-come-froms', '<p>What is Lorem Ipsum?<br>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p>Why do we use it?<br>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n<p>Where does it come from?<br>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>', 1, 'where-does-it-come-froms20180723083339', '.jpg', '2018-04-03 10:03:54', 'amperakoding', '2021-05-17 19:58:08', 'amperakoding'),
(6, 'Aliquam ullamcorper', 'aliquam-ullamcorper', '<p>Aliquam ullamcorper magna consectetur augue laoreet luctus. Duis id nisi eleifend, vestibulum justo eget, scelerisque purus. Pellentesque non risus nec eros ultricies euismod. Donec ullamcorper auctor diam ut fermentum. Maecenas mollis neque magna. Pellentesque blandit arcu mi, vel consequat orci dapibus vel. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus rutrum, risus vitae venenatis efficitur, arcu metus blandit erat, quis pharetra neque leo non quam. Vestibulum imperdiet eleifend rhoncus. Nunc condimentum tellus vel ullamcorper iaculis. Vivamus vitae lorem sem.</p>\r\n<p>Donec lorem diam, rhoncus at tempus eget, dignissim quis nulla. Donec consequat malesuada lacinia. Mauris eget ipsum eget mauris tristique lobortis vel vel turpis. Pellentesque accumsan metus nisi, non molestie diam hendrerit eu. Sed eget lacinia elit. Nulla lobortis diam sed nunc malesuada cursus. Mauris ac maximus tellus.</p>', 2, 'aliquam-ullamcorper20180723083358', '.png', '2018-04-03 11:08:48', 'amperakoding', '2021-05-17 19:58:08', 'amperakoding'),
(7, 'In fermentum scelerisqu', 'in-fermentum-scelerisqu', '<p>In fermentum scelerisque neque. Integer fermentum semper lacinia. Donec porttitor accumsan sem, eget fringilla nisl blandit a. Nam pulvinar faucibus velit, eget vestibulum erat aliquet ac. Maecenas imperdiet felis vitae orci laoreet fermentum. Fusce dui neque, volutpat ac fermentum quis, maximus id diam. Nullam eros urna, tempus tempor vehicula sit amet, sollicitudin quis massa. Mauris metus ex, eleifend nec aliquam a, ullamcorper et leo. Sed convallis, est vitae tincidunt ultrices, orci diam hendrerit magna, ut molestie dui nisl non quam.</p>\r\n<p>Pellentesque in egestas tellus, eget cursus odio. Morbi mollis diam turpis, id luctus leo consequat eu. Integer felis neque, iaculis eget vulputate et, congue pharetra elit. Morbi lacinia lacus vel elit suscipit euismod. Ut tellus leo, sodales ac suscipit in, semper eget sem. Curabitur ultrices, sem id dapibus semper, lectus erat vehicula magna, eu accumsan tellus leo at orci. Fusce rutrum tincidunt tristique. Suspendisse ac cursus libero. Donec aliquet accumsan ex in dignissim. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed vel dignissim velit. Vestibulum mattis malesuada euismod. Praesent in vehicula dui, sit amet fringilla leo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec imperdiet hendrerit neque, at ultricies neque eleifend in.</p>\r\n<p>Sed rutrum egestas diam, vitae sodales odio vulputate id. Phasellus felis risus, varius eget dolor ac, fringilla dapibus risus. Pellentesque ante nulla, egestas ac fermentum suscipit, aliquam ac eros. Mauris elementum justo nec leo imperdiet hendrerit. Praesent ut augue sit amet massa sollicitudin maximus quis eget augue. Etiam malesuada dictum sem, ut ullamcorper diam mattis ut. Morbi non imperdiet ante, ac fermentum justo. Nulla congue magna vel lectus elementum laoreet. Suspendisse ante ipsum, eleifend vel condimentum eu, varius non dolor.</p>', 1, 'in-fermentum-scelerisqu20180413030957', '.jpeg', '2018-04-03 11:11:51', 'amperakoding', '2021-05-17 19:58:08', 'amperakoding');

-- --------------------------------------------------------

--
-- Struktur dari tabel `foto`
--

CREATE TABLE `foto` (
  `id_foto` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  `nama_foto` char(100) NOT NULL,
  `slug_foto` char(100) NOT NULL,
  `foto` text NOT NULL,
  `created_by` char(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` char(20) NOT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `foto`
--

INSERT INTO `foto` (`id_foto`, `album_id`, `nama_foto`, `slug_foto`, `foto`, `created_by`, `created_at`, `modified_by`, `modified_at`) VALUES
(1, 1, 'Testing Saja Cuis', 'testing-saja-cuis', 'testing-saja-cuis20180411025319.jpg', 'amperakoding', '2018-04-11 07:41:29', 'amperakoding', '2021-05-17 19:57:13'),
(2, 4, 'Foto Lagi Coba', 'foto-lagi-coba', 'foto-lagi-coba20180411024503.jpg', 'amperakoding', '2018-04-11 07:45:03', 'amperakoding', '2021-05-17 19:58:17'),
(3, 3, 'Foto Coba Lagi Saja', 'foto-coba-lagi-saja', 'foto-coba-lagi-saja20180411024712.jpg', 'amperakoding', '2018-04-11 07:47:12', 'amperakoding', '2021-05-17 19:58:17'),
(4, 1, 'Teasdasd', 'teasdasd', 'teasdasd20180414101405.png', 'amperakoding', '2018-04-14 15:13:17', 'amperakoding', '2021-05-17 19:57:13'),
(5, 3, 'Agains', 'agains', 'agains20180414101428.jpg', 'amperakoding', '2018-04-14 15:14:29', 'amperakoding', '2021-05-17 19:58:17'),
(6, 4, 'Waasd', 'waasd', 'waasd20180414101515.jpg', 'amperakoding', '2018-04-14 15:15:15', 'amperakoding', '2021-05-17 19:58:17'),
(7, 1, 'ASczxc', 'asczxc', 'asczxc20180414101545.jpg', 'amperakoding', '2018-04-14 15:15:45', 'amperakoding', '2021-05-17 19:58:17'),
(8, 1, 'ASXzc', 'asxzc', 'asxzc20180414101604.jpg', 'amperakoding', '2018-04-14 15:16:05', 'amperakoding', '2021-05-17 19:58:17'),
(9, 2, 'ASczxcacasc', 'asczxcacasc', 'asczxcacasc20180414101613.png', 'amperakoding', '2018-04-14 15:16:13', 'amperakoding', '2021-05-17 19:58:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jam`
--

CREATE TABLE `jam` (
  `id` int(11) NOT NULL,
  `jam` varchar(50) NOT NULL,
  `is_available` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `jam`
--

INSERT INTO `jam` (`id`, `jam`, `is_available`) VALUES
(1, '06:00:00', 1),
(2, '07:00:00', 1),
(3, '08:00:00', 1),
(4, '09:00:00', 1),
(5, '10:00:00', 1),
(6, '11:00:00', 1),
(7, '12:00:00', 1),
(8, '13:00:00', 1),
(9, '14:00:00', 1),
(10, '15:00:00', 1),
(11, '16:00:00', 1),
(12, '17:00:00', 1),
(13, '18:00:00', 1),
(14, '19:00:00', 1),
(15, '20:00:00', 1),
(16, '21:00:00', 1),
(17, '22:00:00', 1),
(18, '23:00:00', 1),
(19, '24:00:00', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(20) NOT NULL,
  `slug_kat` varchar(20) NOT NULL,
  `created_by` char(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` char(50) NOT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `slug_kat`, `created_by`, `created_at`, `modified_by`, `modified_at`) VALUES
(1, 'Turnamen', 'turnamen', 'amperakoding', '2018-07-23 08:38:39', 'amperakoding', '2021-05-17 19:58:57'),
(2, 'Kerja Sama', 'kerja-sama', 'amperakoding', '2018-07-23 08:38:39', 'amperakoding', '2021-05-17 19:58:57');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kontak`
--

CREATE TABLE `kontak` (
  `id_kontak` int(11) NOT NULL,
  `nama_kontak` char(50) NOT NULL,
  `nohp` char(50) NOT NULL,
  `created_by` char(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` char(50) NOT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `kontak`
--

INSERT INTO `kontak` (`id_kontak`, `nama_kontak`, `nohp`, `created_by`, `created_at`, `modified_by`, `modified_at`) VALUES
(1, 'Azmi', '6281228289766', 'amperakoding', '2018-07-23 11:16:57', 'amperakoding', '2021-05-17 19:59:04'),
(2, 'Budi', '6282184082336', 'amperakoding', '2018-07-23 11:16:57', 'amperakoding', '2021-05-17 19:59:04'),
(3, 'Joko', '62819481471', 'amperakoding', '2018-07-23 11:20:44', 'amperakoding', '2021-05-17 19:59:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kota`
--

CREATE TABLE `kota` (
  `id_kota` int(11) NOT NULL,
  `provinsi_id` int(11) NOT NULL,
  `nama_kota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `kota`
--

INSERT INTO `kota` (`id_kota`, `provinsi_id`, `nama_kota`) VALUES
(1, 21, 'Aceh Barat'),
(2, 21, 'Aceh Barat Daya'),
(3, 21, 'Aceh Besar'),
(4, 21, 'Aceh Jaya'),
(5, 21, 'Aceh Selatan'),
(6, 21, 'Aceh Singkil'),
(7, 21, 'Aceh Tamiang'),
(8, 21, 'Aceh Tengah'),
(9, 21, 'Aceh Tenggara'),
(10, 21, 'Aceh Timur'),
(11, 21, 'Aceh Utara'),
(12, 32, 'Agam'),
(13, 23, 'Alor'),
(14, 19, 'Ambon'),
(15, 34, 'Asahan'),
(16, 24, 'Asmat'),
(17, 1, 'Badung'),
(18, 13, 'Balangan'),
(19, 15, 'Balikpapan'),
(20, 21, 'Banda Aceh'),
(21, 18, 'Bandar Lampung'),
(22, 9, 'Bandung'),
(23, 9, 'Bandung'),
(24, 9, 'Bandung Barat'),
(25, 29, 'Banggai'),
(26, 29, 'Banggai Kepulauan'),
(27, 2, 'Bangka'),
(28, 2, 'Bangka Barat'),
(29, 2, 'Bangka Selatan'),
(30, 2, 'Bangka Tengah'),
(31, 11, 'Bangkalan'),
(32, 1, 'Bangli'),
(33, 13, 'Banjar'),
(34, 9, 'Banjar'),
(35, 13, 'Banjarbaru'),
(36, 13, 'Banjarmasin'),
(37, 10, 'Banjarnegara'),
(38, 28, 'Bantaeng'),
(39, 5, 'Bantul'),
(40, 33, 'Banyuasin'),
(41, 10, 'Banyumas'),
(42, 11, 'Banyuwangi'),
(43, 13, 'Barito Kuala'),
(44, 14, 'Barito Selatan'),
(45, 14, 'Barito Timur'),
(46, 14, 'Barito Utara'),
(47, 28, 'Barru'),
(48, 17, 'Batam'),
(49, 10, 'Batang'),
(50, 8, 'Batang Hari'),
(51, 11, 'Batu'),
(52, 34, 'Batu Bara'),
(53, 30, 'Bau-Bau'),
(54, 9, 'Bekasi'),
(55, 9, 'Bekasi'),
(56, 2, 'Belitung'),
(57, 2, 'Belitung Timur'),
(58, 23, 'Belu'),
(59, 21, 'Bener Meriah'),
(60, 26, 'Bengkalis'),
(61, 12, 'Bengkayang'),
(62, 4, 'Bengkulu'),
(63, 4, 'Bengkulu Selatan'),
(64, 4, 'Bengkulu Tengah'),
(65, 4, 'Bengkulu Utara'),
(66, 15, 'Berau'),
(67, 24, 'Biak Numfor'),
(68, 22, 'Bima'),
(69, 22, 'Bima'),
(70, 34, 'Binjai'),
(71, 17, 'Bintan'),
(72, 21, 'Bireuen'),
(73, 31, 'Bitung'),
(74, 11, 'Blitar'),
(75, 11, 'Blitar'),
(76, 10, 'Blora'),
(77, 7, 'Boalemo'),
(78, 9, 'Bogor'),
(79, 9, 'Bogor'),
(80, 11, 'Bojonegoro'),
(81, 31, 'Bolaang Mongondow (Bolmong)'),
(82, 31, 'Bolaang Mongondow Selatan'),
(83, 31, 'Bolaang Mongondow Timur'),
(84, 31, 'Bolaang Mongondow Utara'),
(85, 30, 'Bombana'),
(86, 11, 'Bondowoso'),
(87, 28, 'Bone'),
(88, 7, 'Bone Bolango'),
(89, 15, 'Bontang'),
(90, 24, 'Boven Digoel'),
(91, 10, 'Boyolali'),
(92, 10, 'Brebes'),
(93, 32, 'Bukittinggi'),
(94, 1, 'Buleleng'),
(95, 28, 'Bulukumba'),
(96, 16, 'Bulungan (Bulongan)'),
(97, 8, 'Bungo'),
(98, 29, 'Buol'),
(99, 19, 'Buru'),
(100, 19, 'Buru Selatan'),
(101, 30, 'Buton'),
(102, 30, 'Buton Utara'),
(103, 9, 'Ciamis'),
(104, 9, 'Cianjur'),
(105, 10, 'Cilacap'),
(106, 3, 'Cilegon'),
(107, 9, 'Cimahi'),
(108, 9, 'Cirebon'),
(109, 9, 'Cirebon'),
(110, 34, 'Dairi'),
(111, 24, 'Deiyai (Deliyai)'),
(112, 34, 'Deli Serdang'),
(113, 10, 'Demak'),
(114, 1, 'Denpasar'),
(115, 9, 'Depok'),
(116, 32, 'Dharmasraya'),
(117, 24, 'Dogiyai'),
(118, 22, 'Dompu'),
(119, 29, 'Donggala'),
(120, 26, 'Dumai'),
(121, 33, 'Empat Lawang'),
(122, 23, 'Ende'),
(123, 28, 'Enrekang'),
(124, 25, 'Fakfak'),
(125, 23, 'Flores Timur'),
(126, 9, 'Garut'),
(127, 21, 'Gayo Lues'),
(128, 1, 'Gianyar'),
(129, 7, 'Gorontalo'),
(130, 7, 'Gorontalo'),
(131, 7, 'Gorontalo Utara'),
(132, 28, 'Gowa'),
(133, 11, 'Gresik'),
(134, 10, 'Grobogan'),
(135, 5, 'Gunung Kidul'),
(136, 14, 'Gunung Mas'),
(137, 34, 'Gunungsitoli'),
(138, 20, 'Halmahera Barat'),
(139, 20, 'Halmahera Selatan'),
(140, 20, 'Halmahera Tengah'),
(141, 20, 'Halmahera Timur'),
(142, 20, 'Halmahera Utara'),
(143, 13, 'Hulu Sungai Selatan'),
(144, 13, 'Hulu Sungai Tengah'),
(145, 13, 'Hulu Sungai Utara'),
(146, 34, 'Humbang Hasundutan'),
(147, 26, 'Indragiri Hilir'),
(148, 26, 'Indragiri Hulu'),
(149, 9, 'Indramayu'),
(150, 24, 'Intan Jaya'),
(151, 6, 'Jakarta Barat'),
(152, 6, 'Jakarta Pusat'),
(153, 6, 'Jakarta Selatan'),
(154, 6, 'Jakarta Timur'),
(155, 6, 'Jakarta Utara'),
(156, 8, 'Jambi'),
(157, 24, 'Jayapura'),
(158, 24, 'Jayapura'),
(159, 24, 'Jayawijaya'),
(160, 11, 'Jember'),
(161, 1, 'Jembrana'),
(162, 28, 'Jeneponto'),
(163, 10, 'Jepara'),
(164, 11, 'Jombang'),
(165, 25, 'Kaimana'),
(166, 26, 'Kampar'),
(167, 14, 'Kapuas'),
(168, 12, 'Kapuas Hulu'),
(169, 10, 'Karanganyar'),
(170, 1, 'Karangasem'),
(171, 9, 'Karawang'),
(172, 17, 'Karimun'),
(173, 34, 'Karo'),
(174, 14, 'Katingan'),
(175, 4, 'Kaur'),
(176, 12, 'Kayong Utara'),
(177, 10, 'Kebumen'),
(178, 11, 'Kediri'),
(179, 11, 'Kediri'),
(180, 24, 'Keerom'),
(181, 10, 'Kendal'),
(182, 30, 'Kendari'),
(183, 4, 'Kepahiang'),
(184, 17, 'Kepulauan Anambas'),
(185, 19, 'Kepulauan Aru'),
(186, 32, 'Kepulauan Mentawai'),
(187, 26, 'Kepulauan Meranti'),
(188, 31, 'Kepulauan Sangihe'),
(189, 6, 'Kepulauan Seribu'),
(190, 31, 'Kepulauan Siau Tagulandang Biaro (Sitaro)'),
(191, 20, 'Kepulauan Sula'),
(192, 31, 'Kepulauan Talaud'),
(193, 24, 'Kepulauan Yapen (Yapen Waropen)'),
(194, 8, 'Kerinci'),
(195, 12, 'Ketapang'),
(196, 10, 'Klaten'),
(197, 1, 'Klungkung'),
(198, 30, 'Kolaka'),
(199, 30, 'Kolaka Utara'),
(200, 30, 'Konawe'),
(201, 30, 'Konawe Selatan'),
(202, 30, 'Konawe Utara'),
(203, 13, 'Kotabaru'),
(204, 31, 'Kotamobagu'),
(205, 14, 'Kotawaringin Barat'),
(206, 14, 'Kotawaringin Timur'),
(207, 26, 'Kuantan Singingi'),
(208, 12, 'Kubu Raya'),
(209, 10, 'Kudus'),
(210, 5, 'Kulon Progo'),
(211, 9, 'Kuningan'),
(212, 23, 'Kupang'),
(213, 23, 'Kupang'),
(214, 15, 'Kutai Barat'),
(215, 15, 'Kutai Kartanegara'),
(216, 15, 'Kutai Timur'),
(217, 34, 'Labuhan Batu'),
(218, 34, 'Labuhan Batu Selatan'),
(219, 34, 'Labuhan Batu Utara'),
(220, 33, 'Lahat'),
(221, 14, 'Lamandau'),
(222, 11, 'Lamongan'),
(223, 18, 'Lampung Barat'),
(224, 18, 'Lampung Selatan'),
(225, 18, 'Lampung Tengah'),
(226, 18, 'Lampung Timur'),
(227, 18, 'Lampung Utara'),
(228, 12, 'Landak'),
(229, 34, 'Langkat'),
(230, 21, 'Langsa'),
(231, 24, 'Lanny Jaya'),
(232, 3, 'Lebak'),
(233, 4, 'Lebong'),
(234, 23, 'Lembata'),
(235, 21, 'Lhokseumawe'),
(236, 32, 'Lima Puluh Koto/Kota'),
(237, 17, 'Lingga'),
(238, 22, 'Lombok Barat'),
(239, 22, 'Lombok Tengah'),
(240, 22, 'Lombok Timur'),
(241, 22, 'Lombok Utara'),
(242, 33, 'Lubuk Linggau'),
(243, 11, 'Lumajang'),
(244, 28, 'Luwu'),
(245, 28, 'Luwu Timur'),
(246, 28, 'Luwu Utara'),
(247, 11, 'Madiun'),
(248, 11, 'Madiun'),
(249, 10, 'Magelang'),
(250, 10, 'Magelang'),
(251, 11, 'Magetan'),
(252, 9, 'Majalengka'),
(253, 27, 'Majene'),
(254, 28, 'Makassar'),
(255, 11, 'Malang'),
(256, 11, 'Malang'),
(257, 16, 'Malinau'),
(258, 19, 'Maluku Barat Daya'),
(259, 19, 'Maluku Tengah'),
(260, 19, 'Maluku Tenggara'),
(261, 19, 'Maluku Tenggara Barat'),
(262, 27, 'Mamasa'),
(263, 24, 'Mamberamo Raya'),
(264, 24, 'Mamberamo Tengah'),
(265, 27, 'Mamuju'),
(266, 27, 'Mamuju Utara'),
(267, 31, 'Manado'),
(268, 34, 'Mandailing Natal'),
(269, 23, 'Manggarai'),
(270, 23, 'Manggarai Barat'),
(271, 23, 'Manggarai Timur'),
(272, 25, 'Manokwari'),
(273, 25, 'Manokwari Selatan'),
(274, 24, 'Mappi'),
(275, 28, 'Maros'),
(276, 22, 'Mataram'),
(277, 25, 'Maybrat'),
(278, 34, 'Medan'),
(279, 12, 'Melawi'),
(280, 8, 'Merangin'),
(281, 24, 'Merauke'),
(282, 18, 'Mesuji'),
(283, 18, 'Metro'),
(284, 24, 'Mimika'),
(285, 31, 'Minahasa'),
(286, 31, 'Minahasa Selatan'),
(287, 31, 'Minahasa Tenggara'),
(288, 31, 'Minahasa Utara'),
(289, 11, 'Mojokerto'),
(290, 11, 'Mojokerto'),
(291, 29, 'Morowali'),
(292, 33, 'Muara Enim'),
(293, 8, 'Muaro Jambi'),
(294, 4, 'Muko Muko'),
(295, 30, 'Muna'),
(296, 14, 'Murung Raya'),
(297, 33, 'Musi Banyuasin'),
(298, 33, 'Musi Rawas'),
(299, 24, 'Nabire'),
(300, 21, 'Nagan Raya'),
(301, 23, 'Nagekeo'),
(302, 17, 'Natuna'),
(303, 24, 'Nduga'),
(304, 23, 'Ngada'),
(305, 11, 'Nganjuk'),
(306, 11, 'Ngawi'),
(307, 34, 'Nias'),
(308, 34, 'Nias Barat'),
(309, 34, 'Nias Selatan'),
(310, 34, 'Nias Utara'),
(311, 16, 'Nunukan'),
(312, 33, 'Ogan Ilir'),
(313, 33, 'Ogan Komering Ilir'),
(314, 33, 'Ogan Komering Ulu'),
(315, 33, 'Ogan Komering Ulu Selatan'),
(316, 33, 'Ogan Komering Ulu Timur'),
(317, 11, 'Pacitan'),
(318, 32, 'Padang'),
(319, 34, 'Padang Lawas'),
(320, 34, 'Padang Lawas Utara'),
(321, 32, 'Padang Panjang'),
(322, 32, 'Padang Pariaman'),
(323, 34, 'Padang Sidempuan'),
(324, 33, 'Pagar Alam'),
(325, 34, 'Pakpak Bharat'),
(326, 14, 'Palangka Raya'),
(327, 33, 'Palembang'),
(328, 28, 'Palopo'),
(329, 29, 'Palu'),
(330, 11, 'Pamekasan'),
(331, 3, 'Pandeglang'),
(332, 9, 'Pangandaran'),
(333, 28, 'Pangkajene Kepulauan'),
(334, 2, 'Pangkal Pinang'),
(335, 24, 'Paniai'),
(336, 28, 'Parepare'),
(337, 32, 'Pariaman'),
(338, 29, 'Parigi Moutong'),
(339, 32, 'Pasaman'),
(340, 32, 'Pasaman Barat'),
(341, 15, 'Paser'),
(342, 11, 'Pasuruan'),
(343, 11, 'Pasuruan'),
(344, 10, 'Pati'),
(345, 32, 'Payakumbuh'),
(346, 25, 'Pegunungan Arfak'),
(347, 24, 'Pegunungan Bintang'),
(348, 10, 'Pekalongan'),
(349, 10, 'Pekalongan'),
(350, 26, 'Pekanbaru'),
(351, 26, 'Pelalawan'),
(352, 10, 'Pemalang'),
(353, 34, 'Pematang Siantar'),
(354, 15, 'Penajam Paser Utara'),
(355, 18, 'Pesawaran'),
(356, 18, 'Pesisir Barat'),
(357, 32, 'Pesisir Selatan'),
(358, 21, 'Pidie'),
(359, 21, 'Pidie Jaya'),
(360, 28, 'Pinrang'),
(361, 7, 'Pohuwato'),
(362, 27, 'Polewali Mandar'),
(363, 11, 'Ponorogo'),
(364, 12, 'Pontianak'),
(365, 12, 'Pontianak'),
(366, 29, 'Poso'),
(367, 33, 'Prabumulih'),
(368, 18, 'Pringsewu'),
(369, 11, 'Probolinggo'),
(370, 11, 'Probolinggo'),
(371, 14, 'Pulang Pisau'),
(372, 20, 'Pulau Morotai'),
(373, 24, 'Puncak'),
(374, 24, 'Puncak Jaya'),
(375, 10, 'Purbalingga'),
(376, 9, 'Purwakarta'),
(377, 10, 'Purworejo'),
(378, 25, 'Raja Ampat'),
(379, 4, 'Rejang Lebong'),
(380, 10, 'Rembang'),
(381, 26, 'Rokan Hilir'),
(382, 26, 'Rokan Hulu'),
(383, 23, 'Rote Ndao'),
(384, 21, 'Sabang'),
(385, 23, 'Sabu Raijua'),
(386, 10, 'Salatiga'),
(387, 15, 'Samarinda'),
(388, 12, 'Sambas'),
(389, 34, 'Samosir'),
(390, 11, 'Sampang'),
(391, 12, 'Sanggau'),
(392, 24, 'Sarmi'),
(393, 8, 'Sarolangun'),
(394, 32, 'Sawah Lunto'),
(395, 12, 'Sekadau'),
(396, 28, 'Selayar (Kepulauan Selayar)'),
(397, 4, 'Seluma'),
(398, 10, 'Semarang'),
(399, 10, 'Semarang'),
(400, 19, 'Seram Bagian Barat'),
(401, 19, 'Seram Bagian Timur'),
(402, 3, 'Serang'),
(403, 3, 'Serang'),
(404, 34, 'Serdang Bedagai'),
(405, 14, 'Seruyan'),
(406, 26, 'Siak'),
(407, 34, 'Sibolga'),
(408, 28, 'Sidenreng Rappang/Rapang'),
(409, 11, 'Sidoarjo'),
(410, 29, 'Sigi'),
(411, 32, 'Sijunjung (Sawah Lunto Sijunjung)'),
(412, 23, 'Sikka'),
(413, 34, 'Simalungun'),
(414, 21, 'Simeulue'),
(415, 12, 'Singkawang'),
(416, 28, 'Sinjai'),
(417, 12, 'Sintang'),
(418, 11, 'Situbondo'),
(419, 5, 'Sleman'),
(420, 32, 'Solok'),
(421, 32, 'Solok'),
(422, 32, 'Solok Selatan'),
(423, 28, 'Soppeng'),
(424, 25, 'Sorong'),
(425, 25, 'Sorong'),
(426, 25, 'Sorong Selatan'),
(427, 10, 'Sragen'),
(428, 9, 'Subang'),
(429, 21, 'Subulussalam'),
(430, 9, 'Sukabumi'),
(431, 9, 'Sukabumi'),
(432, 14, 'Sukamara'),
(433, 10, 'Sukoharjo'),
(434, 23, 'Sumba Barat'),
(435, 23, 'Sumba Barat Daya'),
(436, 23, 'Sumba Tengah'),
(437, 23, 'Sumba Timur'),
(438, 22, 'Sumbawa'),
(439, 22, 'Sumbawa Barat'),
(440, 9, 'Sumedang'),
(441, 11, 'Sumenep'),
(442, 8, 'Sungaipenuh'),
(443, 24, 'Supiori'),
(444, 11, 'Surabaya'),
(445, 10, 'Surakarta (Solo)'),
(446, 13, 'Tabalong'),
(447, 1, 'Tabanan'),
(448, 28, 'Takalar'),
(449, 25, 'Tambrauw'),
(450, 16, 'Tana Tidung'),
(451, 28, 'Tana Toraja'),
(452, 13, 'Tanah Bumbu'),
(453, 32, 'Tanah Datar'),
(454, 13, 'Tanah Laut'),
(455, 3, 'Tangerang'),
(456, 3, 'Tangerang'),
(457, 3, 'Tangerang Selatan'),
(458, 18, 'Tanggamus'),
(459, 34, 'Tanjung Balai'),
(460, 8, 'Tanjung Jabung Barat'),
(461, 8, 'Tanjung Jabung Timur'),
(462, 17, 'Tanjung Pinang'),
(463, 34, 'Tapanuli Selatan'),
(464, 34, 'Tapanuli Tengah'),
(465, 34, 'Tapanuli Utara'),
(466, 13, 'Tapin'),
(467, 16, 'Tarakan'),
(468, 9, 'Tasikmalaya'),
(469, 9, 'Tasikmalaya'),
(470, 34, 'Tebing Tinggi'),
(471, 8, 'Tebo'),
(472, 10, 'Tegal'),
(473, 10, 'Tegal'),
(474, 25, 'Teluk Bintuni'),
(475, 25, 'Teluk Wondama'),
(476, 10, 'Temanggung'),
(477, 20, 'Ternate'),
(478, 20, 'Tidore Kepulauan'),
(479, 23, 'Timor Tengah Selatan'),
(480, 23, 'Timor Tengah Utara'),
(481, 34, 'Toba Samosir'),
(482, 29, 'Tojo Una-Una'),
(483, 29, 'Toli-Toli'),
(484, 24, 'Tolikara'),
(485, 31, 'Tomohon'),
(486, 28, 'Toraja Utara'),
(487, 11, 'Trenggalek'),
(488, 19, 'Tual'),
(489, 11, 'Tuban'),
(490, 18, 'Tulang Bawang'),
(491, 18, 'Tulang Bawang Barat'),
(492, 11, 'Tulungagung'),
(493, 28, 'Wajo'),
(494, 30, 'Wakatobi'),
(495, 24, 'Waropen'),
(496, 18, 'Way Kanan'),
(497, 10, 'Wonogiri'),
(498, 10, 'Wonosobo'),
(499, 24, 'Yahukimo'),
(500, 24, 'Yalimo'),
(501, 5, 'Yogyakarta');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lapangan`
--

CREATE TABLE `lapangan` (
  `id_lapangan` int(11) NOT NULL,
  `nama_lapangan` varchar(100) NOT NULL,
  `harga` int(11) NOT NULL,
  `foto` text NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` varchar(50) NOT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `lapangan`
--

INSERT INTO `lapangan` (`id_lapangan`, `nama_lapangan`, `harga`, `foto`, `created_by`, `created_at`, `modified_by`, `modified_at`) VALUES
(1, 'Lapangan A', 100000, 'lapangan-a20180610164236.jpg', 'amperakoding', '2018-06-10 15:37:43', 'amperakoding', '2021-05-17 19:59:32'),
(2, 'Lapangan B', 150000, 'lapangan-b20180610164255.jpg', 'amperakoding', '2018-06-10 16:02:44', 'amperakoding', '2021-05-17 19:59:32'),
(3, 'Lapangan C', 80000, 'lapangan-a20180610164250.jpg', 'amperakoding', '2018-06-10 16:16:17', 'amperakoding', '2021-05-17 19:59:32'),
(4, 'Lapangan D', 100000, 'lapangan-b20180610164305.jpg', 'amperakoding', '2018-06-10 16:25:05', 'amperakoding', '2021-05-17 19:59:32'),
(5, 'Lapangan E', 200000, 'lapangan-c20180610164320.jpg', 'amperakoding', '2018-06-10 16:38:10', 'amperakoding', '2021-05-17 19:59:32'),
(6, 'Lapangan F', 150000, 'lapangan-c20180610164329.jpg', 'amperakoding', '2018-06-10 16:54:28', 'amperakoding', '2021-05-17 19:59:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `login` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `page`
--

CREATE TABLE `page` (
  `id_page` int(11) NOT NULL,
  `judul_page` varchar(50) NOT NULL,
  `judul_seo` varchar(50) NOT NULL,
  `isi_page` text NOT NULL,
  `gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `page`
--

INSERT INTO `page` (`id_page`, `judul_page`, `judul_seo`, `isi_page`, `gambar`) VALUES
(1, 'Home', 'home', '', ''),
(2, 'Download', 'download', 'download', ''),
(3, 'Kontak', 'kontak', '<p style=\"text-align: center;\">&nbsp;<img src=\"http://localhost/tol/assets/images/upload/whatsapp.png\" /><br /><strong>SMS/ Call/ Whatsapp</strong></p>\r\n<p style=\"text-align: center;\">0853-6873-3631</p>\r\n<p style=\"text-align: center;\">0822-8155-1666</p>', ''),
(4, 'Profil', 'profil', '<p style=\"text-align: justify;\">Kami merupakan toko yang menyediakan berbagai macam parfum, obat-obatan herbal, baju koko, dan aksesoris muslim lainnya. Toko kami beralamat di Jl. Dr. M. Isa No.1109, Kuto Batu, Ilir Tim. II, Kota Palembang, Sumatera Selatan 30114.</p>\r\n<p style=\"text-align: justify;\">Berikut adalah foto toko kami:</p>', ''),
(5, 'Order', 'order', '<p>Anda dapat menghubungi&nbsp;kami melalui tombol order via whatsapp di masing-masing produk atau melalui customer service/ kontak yang telah disediakan di sisi kanan website ini</p>', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `provinsi`
--

CREATE TABLE `provinsi` (
  `id_provinsi` int(11) NOT NULL,
  `nama_provinsi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `provinsi`
--

INSERT INTO `provinsi` (`id_provinsi`, `nama_provinsi`) VALUES
(1, 'Bali'),
(2, 'Bangka Belitung'),
(3, 'Banten'),
(4, 'Bengkulu'),
(5, 'DI Yogyakarta'),
(6, 'DKI Jakarta'),
(7, 'Gorontalo'),
(8, 'Jambi'),
(9, 'Jawa Barat'),
(10, 'Jawa Tengah'),
(11, 'Jawa Timur'),
(12, 'Kalimantan Barat'),
(13, 'Kalimantan Selatan'),
(14, 'Kalimantan Tengah'),
(15, 'Kalimantan Timur'),
(16, 'Kalimantan Utara'),
(17, 'Kepulauan Riau'),
(18, 'Lampung'),
(19, 'Maluku'),
(20, 'Maluku Utara'),
(21, 'Nanggroe Aceh Darussalam (NAD)'),
(22, 'Nusa Tenggara Barat (NTB)'),
(23, 'Nusa Tenggara Timur (NTT)'),
(24, 'Papua'),
(25, 'Papua Barat'),
(26, 'Riau'),
(27, 'Sulawesi Barat'),
(28, 'Sulawesi Selatan'),
(29, 'Sulawesi Tengah'),
(30, 'Sulawesi Tenggara'),
(31, 'Sulawesi Utara'),
(32, 'Sumatera Barat'),
(33, 'Sumatera Selatan'),
(34, 'Sumatera Utara');

-- --------------------------------------------------------

--
-- Struktur dari tabel `slider`
--

CREATE TABLE `slider` (
  `id_slider` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `nama_slider` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `foto` text NOT NULL,
  `foto_type` char(10) NOT NULL,
  `foto_size` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` char(50) NOT NULL,
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `modified_by` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `slider`
--

INSERT INTO `slider` (`id_slider`, `no_urut`, `nama_slider`, `link`, `foto`, `foto_type`, `foto_size`, `created_at`, `created_by`, `modified_at`, `modified_by`) VALUES
(1, 1, 'Slider 1', 'http://www.yahoo.com ', '120180610164516', '.jpg', 203, '2017-11-25 08:05:03', 'amperakoding', '2021-05-17 20:00:16', 'amperakoding'),
(2, 2, 'Slider 2', 'http://www.google.com ', '220180610164521', '.jpg', 833, '2017-11-25 08:05:03', 'amperakoding', '2021-05-17 20:00:16', 'amperakoding'),
(3, 3, 'XXZ', 'http://www.facebook.com', '320180610164527', '.jpg', 167, '2017-11-25 08:05:03', 'amperakoding', '2021-05-17 20:00:16', 'amperakoding');

-- --------------------------------------------------------

--
-- Struktur dari tabel `subscriber`
--

CREATE TABLE `subscriber` (
  `id_subscriber` int(11) NOT NULL,
  `email` char(20) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_trans` int(11) NOT NULL,
  `id_invoice` char(15) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `diskon` int(11) NOT NULL,
  `grand_total` int(11) NOT NULL,
  `deadline` datetime NOT NULL,
  `catatan` text NOT NULL,
  `status` int(11) NOT NULL,
  `created_date` date NOT NULL,
  `created_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_trans`, `id_invoice`, `user_id`, `subtotal`, `diskon`, `grand_total`, `deadline`, `catatan`, `status`, `created_date`, `created_time`) VALUES
(1, 'J-210517-0001', 3, 100000, 0, 100000, '2021-05-17 21:03:57', '', 2, '2021-05-17', '08:03:19'),
(2, 'J-210517-0002', 4, 260000, 50000, 210000, '2021-05-17 21:10:50', 'takada', 2, '2021-05-17', '08:09:54'),
(3, 'J-210516-0003', 3, 300000, 0, 300000, '2021-05-16 21:20:17', '', 2, '2021-05-16', '08:20:09'),
(4, 'J-210408-0001', 3, 330000, 0, 330000, '2021-04-08 21:21:53', '', 2, '2021-04-08', '08:21:35'),
(5, 'J-210408-0002', 3, 150000, 0, 150000, '2021-04-08 21:22:35', '', 2, '2021-04-08', '08:22:29'),
(6, 'J-210408-0003', 3, 300000, 0, 300000, '2021-04-08 21:23:15', '', 2, '2021-04-08', '08:23:09'),
(7, 'J-210410-0004', 3, 300000, 0, 300000, '2021-04-10 21:24:07', '', 2, '2021-04-10', '08:23:52'),
(8, 'J-210517-0003', 3, 150000, 0, 150000, '2021-05-17 21:23:05', '', 1, '2021-05-17', '08:23:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_detail`
--

CREATE TABLE `transaksi_detail` (
  `id_transdet` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `lapangan_id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam_mulai` time DEFAULT NULL,
  `durasi` int(11) NOT NULL,
  `jam_selesai` time DEFAULT NULL,
  `harga_jual` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `transaksi_detail`
--

INSERT INTO `transaksi_detail` (`id_transdet`, `trans_id`, `lapangan_id`, `tanggal`, `jam_mulai`, `durasi`, `jam_selesai`, `harga_jual`, `total`, `created_at`) VALUES
(1, 1, 1, '2021-05-18', '07:00:00', 1, '08:00:00', 100000, 100000, '2021-05-17 20:03:19'),
(2, 2, 1, '2021-05-18', '08:00:00', 1, '09:00:00', 100000, 100000, '2021-05-17 20:09:54'),
(3, 2, 3, '2021-05-17', '10:00:00', 2, '12:00:00', 80000, 160000, '2021-05-17 20:09:55'),
(4, 3, 4, '2021-05-16', '13:00:00', 3, '16:00:00', 100000, 300000, '2021-05-16 20:20:09'),
(5, 4, 1, '2021-04-09', '22:00:00', 1, '23:00:00', 100000, 100000, '2021-04-08 20:21:35'),
(6, 4, 2, '2021-04-11', '21:00:00', 1, '22:00:00', 150000, 150000, '2021-04-08 20:21:36'),
(7, 4, 3, '2021-04-13', '21:00:00', 1, '22:00:00', 80000, 80000, '2021-04-08 20:21:36'),
(8, 5, 6, '2021-04-08', '10:00:00', 1, '11:00:00', 150000, 150000, '2021-04-08 20:22:29'),
(9, 6, 2, '2021-04-10', '10:00:00', 2, '12:00:00', 150000, 300000, '2021-04-08 20:23:09'),
(10, 7, 2, '2021-04-10', '08:00:00', 2, '10:00:00', 150000, 300000, '2021-04-10 20:23:52'),
(11, 8, 2, '2021-05-18', '10:00:00', 1, '11:00:00', 150000, 150000, '2021-05-17 20:23:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `provinsi` int(11) DEFAULT NULL,
  `kota` int(11) DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertype` int(11) NOT NULL,
  `active` tinyint(3) UNSIGNED DEFAULT NULL,
  `photo` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `photo_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `activation_code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `forgotten_password_code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `forgotten_password_time` int(10) UNSIGNED DEFAULT NULL,
  `remember_code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_login` int(11) DEFAULT NULL,
  `created_on` int(11) NOT NULL,
  `modified` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `email`, `phone`, `provinsi`, `kota`, `address`, `usertype`, `active`, `photo`, `photo_type`, `ip_address`, `salt`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `last_login`, `created_on`, `modified`) VALUES
(1, 'SuperAdmin', 'superadmin', '$2y$08$TWMdtdacqPE5yEz9n1LwFuhEVmiDTTsupl12M45tCQihzF1tu2N/6', 'superadmin@gmail.com', '081228289766', 6, 151, 'asdasdasdsa', 1, 1, 'mazmi20180205001726', '.jpg', '::1', NULL, 'c6ad242e6fd3de875568c7de5ba23af4a24137ef', 'ZRbSp7wMJU4jdY3-Ahotce81d5c57620fbacdab1', 1751960448, NULL, 1621257748, 2147483647, '2025-07-08 15:40:48'),
(2, 'Admin', 'administrator', '$2y$08$rnCngWyQhFLdVJijctNDKuwJZ8o9VfcSsZ9IM9XN71ugxIpQFeCWe', 'administrator@gmail.com', '08124124', NULL, NULL, 'kaldjlas', 2, 1, 'admin20180424102408', '.jpeg', '::1', NULL, NULL, NULL, NULL, NULL, 1621252084, 1524551716, '2021-05-17 18:48:04'),
(3, 'Batistuta', 'batistuta', '$2y$08$.5EYrM8S8Up0LcpFiEmjauyPVdWOmylLZ.MqM0zBKyDVKniwdVbYi', 'batistuta@gmail.com', '0812412414', 33, 327, 'Jl. Skdlajsdlasjkdl', 4, 1, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 1621257779, 1528634033, '2021-05-17 20:22:59'),
(4, 'User Premium', 'userpremium', '$2y$08$Wv3MA.DnwTNzBeF62o9neuSXeVdIA/bjlxOzSxtD6DtgStEBn//s.', 'userpremium@gmail.com', '0812412412', 3, 106, 'kaljdklasjdkl', 3, 1, NULL, NULL, '::1', NULL, NULL, NULL, NULL, NULL, 1621252638, 1531807819, '2021-05-17 18:57:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_group`
--

CREATE TABLE `users_group` (
  `id_group` int(11) NOT NULL,
  `name_group` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `users_group`
--

INSERT INTO `users_group` (`id_group`, `name_group`) VALUES
(1, 'SuperAdmin'),
(2, 'Administrator'),
(3, 'Member Premium'),
(4, 'Member Biasa');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`id_album`);

--
-- Indeks untuk tabel `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indeks untuk tabel `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id_company`);

--
-- Indeks untuk tabel `diskon`
--
ALTER TABLE `diskon`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id_event`);

--
-- Indeks untuk tabel `foto`
--
ALTER TABLE `foto`
  ADD PRIMARY KEY (`id_foto`),
  ADD KEY `foto_FK` (`album_id`);

--
-- Indeks untuk tabel `jam`
--
ALTER TABLE `jam`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `kontak`
--
ALTER TABLE `kontak`
  ADD PRIMARY KEY (`id_kontak`);

--
-- Indeks untuk tabel `lapangan`
--
ALTER TABLE `lapangan`
  ADD PRIMARY KEY (`id_lapangan`);

--
-- Indeks untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`id_page`);

--
-- Indeks untuk tabel `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`id_slider`);

--
-- Indeks untuk tabel `subscriber`
--
ALTER TABLE `subscriber`
  ADD PRIMARY KEY (`id_subscriber`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_trans`),
  ADD KEY `transaksi_FK` (`user_id`);

--
-- Indeks untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD PRIMARY KEY (`id_transdet`),
  ADD KEY `transaksi_detail_FK` (`lapangan_id`),
  ADD KEY `transaksi_detail_FK_1` (`trans_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users_group`
--
ALTER TABLE `users_group`
  ADD PRIMARY KEY (`id_group`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `album`
--
ALTER TABLE `album`
  MODIFY `id_album` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `company`
--
ALTER TABLE `company`
  MODIFY `id_company` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `event`
--
ALTER TABLE `event`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `foto`
--
ALTER TABLE `foto`
  MODIFY `id_foto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `jam`
--
ALTER TABLE `jam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `kontak`
--
ALTER TABLE `kontak`
  MODIFY `id_kontak` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `lapangan`
--
ALTER TABLE `lapangan`
  MODIFY `id_lapangan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `page`
--
ALTER TABLE `page`
  MODIFY `id_page` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `slider`
--
ALTER TABLE `slider`
  MODIFY `id_slider` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `subscriber`
--
ALTER TABLE `subscriber`
  MODIFY `id_subscriber` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_trans` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  MODIFY `id_transdet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users_group`
--
ALTER TABLE `users_group`
  MODIFY `id_group` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `foto_FK` FOREIGN KEY (`album_id`) REFERENCES `album` (`id_album`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD CONSTRAINT `transaksi_detail_FK` FOREIGN KEY (`lapangan_id`) REFERENCES `lapangan` (`id_lapangan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_detail_FK_1` FOREIGN KEY (`trans_id`) REFERENCES `transaksi` (`id_trans`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Database: `futsal_booking`
--
CREATE DATABASE IF NOT EXISTS `futsal_booking` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `futsal_booking`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `arenas`
--

CREATE TABLE `arenas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `number` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `image` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `arenas`
--

INSERT INTO `arenas` (`id`, `number`, `price`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 10, 75000, NULL, 0, '2025-07-03 08:20:08', '2025-07-03 08:20:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `arena_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `time_from` datetime NOT NULL,
  `time_to` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `grand_total` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `fields`
--

CREATE TABLE `fields` (
  `id` int(11) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_type` varchar(50) NOT NULL,
  `price_per_hour` decimal(10,2) NOT NULL,
  `status` enum('available','maintenance','booked') DEFAULT 'available',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `fields`
--

INSERT INTO `fields` (`id`, `field_name`, `field_type`, `price_per_hour`, `status`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Lapangan A', 'Indoor', 100000.00, 'available', 'Lapangan indoor dengan fasilitas lengkap', '2025-07-08 15:15:13', '2025-07-08 15:15:13'),
(2, 'Lapangan B', 'Outdoor', 80000.00, 'available', 'Lapangan outdoor dengan rumput sintetis', '2025-07-08 15:15:13', '2025-07-08 15:15:13'),
(3, 'Lapangan C', 'Indoor', 120000.00, 'available', 'Lapangan indoor premium dengan AC', '2025-07-08 15:15:13', '2025-07-08 15:15:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Arena', 1, '2b4733e3-2f26-4505-9245-c900256d281e', 'photo', '68663d239d922_images (2)', '68663d239d922_images-(2).jpg', 'image/jpeg', 'public', 'public', 13968, '[]', '[]', '[]', 1, '2025-07-03 08:20:08', '2025-07-03 08:20:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_02_04_020715_create_permissions_table', 1),
(6, '2022_02_04_020803_create_roles_table', 1),
(7, '2022_02_04_020910_create_role_user_table', 1),
(8, '2022_02_04_021018_create_permission_role_table', 1),
(9, '2022_04_04_143907_create_arenas_table', 1),
(10, '2022_04_04_144215_create_bookings_table', 1),
(11, '2022_04_05_170727_create_media_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `permissions`
--

INSERT INTO `permissions` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'user_management_access', NULL, NULL),
(2, 'user_management_create', NULL, NULL),
(3, 'user_management_edit', NULL, NULL),
(4, 'user_management_view', NULL, NULL),
(5, 'user_management_delete', NULL, NULL),
(6, 'permission_access', NULL, NULL),
(7, 'permission_create', NULL, NULL),
(8, 'permission_edit', NULL, NULL),
(9, 'permission_view', NULL, NULL),
(10, 'permission_delete', NULL, NULL),
(11, 'role_access', NULL, NULL),
(12, 'role_create', NULL, NULL),
(13, 'role_edit', NULL, NULL),
(14, 'role_view', NULL, NULL),
(15, 'role_delete', NULL, NULL),
(16, 'user_access', NULL, NULL),
(17, 'user_create', NULL, NULL),
(18, 'user_edit', NULL, NULL),
(19, 'user_view', NULL, NULL),
(20, 'user_delete', NULL, NULL),
(21, 'arena_access', NULL, NULL),
(22, 'arena_create', NULL, NULL),
(23, 'arena_edit', NULL, NULL),
(24, 'arena_view', NULL, NULL),
(25, 'arena_delete', NULL, NULL),
(26, 'booking_access', NULL, NULL),
(27, 'booking_create', NULL, NULL),
(28, 'booking_edit', NULL, NULL),
(29, 'booking_view', NULL, NULL),
(30, 'booking_delete', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `permission_role`
--

CREATE TABLE `permission_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 3, 1, NULL, NULL),
(4, 4, 1, NULL, NULL),
(5, 5, 1, NULL, NULL),
(6, 6, 1, NULL, NULL),
(7, 7, 1, NULL, NULL),
(8, 8, 1, NULL, NULL),
(9, 9, 1, NULL, NULL),
(10, 10, 1, NULL, NULL),
(11, 11, 1, NULL, NULL),
(12, 12, 1, NULL, NULL),
(13, 13, 1, NULL, NULL),
(14, 14, 1, NULL, NULL),
(15, 15, 1, NULL, NULL),
(16, 16, 1, NULL, NULL),
(17, 17, 1, NULL, NULL),
(18, 18, 1, NULL, NULL),
(19, 19, 1, NULL, NULL),
(20, 20, 1, NULL, NULL),
(21, 21, 1, NULL, NULL),
(22, 22, 1, NULL, NULL),
(23, 23, 1, NULL, NULL),
(24, 24, 1, NULL, NULL),
(25, 25, 1, NULL, NULL),
(26, 26, 1, NULL, NULL),
(27, 27, 1, NULL, NULL),
(28, 28, 1, NULL, NULL),
(29, 29, 1, NULL, NULL),
(30, 30, 1, NULL, NULL),
(31, 1, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'admin', NULL, NULL),
(2, 'user', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_user`
--

CREATE TABLE `role_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@example.com', NULL, '$2y$10$hKrRGjm0j440PX/Osx96AOrs23W1tbcqH9qqF.KtgdyvpiHzcTLpi', 'Cs6pTZvL002v8xBCuhVZpagZRcGjOTpVzeMtRzwQ7z3Pj5WVkicBButoFe0O', NULL, NULL),
(2, 'Shironeko', 'shironeko@gmail.com', NULL, '$2y$10$dJKNlOPFXeA9MSCAS7My0e/./7YEanpeYOERLbfNNAt1lSm.r5/tO', NULL, '2025-07-03 08:14:41', '2025-07-03 08:14:41');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `arenas`
--
ALTER TABLE `arenas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_arena_id_foreign` (`arena_id`),
  ADD KEY `bookings_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_permission_id_foreign` (`permission_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`),
  ADD KEY `role_user_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `arenas`
--
ALTER TABLE `arenas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_arena_id_foreign` FOREIGN KEY (`arena_id`) REFERENCES `arenas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `futsal_skrikandi`
--
CREATE DATABASE IF NOT EXISTS `futsal_skrikandi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `futsal_skrikandi`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal`
--

CREATE TABLE `jadwal` (
  `kode_jadwal` varchar(5) NOT NULL,
  `jam` varchar(15) NOT NULL,
  `harga` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jadwal`
--

INSERT INTO `jadwal` (`kode_jadwal`, `jam`, `harga`) VALUES
('A07', '07.00-08.00', 70000),
('A08', '08.00-09.00', 70000),
('A09', '09.00-10.00', 70000),
('A10', '10.00-11.00', 70000),
('A11', '11.00-12.00', 70000),
('A12', '12.00-13.00', 70000),
('A13', '13.00-14.00', 70000),
('A14', '14.00-15.00', 70000),
('A15', '15.00-16.00', 80000),
('A16', '16.00-17.00', 80000),
('A17', '17.00-18.00', 80000),
('A18', '18.00-19.00', 110000),
('A19', '19.00-20.00', 110000),
('A20', '20.00-21.00', 110000),
('A21', '21.00-22.00', 110000),
('A22', '22.00-23.00', 110000),
('B07', '07.00-08.00', 70000),
('B08', '08.00-09.00', 70000),
('B09', '09.00-10.00', 70000),
('B10', '10.00-11.00', 70000),
('B11', '11.00-12.00', 70000),
('B12', '12.00-13.00', 70000),
('B13', '13.00-14.00', 70000),
('B14', '14.00-15.00', 70000),
('B15', '15.00-16.00', 80000),
('B16', '16.00-17.00', 80000),
('B17', '17.00-18.00', 80000),
('B18', '18.00-19.00', 110000),
('B19', '19.00-20.00', 110000),
('B20', '20.00-21.00', 110000),
('B21', '21.00-22.00', 110000),
('B22', '22.00-23.00', 110000),
('T07', '07.00-08.00', 70000),
('T08', '08.00-09.00', 70000),
('T09', '09.00-10.00', 70000),
('T10', '10.00-11.00', 70000),
('T11', '11.00-12.00', 70000),
('T12', '12.00-13.00', 70000),
('T13', '13.00-14.00', 70000),
('T14', '14.00-15.00', 70000),
('T15', '15.00-16.00', 80000),
('T16', '16.00-17.00', 80000),
('T17', '17.00-18.00', 80000),
('T18', '18.00-19.00', 110000),
('T19', '19.00-20.00', 110000),
('T20', '20.00-21.00', 110000),
('T21', '21.00-22.00', 110000),
('T22', '22.00-23.00', 110000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lapangan`
--

CREATE TABLE `lapangan` (
  `kode_lapangan` varchar(5) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `lokasi` varchar(20) NOT NULL,
  `lat` decimal(10,6) NOT NULL,
  `lng` decimal(10,6) NOT NULL,
  `kode_jadwal` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lapangan`
--

INSERT INTO `lapangan` (`kode_lapangan`, `nama`, `lokasi`, `lat`, `lng`, `kode_jadwal`) VALUES
('LA-07', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A07'),
('LA-08', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A08'),
('LA-09', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A09'),
('LA-10', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A10'),
('LA-11', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A11'),
('LA-12', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A12'),
('LA-13', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A13'),
('LA-14', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A14'),
('LA-15', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A15'),
('LA-16', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A16'),
('LA-17', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A17'),
('LA-18', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A18'),
('LA-19', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A19'),
('LA-20', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A20'),
('LA-21', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A21'),
('LA-22', 'Lapangan Atas', 'Atas', -5.376350, 105.255730, 'A22'),
('LB-07', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B07'),
('LB-08', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B08'),
('LB-09', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B09'),
('LB-10', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B10'),
('LB-11', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B11'),
('LB-12', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B12'),
('LB-13', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B13'),
('LB-14', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B14'),
('LB-15', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B15'),
('LB-16', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B16'),
('LB-17', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B17'),
('LB-18', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B18'),
('LB-19', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B19'),
('LB-20', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B20'),
('LB-21', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B21'),
('LB-22', 'Lapangan Bawah', 'Bawah', -5.376141, 105.255585, 'B22'),
('LT-07', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T07'),
('LT-08', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T08'),
('LT-09', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T09'),
('LT-10', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T10'),
('LT-11', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T11'),
('LT-12', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T12'),
('LT-13', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T13'),
('LT-14', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T14'),
('LT-15', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T15'),
('LT-16', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T16'),
('LT-17', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T17'),
('LT-18', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T18'),
('LT-19', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T19'),
('LT-20', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T20'),
('LT-21', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T21'),
('LT-22', 'Lapangan Tengah', 'Tengah', -5.376303, 105.255432, 'T22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2020_03_19_175411_make_table', 1),
(2, '2020_03_19_175713_relation_table', 1),
(3, '2020_04_15_184738_change_unique_key', 1),
(4, '2020_04_22_135818_update_lapangan', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `operator`
--

CREATE TABLE `operator` (
  `kode_operator` int(10) UNSIGNED NOT NULL,
  `nama` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `operator`
--

INSERT INTO `operator` (`kode_operator`, `nama`, `password`) VALUES
(1, 'Rivaldo', '$2a$12$yZMkQRMN05oNkjXT7KxpQ.d0JETp/F/k2yaNjv3j5mnhJQdOabN.G'),
(2, 'Iqbal', '$2y$10$nvH/ZwqnEtawXFX7h.QPGe9Nf3KiwA950DQ2EkAKubCgxclm9SUFe'),
(3, 'Jefri', '$2y$10$K.RM4NKBNobfpVT.IPp4te6J.jh5KbTDAhSZnGWIVWShAdPrHQzzu');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `rekap`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `rekap` (
`kode_transaksi` int(10) unsigned
,`tanggal` date
,`kode_lapangan` varchar(5)
,`jam` varchar(15)
,`diskon` int(10) unsigned
,`harga` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `kode_transaksi` int(10) UNSIGNED NOT NULL,
  `kode_operator` int(10) UNSIGNED NOT NULL,
  `kode_user` int(10) UNSIGNED NOT NULL,
  `kode_lapangan` varchar(5) NOT NULL,
  `kode_jadwal` varchar(5) NOT NULL,
  `diskon` int(10) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`kode_transaksi`, `kode_operator`, `kode_user`, `kode_lapangan`, `kode_jadwal`, `diskon`, `tanggal`) VALUES
(1, 1, 4, 'LA-07', 'A07', 20, '2023-07-28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `kode_user` int(10) UNSIGNED NOT NULL,
  `nama` varchar(50) NOT NULL,
  `telepon` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`kode_user`, `nama`, `telepon`) VALUES
(1, 'Budi Budiman', '081122334455'),
(2, 'Caca Macaca', '082233445566'),
(3, 'Andi Surandi', '083344556677'),
(4, 'Adudu', '081890175');

-- --------------------------------------------------------

--
-- Struktur untuk view `rekap`
--
DROP TABLE IF EXISTS `rekap`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rekap`  AS SELECT `a`.`kode_transaksi` AS `kode_transaksi`, `a`.`tanggal` AS `tanggal`, `a`.`kode_lapangan` AS `kode_lapangan`, `b`.`jam` AS `jam`, `a`.`diskon` AS `diskon`, `b`.`harga` AS `harga` FROM (`transaksi` `a` join `jadwal` `b` on(`a`.`kode_jadwal` = `b`.`kode_jadwal`)) ;
--
-- Database: `kppm_center`
--
CREATE DATABASE IF NOT EXISTS `kppm_center` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kppm_center`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL,
  `hotel_nama` varchar(100) NOT NULL,
  `hotel_alamat` varchar(255) NOT NULL,
  `hotel_img` varchar(255) NOT NULL,
  `hotel_rating` int(11) NOT NULL,
  `hotel_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `hotel_updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `hotel_nama`, `hotel_alamat`, `hotel_img`, `hotel_rating`, `hotel_created_at`, `hotel_updated_at`) VALUES
(1, 'Best Western (Dummy)', 'Bahu', 'hotel_dummy.jpg', 5, '2025-07-28 11:00:16', '2025-07-28 11:00:16'),
(2, 'Best Western (Dummy)', 'Bahu', 'hotel_dummy.jpg', 3, '2025-07-28 11:06:38', '2025-07-28 11:06:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_kamar`
--

CREATE TABLE `jenis_kamar` (
  `jenis_kamar_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `jenis_kamar_nama` varchar(100) NOT NULL,
  `jenis_kamar_harga` int(11) NOT NULL,
  `jenis_kamar_img` varchar(255) NOT NULL,
  `jenis_kamar_kapasitas` int(11) NOT NULL DEFAULT 1,
  `jenis_kamar_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `jenis_kamar_updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jenis_kamar`
--

INSERT INTO `jenis_kamar` (`jenis_kamar_id`, `hotel_id`, `jenis_kamar_nama`, `jenis_kamar_harga`, `jenis_kamar_img`, `jenis_kamar_kapasitas`, `jenis_kamar_created_at`, `jenis_kamar_updated_at`) VALUES
(1, 1, 'Superior', 450000, 'jk_dummy.jpg', 2, '2025-07-28 11:05:45', '2025-07-28 11:05:45'),
(2, 1, 'Deluxe', 550000, 'jk_dummy.jpg', 3, '2025-07-28 11:06:09', '2025-07-28 11:06:09'),
(3, 1, 'Superior 2', 450000, 'jk_dummy.jpg', 2, '2025-07-28 11:06:53', '2025-07-28 11:06:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelompok`
--

CREATE TABLE `kelompok` (
  `kelompok_id` int(11) NOT NULL,
  `kelompok_nama` varchar(100) NOT NULL,
  `kelompok_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `kelompok_updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peserta`
--

CREATE TABLE `peserta` (
  `peserta_id` int(11) NOT NULL,
  `peserta_nama` varchar(100) NOT NULL,
  `peserta_wa` varchar(15) NOT NULL,
  `peserta_jk` varchar(10) NOT NULL,
  `peserta_keterangan` varchar(100) NOT NULL,
  `peserta_usia` int(11) NOT NULL,
  `peserta_kota` varchar(100) NOT NULL,
  `peserta_prov` varchar(100) NOT NULL,
  `peserta_gereja` varchar(100) NOT NULL,
  `peserta_jenis_ak` varchar(100) NOT NULL,
  `peserta_is_kk` smallint(6) NOT NULL DEFAULT 0,
  `peserta_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `peserta_updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `peserta_kelompok_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peserta_booking_kamar`
--

CREATE TABLE `peserta_booking_kamar` (
  `pbk_id` int(11) NOT NULL,
  `kelompok_id` int(11) NOT NULL,
  `jenis_kamar_id` int(11) NOT NULL,
  `pbk_checkin` datetime NOT NULL,
  `pbk_checkout` datetime NOT NULL,
  `pbk_no_kamar` varchar(100) DEFAULT NULL,
  `pbk_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `pbk_updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_wa` varchar(15) NOT NULL,
  `user_role` enum('admin','transportasi','konsumsi','akomodasi') NOT NULL DEFAULT 'admin',
  `user_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `user_updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotel_id`);

--
-- Indeks untuk tabel `jenis_kamar`
--
ALTER TABLE `jenis_kamar`
  ADD PRIMARY KEY (`jenis_kamar_id`),
  ADD KEY `hotel_id` (`hotel_id`);

--
-- Indeks untuk tabel `kelompok`
--
ALTER TABLE `kelompok`
  ADD PRIMARY KEY (`kelompok_id`);

--
-- Indeks untuk tabel `peserta`
--
ALTER TABLE `peserta`
  ADD PRIMARY KEY (`peserta_id`),
  ADD KEY `peserta_kelompok_id` (`peserta_kelompok_id`);

--
-- Indeks untuk tabel `peserta_booking_kamar`
--
ALTER TABLE `peserta_booking_kamar`
  ADD PRIMARY KEY (`pbk_id`),
  ADD KEY `kelompok_id` (`kelompok_id`),
  ADD KEY `jenis_kamar_id` (`jenis_kamar_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `jenis_kamar`
--
ALTER TABLE `jenis_kamar`
  MODIFY `jenis_kamar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `kelompok`
--
ALTER TABLE `kelompok`
  MODIFY `kelompok_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `peserta`
--
ALTER TABLE `peserta`
  MODIFY `peserta_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `peserta_booking_kamar`
--
ALTER TABLE `peserta_booking_kamar`
  MODIFY `pbk_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jenis_kamar`
--
ALTER TABLE `jenis_kamar`
  ADD CONSTRAINT `jenis_kamar_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `peserta`
--
ALTER TABLE `peserta`
  ADD CONSTRAINT `peserta_ibfk_1` FOREIGN KEY (`peserta_kelompok_id`) REFERENCES `kelompok` (`kelompok_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `peserta_booking_kamar`
--
ALTER TABLE `peserta_booking_kamar`
  ADD CONSTRAINT `peserta_booking_kamar_ibfk_1` FOREIGN KEY (`kelompok_id`) REFERENCES `kelompok` (`kelompok_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `peserta_booking_kamar_ibfk_2` FOREIGN KEY (`jenis_kamar_id`) REFERENCES `jenis_kamar` (`jenis_kamar_id`) ON DELETE CASCADE;
--
-- Database: `kppm_sendmsg`
--
CREATE DATABASE IF NOT EXISTS `kppm_sendmsg` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kppm_sendmsg`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `participants`
--

CREATE TABLE `participants` (
  `id` int(11) NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  `nama_peserta` varchar(255) DEFAULT NULL,
  `nomor_whatsapp` varchar(20) DEFAULT NULL,
  `jenis_kelamin` char(1) DEFAULT NULL,
  `usia` varchar(20) DEFAULT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `asal_gereja` varchar(255) DEFAULT NULL,
  `kota_kabupaten` varchar(255) DEFAULT NULL,
  `provinsi` varchar(255) DEFAULT NULL,
  `akomodasi_konsumsi` text DEFAULT NULL,
  `kepala_penanggung_jawab_kamar` varchar(255) DEFAULT NULL,
  `pilihan_hotel` varchar(255) DEFAULT NULL,
  `pilihan_kamar` varchar(255) DEFAULT NULL,
  `kedatangan` varchar(255) DEFAULT NULL,
  `kepulangan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `participants`
--

INSERT INTO `participants` (`id`, `timestamp`, `nama_peserta`, `nomor_whatsapp`, `jenis_kelamin`, `usia`, `jabatan`, `asal_gereja`, `kota_kabupaten`, `provinsi`, `akomodasi_konsumsi`, `kepala_penanggung_jawab_kamar`, `pilihan_hotel`, `pilihan_kamar`, `kedatangan`, `kepulangan`, `created_at`) VALUES
(2660, '2025-07-02 12:19:45', 'Abdiel Setiawan Firmanto', '081390225215', 'L', '45', 'Pdm.', 'GKTDI ponompiaan', 'Bolaang Mongondow', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Abdiel Setiawan Firmanto', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:35'),
(2661, '2025-07-02 12:35:13', 'Abraham Souisa Batmanlusy', '081352956029', 'L', '23', 'Pdm.', 'Gereja Pantekosta Tabernakel Kristus Imam Besar Ambon', 'Ambon', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Abraham Souisa Batmanlusy', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:35'),
(2662, '2025-07-02 10:24:30', 'Abraham Yose R.', '081391100280', 'L', '4 Tahun', 'Anak Hamba Tuhan', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Yosua Victoria', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe sea view Rp. 750.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2663, '2025-07-05 22:37:14', 'Adolfine Tatuil', '082346333877', 'P', '73', 'Istri Hamba Tuhan', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jerry Mandagie', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2664, '2025-08-02 11:33:27', 'Agnes R. Saleppa', '081310684777', 'P', '60', 'Istri Hamba Tuhan', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Timotius O. Saleppa', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:35'),
(2665, '2025-08-03 18:16:25', 'Agus Roberd Mourice Suria', '089609070604', 'L', '45', 'Hamba Tuhan', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', '-', '', '', 'Selasa, 2 September 2025', 'Kanis, 4 September 2025', '2025-08-29 15:18:35'),
(2666, '2025-07-02 12:26:51', 'Agustine Lase', '081283115805', 'P', '67 thn', 'Ibu Janda Hamba Tuhan', 'GKTDI ALFA & OMEGA Bekasi', 'KOTA BEKASI', 'JAWA BARAT', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Belum ada', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:35'),
(2667, '2025-08-02 12:23:02', 'Agustine Lase', '0812-8311-5805', 'P', '67', 'Ibu Janda Hamba Tuhan', 'GKTDI Kristus Alfa & Omega', 'Bekasi', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Agustine Lase', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:35'),
(2668, '2025-07-02 09:40:14', 'Albert Hezky Christiawan', '081288992337', 'L', '38 Tahun', 'Pdt.', 'GPSDI KRISTUS PENEBUS', 'Nabire', 'Papua Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Albert Hezky Christiawan', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2669, '2025-07-02 15:13:46', 'ALFIAN PANINGO', '085845528488', 'L', '47', 'Pdt.', 'GKTDI', 'BONTANG', 'KALIMANTAN TIMUR', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'ALFIAN PANINGO', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2670, '2025-07-02 15:22:29', 'ALFRIDA YACOB', '085845528488', 'P', '45', 'Istri Hamba Tuhan', 'GKTDI', 'BONTANG', 'KALIMANTAN TIMUR', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'ALFIAN PANINGO', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2671, '2025-07-30 08:11:30', 'Alfrida yohanis', '085242277281', 'P', '56thn', 'Istri Hamba Tuhan', 'Gpt Kristus Raja Makassar', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Suami', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2672, '2025-07-16 12:58:31', 'ANDAREAS PASAMPANG SURA\'', '081347840818', 'L', '49', 'Pdt.', 'GKTDI KRISTUS AJAIB', 'SAMARINDA', 'KALIMANTAN TIMUR', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2673, '2025-08-02 11:40:04', 'Andrey C. Songan', '082199024337', 'L', '53', 'Pdt.', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Andrey C. Songan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2674, '2025-07-27 17:11:42', 'Andy V palar', '081390286403', 'L', '48 Tahun', 'Pdt.', 'Gereja Pantekosta di indonesia', 'Kab. Semarang', 'Jawa tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sumarno', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:35'),
(2675, '2025-07-05 16:01:38', 'Angelina Sampouw', '085240523997', 'P', '37', 'Istri Hamba Tuhan', 'Gpsdi alfa omega taratara ', 'Tomohon', 'Sulut', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Gideon Esing ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:35'),
(2676, '2025-07-02 10:04:49', 'Anita R Sianturi', '085242449681', 'P', '34 Tahun', 'Istri Hamba Tuhan', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat Daya', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Rufus Y Simamora', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2677, '2025-07-26 15:11:02', 'Anton Kornelius', '+62 823-7348-4384', 'L', '39th', 'Pengerja', 'GKTDI Kristus Pengharapan - Kotaagung, Lampung', 'Tanggamus', 'Lampung', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Anton', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2678, '2025-08-02 16:55:20', 'Apseven Tantu', '081340555832', 'L', '49', 'Pdt.', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yehezkiel Nederupun', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2679, '2025-07-07 00:53:06', 'Arinson Purba', '081350123731', 'L', '63', 'Pdt.', 'GKTDI Kristus Penolong', 'Samarinda', 'KALIMANTAN TIMUR', 'Akomodasi urus sendiri konsumsi panitia', 'Arinson Purba', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2680, '2025-07-02 10:32:09', 'Arn Peter Aviezer Gawe', '085397730737', 'L', '5', 'Anak Hamba Tuhan', 'GPT KRISTUS PENOLONG Bonebae 1', 'Tojo Unauna', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Edaaprelius Gawe', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2681, '2025-08-01 21:38:47', 'Arthur Yoldi Lontaan', '087872208628', 'L', '49 thn', 'Pdt.', 'GPdI ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Arthur Lontaan ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2682, '2025-07-07 20:08:29', 'Azriel Purba', '082358381193/0853677', 'L', '32', 'Pdm.', 'GPT KRISTUS GEMBALA', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt. Nelson Tambunan', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2683, '2025-07-12 10:59:24', 'BEATRIS KURANTHA', '085343524104', 'P', '60', 'Ibu Janda Hamba Tuhan', 'GPT KRISTUS AJAIB BIAU ', 'Siau Tagulandang Biaro ', 'SULAWESI UTARA ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'BEATRIS KURANTHA ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2684, '2025-07-30 18:26:31', 'Bella Rando', '082344391782', 'P', '24', 'Pengerja', 'Gereja Pantekosta di Indonesia (GPdI)', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Bella Rando', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2685, '2025-07-19 13:19:21', 'BERYL ANTONIO SEWANG', '085242995974', 'L', '7', 'Anak Hamba Tuhan', 'GPT KRISTUS PENOLONG SAOJO', 'POSO', 'SULAWESI TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Nova sewang', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2686, '2025-07-18 12:45:47', 'BETSY  TADORANGGI', '081342177031', 'P', '52 thn', 'Pdt.', 'Gpdi Torsina palu', 'Kota palu', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Penanggung jawab kamar', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2687, '2025-07-19 13:38:43', 'BEZALEEL SEWANG', '085242995974', 'L', '17', 'Anak Hamba Tuhan', 'GPT KRISTUS PENOLONG SAOJO', 'POSO', 'SULAWESI TENGAH', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bezaleel sewang', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2688, '2025-07-07 23:13:31', 'Bonar Nathan Manurung', '08194805274', 'L', '72', 'Pdt.', 'GBIS ALPHA OMEGA', 'Palembang', 'Sumatera selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Bonar Nathan Manurung', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2689, '2025-07-02 02:47:19', 'Bpk Pdt.Tohap Pasaribu.', '081318874398', 'L', '54 Thn.', 'Pdt.', 'GISI (Gereja Injil Sepenuh Indonesia)', 'Kota Matiya Bekasi', 'Jawa - Barat.', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Bpk PdtTohap Pasaribu.', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2690, '2025-07-29 11:47:18', 'Brayen Djamen', '085341937143', 'L', '33', 'Pdm.', 'GPdI bukit Hermon', 'Bitung', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdm.Brayen Djamen', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2691, '2025-08-02 12:20:05', 'Carolina Tandayu', '081315262701', 'P', '60', 'Pengerja', 'GKTDI Kristus Penolong', 'Jakarta Utara', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Carolina Tandayu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2692, '2025-07-17 18:22:52', 'Christine Mosude', '081213896998', 'P', '54', 'Pengerja', 'GPT Kristus Penolong Saojo', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Christine Mosude', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2693, '2025-08-02 12:25:20', 'Claudia S. Nederupun', '0812-8971-1170', 'P', '37', 'Istri Hamba Tuhan', 'GKTDI Kristus Alfa & Omega', 'Bekasi', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yehezkiel Nederupun', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2694, '2025-07-28 12:59:01', 'Clay', '082193339225', 'P', '6', 'Anak Hamba Tuhan', 'GPT Kristus Kasih Palu', 'Palu', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Henok', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2695, '2025-07-17 09:17:11', 'Corina Concetta Ongan', '081213896998', 'P', '0', 'Anak Hamba Tuhan', 'GPT Kristus Penolong Saojo Maliwuko', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Haniel Imanuel Ongan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2696, '2025-07-28 20:05:06', 'Daniel Hendrawan', '081328749407', 'L', '43', 'Pdt.', 'GKTDI EBEN HAEZER YOGYAKARTA ', 'Bantul ', 'YOGYAKARTA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Daniel Hendrawan ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2697, '2025-07-03 16:43:21', 'Daniel Pagawak', '081235103360', 'L', '57 Tahun', 'Pdt.', 'GKTDI', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Daniel Pagawak', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2698, '2025-07-12 10:47:45', 'Darsini', '081356239449', 'P', '66 tahun', 'Istri Hamba Tuhan', 'GPT Kristus Ajaib Biau', 'Sitaro', 'Sulut', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Nushel Kuranta', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2699, '2025-08-02 11:15:14', 'Dave J. Williantono', '08161959454', 'L', '51', 'Pdt.', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Dave J. Williantono', '', '', 'Sabtu, 30 Agustus 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2700, '2025-07-05 00:26:16', 'David Richard Tutu', '081389888119', 'L', '49 th', 'Pdt.', 'GPT Kristua Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'David Richard Tutu', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.00,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2701, '2025-07-02 00:04:44', 'Debora Macpal', '082344730784', 'P', '38 Tahun', 'Istri Hamba Tuhan', 'GPT Charisma Didiri', 'Poso', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Steven Macpal', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2702, '2025-07-02 02:39:18', 'Debora Manalu', '081371999303', 'P', '43 Tahun', 'Istri Hamba Tuhan', 'GKTDI KRISTUS PENGASIH', 'Batanghari', 'JAMBI', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jonas Patar Sitindjak', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2703, '2025-07-21 20:50:11', 'Debora Saleppa', '082299413953', 'P', '53', 'Istri Hamba Tuhan', 'Gereja pantekosta Tabernakel ', 'Kabupaten Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Thomas Pasombo', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2704, '2025-07-25 13:40:30', 'Deby Sumampouw', '082197434217', 'P', '50', 'Istri Hamba Tuhan', 'GSPDI ', 'Langowan Minahasa ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sonny J Oroh', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2705, '2025-07-17 08:58:17', 'Deckson Kanoneng', '085240069012', 'L', '55', 'Pdt.', 'GPT', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Deckson', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2706, '2025-07-22 07:56:36', 'Deisye Sumolang', '089697927669', 'P', '50 thn', 'Pdm.', 'GPdi Victory Kalawat', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Ferry Hanoch Frederik Sangian', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2707, '2025-07-07 10:33:48', 'Deyfi H. Sondakh', '085255564848', 'P', '46 Thn', 'Pdm.', 'GPdI IMMANUEL, Tenau Warembungan', 'Minahasa', 'SULUT', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Murphy P. Palapa', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2708, '2025-08-02 09:42:46', 'Deyvita Tegi', '082271304780', 'P', '35 thn', 'Istri Hamba Tuhan', 'GPT Kristus gembala Agung Bumi nyiur manado', 'Manado', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Oktafianus kahimpong ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2709, '2025-07-02 10:28:14', 'Diane Jeklien Tangkowit', '085397730737', 'P', '45', 'Istri Hamba Tuhan', 'GPT KRISTUS PENOLONG Bonebae 1', 'Tojo Unauna', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Edaaprelius Gawe', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2710, '2025-07-09 20:38:06', 'Djhon D. Menangkoda', '085243093675', 'L', '56 thn', 'Pdt.', 'GPdI Bethesda Waisamu', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Djhon D.Menangkoda', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2711, '2025-07-27 14:39:41', 'Donald Mustamu', '085244544597', 'L', '45', 'Pdt.', 'GKTDI Kristus Gembala Biak ', 'Biak ', 'Papua ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Donald Mustamu ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2712, '2025-08-16 14:19:42', 'Donny Bantu', '081341100540', 'L', '41', 'Pdt.', 'GPdI Miracle Tokelemo', 'Sigibiromaru Palu', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:36'),
(2713, '2025-07-02 11:57:10', 'Dorkas Markus Palimbunga', '082151567177', 'P', '60 Tahun', 'Istri Hamba Tuhan', 'GKTDI \"Kristus Gembala\" Balikpapan', 'Kota Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdm. Maleakhi Urbanus Palimbunga', 'LION HOTEL***', 'Executive Suite Rp. 1.000.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2714, '2025-07-14 06:06:43', 'Dorniu Wulanta', '082269492779', 'P', '53 (thn)', 'Istri Hamba Tuhan', 'GKTDI MKCM Tobelo', 'Halmahera utara', 'Maluku utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2715, '2025-07-02 10:26:55', 'Edaaprelius Gawe', '085397730737', 'L', '37', 'Pdt.', 'GPT KRISTUS PENOLONG Bonebae 1', 'Tojo Unauna', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Edaaprelius Gawe', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2716, '2025-07-02 20:31:22', 'Eferata Efi P', '081287796100', 'P', '60', 'Ibu Janda Hamba Tuhan', 'GPT Getsemani Airmadidi Atas', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Firdaus sutikno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2717, '2025-07-30 08:06:43', 'Elim Daniel sambe', '085242277281', 'L', '63thn', 'Pdm.', 'Gpt Kristus Raja Makassar', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Elim Daniel sambe', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2718, '2025-07-01 23:57:46', 'ELIM EVIANTI BAWUNA', '081342316771', 'P', '48 Thn', 'Ibu Janda Hamba Tuhan', 'GKTDI KRISTUS GEMBALA', 'BALIKPAPAN', 'KALIMANTAN TIMUR', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'ELIM EVIANTI BAWUNA', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2719, '2025-07-21 21:08:36', 'Elisa Daniel Sutan', '082192788283', 'L', '11', 'Anak Hamba Tuhan', 'GPT Kristus Roti Hidup Labuan Uki', 'Bolmong Induk', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jahja Purwanto Sutan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2720, '2025-07-23 22:58:39', 'ELISA PRAMONO', '081325166725', 'L', '34', 'Anak Hamba Tuhan', 'GKTDI Kristus Kehidupan', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'ELISA PRAMONO', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2721, '2025-07-07 14:58:31', 'Elisabeth Bunga', '085256857254', 'P', '77 thn', 'Ibu Janda Hamba Tuhan', 'GPT Kristus Gembala Bahu ', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Elisabeth Bunga', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2722, '2025-07-29 11:49:54', 'Elisabeth Emilia mentang', '087761879872', 'P', '23', 'Pdm.', 'GPdI bukit Hermon ', 'Bitung', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdm.Brayen Djamen ', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2723, '2025-07-01 23:52:22', 'Elisabeth Manase', '082110774399', 'P', '55', 'Istri Hamba Tuhan', 'Gereja Kristus Tabernakel Di Indonesia (GKTDI)', 'Merauke ', 'Papua Selatan ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Lukas Giyono ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2724, '2025-07-15 13:43:31', 'Elisabeth Ribka Meiry Waney', '081317781272', 'P', '43', 'Istri Hamba Tuhan', 'Gereja Pentakosta Kotabaru Jambi ', 'Jambi', 'Jambi ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Zuhdi Fretto Siburian ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2725, '2025-07-18 10:01:24', 'Elrik simanjuntak.', '081398652991', 'L', '50', 'Pdt.', 'Gereja Bethel indonesia jemaat Manyahi', 'Kapuas.Kab.Kuala kapuas', 'Kalimantan Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Saya sendiri', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2726, '2025-07-30 21:47:18', 'Emanuel Kardiman', '081289773307', 'L', '80thn', 'Pdm.', 'GKTDI Kristus Alfa & Omega', 'Bekasi, Bekasi Timur', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Emanuel Kardiman', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2727, '2025-07-02 16:30:05', 'ESLY KURANTHA', '082187236098', 'L', '55 tahun', 'Pdt.', 'GPSDI KRISTUS RAJA DAMAI TRANGKIL', 'PATI', 'JAWA TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'ESLY KURANTHA', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:36'),
(2728, '2025-07-20 21:32:54', 'Ester Lustiari', '087835665877', 'P', '46', 'Istri Hamba Tuhan', 'GPSDi', 'Bantul', 'Yogjakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yonatan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:36'),
(2729, '2025-07-17 14:51:03', 'Etni Lustiana', '081229438890', 'P', '47', 'Istri Hamba Tuhan', 'GPSDI', 'Surakarta', 'Jawa Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Samuel Ari Harseno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2730, '2025-07-16 13:00:06', 'EUNIKE RUNDAY', '081346240381', 'P', '45', 'Istri Hamba Tuhan', 'GKTDI. KRISTUS AJAIB ', 'SAMARINDA', 'KALIMANTAN TIMIUR', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2731, '2025-07-02 02:34:34', 'Euodia Arla Gracia', '081225900307', 'P', '12', 'Anak Hamba Tuhan', 'GPSDI Jangkungan ', 'Salatiga ', 'Jawa Tengah ', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Yula Lustianto ', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2732, '2025-08-01 16:10:03', 'Eva Susianita Obed', '082119191942', 'P', '51', 'Istri Hamba Tuhan', 'GKTDI EFATA', 'Bandar Lampung ', 'Lampung ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Hendry Sutanto', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe Executive Rp. 850.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2733, '2025-07-06 15:35:52', 'EVANIA EUODIA BAWUNA', '081343948784', 'P', '16 thn', 'Anak Hamba Tuhan', 'GKTDI KRISTUS GEMBALA', 'BALIKPAPAN', 'KALIMANTAN TIMUR', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'ELIM EVIANTI BAWUNA', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2734, '2025-07-22 17:08:30', 'Evi Repi', '087755089060', 'P', '70(thn)', 'Ibu Janda Hamba Tuhan', 'GPdi Victory Kalawat', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Ferry H.F Sangian', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2735, '2025-07-21 18:46:32', 'Fadly Harimisa', '085141375404', 'L', '38 Tahun', 'Pdt.', 'GPT EXODUS KARUNGO BIARO', 'SITARO', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Fadly harimisa', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2736, '2025-07-02 09:29:29', 'Faith Yokhebed Diaz', '085247813822', 'P', '5', 'Anak Hamba Tuhan', 'GPSDI KRISTUS PENEBUS', 'Nabire', 'Papua Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Albert Hezky Christiawan', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2737, '2025-07-19 20:08:53', 'Fandra Tiwa', '085240786314', 'L', '48', 'Pdt.', 'GPdI Ekklesia Kamarora Kec. Nokilalaki', 'Sigi', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Fandra Tiwa', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2738, '2025-07-31 09:11:47', 'Febri Manopo', '082187926810', 'L', '49', 'Pdt.', 'Gereja Pantekosta di Indonesia (GPdI)', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Febri Manopo', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2739, '2025-07-21 11:42:53', 'Felma Tewu', '081347210834', 'P', '51 thn', 'Istri Hamba Tuhan', 'Gpdi', 'Kuai kartanegara', 'Kalimantan timur', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jonli', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2740, '2025-07-17 13:29:31', 'Ferry Tumpal Hutabarat', '081802770172', 'L', '53', 'Pdt.', 'GPdI air hidup Yogyakarta', 'Yogyakarta ', 'Yogyakarta', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ya', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2741, '2025-07-05 22:26:00', 'Fientje N.Papona', '081235073705', 'P', '71 tahun', 'Istri Hamba Tuhan', 'GPT Kristus Gembala Bahu Manado', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Robert P. Makapindar', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2742, '2025-07-04 21:11:48', 'Filadelfia T Gainau', '082173582838', 'L', '19th', 'Anak Hamba Tuhan', 'GPT KRISTUS GEMBALA SENTANI', 'Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdm. Markus S Gainau', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2743, '2025-07-02 10:27:44', 'Firdaus G Setiawan', '082123513292', 'L', '29 Tahun', 'Pdp.', 'Gereja Pantekosta Tabernakel Getsemani Airmadidi Atas', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Firdaus G Setiawan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2744, '2025-07-25 19:30:40', 'FLANY NOVIA LUMANSIK', '085341280085', 'P', '47 Tahun', 'Istri Hamba Tuhan', 'GSPDI FILADELFIA VINEYARD OF GOD PERKAMIL', 'MANADO', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'IZAKH REINHARD PALAR (SUAMI)', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2745, '2025-08-03 23:05:34', 'Fonny Gerrys Kolamban', '089698013523', 'P', '59', 'Hamba Tuhan', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', '-', '', '', 'Selasa, 2 September 2025', 'Kamis 4 September 2025', '2025-08-29 15:18:37'),
(2746, '2025-08-16 16:13:04', 'Fonny Santy Kurniawan', '085608257440', 'P', '42', 'Istri Hamba Tuhan', '', '', '', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:37'),
(2747, '2025-07-31 11:05:39', 'Frans Maasi', '085325805020', 'L', '60 th', 'Pdt.', 'GPdI', 'Ds Mekarsari.Kec Toili barat.kab Banggai', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Frans Maasi', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2748, '2025-07-04 07:36:09', 'Fransiska Sipora Fonataba', '081286447028', 'P', '41 thn', 'Anak Hamba Tuhan', 'GBI MARANATA', 'Bekasi', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sonya k Fonataba', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2749, '2025-07-13 11:51:46', 'FREDDY  PUNUSINGON', '085340070013', 'L', '49 thn', 'Ev.', 'GPSDI ALFA OMEGA TARATARA TOMOHON', 'Kota Tomohon', 'Sulawesi UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2750, '2025-07-30 18:31:50', 'Frety Mataheru', '082198832488', 'P', '61 thn', 'Istri Hamba Tuhan', 'GPdI Elsaday Lumalatal', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yusak Mokolomban', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2751, '2025-07-14 14:47:14', 'George Kursam', '082198601695', 'L', '57 thn', 'Pdm.', 'GPdI Eklesia Hatusua', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'George Kursam', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2752, '2025-07-05 15:58:31', 'Gideon Esing', '081342397607', 'L', '42', 'Pengerja', 'Gpsdi alfa omega taratara ', 'Tomohon ', 'Sulut ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Gideon Esing ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2753, '2025-07-12 10:59:24', 'Haggai Hatoguan Sianturi', '081274949555', 'L', '38 Tahun', 'Pdt.', 'GPdI EBENHAEZER PEKANBARU', 'PEKANBARU', 'RIAU', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'HAGGAI HATOGUAN SIANTURI', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2754, '2025-07-01 23:59:17', 'Hani Anggoh', '082195905075', 'L', '62 tahun', 'Pdt.', 'GPT BUKIT SION HAASI TAGULANDANG', 'Kepl. Sitaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hani Anggoh', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2755, '2025-07-17 09:09:24', 'Haniel Imanuel Ongan', '081213896998', 'L', '32', 'Pdm.', 'GPT Kristus Penolong Saojo Maliwuko', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Haniel Imanuel Ongan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2756, '2025-07-01 23:50:16', 'Hanna Butar Butar', '081325524406', 'P', '4 Tahun', 'Anak Hamba Tuhan', 'GKTDI Kristus Gembala Morotai ', 'Pulau Morotai ', 'Maluku Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hendra Toni Butar Butar ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2757, '2025-08-16 16:12:28', 'Harun Eka Syama Kurniawan', '085755052021', 'L', '42', 'Pdt.', '', '', '', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:37'),
(2758, '2025-07-02 11:50:54', 'Hein Masambe', '082239028930', 'L', '57', 'Pdt.', 'GPdI El-Olam kamarian', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hein Masambe', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2759, '2025-07-21 16:07:45', 'Helmi Jeane Engkol', '085256366305', 'P', '44 thn', 'Pdt.', 'GPdI El Gibbor ', 'Parigi Moutong ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2760, '2025-07-01 23:38:43', 'Hendra Toni Butar Butar', '081325524406', 'L', '41 Tahun', 'Pdt.', 'GKTDI Kristus Gembala Morotai', 'Pulau Morotai', 'Maluku Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hendra Toni Butar Butar', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2761, '2025-08-01 16:07:10', 'Hendry Sutanto', '082119191942', 'L', '56', 'Pdt.', 'GKTDI EFATA', 'Bandar Lampung ', 'Lampung ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Hendry Sutanto', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe Executive Rp. 850.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2762, '2025-07-28 10:49:09', 'Henok imanuel Ongan', '081247705917', 'L', '33', 'Pdt.', 'GPT KRISTUS KASIH PALU', 'Palu', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Henok', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2763, '2025-08-02 11:20:18', 'Herneke J. Williantono', '081313133573', 'P', '52', 'Istri Hamba Tuhan', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Dave J. Williantono', '', '', 'Sabtu, 30 Agustus 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2764, '2025-07-17 14:55:15', 'Hezekiah Ariananda', '0878-4324-5079', 'L', '12', 'Anak Hamba Tuhan', 'GPSDI', 'Surakarta', 'Jawa Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Samuel Ari Harseno', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2765, '2025-07-30 00:36:17', 'Hizkia Imanuel Ongan', '081259737005', 'L', '30', 'Pdm.', 'Gpt Kristus kasih ', 'Kota palu', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hizkia imanuel Ongan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2766, '2025-07-19 13:05:40', 'Ibrahim Tato', '082187305583', 'L', '51', 'Pdm.', 'GPT BUKIT SION MAKASSAR', 'KOTA MAKASSAR', 'SULAWESI SELATAN', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2767, '2025-07-04 12:22:13', 'IBU  NOVI  PANAWU', '081321388808', 'P', '53', 'Istri Hamba Tuhan', 'GPT  JEHOVA  JIREH  BANDUNG', 'BANDUNG', 'JAWA  BARAT', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'PDT  HEMAT  SINAGA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2768, '2025-07-02 02:54:19', 'Ibu Pdt Martolius Minggu', '082298756538', 'P', '51 Tahun', 'Istri Hamba Tuhan', 'Gpt Kristus Gembala Gorontalo', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Martolius minggu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2769, '2025-07-02 02:49:30', 'Ibu Tina Hutabarat', '081318874398', 'P', '55 Thn.', 'Istri Hamba Tuhan', 'GISI (Gereja Injil Sepenuh Indonesia)', 'Kota Matiya Bekasi', 'Jawa - Barat.', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Bpk PdtTohap Pasaribu.', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2770, '2025-07-17 14:25:51', 'Ifaludwich Stefanus E. Pattihahuan', '085397918984', 'L', '63', 'Pdt.', 'GPdI Kolongan Tetempangan', 'Minahasa Utara', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ifaludwich Stefanus E. Pattihahuan', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2771, '2025-07-23 10:58:58', 'Imelda Juliana', '0811938817', 'P', '55', 'Istri Hamba Tuhan', 'GPMI BOL FILADELFIA', 'Jakarta Barat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jong Tjoen Hau', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:37'),
(2772, '2025-07-04 11:06:14', 'Imintoro', '087897545559', 'L', '71 tahun', 'Pdt.', 'GBIS(Gereja Bethel Injil Sepenuh).', 'Palembang', 'Sumatera Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Imintoro', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:37'),
(2773, '2025-08-16 12:14:01', 'Indah Sunarti Palar', '081390286403', 'P', '46', 'Istri Hamba Tuhan', 'Gereja Pantekosta di Indonesia', 'Kab Semarang', 'Jawa Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Andy V Palar', '', '', 'Senin, 1 September 2025', 'Jumat , 5 September', '2025-08-29 15:18:38'),
(2774, '2025-07-31 22:24:47', 'IRAY RISA SUPIT', '082296494494', 'P', '39', 'Istri Hamba Tuhan', 'GPdI SMIRNA DIDIRI', 'POSO', 'SULAWESI TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'PANITIA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2775, '2025-07-02 10:26:07', 'Ishak Yose R.', '081391100280', 'L', '2 Bulan', 'Anak Hamba Tuhan', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Yosua Victoria', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe sea view Rp. 750.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2776, '2025-07-25 19:23:07', 'IZAKH REINHARD PALAR', '085341280085', 'L', '53 Thn', 'Pdt.', 'GSPDI FILADELFIA VINEYARD OF GOD PERKAMIL.MANADO', 'MANADO', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'iZAKH REINHARD PALAR', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2777, '2025-07-02 10:34:12', 'Jackson Hizkia Tangkowit', '085397730737', 'L', '43', 'Pdt.', 'GPT KRISTUS PENOLONG Bonebae 1', 'Tojo Unauna', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Edaaprelius Gawe', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2778, '2025-07-03 09:02:56', 'Jahja Purwanto Sutan', '082192788283', 'L', '60', 'Pdt.', 'GPT Kristus Roti Hidup labuan uki', 'Bolmong induk', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jahja Purwanto Sutan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2779, '2025-07-02 03:01:10', 'Jayden Simamora', '081286523246', 'L', '2 Tahun', 'Anak Hamba Tuhan', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua barat daya', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Rufus Y Simamora', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2780, '2025-07-13 12:10:38', 'JEIN MANAWAN', '085240743887', 'P', '48 thn', 'Pengerja', 'GPSDI ALFA OMEGA TARATARA TOMOHON', 'Kota TOMOHON', 'Sulawesi  Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Penanggung Jawab Kamar', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2781, '2025-07-08 10:03:00', 'Jendry Jems Ratu', '081354142521', 'L', '45 thn', 'Pdt.', 'GPdi Solagracia Ouw', 'Saparua/Maluku Tengah', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jendry Jems Ratu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2782, '2025-07-17 14:28:48', 'Jeniffer J. C. Tairas', '085397918984', 'P', '64', 'Istri Hamba Tuhan', 'GPDI Kolongan Tetempangan', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ifaludwich Stefanus E. Pattihahuan', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2783, '2025-07-05 22:34:41', 'Jerry Mandagie', '082346333877', 'L', '73', 'Pdt.', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jerry Mandagie', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2784, '2025-07-02 09:42:25', 'Jethro F Palimbunga', '081211133387', 'L', '5', 'Anak Hamba Tuhan', 'GKTDI Kristus Gembala Balikpapan', 'Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt. Filemon Palimbunga', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2785, '2025-07-19 13:09:02', 'Jhony Stenly Piri', '081385658455', 'L', '75', 'Pdt.', 'GBIS EBEN HESER', 'Muara Enim', 'Sumatera Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jhony Stenly Piri', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2786, '2025-07-03 21:15:21', 'JIMMY TALUMEWO', '085231129991', 'L', '56', 'Pdt.', 'GEREJA PANTEKOSTA TABERNAKEL', 'SITARO', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jimmy Talumewo', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2787, '2025-07-02 09:44:24', 'Joanna E Palimbunga', '081211133387', 'P', '2', 'Anak Hamba Tuhan', 'GKTDI Kristus Gembala Balikpapan', 'Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt. Filemon Palimbunga', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2788, '2025-07-14 13:59:55', 'Johana Febe Titahena', '085244154063', 'P', '57 thn', 'Ev.', 'GPT Kristus Ajaib Wainitu', 'Ambon', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Johana Febe Titahena', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2789, '2025-07-07 14:46:08', 'Johanes tampubolon', '082160200822', 'L', '43 tahun', 'Pdt.', 'Gereja Pentakosta pusat surabaya', 'Deli Serdang ', 'Sumut', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Johanes tampubolon', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2790, '2025-08-02 10:13:28', 'Jolsius sombouwadile', '08978625202', 'L', '54 thn', 'Pdm.', 'GPT KRISTUS GEMBALA AGUNG BUMI NYIUR', 'MANADO', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tidak ada', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2791, '2025-07-02 02:37:58', 'Jonas Patar Sitindjak', '081371999303', 'L', '51 Tahun', 'Pdt.', 'GKTDI KRISTUS PENGASIH', 'Batanghari', 'JAMBI', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jonas Patar Sitindjak', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2792, '2025-07-23 10:57:09', 'Jong Tjoen Hau', '087783949322', 'L', '52', 'Pdt.', 'GPMI BOL Filadelfia', 'Jakarta Barat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jong Tjoen Hau', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2793, '2025-07-21 11:49:43', 'Jonli', '082252853069', 'L', '51thn', 'Pdt.', 'Gpdi', 'Kutai Kartanegara ', 'Kalimantan timur', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jonli', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2794, '2025-07-02 03:00:02', 'Joshua Simamora', '081286523246', 'L', '8 Tahun', 'Anak Hamba Tuhan', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua barat daya', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Rufus Y Sinamora', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2795, '2025-07-07 23:15:28', 'Kaleb Situmeang', '081397764814', 'L', '37', 'Pdm.', 'GBIS ALPHA OMEGA', 'Palembang', 'Sumatera Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Bonar Nathan Manurung', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2796, '2025-07-30 15:30:53', 'Kezia Ivana Gononggo', '082293574744', 'P', '23', 'Pengerja', 'Gereja Pantekosta di Indonesia (GPdI)', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kezia Ivana Gononggo', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2797, '0000-00-00 00:00:00', 'Kezia Rahmawati', '087835665877', 'P', '23', 'Anak Hamba Tuhan', 'GPSDi', 'Bantul', 'Yogjakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yonatan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:38'),
(2798, '2025-07-07 18:40:13', 'Kristin Titin Palapa', '081334333448', 'P', '49 thn', 'Pdm.', 'GPdI Parakletos Taman Sidorejo', 'Sidoarjo', 'Jawa Timur', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2799, '2025-07-10 18:52:26', 'LANY MARLEN MANABUNG', '085240106000', 'P', '46', 'Pdt.', 'GPT PETRA MANGANITI', 'KEPULAUAN SANGIHE', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'STEVANUS FAEHUSI ZEBUA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2800, '2025-07-31 10:14:29', 'Lazarus Jamatia', '082162613179', 'L', '70 Tahun', 'Pdm.', 'Gpdi Bheterda', 'Banggai', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Lasarus Hamatia', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2801, '2025-07-02 12:24:47', 'Lentji karisoh', '085696074776', 'P', '77', 'Ibu Janda Hamba Tuhan', 'GKTDI Ponompiaan', 'Bolaang Mongondow', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Lidya Utami', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2802, '2025-07-07 07:20:55', 'Lestariana Saragih', '081253745713', 'P', '59', 'Istri Hamba Tuhan', 'GKTDI Kristus Penolong', 'SAMARINDA', 'Kalimantan Timur', 'Akomodasi urus sendiri konsumsi panitia', 'Pdt. Arinson Purba', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2803, '2025-07-28 12:34:31', 'Lidia Serdi', '081340058382', 'P', '47 th', 'Istri Hamba Tuhan', 'Gereja Pantekosta Tabernakel ', 'Kab sigi ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Joni Parangki ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2804, '2025-08-01 21:32:58', 'Lidya Ester Selvana Senduk', '085319567399', 'P', '43 thn ', 'Pdm.', 'GPdI ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Arthur Lontaan ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2805, '2025-07-19 20:40:40', 'Lidya Mengko', '081341425716', 'P', '38', 'Istri Hamba Tuhan', 'Geraja Gerakan Pentakosta(GGP)', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Jones Wokas', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2806, '2025-08-03 23:05:40', 'Lidya Santi Pandoh', '081244363783', 'P', '38', 'Hamba Tuhan', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumso Mengurus Sendiri Diluar Panitia', '-', '', '', 'Selasa. 2 September 2025', 'Kamis, 4 September 2025', '2025-08-29 15:18:38'),
(2807, '2025-07-02 12:20:19', 'Lidya utami', '085696074776', 'P', '67', 'Ibu Janda Hamba Tuhan', 'Gktdi ponompiaan', 'Bolmong', 'Sulut', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Lidya utami', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2808, '2025-07-21 18:53:39', 'Lidyaninna Gulo', '085141375404', 'P', '34', 'Istri Hamba Tuhan', 'GPT EXODUS KARUNGO', 'SITARO', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Fadly Harimisa', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2809, '2025-07-30 20:13:01', 'Lily Simaela', '081356348776', 'P', '51 thn', 'Pdt.', 'GSJA Victory', 'Kairatu/ Seram  Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Lily Simaela', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2810, '2025-08-18 12:39:28', 'Lince Sarira', '081344637918', 'P', '58', 'Istri Hamba Tuhan', 'GPT. Kristus Pembela, Kmp.Malaus, Salawati', 'Sorong', 'Papua Barat Daya', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi ditanggung Panitia', 'Pdt.Gunawan Wibisono', 'LION', '', '', '', '2025-08-29 15:18:38'),
(2811, '2025-08-02 11:48:17', 'Lucas Irawan', '085817837156', 'L', '69', 'Pdm.', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Lucas Irawan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2812, '2025-07-01 23:44:58', 'Lukas Giyono', '082110774399', 'L', '54', 'Pdm.', 'Gereja Kristus Tabernakel Di Indonesia (GKTDI)', 'Merauke', 'Papua Selatan', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi ditanggung Panitia', 'Lukas Giyono ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2813, '2025-07-12 11:02:40', 'Maria Melisa Rumampuk', '085274505557', 'P', '37', 'Pdm.', 'GPdI EBENHAEZER PEKANBARU', 'PEKANBARU', 'RIAU', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'HAGGAI HATOGUAN SIANTURI', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2814, '2025-08-01 19:02:58', 'Maria Ringo', '085276543522', 'P', '62', 'Istri Hamba Tuhan', 'GPT', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Berthon Lambok Siahaan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2815, '2025-07-14 00:23:30', 'Maria Yohana Suba', '087784909846', 'P', '12', 'Anak Hamba Tuhan', 'GKTDI Imanuel Watuawu', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ranita Nainggolan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2816, '2025-07-02 15:27:31', 'Maringan Sibagariang', '085766861285', 'L', '42 thn', 'Pdt.', 'Gereja Pantekosta Tabernakel (GPT) ', 'Muaro Jambi', 'Jambi', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Maringan Sibagariang', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38'),
(2817, '2025-07-02 21:24:11', 'MARKUS MANAHAMPI', '081340427310', 'L', '65', 'Pdt.', 'GPT KRISTUS RAJA BULANGAN', 'Kabupaten Kep.Siau Tagulandang Biaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'MARKUS MANAHAMPI', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:38'),
(2818, '2025-07-02 10:14:37', 'MARTA TITIK SRISUKAMTI', '087835711222', 'P', '68 Tahun', 'Istri Hamba Tuhan', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'PAULUS SUPARNO RAHARJO', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe Executive Rp. 850.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:38');
INSERT INTO `participants` (`id`, `timestamp`, `nama_peserta`, `nomor_whatsapp`, `jenis_kelamin`, `usia`, `jabatan`, `asal_gereja`, `kota_kabupaten`, `provinsi`, `akomodasi_konsumsi`, `kepala_penanggung_jawab_kamar`, `pilihan_hotel`, `pilihan_kamar`, `kedatangan`, `kepulangan`, `created_at`) VALUES
(2819, '2025-07-31 22:22:05', 'MARTEN LUTHER BAKUMAWA', '085252825759', 'L', '41 Thn', 'Pdt.', 'GPdI SMIRNA DIDIRI', 'POSO', 'SULAWESI TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2820, '2025-07-05 17:07:31', 'MARTEYR TAROREH', '085696237607', 'L', '80 Tahun', 'Pdt.', 'GEREJA PANTEKOSTA TABERNAKEL', 'BOLAANG MONGONDOW', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'MARTEYR TAROREH', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2821, '2025-07-09 20:40:53', 'Martje Hehakaya', '085243093675', 'P', '58 thn', 'Istri Hamba Tuhan', 'GPdI Bethesda Waisamu', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Djhon D Menangkoda', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2822, '2025-07-17 14:52:47', 'Mary Ariananda', '0812-2707-1704', 'P', '20', 'Anak Hamba Tuhan', 'GPSDI', 'Surakarta', 'Jawa Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Samuel Ari Harseno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2823, '2025-07-12 16:08:06', 'Maryam Kumayas', '081526099032', 'P', '52', 'Istri Hamba Tuhan', 'GPDI Filadelfia ponompiaan', 'Bolaang Mongondow', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jefry Tembesi', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2824, '2025-07-05 17:13:20', 'MASYE WURARA', '085696237607', 'P', '73 Tahun', 'Istri Hamba Tuhan', 'GEREJA PANTEKOSTA TABERNAKEL', 'BOLAANG MONGONDOW', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'MARTEYR TAROREH', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2825, '2025-07-25 21:49:43', 'Matheos lambiombir', '081382223923', 'L', '64', 'Pdt.', 'GpdI', 'Bogor', 'Jawa barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Belum ada', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2826, '2025-07-01 23:48:21', 'Matthew Butar Butar', '081325524406', 'L', '7 Tahun', 'Anak Hamba Tuhan', 'GKTDI Kristus Gembala Morotai ', 'Pulau Morotai ', 'Maluku Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hendra Toni Butar Butar ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2827, '2025-07-02 00:00:32', 'Maya Anggoh', '082195905075', 'P', '54 tahun', 'Istri Hamba Tuhan', 'GPT BUKIT SION HAASI TAGULANDANG', 'Kepl. Sitaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hani Anggoh', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2828, '2025-07-31 10:03:13', 'Mayke Mayambo', '085656718682', 'P', '63 Thn', 'Istri Hamba Tuhan', 'Gpdi Bhetesda', 'Banggai', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Lazarus Hamatis', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2829, '2025-07-04 20:54:09', 'MC. Joseph R Gainau', '0812447768455', 'L', '23 tahun', 'Anak Hamba Tuhan', 'GPT Kristus Gembala Sentani Papua', 'Jayapura', 'Jayapura ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdm. Markus S Gainau', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2830, '2025-07-24 06:24:41', 'Meity Madadi', '081241591233', 'P', '53 tahun', 'Pdt.', 'GSJA Tamaninjil kamarora ', 'Kamarora kabupaten Sigi ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2831, '2025-08-21 17:22:05', 'Melly Polnaya', '085244154063', 'P', '51', 'Pengerja', 'GPT Kristus Ajaib Wainitu', 'Ambon', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:39'),
(2832, '2025-08-10 23:28:49', 'Meltina Terry', '082187046172', 'P', '42', 'Imam-imam/Jemaat', 'Gereja Suara Ketebusan Sorong', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohana Tanifan', '', '', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:39'),
(2833, '2025-07-03 09:05:45', 'Meniat Lase', '082192788283', 'P', '61', 'Istri Hamba Tuhan', 'Gpt kristus roti hidup labuan uki', 'Bolmong induk', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jahja purwanto sutan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2834, '2025-07-08 17:15:00', 'MERPATI LALEDA', '085343524104', 'P', '53', 'Istri Hamba Tuhan', 'GPT KRISTUS AJAIB BIAU', 'Siau Tagulandang Biaro ', 'SULAWESI UTARA ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Paulus Kurantha', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2835, '2025-08-02 12:05:10', 'Michal Tandi Gala', '085349686701', 'P', '33', 'Pengerja', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Michal Tandi Gala', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2836, '2025-07-02 12:04:35', 'Mikhaya Kharis Palimbunga', '082151567177', 'P', '1 Tahun', 'Anak Hamba Tuhan', 'GKTDI \"Kristus Gembala\"', 'Kabupaten Penajam', 'Kalimantan Timur', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Pdm. Maleakhi Urbanus Palimbunga', 'LION HOTEL***', 'Executive Suite Rp. 1.000.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2837, '2025-07-28 12:57:36', 'Minar', '082193339225', 'P', '33', 'Istri Hamba Tuhan', 'GPT Kristus Kasih Palu', 'Palu', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Henok', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2838, '2025-08-02 12:11:30', 'Muhonis Nixon', '087782020525', 'L', '56', 'Pdt.', 'Gereja Elim Tabernakel', 'Jakarta Utara', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Muhonis Nixon', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2839, '2025-07-07 10:28:20', 'Murphy P. Palapa.', '085255564847', 'L', '48 Thn', 'Pdt.', 'GPdI Immanuel Tenau Warembungan', ' Minahasa', ' SULUT', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Murphy P. Palapa', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2840, '2025-08-17 16:15:46', 'Nancy Jenny Wuisan', '081347411600', 'P', '48', 'Istri Hamba Tuhan', 'GPdI Tanah Datar ', 'Muara Badak', 'Kaltim', '', 'Roni Modi Lausan', '', '', '', '', '2025-08-29 15:18:39'),
(2841, '2025-08-02 16:55:20', 'Naniek Susanti', '081340555832', 'P', '51', 'Istri Hamba Tuhan', 'GPdI Eben Heazer Sentani', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt. Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2842, '0000-00-00 00:00:00', 'Natalia Nugraheni', '087835665877', 'P', '15', 'Anak Hamba Tuhan', 'GPSDi', 'Bantul', 'Yogjakarta', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Yonatan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:39'),
(2843, '2025-07-02 02:33:17', 'Nehemia Arla Yedija', '087859461944', 'L', '15', 'Anak Hamba Tuhan', 'GPSDI Jangkungan ', 'Salatiga ', 'Jawa Tengah ', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Yula Lustianto ', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2844, '2025-07-27 14:37:07', 'Netty Tobing/ Mustamu', '085244544597', 'L', '72', 'Ibu Janda Hamba Tuhan', 'GKTDI Kristus Gembala Biak Papua ', 'Biak ', 'Papua ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Netty Tobing/ Mustamu ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2845, '2025-07-17 09:11:06', 'Neysa Glenda Preciosa', '081213896998', 'P', '35', 'Istri Hamba Tuhan', 'GPT Kristus Penolong Saojo Maliwuko', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Haniel Imanuel Ongan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2846, '2025-07-25 17:29:34', 'Ngarijan joshua', '081245388965', 'L', '60', 'Pdt.', 'gpdi  zaitun Rahmat kec. Palolo', 'Sigi', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Fandra Tiwa', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2847, '2025-07-04 11:14:14', 'Ninik Widyaningsih', '087897545559', 'P', '70th', 'Istri Hamba Tuhan', 'GBIS(Gereja Bethel Injil Sepenuh)', 'Pakembang', 'Sumatera Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Imintoro', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2848, '2025-07-02 11:59:28', 'Norce Masambe', '082199708756', 'P', '47', 'Pdt.', 'GPdI El-Olam', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hein Masambe', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2849, '2025-07-19 13:36:12', 'NOVA ANDRIANA SEWANG', '085242995974', 'P', '41 th', 'Ibu Janda Hamba Tuhan', 'GPT KRISTUS PENOLONG SAOJO', 'POSO', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Nova', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2850, '2025-07-02 09:57:32', 'Nova Tanifan', '082187046172', 'P', '49 thn', 'Istri Hamba Tuhan', 'GKTDI Kristus Raja', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Samuel Tanifan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2851, '2025-07-17 09:01:57', 'Novita Kanoneng', '085240069012', 'P', '53', 'Istri Hamba Tuhan', 'GPT', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Deckson Kanoneng', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2852, '2025-07-01 23:55:57', 'Nurlinda', '081268308688', 'P', '53', 'Istri Hamba Tuhan', 'GEREJA PANTRKOSTA TABERNAKEL', 'BATAM', 'KEPULAUAN RIAU', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohanes Suyatno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2853, '2025-07-17 18:25:23', 'Nutrian Eta', '081213896998', 'P', '39', 'Pengerja', 'GPT Kristus Penolong Saojo', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Christine Mosude', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2854, '2025-07-07 23:28:01', 'Ny. Dorothy Kurniawan', '081803077751', 'P', '73', 'Istri Hamba Tuhan', 'GPT Kristus Raja Salem', 'Depok', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tirza Febriani', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2855, '2025-08-16 14:19:53', 'Octavina Seu', '081341100540', 'P', '40', 'Istri Hamba Tuhan', 'GPdI Miracle Tokelemo', 'Sigibiromaru Palu', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:39'),
(2856, '2025-08-02 09:48:36', 'Oktafianus kahimpong', '082271304780', 'L', '36 thn', 'Pdm.', 'GPt Kristus gembala Agung Bumi nyiur manado ', 'Manado', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Oktafianus kahimpong ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2857, '2025-07-14 10:48:11', 'Pamuji Rahayu', '081331391144', 'P', '61th', 'Pengerja', 'GPT Kriatua Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Elisabeth Bunga', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2858, '2025-07-01 23:47:04', 'Paulus Butar Butar', '081325524406', 'L', '12 Tahun', 'Anak Hamba Tuhan', 'GKTDI Kristus Gembala Morotai ', 'Pulau Morotai ', 'Maluku Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hendra Toni Butar Butar ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2859, '2025-07-08 17:11:33', 'PAULUS KURANTHA', '085343524104', 'L', '50', 'Pdm.', 'GPT KRISTUS AJAIB', 'Siau Tagulandang Biauro', 'SULAWESI UTARA ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'PAULUS KURANTHA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2860, '2025-07-02 10:12:20', 'PAULUS SUPARNO RAHARJO', '087835711222', 'L', '73 Tahun', 'Pdt.', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'PAULUS SUPARNO RAHARJO', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe Executive Rp. 850.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2861, '2025-07-07 20:10:58', 'Pdm .Geybi Maliangkay', '085342887310', 'P', '47 tahun', 'Pdm.', 'GPdI Elgibbor ILOLOY ', 'Minahasa Selatan ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Gembala GPdI Elgibbor ILOLOY ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2862, '2025-07-14 05:57:07', 'Pdm jupri Tamudiman', '081241403121', 'L', '44 (thn)', 'Pdm.', 'GKTDI MKCM Tobelo', 'Halmahera utara', 'Maluku utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2863, '2025-07-18 09:59:22', 'Pdm yunita Sekoh S. PdK', '082187770116', 'P', '47 thn', 'Istri Hamba Tuhan', 'GPdI Bkt Kasih Kanonang', 'Minahasa', 'SULUT', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Frits Tuwo S. Th', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2864, '2025-07-06 10:26:09', 'Pdm. Beatrix Hengkeng', '085331973956', 'P', '61 Tahun', 'Pdm.', 'GPSDI Alfa Omega Kakenturan', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Weldie Adolf Karoho, S.Th', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2865, '2025-07-23 14:52:19', 'Pdm. Hendy Sihombing', '081360074332', 'L', '43', 'Pdm.', 'Gpt gunung hermon', 'Batam', 'Kepulauan Riau ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdm.Hendy Sihombing ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2866, '2025-07-02 11:59:29', 'Pdm. Maleakhi Urbanus Palimbunga', '082151567177', 'L', '34 Tahun', 'Pdm.', 'GKTDI \"Kristus Gembala\" Penajam', 'Kabupaten Penajam', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdm. Maleakhi Urbanus Palimbunga', 'LION HOTEL***', 'Executive Suite Rp. 1.000.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2867, '2025-07-04 17:28:43', 'Pdm. Markus S Gainau', '081248717025', 'L', '53 tahun', 'Pdm.', 'GPT Kristus Gembala Sentani Papua', 'Kabupaten Jayapura', 'Papua', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Markus S Gainau', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2868, '2025-07-12 10:30:50', 'Pdm. Meity Pangaila', '085256968417', 'P', '54', 'Istri Hamba Tuhan', 'GSPDI Filadelfia ', 'Amurang ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Donny F Wakari ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2869, '2025-07-28 12:57:15', 'Pdm.Befy Najoan SPdK', '085757140614', 'P', '53', 'Pdm.', 'GPdI Gloria Kalait ', 'Minahasa Tenggara ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Nixen V.Lumempow STh', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:39'),
(2870, '2025-07-24 09:52:16', 'Pdm.Tiromsi Gultom', '081366031694', 'P', '61 thn', 'Istri Hamba Tuhan', 'GPPS Imanuel Jambi', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Josua.P.Nababan STh', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:39'),
(2871, '2025-07-21 20:23:24', 'Pdp. Kristiani Larosa', '081361116053', 'P', '57', 'Pdp.', 'GBI  LFC ', 'Batam', 'Kepulauan Riau', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Drs. Iskandar Dachi', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2872, '2025-07-21 10:49:44', 'Pdt Ariel Ratag', '082349999330', 'L', '63', 'Pdt.', 'GPdI,Smirna uerani', 'Sigi', 'Palu sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2873, '2025-07-23 08:44:18', 'Pdt Arnold nuban', '085242021536', 'L', '60', 'Pdt.', 'Gpdi', 'Luwu', 'Sulawesi selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Arnold nuban', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2874, '2025-08-01 19:00:49', 'Pdt Berthon Lambok Siahaan', '085276543522', 'L', '62', 'Pdt.', 'GPT', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Berthon Lambok Siahaan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2875, '2025-07-18 09:06:10', 'Pdt Conny Manaroinsong', '081354547897', 'P', '48', 'Pdt.', 'GPdI', 'Luwuk banggai', 'Sulawesi tenga', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2876, '2025-08-18 12:39:34', 'Pdt Denny Poluan', '081341100540', 'L', '56', 'Pdt.', '', '', '', '', '', '', '', '', '', '2025-08-29 15:18:40'),
(2877, '2025-08-16 14:33:08', 'Pdt Dolfi Kiroyan', '081380640006', 'L', '50', 'Pdt.', 'GPdi Poka', 'Ambon', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:40'),
(2878, '2025-07-12 05:33:24', 'Pdt Donny F Wakari', '085256968417', 'L', '53', 'Pdt.', 'GSPDI Filadelfia ', 'Amurang ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Donny F Wakari ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2879, '2025-07-03 16:39:14', 'Pdt Eddy BW. Tampemawa', '085715654478', 'L', '56 Tahun', 'Pdt.', 'GPdI Kristus Gembala', 'Kota Depok', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Eddy BW. Tampemawa', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2880, '2025-07-23 20:18:02', 'PDT EIN PALEGA', '081245146251', 'P', '61 tahun', 'Pdt.', 'gkst hermon dodolo napu', 'poso', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Gea Riami', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2881, '2025-07-03 16:17:56', 'Pdt Fenny Christiane Pangayow', '082194433117', 'P', '49 tahun', 'Pdt.', 'GPdI', 'Seram Bagian Barat', 'Gembala(istri)', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hanny Kaawoan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2882, '2025-07-21 10:53:56', 'Pdt Frely Walean', '082349999330', 'P', '65 thn', 'Pdt.', 'GPdI,uerani palolo', 'Sigi', 'Palu sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2883, '2025-07-18 09:53:57', 'Pdt frits Tuwo S. Pd S. Th', '082187770116', 'L', '54 thn', 'Pdt.', 'GPdI bkt Kasih Kanonang', 'Minahasa', 'SULUT', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Saya Pdt Frits Tuwo', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2884, '2025-07-19 13:15:45', 'Pdt Hace Mangande', '081245282417', 'P', '53', 'Pdt.', 'GPdI Watutau', 'Poso', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Hace Mangande', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2885, '2025-07-03 16:14:04', 'Pdt Hanny Kaawoan', '085212419512', 'L', '55 tahun', 'Pdt.', 'GPdI', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hanny Kaawoan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2886, '2025-07-04 12:20:33', 'Pdt Hemat  Sinaga', '081321388808', 'L', '60', 'Pdt.', 'GPT JEHOVA JIREH BANDUNG', 'BANDUNG', 'JAWA  BARAT', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'PDT HEMAT  SINAGA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2887, '2025-07-02 12:10:08', 'Pdt Hendrika Erari', '085244110931', 'P', '62', 'Pdt.', 'Gereja Bethel Papua Barat di Tanah Papua Jemaat Kota Sorong', 'Kota Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Johanis Revidesso SE MM', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2888, '2025-07-31 10:23:04', 'Pdt ibu Fince Posumah', '085340206762', 'P', '62 th', 'Istri Hamba Tuhan', 'Gereja Pantekosta di Indonesia', 'Ds Uwelolu.Kec Toili Barat .Kab Banggai', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Polke Wotulo', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2889, '2025-07-02 12:05:08', 'Pdt Johanis Revidesso SE MM Ketua Sinode Gereja Bethel Papua Barat di Tanah Papua', '085244110931', 'L', '60', 'Pdt.', 'Gereja Bethel Papua Barat di Tanah Papua Jemaat Petra Kota Sorong', 'Kota Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Johanis Revidesso SE MM', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2890, '2025-07-28 12:11:10', 'Pdt Joni Parangki', '081340058382', 'L', '48 th', 'Pdt.', 'Gereja Pantekosta Tabernakel ', 'Kab sigi ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Joni Parangki ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2891, '2025-07-21 16:02:25', 'Pdt Leo David Singon', '085256366305', 'L', '50', 'Pdt.', 'GPdI Elgibbor Tombi ', 'Parigi ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2892, '2025-07-20 20:21:43', 'Pdt Magdalena Mamahani', '082290410001', 'P', '56', 'Pdt.', 'GPDI Elsadhai Tongoa.', 'Sigi biromaru', 'Palu sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2893, '2025-07-28 12:48:30', 'Pdt Nixen V Lumempow STH', '082199724979', 'L', '50', 'Pdt.', 'GPdI Gloria Kalait', 'Minahasa Tenggara ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Nixen V Lumempow STh', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2894, '2025-07-18 09:32:13', 'Pdt Nolly Fredy kambey', '082255759990', 'L', '49 thn', 'Pdt.', 'Gpdi', 'Kutaikartanegara', 'Kalimatan Timur ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt nolly', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2895, '2025-07-31 10:32:56', 'pdt Polke wotulo', '085340206762', 'L', '65 tahun', 'Pdt.', 'gpdi', 'banggai', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'pdt Polke wotulo', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2896, '2025-07-18 08:06:35', 'Pdt Riami Gea', '081341392761', 'P', '51 thn', 'Pdt.', 'GPdI Sion Sipulung', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2897, '2025-07-18 07:58:51', 'Pdt Rio Wauran', '081341100540', 'L', '56 thn', 'Pdt.', 'GPdI Sion Sipulumg', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'penangung jawab kamar', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2898, '2025-07-07 23:26:32', 'Pdt Yusak Kurniawan', '081803077751', 'L', '74', 'Pdt.', 'GPT Kristus Raja Salem', 'Depok', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tirza Febriani', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2899, '2025-07-18 05:09:47', 'Pdt Yusak Mentang', '085298079680', 'L', '53', 'Pdt.', 'Gpdi bukit Hermon ', 'Bitung', 'Sulut', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt yusak mentang', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2900, '2025-07-02 12:15:06', 'Pdt. Akim Banjarnahor', '082265080322', 'L', '57 Tahun ', 'Pdt.', 'GPdI Filadelfia', 'Kab. Pati', 'Jawatengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Akim Banjarnahor', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2901, '2025-07-12 17:47:50', 'Pdt. Anton Situmeang', '081373824799', 'L', '48 Tahun ', 'Pdt.', 'GPdI Mahanaim Arengka II ', 'Pekanbaru ', 'Riau', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Anton Situmeang ', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2902, '2025-08-01 20:42:43', 'Pdt. AYUB YEWUN', '081220496063', 'L', '52 tahun ', 'Pdt.', 'GPT KRISTUS PENOLONG ', 'SORONG SELATAN ', 'PAPUA BARAT DAYA ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt AYUB YEWUN ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2903, '2025-08-16 14:20:05', 'Pdt. Boy Pomantow', '081341100540', 'L', '53', 'Pdt.', 'GPdI Watutau', 'Poso', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', 'Selasa, 2 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:40'),
(2904, '2025-07-06 19:02:58', 'Pdt. Charles Marbun.', '085262202065', 'L', '63 tahun.', 'Pdt.', 'Gereja Penyebaran Injil.', 'Kota Medan.', 'Sumatera Utara.', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Penanggung jawab kamar.', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2905, '2025-07-02 11:53:36', 'Pdt. Daud Palimbunga', '082151567177', 'L', '70 Tahun', 'Pdt.', 'GKTDI \"Kristus Gembala\" Balikpapan', 'Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdm. Maleakhi Urbanus Palimbunga', 'LION HOTEL***', 'Executive Suite Rp. 1.000.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2906, '2025-07-12 18:03:59', 'Pdt. Djery Hanny Kolamban', '081356239456', 'L', '57 Tahun ', 'Pdt.', 'Gereja Pantekosta Tabernakel ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Djery Hanny Kolamban ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2907, '2025-07-21 14:30:12', 'Pdt. Drs. Iskandar Dachi', '08117019111', 'L', '62 thn', 'Pdt.', 'GBI LFC ', 'Batam', 'Kepulauan Riau', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Drs. Iskandar Dachi ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2908, '2025-08-17 15:46:38', 'Pdt. Fence Liando', '081341160630', 'L', '63', 'Pdt.', 'GPdI AGAPE Tiniawangko', 'Minsel', 'Sulut', '', '', '', '', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:40'),
(2909, '2025-07-22 07:07:13', 'Pdt. Ferry Hanoch Frederik Sangian', '081340147673', 'L', '62 thn', 'Pdt.', 'GPdI Victory Kalawat', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Ferry Hanoch Frederik Sangian(saya) ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2910, '2025-07-02 09:34:23', 'Pdt. Filemon Palimbunga', '081211133387', 'L', '38', 'Pdt.', 'GKTDI Kristus Gembala Balikpapan', 'Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt. Filemon Palimbunga', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2911, '2025-08-23 15:14:06', 'Pdt. Geradus Wayoi', '081344808277', 'L', '62', 'Pdt.', 'GBI', 'Sorong', 'Papua Barat Daya', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Geradus Wayoi', '', '', 'Kamis, 28 Agustus 2025', '', '2025-08-29 15:18:40'),
(2912, '2025-07-20 20:17:34', 'Pdt. Herry Pangau Sth.', '082290410001', 'L', '62 thn', 'Pdt.', 'GPDI ELSADHAI TONGOA', 'Sigi Biromaru', 'Palu Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2913, '2025-07-08 18:52:29', 'Pdt. Jeffry Rumengan', '082333696555', 'L', '57', 'Pdm.', 'GPdI', 'Sidoarjo ', 'Jawa Timur ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:40'),
(2914, '2025-07-15 13:07:40', 'Pdt. Jetro Julis', '082199784009', 'L', '62 Tahun', 'Pdt.', 'GPdI Imanuel Kairatu', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Jetro Julis', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2915, '2025-07-08 18:39:34', 'Pdt. Junus Wotulo, S.Th., M.Miss', '081333513648', 'L', '57 thn', 'Pdt.', 'GPdI Ekklesia Family', 'Sidoarjo', 'Jawa Timur', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2916, '2025-07-02 10:14:27', 'Pdt. Martoni waruwu', '081375530703', 'L', '51 tahun', 'Pdt.', 'GKTDI JEMAAT SHALOM MEDAN', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Martoni waruwu ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:40'),
(2917, '2025-08-04 23:27:11', 'Pdt. Meike Ratu', '085289212606', 'P', '52', 'Istri Hamba Tuhan', 'GPdI Shekinah Cibinong', 'Bogor', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sony Johanes Ratu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2918, '2025-08-16 14:19:58', 'Pdt. Merry Umbunan', '', 'P', '47', 'Pdt.', 'GPdI Kora', 'Sigibiromaru Palu', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:41'),
(2919, '2025-07-08 18:46:39', 'Pdt. Metruly Lumenta', '081249638357', 'P', '56 thn', 'Istri Hamba Tuhan', 'GPdI Ekklesia Family', 'Sidoarjo', 'Jawa Timur', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Panitia', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2920, '2025-07-02 02:35:53', 'Pdt. Nataniel Hendrik O', '087775971836', 'L', '52 Tahun', 'Pdt.', 'GPT. BUKIT SION MAKASSAR', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Nataniel Hendrik O', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2921, '2025-07-07 21:12:15', 'Pdt. Nelson Tambunan', '082181782223', 'L', '81', 'Pdt.', 'GPT Kristus Gembala Jambi', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt  Nelson Tambunan', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2922, '2025-08-02 00:26:50', 'Pdt. Siane Bantara', '081245263169', 'P', '59 tahun', 'Istri Hamba Tuhan', 'GPdI', 'Sigi', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Siane Bantara', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2923, '2025-08-02 17:02:20', 'Pdt. Sionitra Kambuno', '081354599587', 'L', '50', 'Pdt.', 'GPT', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Sionitra Kambuno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2924, '2025-08-04 23:23:32', 'Pdt. Sony Johanes Ratu', '081219150634', 'L', '58 tahun', 'Pdt.', 'GPdI Shekinah Cibinong', 'Bogor', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sony Johanes Ratu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2925, '2025-08-16 14:20:53', 'Pdt. Steven Rantung', '081341100540', 'L', '48', 'Pdt.', 'GPdI Olo Baru', 'Parigi Moutong', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', 'Selasa, 2 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:41'),
(2926, '2025-07-13 22:28:09', 'Pdt. Tulus Iklas Zebua, S. Th', '081373330011', 'L', '53 thn', 'Pdt.', 'Gereja Pantekosta di Indinesia', 'Gunungsitoli/Pulau Nias', 'Sumatera Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', '-', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2927, '2025-08-16 14:20:57', 'Pdt. Vera Pasla', '081341100540', 'P', '46', 'Istri Hamba Tuhan', 'GPdI Olo Baru', 'Parigi Moutong', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', 'Selasa, 2 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:41'),
(2928, '2025-07-06 10:22:00', 'Pdt. Weldie Adolf Karoho, S.Th', '02195071723', 'L', '62 Tahun', 'Pdt.', 'GPSDI Alfa Omega Kakenturan', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Weldie Adolf Karoho, S.Th', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2929, '2025-08-02 10:15:13', 'Pdt. Yahya Moloku', 'O81344555089', 'L', '60 th', 'Pdt.', 'GBAI.JEMAAT LOGOS MERAUKE', 'Merauke', 'Papua selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Yahya Moloku', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2930, '2025-07-29 11:39:30', 'Pdt. Yohanes Pandensolang', '+6281379979052', 'L', '72 th', 'Pdt.', 'GKTDI Kristus Pengharapan - Kotaagung, Lampung', 'Tanggamus ', 'Lampung', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yonatan', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2931, '2025-07-07 20:07:00', 'Pdt. Yomi Kawengian', '085256622031', 'L', '48 thn', 'Pdt.', 'GPdI Elgibbor ILOLOY ', 'Minahasa selatan', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Gembala GPdI Elgibbor ILOLOY ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2932, '2025-07-04 07:25:43', 'Pdt.Filemon Fonataba', '081316666846', 'L', '72 thn', 'Pdt.', 'GBI Maeanata', 'Kota Bekasi', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Filemon Fonataba', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2933, '2025-07-03 17:18:18', 'Pdt.Geret Hendrik Lapong', '085656927740', 'L', '63 (thn)', 'Pdt.', 'GPSDI ALFA OMEGA TARATARA ', 'Tomohon ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Geret Hendrik Lapong ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2934, '2025-08-18 11:23:28', 'Pdt.Gunawan Wibisono', '081344637918', 'L', '66', 'Pdt.', 'GPT. Kristus Pembela, Kmp.Malaus, Salawati', 'Sorong', 'Papua Barat Daya', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi ditanggung Panitia', 'Pdt.Gunawan Wibisono', 'LION', '', '', '', '2025-08-29 15:18:41'),
(2935, '2025-07-23 12:39:47', 'Pdt.Hanna Lengkoan', '082192218340', 'L', '68 thn', 'Pdt.', 'GPdI Imanuel Sejahtera', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2936, '2025-07-29 10:58:23', 'Pdt.Jean Walean', '082194384954', 'P', '55 thn', 'Pdt.', 'GPdI Ranteleda', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2937, '2025-07-18 11:43:13', 'Pdt.Jeklin Wowiling', '082284992188', 'P', '46 thn', 'Pdt.', 'GPdI Imanuel BAHAGIA ', 'Sigi biromaru ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Nicky lumenta ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2938, '2025-07-19 20:38:12', 'Pdt.Jones Wokas', '081341425716', 'L', '41 Tahun', 'Pdt.', 'Gereja Gerakan Pentakosta(GGP)', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Jones Wokas', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2939, '2025-07-23 15:50:41', 'Pdt.Josua.P.Nababan STh', '081366031694', 'L', '62 tahun', 'Pdt.', 'GPPS.Imanuel Jambi', 'kota Jambi', 'Jambi', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Josua P.Nababan STh', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2940, '2025-07-28 09:22:29', 'Pdt.Linda Sari', '085363531727', 'P', '54 Thn', 'Pdt.', 'GPdI Bethesda Simpang Astra', 'Siak Sri Indrapura', 'Riau Pekanbaru', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2941, '2025-07-24 21:25:48', 'Pdt.Mangatur  Mangaratua Panjaitan', '082347566210', 'L', '42 Thn', 'Pdt.', 'GPdI Sidondo', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2942, '2025-07-02 02:52:55', 'Pdt.Martolius minggu', '085249928805', 'L', '59 Tahun', 'Pdt.', 'Gpt Kristus Gembala Gorontalo', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Martolius minggu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2943, '2025-07-22 13:26:32', 'Pdt.max langi', '082118564245', 'L', '69', 'Pdt.', 'GPdI gunung potong', 'Sigi biromaru', 'Palu Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2944, '2025-07-18 11:40:06', 'Pdt.Nicky Lumenta', '082284992188', 'L', '52 thn', 'Pdt.', 'GPdI Imanuel BAHAGIA ', 'Sigi biromaru ', 'Sulawesi Tengah ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Nicky Lumenta ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2945, '2025-07-23 12:37:06', 'Pdt.Richard Rantung', '082192218340', 'L', '69', 'Pdt.', 'GPdI Imanuel Sejahtera', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2946, '2025-07-18 20:38:00', 'Pdt.Simon Haloho, S.Th', '081372871579', 'L', '42 tahun', 'Pdt.', 'GPT Krisando- Kapeta', 'Siau Tagulandang Biaro (Sitaro)', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Simon Haloho,S.Th', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2947, '2025-07-24 14:44:32', 'Pdt.Syeni Tatulus', '082220830785', 'P', '55 thn', 'Pdt.', 'GPdI Kasih Karunia', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2948, '2025-07-07 10:42:58', 'Pdt.Tumim Panjaitan', '081365688473', 'L', '57', 'Pdt.', 'GKTDI Kristus Kasih', 'Pekanbaru ', 'Riau', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt.Tumim Panjaitan ', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2949, '2025-07-23 10:17:47', 'Pdt.Werlin Mowemba', '082335562415', 'P', '69 thn', 'Pdt.', 'GPdI KNPI', 'Sigibiromaru', 'Palu Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2950, '2025-07-18 09:35:13', 'Pdtm MASRINE Lumban Tobing', '082255759990', 'P', '46 thn', 'Pdm.', 'Gpdi', 'Kutaikartanegara', 'Kalimantan Timur ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt nolly', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2951, '2025-07-16 16:16:54', 'Pendeta Soedjanmono', '081325166725', 'L', '73', 'Pdt.', 'GKTDI Kristus Kehidupan', 'Medan Belawan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pendeta Soedjanmono', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2952, '2025-08-02 11:11:21', 'Peter Williantono', '08161959454', 'L', '81', 'Pdt.', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Peter Williantono', '', '', 'Sabtu, 30 Agustus 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2953, '2025-07-20 16:12:48', 'Poltak Pasaribu', '081281017433', 'L', '45 thn', 'Pdt.', 'Gktdi Kristus Penolong Cileungsi', 'Bogor', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Poltak Pasaribu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2954, '2025-07-15 13:13:57', 'Princess Eunike Julis', '082199784009', 'P', '11 Tahun', 'Anak Hamba Tuhan', 'GPdI Immanuel Kairatu', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Jetro Julis', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2955, '2025-07-23 14:57:48', 'Priscilla Syenny meriyana', '082227150250', 'P', '42', 'Istri Hamba Tuhan', 'Gpt gunung hermon ', 'Batam ', 'Kepulauan Riau ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdm.hendy Sihombing ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2956, '2025-07-14 00:22:24', 'Priskila Suba', '087784909846', 'P', '17', 'Anak Hamba Tuhan', 'GKTDI Imanuel Watuawu', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ranita Nainggolan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2957, '2025-07-29 18:35:48', 'RACHMAT PANJAITAN', '085368557575', 'L', '56', 'Pdt.', 'GBI ROCK PENABUR ', 'PEKANBARU ', 'RIAU', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Filemon Fonataba', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2958, '2025-07-18 00:03:39', 'Rafel sitanggang', '081364794540', 'L', '67 thn', 'Pdt.', 'GPDI Alfa Omega Batu Aji- Batam KEPRI', 'Kota batam', 'Kepri', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Rafel Sitanggang', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2959, '2025-07-09 22:05:08', 'Ranita Nainggolan', '082247595059', 'P', '49', 'Ibu Janda Hamba Tuhan', 'GKTDI Imanuel Watuawu', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ranita Nainggolan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:41'),
(2960, '2025-07-02 12:01:38', 'Rebeka Anastasya', '082151567177', 'P', '35 Tahun', 'Istri Hamba Tuhan', 'GKTDI \"Kristus Gembala\"', 'Kabupaten Penajam', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdm. Maleakhi Urbanus Palimbunga', 'LION HOTEL***', 'Executive Suite Rp. 1.000.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2961, '2025-07-30 15:16:48', 'Riana Silalahi', '081222200186', 'P', '60', 'Ibu Janda Hamba Tuhan', 'GPT Kristus Raja', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Lois', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:41'),
(2962, '2025-07-01 23:42:22', 'Ribka Feybe Bawuna', '081325524406', 'P', '40 Tahun', 'Istri Hamba Tuhan', 'GKTDI Kristus Gembala Morotai ', 'Pulau Morotai', 'Maluku Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hendra Toni Butar Butar ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2963, '2025-07-02 10:23:30', 'Rina Sidabutar', '081375530703', 'P', '48 tahun', 'Istri Hamba Tuhan', 'GKTDI Jemaat Shalom Medan', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Martoni waruwu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2964, '2025-07-03 21:19:48', 'RINNY JULIKE WOWILING', '085231129991', 'P', '46', 'Istri Hamba Tuhan', 'GEREJA PANTEKOSTA TABERNAKEL', 'SITARO', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Jimmy Talumewo', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2965, '2025-07-20 18:13:22', 'Risci Taib Nasution', '089604458503', 'L', '34', 'Pdt.', 'Gereja Bethany Seretan', 'Minahasa', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Risci Taib Nasution', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2966, '2025-08-03 18:12:49', 'Rismawati Abram', '081354599587', 'P', '40', 'Istri Hamba Tuhan', 'GPT', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Sionitra Kambuno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2967, '2025-07-05 22:24:20', 'Robert P. Makapindar', '085241006941', 'L', '73 tahun', 'Pdt.', 'GPT Kristus Gembala Bahu Manado', 'Manado', 'Sulawesi utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Robert P. Makapindar', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2968, '2025-08-01 10:51:16', 'ROMI TENDEAN', '082191389347', 'L', '48', 'Pdt.', 'GPdI ELSHADAI PINEDAPA', 'POSO', 'SULAWESI TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'PANITIA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2969, '2025-07-19 13:00:28', 'Roni Modi Lausan', '081347411600', 'L', '50 tahun', 'Pdt.', 'Gpdi Tanah datar', 'Kec muara badak Kukar ', 'Kal Tim', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Roni modi lausan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2970, '2025-07-03 17:24:19', 'Rosa Datu', '085705433907', 'P', '58 (thn)', 'Pdm.', 'GPSDI ALFA OMEGA TARATARA ', 'Tomohon ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Geret Hendrik Lapong ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2971, '2025-07-08 10:06:00', 'Rosdiana Tobing', '0823-7712-2377', 'P', '52', 'Istri Hamba Tuhan', 'GKTDI', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Daniel Pagawak', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2972, '2025-07-02 22:04:33', 'Rosita Vera Mandiangan', '082194754616', 'P', '52 thn', 'Istri Hamba Tuhan', 'GPT Krustus Raja Bulangan', 'Kepulauan Sitaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', '-', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2973, '2025-07-14 11:20:08', 'Rosmawati Siahaan', '081287775522', 'P', '59 tahun', 'Istri Hamba Tuhan', 'Gereja Pantekosta Serikat Indonesia (GPSI)', 'Jakarta Utara ', 'DKI', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yusuf Nic Panjaitan ', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2974, '2025-08-02 12:00:42', 'Rosmeli Manurung', '082167121360', 'P', '33', 'Pengerja', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Rosmeli Manurung', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2975, '2025-07-16 16:18:29', 'ROSNI SOEDJANMOMO', '081315166725', 'P', '63', 'Istri Hamba Tuhan', 'GKTDI Kristus Kehidupan', 'Medan', 'Sumatera Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pendeta Soedjanmono', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2976, '2025-07-12 15:36:05', 'Rudy Adolf Lumatauw', '085216675113', 'L', '59 Tahun', 'Pdt.', 'Gereja Pantekosta di Indonesia', 'Tangerang Selatan', 'Banten', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sendiri', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2977, '2025-07-02 02:45:04', 'Rudy Marbun', '085256553283', 'L', '63', 'Pdt.', 'GPT FILADELFIA GENTUMA', 'Gorontalo Utara', 'Gorontalo', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Rudy marbun', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2978, '2025-07-02 02:58:10', 'Rufus Y Sinamora', '081286523246', 'L', '35', 'Pdt.', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua barat daya', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Rufus Y Sinamora', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2979, '2025-08-02 09:29:10', 'Ruly christanto', '085256403978', 'L', '47', 'Pdt.', 'GPT Kristus Gembala Agung ', 'Manado', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ruly Christanto', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2980, '2025-07-22 14:40:09', 'Rusnawati pasaribu', '081354343793', 'P', '45 thn', 'Istri Hamba Tuhan', 'GPT ', 'Sigi', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohanis pangala', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2981, '2025-07-02 02:51:15', 'Rut Sri Utami', '085256553283', 'P', '57 Tahun', 'Istri Hamba Tuhan', 'GPT FILADELFIA GENTUMA', 'Gorontalo Utara', 'Gorontalo', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Rudy Marbun', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42');
INSERT INTO `participants` (`id`, `timestamp`, `nama_peserta`, `nomor_whatsapp`, `jenis_kelamin`, `usia`, `jabatan`, `asal_gereja`, `kota_kabupaten`, `provinsi`, `akomodasi_konsumsi`, `kepala_penanggung_jawab_kamar`, `pilihan_hotel`, `pilihan_kamar`, `kedatangan`, `kepulangan`, `created_at`) VALUES
(2982, '2025-07-31 09:15:56', 'Ruth AS Bangguna', '085141202227', 'P', '43', 'Pdm.', 'Gereja Pantekosta di Indonesia', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ruth AS Bangguna', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2983, '2025-08-02 12:15:42', 'Samu Anggoh', '08129409140', 'L', '59', 'Pdt.', 'GKTDI Kristus Penolong', 'Jakarta Utara', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Samu Anggoh', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2984, '2025-07-17 14:47:05', 'Samuel Ari Harseno', '081229438890', 'L', '49', 'Pdm.', 'GPSDI', 'Surakarta', 'Jawa Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Samuel Ari Harseno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2985, '2025-07-02 09:48:57', 'Samuel Tanifan', '082248169109', 'L', '53 thn', 'Pdm.', 'GKTDI Kristus Raja ', 'Kairatu/Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Samuel Tanifan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2986, '2025-08-02 11:54:37', 'Sandra Irawan', '08129534142', 'P', '68', 'Istri Hamba Tuhan', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Lucas Irawan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2987, '2025-07-30 00:37:46', 'Sarah Graciola Sampeliling', '085246815575', 'P', '21', 'Istri Hamba Tuhan', 'Gpt kristus kasih Palu', 'Palu', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Hizkia imanuel ongan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2988, '2025-07-02 02:31:26', 'Sarah Yayuk Ariyani', '085226751997', 'P', '44', 'Istri Hamba Tuhan', 'GPSDI Jangkungan ', 'Salatiga ', 'Jawa Tengah ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yula Lustianto ', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2989, '2025-07-30 15:17:09', 'Sardind Henoch Gononggo', '081341142323', 'L', '49', 'Pdt.', 'Gereja Pantekosta di Indonesia (GPdI)', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sardind Henoch Gononggo', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2990, '2025-08-02 11:48:46', 'Scharlly A. Rosita', '087782020525', 'P', '56', 'Istri Hamba Tuhan', 'Gereja Elim Tabernakel', 'Jakarta Utara', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Muhonis Nixon', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2991, '2025-07-02 03:03:03', 'Selumiel minggu', '081340210305', 'L', '8 Tahun', 'Anak Hamba Tuhan', 'Gpt Kristus Gembala Gorontalo', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Bpk Martolius Minggu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2992, '2025-07-02 10:21:22', 'Sely Widiastanti', '081391100280', 'P', '30 Tahun', 'Istri Hamba Tuhan', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yosua Victoria', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe sea view Rp. 750.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2993, '2025-07-19 08:42:54', 'Serli katulung', '085397303665', 'P', '59 thn', 'Istri Hamba Tuhan', 'Gpt bukit Sion HASI tagulandang', 'Sitaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Wildumel tumeleng', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2994, '2025-07-20 18:35:34', 'Seysi Mewengkang', '0895635794802', 'P', '40', 'Istri Hamba Tuhan', 'Gereja Bethany Seretan', 'Minahasa', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Risci Taib Nasution', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2995, '2025-07-17 09:13:47', 'Shawn Elliot Imanuel Ongan', '081213896998', 'L', '3', 'Anak Hamba Tuhan', 'GPT Kristus Penolong Saojo Maliwuko', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Haniel Imanuel Ongan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2996, '2025-08-02 09:45:23', 'Sherly Poluan', '082278946626', 'P', '59', 'Pengerja', 'GPT Kristus Gembala Agung ', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Sherly Poluan', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2997, '2025-07-27 14:42:14', 'Sherly Tandidatu/Mustamu', '081240256003', 'P', '38', 'Istri Hamba Tuhan', 'GKTDI Kristus Gembala Biak ', 'Biak ', 'Papua ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sherly Tandidatu/ Mustamu ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(2998, '2025-07-05 00:18:57', 'Shivra Kezia Tutu', '081340086232', 'P', '50th', 'Istri Hamba Tuhan', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt David Richard Tutu', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.00,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(2999, '2025-08-02 12:17:13', 'Siecka Anggoh', '08124485065', 'P', '58', 'Istri Hamba Tuhan', 'GKTDI Kristus Penolong', 'Jakarta Utara', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Samu Anggoh', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(3000, '2025-07-31 13:08:06', 'Silvya Ongan', '081245447400', 'P', '55 thn', 'Ibu Janda Hamba Tuhan', 'GPT.Kristus Kasih Palu', 'Palu', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Silvya Ongan', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(3001, '2025-08-01 14:48:30', 'Silwanus Mareli Gulo', '0823 9586 9513', 'L', '52 tahun', 'Pdt.', 'Gereja Pantekosta Tabernakel', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'SILWANUS MARELI GULO ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(3002, '2025-08-02 09:49:37', 'SISKA JATUSARI', '085258162328', 'P', '44 thn', 'Istri Hamba Tuhan', 'GPT KRISTUS GEMBALA AGUNG BUMI NYIUR  ', 'MANADO', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ruly christanto', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(3003, '2025-07-25 13:42:59', 'Sonny J Oroh', '085298813766', 'L', '51', 'Pdt.', 'GSPDI ', 'Langowan Minahasa ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sonny J Oroh ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:42'),
(3004, '2025-08-16 14:05:14', 'Sonny R Kordak', '085218877331', 'L', '61', 'Pdt.', 'GPdI', 'Depok', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:42'),
(3005, '2025-07-14 22:21:11', 'Sony Abas', '085298444700', 'L', '49 thn', 'Pdt.', 'GPKDI Keluarga Allah ', 'Tobelo/Halmahera Utara', 'Maluku Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sony Abas', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:42'),
(3006, '2025-07-04 07:28:59', 'Sonya k Fonataba', '081288135253', 'P', '48 thn', 'Pdp.', 'GBI MARANATA ', 'Bekasi', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Sonya k Fonataba', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3007, '2025-07-04 09:59:40', 'Sri Yuningsi Malendes', '082311277936', 'P', '41', 'Istri Hamba Tuhan', 'GPT Lesah', 'Sitaro', 'Sulut', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Tri Luki', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3008, '2025-08-02 12:19:00', 'Stanly Anggoh', '0852-8483-3454', 'L', '39', 'Pdt.', 'GKTDI Kristus Penolong', 'Jakarta Utara', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Stanly Anggoh', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3009, '2025-07-15 14:41:53', 'Stenly Lepar', '08114819140', 'L', '50 thn', 'Pdt.', 'GPdI Eben Heazer Sentani', 'Jayapura', 'Papua', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Stenly Lepar', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3010, '2025-07-11 08:38:18', 'Stenly Sumanti', '081260032195', 'L', '52 tahun', 'Pdt.', 'GPT', 'Tentena Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Stenly sumanti', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3011, '2025-07-12 21:27:39', 'Stevani Waha palar', '085255006999', 'P', '42thn', 'Istri Hamba Tuhan', 'GPT', 'Makassar ', 'Sulawesi Selatan ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yehuda Kambuno ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3012, '2025-07-10 18:46:26', 'STEVANUS FAEHUSI ZEBUA', '085240106000', 'L', '54', 'Pdt.', 'GPT PETRA MANGANITU', 'KEPULAUAN SANGIHE', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'STEVANUS FAEHUSI ZEBUA', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3013, '2025-07-02 00:03:10', 'Steven Macpal', '085256170917', 'L', '40', 'Pdt.', 'GPT Charisma Didiri', 'Poso', 'Sulawesi tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Steven Macpal', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3014, '2025-07-18 21:46:27', 'Stevie Liwe', '086298079680', 'P', '55', 'Istri Hamba Tuhan', 'Gpdi bukit Hermon ', 'Bitung ', 'Sulut ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt yusak mentang ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3015, '2025-07-19 18:59:33', 'Sulamit Cussoy', '081260032195', 'P', '50', 'Istri Hamba Tuhan', 'GPT', 'Tentena Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Stenly Sumanti', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3016, '2025-07-15 13:10:46', 'Susan Esther Mongkauw', '082199784009', 'L', '50', 'Pdt.', 'GPdI Imanuel Kairatu', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. jetro Julis', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3017, '2025-08-16 12:13:51', 'Tabita Tinambunan', '081281017433', 'P', '46', 'Istri Hamba Tuhan', 'GKTDI Kristus Penolong Cileungsi', 'Bogor', 'Jawa Barat', 'Akomodasi urus sendiri konsumsi panitia', '', '', '', '', '', '2025-08-29 15:18:43'),
(3018, '2025-07-21 20:47:16', 'Thomas Pasombo', '082299413953', 'L', '58', 'Pdt.', 'Gereja Pantekosta Tabernakel Wuasa', 'Kabupaten Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Thomas pasombo', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3019, '2025-08-02 11:26:20', 'Timotius O. Saleppa', '081385785762', 'L', '63', 'Pdt.', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Timotius O. Saleppa', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3020, '2025-07-25 17:32:38', 'Tinny sepang', '081245388965', 'P', '55', 'Pdt.', 'GPdI Zaitun Rahmat Kec. Palolo', 'Sigi', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Ngarijan Joshua', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3021, '2025-07-04 09:17:28', 'Tri Luki', '082311277936', 'L', '48', 'Pdt.', 'GPT LESAH', 'Sitaro', 'SULUT', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Tri Luki', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3022, '2025-07-15 13:12:41', 'Trifosa Ribka Julis', '082199784009', 'P', '17 Tahun', 'Anak Hamba Tuhan', 'GPdI Immanuel Kairatu', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Jetro Julis', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3023, '2025-07-02 13:39:15', 'Tulus Sibarani', '081366329992', 'L', '47th', 'Pdt.', 'Gereja Pantekosta Tabernakel ', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Tulus sibarani', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3024, '2025-07-03 16:37:47', 'Tutik Nurani', '085692969795', 'P', '57 Tahun', 'Istri Hamba Tuhan', 'GPdI Kristus Gembala', 'Kota Depok', 'Jawa Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Eddy BW. Tampemawa', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3025, '2025-07-20 21:27:38', 'Venny Kending', '082188994634', 'P', '48', 'Istri Hamba Tuhan', 'Gereja Bethany Indonesia', 'Minahasa utara', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Wolfrets Gumabo', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3026, '2025-08-01 20:40:14', 'Violent Engel Utama', '082197945476', 'P', '52 tahun ', 'Istri Hamba Tuhan', 'GPT KRISTUS PENOLONG ', 'SORONG SELATAN ', 'PAPUA BARAT DAYA ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt AYUB YEWUN ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3027, '2025-07-02 16:34:00', 'WAHYU KRISTIANI', '081287886651', 'P', '46 Tahun', 'Istri Hamba Tuhan', 'GPSDI KRISTUS RAJA DAMAI TRANGKIL', 'PATI', 'JAWA TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'ESLY KURANTHA', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3028, '2025-07-07 10:46:56', 'Wastina Br Simanjuntak', '081365688473', 'P', '57 tahun', 'Istri Hamba Tuhan', 'GKTDI Kristus Kasih', 'Pekanbaru ', 'Riau', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt.Tumim Panjaitan ', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3029, '2025-07-07 20:22:56', 'Welly gerungan', '081386174662', 'L', '65 tahun', 'Pdt.', 'GPDI', 'Kota', 'Jawa barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt Welly gerungan', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3030, '2025-08-02 11:46:32', 'Wiedati Lumoindong', '081326239013', 'P', '85', 'Ibu Janda Hamba Tuhan', 'GBT Kristus Alfa Omega', 'Semarang', 'Jawa Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Wiedati Lumoindong', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3031, '2025-07-18 21:31:42', 'Wiemach Puri Diansari', '082216221820', 'P', '42', 'Istri Hamba Tuhan', 'GPT Krisando-Kapeta ', 'Siau Tagulandang Biaro (Sitaro)', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt.Simon Haloho, S.Th', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3032, '2025-07-22 11:02:23', 'Wiesye Dumanauw', '081343927592', 'P', '61 thn', 'Istri Hamba Tuhan', 'GPdI ', 'Kabupaten Luwu ', 'Sulawesi Selatan ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Arnold Nuban ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3033, '2025-07-19 08:49:33', 'Wildumel tumeleng', '085397303665', 'L', '58 thn', 'Pdm.', 'Gpt bukit Sion haasi', 'Sitaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Wildumel tumeleng', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3034, '2025-07-17 21:39:21', 'Wiwaha Parikesit', '085714650503', 'P', '19', 'Anak Hamba Tuhan', 'GPT Kristus Mulia ', 'Jogja', 'DIY', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yosua Suwidi ', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3035, '2025-07-20 21:23:14', 'Wolfrets Gumabo', '082188994634', 'L', '50 thn', 'Pdt.', 'Gereja Bethany Indonesia', 'Minahasa Utara', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Wolfrets Gumabo', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3036, '2025-08-02 11:44:25', 'Wulan Songan', '081315677790', 'P', '51', 'Istri Hamba Tuhan', 'GKTDI Kristus Raja', 'Jakarta Pusat', 'DKI Jakarta', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Andrey C. Songan', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3037, '2025-07-02 09:40:17', 'Yahel Parangki', '081211133387', 'P', '30', 'Istri Hamba Tuhan', 'GKTDI Kristus Gembala Balikpapan', 'Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt. Filemon Palimbunga', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3038, '2025-07-02 09:26:15', 'Yatniel Palimbunga', '085247813822', 'P', '32', 'Istri Hamba Tuhan', 'GPSDI KRISTUS PENEBUS', 'Nabire', 'Papua Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Albert Hezky Christiawan', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3039, '2025-08-02 12:24:18', 'Yehezkiel Nederupun', '082244402022', 'L', '39', 'Pdm.', 'GKTDI Kristus Alfa & Omega', 'Bekasi', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yehezkiel Nederupun', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3040, '2025-07-10 21:21:05', 'Yehuda Kambuno', '085255006999', 'L', '47 thn', 'Pdt.', 'GPT', 'Makassar ', 'Sulawesi Selatan ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yehuda Kambuno ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3041, '2025-07-12 18:08:36', 'Yenlly Unggu Pinontoan', '082217307279', 'P', '54 Tahun ', 'Istri Hamba Tuhan', 'Gereja Pantekosta Tabernakel ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Djery Hanny Kolamban ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3042, '2025-08-02 10:19:00', 'Yenny.Moloku', '081344555089', 'P', '51 tj', 'Istri Hamba Tuhan', 'GBAI.JEMAAT LOGOS.MERAUKE', 'Merauke', 'Papua selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Yahya Moloku', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:43'),
(3043, '2025-08-10 23:27:33', 'Yohana Tanifan', '082187046172', 'P', '53', 'Pdt.', 'Gereja Suara Ketebusan Sorong', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohana Tanifan', '', '', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:18:43'),
(3044, '2025-07-26 06:22:38', 'Yohanes Indra', '081354873025', 'L', '73 th', 'Pdt.', 'Gereja Pantekosta di Indonesia', 'Ds Bukit jaya Kec Toili jaya Kab Banggai', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohanes Indra', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3045, '2025-07-01 23:54:21', 'Yohanes Suyatno', '08126189033', 'L', '51', 'Pdt.', 'GEREJA PANTEKOSTA TABERNAKEL', 'BATAM', 'KEPULAUAN RIAU', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohanes Suyatno', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3046, '2025-07-22 14:36:12', 'yohanis pangala', '081354343793', 'L', '44 thn', 'Pdt.', 'GPT', 'Sigi', 'Sulteng', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yohanis pangala', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:43'),
(3047, '2025-07-20 21:28:14', 'Yonatan', '087831196677', 'L', '47', 'Pdm.', 'GPSDI', 'Bantul', 'Yogjakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yonatan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3048, '2025-07-28 17:09:34', 'Yos Egeten', '085298099135', 'L', '47', 'Pdt.', 'GPdI Elshadai Tentena', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Kepala', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3049, '2025-07-19 13:37:25', 'YOSIFYA TALITA SEWANG', '085242995974', 'P', '14', 'Anak Hamba Tuhan', 'GPT KRISTUS PENOLONG SAOJO', 'POSO', 'SULAWESI TENGAH', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Nova', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3050, '2025-07-17 21:36:13', 'Yosua Suwidi', '085714650503', 'L', '64', 'Pdt.', 'GPT Kristus Mulia', 'Jogja', 'DIY', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yosua Suwidi ', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:44'),
(3051, '2025-07-02 10:17:45', 'Yosua Victoria', '081391100280', 'L', '42 Tahun', 'Pdp.', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yosua Victoria', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe sea view Rp. 750.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3052, '2025-07-19 20:18:27', 'Yuike kodong', '085240786314', 'P', '43', 'Pdm.', 'GPdI Ekklesia Kamarora kec. Nokilalaki', 'Sigi', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Fandra Tiwa', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3053, '2025-07-02 00:07:40', 'Yula Lustianto', '085290860674', 'L', '50th', 'Pdm.', 'GPSDI Jangkungan', 'Salatiga ', 'Jawa Tengah ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yula Lustianto ', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3054, '2025-08-21 11:28:36', 'Yuliana  Agustina Hengkeng', '081344982829', 'L', '65', 'J', 'GPT Kristus Ajaib', 'Manokwari', 'Papua Barat', 'Akomodasi dan Konsumsi Ditanggung Panitia', '', '', '', '', '', '2025-08-29 15:18:44'),
(3055, '2025-07-30 15:24:15', 'Yulin Sepatondu', '085189269942', 'P', '47', 'Pdm.', 'Gereja Pantekosta di Indonesia (GPdI)', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yulin Sepatondu', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:44'),
(3056, '2025-07-02 12:24:08', 'Yuliske Lidia Kawulur', '081390225215', 'P', '49', 'Istri Hamba Tuhan', 'GKTDI ponompiaan', 'Bolaang Mongondow', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Abdiel Setiawan Firmanto', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:44'),
(3057, '2025-07-13 16:53:56', 'Yuna', '087775971836', 'P', '42', 'Istri Hamba Tuhan', 'GPT. BUKIT SION MAKASSAR', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Nataniel Hendrik O', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3058, '2025-07-26 15:13:06', 'Yuniar Ch. Pandensolang', '+6281379560419', 'P', '39th', 'Anak Hamba Tuhan', 'GKTDI Kristus Pengharapan - Kotaagung, Lampung', 'Tanggamus', 'Lampung', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Anton', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3059, '2025-08-18 12:39:40', 'Yunita Ivone Tungka', '081341100540', 'P', '49', 'Istri Hamba Tuhan', '', '', '', '', '', '', '', '', '', '2025-08-29 15:18:44'),
(3060, '2025-07-30 18:29:22', 'Yusak Mokolomban', '082198832488', 'L', '58 thn', 'Pdt.', 'GPdI Elsaday Lumalatal', 'Seram Bagian Barat', 'Maluku', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Yusak Mokolomban', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:44'),
(3061, '2025-07-14 11:15:44', 'Yusuf Nic Panjaitan', '081287775522', 'L', '65 tahun', 'Pdt.', 'Gereja Pantekosta Serikat Indonesia (GPSI)', 'Jakarta Utara ', 'DKI ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yusuf Nic Panjaitan ', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3062, '2025-08-01 16:16:12', 'Zefanya Joseph Elnatan', '082119191942', 'L', '18', 'Anak Hamba Tuhan', 'GKTDI EFATA ', 'Bandar Lampung ', 'Lampung ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pdt Hendry Sutanto ', 'BEST WESTERN THE LAGOON HOTEL****', 'Deluxe Executive Rp. 850.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:44'),
(3063, '2025-07-15 13:42:05', 'Zuhdi Fretto Siburian', '081317781272', 'L', '45', 'Pdt.', 'Gereja Pentakosta Kotabaru Jambi ', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Ditanggung Panitia', 'Pdt. Zuhdi Fretto Siburian ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:18:44'),
(3064, '2025-07-06 18:15:15', 'Abigail Eunice Sahetapy', '087883528356', 'P', '31th', 'Imam-imam/Jemaat', 'GKTDI Kristus Raja ', 'Jakarta', 'DKI Jakarta', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Jacob Marlon Sahetapy', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Minggu, 7 September 2025', '2025-08-29 15:18:59'),
(3065, '2025-07-07 21:23:23', 'Adelle R. Christoffel', '085242016271', 'P', '42 tahun', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Manado', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Kalvianus Palimbongan', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:59'),
(3066, '2025-07-07 21:29:33', 'Alviel R. Palimbongan', '085242016271', 'L', '7 tahun', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Manado ', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Kalvianus Palimbongan', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:18:59'),
(3067, '2025-07-07 16:01:04', 'Amoreiza Bogar', '081356021185', 'P', '9', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Felix Bogar', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3068, '2025-07-05 12:46:47', 'Andreas Gideon Runtulalo', '085692683177', 'L', '19 th', 'Imam-imam/Jemaat', 'GKTDI KRISTUS RAJA', 'JAKARTA', 'DKI JAKARTA ', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Hebron Runtulalo ', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3069, '2025-07-05 05:05:04', 'Angelia Jacobs', '085274732416', 'P', '19', 'Imam-imam/Jemaat', 'GPT haasi ', 'Sitaro ', 'Sulawesi Utara ', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Vernandef ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3070, '2025-07-05 05:01:16', 'Charisyani Matualaga', '085274732416', 'P', '22', 'Imam-imam/Jemaat', 'GPT Kristus gembala bahu ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Edwin ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3071, '2025-07-07 08:57:55', 'Dervina Pratiwi Sianturi', '081211457422', 'P', '27 thn', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA SENTANI ', 'Jayapura', 'Papua', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Hanna Daniella Gainau', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3072, '2025-07-05 04:58:16', 'Edwin Matualaga', '085274732416', 'L', '65', 'Imam-imam/Jemaat', 'GPT Kristus gembala bahu ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Edwin ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3073, '2025-07-02 19:04:37', 'ELEANOR IVANNA GRACIELLA SELANNO', '081333758101', 'P', '7', 'Imam-imam/Jemaat', 'GPT. KRISTUS PENGASIH, AIMAS', 'KAB. SORONG', 'PAPUA BARAT DAYA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'NOVERIO GUNAWAN SELANNO', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3074, '2025-07-02 18:57:29', 'ELHANAN ISAAC GAVRIEL SELANNO', '081333758101', 'L', '5', 'Imam-imam/Jemaat', 'GPT. KRISTUS PENGASIH, AIMAS', 'KAB. SORONG', 'PAPUA BARAT DAYA', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'NOVERIO GUNAWAN SELANNO', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3075, '2025-07-05 22:05:08', 'Elia Theophilus Sabaru', '08999205313', 'L', '22', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Standfield Sabaru', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3076, '2025-07-02 00:57:51', 'Elon Balau', '082291327193', 'P', '35', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Wonggarasi', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Elon Balau', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3077, '2025-07-08 10:14:14', 'Febe Pagawak', '081278654494', 'P', '23', 'Imam-imam/Jemaat', 'GKTDI ', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Marselia Rut ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3078, '2025-07-07 15:55:43', 'Felix Bogar', '085298729467', 'L', '42', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Felix Bogar', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3079, '2025-07-05 05:03:54', 'Femy amir', '085274732416', 'P', '50', 'Imam-imam/Jemaat', 'GPT haasi ', 'Sitaro ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Vernandef ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3080, '2025-07-07 06:34:27', 'Hanna Daniela Gainau', '081340976393', 'P', '20 tahun', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Sentani ', 'Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Hanna D Gainau', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3081, '2025-07-05 12:42:00', 'Hebron Pusaka Runtulalo', '082114120971', 'L', '55 th', 'Imam-imam/Jemaat', 'GKTDI KRISTUS RAJA JAKARTA', 'Jakarta ', 'DKI Jakarta ', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Hebron Runtulalo ', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3082, '2025-07-02 00:50:50', 'Hermon Sumule', '081253369581', 'P', '29', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Royi Sumule', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3083, '2025-07-02 00:59:38', 'Heryanto Kapal', '085257438133', 'L', '49', 'Imam-imam/Jemaat', 'GPIG EBENHAEZER Wonggarasi', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Heryanto Kapal', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3084, '2025-07-02 00:44:51', 'Hesli Azalia', '081253369581', 'P', '24', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Royi Sumule', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3085, '2025-07-07 21:17:37', 'Hindar Rosmadewi', '085268616868', 'P', '51', 'Imam-imam/Jemaat', 'GKDTI', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tomy Yutaka', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3086, '2025-07-02 00:35:09', 'Ibu Linda Antoh', '081240605670', 'P', '49 Tahun', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih', 'Kabupaten Sorong', 'Papua Barat Daya', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ibu Linda Antoh', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3087, '2025-07-05 09:35:47', 'Ibu Masye Renyaan', '081247469494', 'P', '46 Tahun', 'Imam-imam/Jemaat', 'Kristus Pengasih ', 'Sorong', 'Papua Barat Daya', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ibu Masye Renyaan ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3088, '2025-07-06 16:23:14', 'Indah Sondakh', '085657201413', 'P', '34 thn', 'Imam-imam/Jemaat', 'GKTDI PONOMPIAAN ', 'Bolaang Mongondow ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yunus Sondakh ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3089, '2025-07-06 18:07:14', 'Jacob Marlon Sahetapy', '085959684575', 'L', '65th', 'Imam-imam/Jemaat', 'GKTDI Kristus Raja', 'Jakarta', 'DKI Jakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jacob Marlon Sahetapy', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Minggu, 7 September 2025', '2025-08-29 15:19:00'),
(3090, '2025-07-05 04:56:08', 'Jeane Inggrid Jacobs', '085274732416', 'P', '32', 'Imam-imam/Jemaat', 'GPT Kristus gembala bahu ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Ronald ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3091, '2025-07-05 21:39:14', 'Jeconiah Matheos', '089530282449', 'P', '17 tahun', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Mariam Katiandagho', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3092, '2025-07-05 21:33:10', 'Jeth Bendah', '089513386061', 'P', '52 thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung', 'Kota Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jeth Bendah', 'MCC RESORT**', 'Deluxe Sea View Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3093, '2025-07-05 22:17:41', 'Joanna Elisabeth Bawuna', '089669011112', 'P', '19 Thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung', 'Kota Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jultje Jovina Kilanta', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3094, '2025-07-07 21:15:51', 'Jony iskandar', '+62 822-6213-0040', 'L', '50', 'Imam-imam/Jemaat', 'GKTDI ', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'TOMY YUTAKA', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3095, '2025-07-05 12:44:17', 'Josephien Fransisca', '085966436388', 'P', '55 th', 'Imam-imam/Jemaat', 'GKTDI KRISTUS RAJA', 'JAKARTA ', 'DKI JAKARTA ', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Hebron Runtulalo ', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3096, '2025-07-05 21:53:22', 'JULIET BERKIPAS', '085298420442', 'P', '77 TAHUN', 'Imam-imam/Jemaat', 'GEREJA PANTEKOSTA TABERNAKEL KRISTUS GEMBALA BITUNG', 'BITUNG', 'SULAWESI UTARA ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'RUTH HADASSA PANGALERANG', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3097, '2025-07-05 22:10:20', 'Jultje Jovina Kilanta', '089669011112', 'P', '65 Thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung', 'Kota Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jultje Jovina Kilanta', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3098, '2025-07-07 21:20:52', 'Kalvianus Palimbongan', '082293349773', 'L', '40', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Kalvianus Palimbongan', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3099, '2025-07-07 09:56:36', 'Karissa Saisab', '085342570007', 'P', '13', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Manembo', 'Langowan Minahasa', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tidak ada', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3100, '2025-07-05 21:37:01', 'Katriel Matheos', '089697956859', 'P', '15 tahun', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Mariam Katiandagho', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3101, '2025-07-03 12:13:10', 'Kho cing huang', '085213027770', 'P', '47', 'Imam-imam/Jemaat', 'gktdi kota baru jambi', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Sumardi', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:00'),
(3102, '2025-07-05 04:59:32', 'Lili Batukarang', '085274732416', 'P', '60', 'Imam-imam/Jemaat', 'GPT Kristus gembala bahu ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Edwin ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3103, '2025-07-02 00:48:22', 'Lina Mutu', '081350372888', 'P', '54', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Royi Sumule', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3104, '2025-07-05 21:40:42', 'LYDIA PANGALERANG', '0895803674413', 'P', '25', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA PARIGI DOLONG (BITUNG)', 'BITUNG', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'NIKSON PANGALERANG', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:00'),
(3105, '2025-07-05 21:57:24', 'Mariam Katiandagho', '085399891699', 'P', '54 tahun', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Bahu ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Mariam Katiandagho ', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3106, '2025-07-05 21:48:27', 'MARIANTI PANGALERANG ROMPAH', '081243628969', 'P', '57', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA PARIGI DOLONG (BITUNG)', 'BITUNG', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'NIXON PANGALERANG', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3107, '2025-07-07 23:40:11', 'Meiliana', '0895370596850', 'P', '48 tahun', 'Imam-imam/Jemaat', 'GKTDI', 'Jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tommy Yutaka', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3108, '2025-07-08 08:13:40', 'Natalia duwila', '081273045779', 'P', '36', 'Imam-imam/Jemaat', 'Kristus gembala', 'Biak numfor', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ibu ervina duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3109, '2025-07-05 21:46:16', 'NIXON PANGALERANG', '085343555357', 'L', '55', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA PARIGI DOLONG (PARDO)', 'BITUNG', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'NIXON PANGALERANG', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3110, '2025-07-02 18:41:17', 'NOVERIO GUNAWAN SELANNO', '081333758101', 'L', '43', 'Imam-imam/Jemaat', 'GPT. KRISTUS PENGASIH, AIMAS', 'KAB. SORONG', 'PAPUA BARAT DAYA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'NOVERIO GUNAWAN SELANNO', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3111, '2025-07-07 15:57:15', 'Novita Tandi', '081356021185', 'P', '41', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Felix Bogar', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3112, '2025-07-02 18:52:32', 'OLIVIA FEBY MATUALAGA', '081333758101', 'P', '42', 'Imam-imam/Jemaat', 'GPT. KRISTUS PENGASIH, AIMAS', 'KAB. SORONG', 'PAPUA BARAT DAYA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'NOVERIO GUNAWANA SELANNO', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3113, '2025-07-07 15:00:52', 'Priscilla Zipora Lumare', '082187724008', 'P', '56th', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Priscilla Zipora Lumare', 'MCC RESORT**', 'Deluxe Room Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3114, '2025-07-06 15:25:43', 'Reity Manopo', '085656987468', 'P', '53', 'Imam-imam/Jemaat', 'GKTDI PONOMPIAAN ', 'Bolaang Mongondow ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yunus Sondakh ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3115, '2025-07-05 21:55:04', 'Rina Poting', '082296816853', 'P', '50', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Standfield Sabaru', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3116, '2025-07-05 21:58:59', 'Robert Mesakh Kilanta', '082223371334', 'L', '53 Thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung', 'Kota Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jeth Bendah', 'MCC RESORT**', 'Deluxe Sea View Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3117, '2025-07-05 04:54:24', 'Ronald Edward Matualaga', '085274732416', 'L', '39', 'Imam-imam/Jemaat', 'GPT Kristus gembala bahu ', 'Manado ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Ronald ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3118, '2025-07-02 00:47:06', 'Royi Sumule', '081253922005', 'L', '56', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Royi Sumule', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3119, '2025-07-05 21:38:17', 'RUTH HADASSA PANGALERANG', '082195081058', 'P', '21', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG ', 'BITUNG', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'RUTH HADASSA PANGALERANG', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3120, '2025-07-06 18:11:22', 'Shirley', '08176768937', 'P', '63th', 'Imam-imam/Jemaat', 'GKTDI Kristus Raja', 'Jakarta', 'DKI Jakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jacob Marlon Sahetapy', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Minggu, 7 September 2025', '2025-08-29 15:19:01'),
(3121, '2025-07-05 21:49:01', 'Standfield Turner Sabaru', '082296196876', 'L', '48', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Standfield Sabaru', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3122, '2025-07-07 15:59:28', 'Steave Paulus Bogar', '081356021185', 'L', '12', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Felix Bogar', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3123, '2025-07-03 12:07:35', 'Sumardi', '085213027770', 'L', '50', 'Imam-imam/Jemaat', 'Gktdi kotabaru jambi', 'Jambi', 'jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Sumardi', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3124, '2025-07-07 23:41:48', 'Sutono', '0895370596850', 'L', '49', 'Imam-imam/Jemaat', 'GKTDI', 'Kota jambi', 'Jambi', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tommy Yutaka ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3125, '2025-07-02 00:53:55', 'Theo Christy Panimba', '085342007428', 'P', '35', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Royi Sumule', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3126, '2025-07-08 00:06:39', 'Tirza Febriani', '08569853702', 'P', '34', 'Imam-imam/Jemaat', 'GPT Kristus Raja Salem', 'Depok', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tirza Febriani', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3127, '2025-07-06 16:21:26', 'Tirza Sondakh', '085657110676', 'P', '22thn', 'Imam-imam/Jemaat', 'GKTDI PONOMPIAAN ', 'Bolaang Mongondow ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yunus Sondakh ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3128, '2025-07-05 05:02:27', 'Vernandef Jacobs', '085274732416', 'L', '55', 'Imam-imam/Jemaat', 'GPT haasi ', 'Sitaro ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Vernandef ', 'BEST WESTERN THE LAGOON HOTEL****', 'Suite Room Rp. 1.250.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3129, '2025-07-05 22:00:25', 'Yedida Abigael Sabaru', '082192218047', 'P', '19', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Standfield Sabaru', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3130, '2025-07-07 09:39:25', 'Yolanda Sabaru', '082196444484', 'P', '49', 'Imam-imam/Jemaat', 'GPT. Kristus Gembala Manembo', 'Langowan Minahasa', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Tidak ada', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3131, '2025-07-06 16:05:57', 'Yunus Sondakh', '085656987468', 'L', '63 THN.', 'Imam-imam/Jemaat', 'GKTDI PONOMPIAAN ', 'Bolaang Mongondow ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yunus Sondakh ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3132, '2025-07-05 21:47:14', 'Zipora Kilanta', '082292070776', 'P', '20', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung', 'Kota Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jeth Bendah', 'MCC RESORT**', 'Deluxe Sea View Room Rp. 450.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3133, '2025-07-08 19:53:31', 'Yeni modeong', '082291525005', 'P', '51', 'Imam-imam/Jemaat', 'Gktdi ponompiaan', 'Bolaang mongondow', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Nofri sumigar', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3134, '2025-07-08 19:56:21', 'Nofri Sumigar', '082291525005', 'L', '48', 'Imam-imam/Jemaat', 'Gktdi ponompiaan', 'Bolaang mongondow', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Nofri sumigar', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01');
INSERT INTO `participants` (`id`, `timestamp`, `nama_peserta`, `nomor_whatsapp`, `jenis_kelamin`, `usia`, `jabatan`, `asal_gereja`, `kota_kabupaten`, `provinsi`, `akomodasi_konsumsi`, `kepala_penanggung_jawab_kamar`, `pilihan_hotel`, `pilihan_kamar`, `kedatangan`, `kepulangan`, `created_at`) VALUES
(3135, '2025-07-09 09:23:40', 'Yohanes fransis', '082199495203', 'L', '55', 'Imam-imam/Jemaat', 'Kristus gembala', 'Biak numfor', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3136, '2025-07-09 09:25:32', 'Agustina mual', '082199495203', 'P', '54', 'Imam-imam/Jemaat', 'Krustus gembala', 'Biak numfor', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3137, '2025-07-09 09:29:15', 'Peter kafiar', '081344967383', 'L', '18', 'Imam-imam/Jemaat', 'Kristus gembala', 'Biak numfor', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3138, '2025-07-09 09:31:59', 'Amelia kafiar', '081344967383', 'P', '44', 'Imam-imam/Jemaat', 'Kristus gembala', 'Biak numfor', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3139, '2025-07-09 09:35:27', 'Daud fransis', '082199495203', 'L', '22', 'Imam-imam/Jemaat', 'Kristus gembala', 'Biak numfor', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3140, '2025-07-09 11:56:33', 'Hawrevian Ryan Saputra Wattimury', '082285768543', 'L', '26', 'Imam-imam/Jemaat', 'GKTDI Kristus Raja Kairatu', 'Seram bagian barat', 'Maluku', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Hawrevian Ryan Saputra Wattimury', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3141, '2025-07-09 12:03:04', 'Danny Bunga', '085389072922', 'L', '43', 'Imam-imam/Jemaat', 'GKTDI SAMARINDA', 'Samarinda', 'Kaltim', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Danny bunga', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3142, '2025-07-09 12:35:29', 'Lanny', '085389072922', 'P', '42', 'Imam-imam/Jemaat', 'GKTDI SAMARINDA', 'Samarinda', 'Kaltim', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Danny Bunga', 'BEST WESTERN THE LAGOON HOTEL****', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3143, '2025-07-09 12:37:33', 'Jonathan Andrew Wellem Bunga', '085389072922', 'L', '6', 'Imam-imam/Jemaat', 'GKTDI SAMARINDA', 'Samarinda', 'Kaltim', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Danny bunga', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3144, '2025-07-09 18:29:07', 'Alfrets Pangkey', '085757068589', 'L', '63', 'Imam-imam/Jemaat', 'Gktdi ponompiaan', 'Bolaang mongondow', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Alfrets pangkey', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3145, '2025-07-09 19:37:03', 'Jeni Manopo', '085757068589', 'P', '58', 'Imam-imam/Jemaat', 'Gktdi ponompiaan', 'Bolaang mongondow', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Alfrets Pangkey', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3146, '2025-07-09 21:59:12', 'Ervina Duwila', '081247248132', 'P', '41', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Biak Papua', 'Biak', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina duwila ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3147, '2025-07-09 22:01:29', 'Louisa Euis Rhynaia', '081247248132', 'P', '16', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Biak Papua', 'Biak', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina Duwila', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3148, '2025-07-09 22:03:12', 'Musa Dwi Permana', '081247248132', 'L', '14', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Biak Papua', 'Biak', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina Duwila ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3149, '2025-07-09 22:04:51', 'Daud Tri Abhivandya', '081247248132', 'L', '7', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Biak Papua', 'Biak', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Ervina Duwila ', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:01'),
(3150, '2025-07-11 13:46:57', 'Irna', '085225534445', 'P', '34', 'Imam-imam/Jemaat', 'GKTDI BONTANG', 'Bontang', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Irna', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:01'),
(3151, '2025-07-12 13:40:19', 'Johnny Pollo', '082344730784', 'L', '68', 'Imam-imam/Jemaat', 'GPT Charisma Didiri', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Johnny Pollo', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3152, '2025-07-12 13:41:57', 'Lian Pollo', '082344730784', 'P', '68', 'Imam-imam/Jemaat', 'GPT Charisma Didiri', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Johnny Pollo', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3153, '2025-07-13 07:54:14', 'Eunike Brigita', '082398919647', 'P', '20 tahun', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Makassar', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Eunike Brigita', 'MANADO QUALITY HOTEL****', 'Superior Rp. 525.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3154, '2025-07-13 12:18:44', 'Euodia Sophia', '085255877033', 'P', '31', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Makassar', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Eunike Brigita', 'MANADO QUALITY HOTEL****', 'Superior Rp. 525.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3155, '2025-07-14 14:07:46', 'H.Lumban Raja', '081367770300', 'L', '64', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Jambi (Pdt. Daniel P)', 'Jambi', 'Jambi ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'H.Lumban Raja ', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:02'),
(3156, '2025-07-14 16:40:57', 'Yospin manahampi', '081244228622', 'L', '48th ', 'Imam-imam/Jemaat', 'Gereja Pantekosta tabernakel Kristus gembala Bitung ', 'Kota Bitung ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yospin manahampi ', 'MCC REOSRT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3157, '2025-07-14 16:43:32', 'Okdriana Gaghansa', '081244228622', 'P', '43', 'Imam-imam/Jemaat', 'Gereja Pantekosta tabernakel Kristus gembala Bitung ', 'Kota Bitung ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yospin manahampi ', 'MCC REOSRT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3158, '2025-07-15 10:56:50', 'Eliaser Piter Jama', '082148930891', 'L', '35', 'Imam-imam/Jemaat', 'GKTDI KRISTUS GEMBALA', 'BALIKPAPAN', 'KALTIM', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Eliaser', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3159, '2025-07-15 11:26:51', 'Bonifasius langi', '085256765561', 'L', '48 tahun', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Kota bitung', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bonifasius langi ', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3160, '2025-07-15 11:30:44', 'Lineke stine kuemba', '085341907040', 'P', '47 tahun ', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Kota Bitung', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bonifasius langi ', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3161, '2025-07-15 11:39:08', 'Cicilia Langi', '082196923898', 'P', '17 tahun', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Kota bitung', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bonifasius langi ', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3162, '2025-07-15 11:41:53', 'Dominic Langi', '085341907040', 'L', '12 tahun', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Kota bitung', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bonifasius langi ', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3163, '2025-07-15 22:21:58', 'Meynhard Stevanus Jacob', '081242139178', 'L', '29thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung - Pardo', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Meynhard Stevanus Jacob', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3164, '2025-07-15 22:31:15', 'Alfiani Maria Yohana Kananduang', '082193060352', 'P', '24thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung - Pardo', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Alfiani Maria Yohana Kananduang ', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3165, '2025-07-15 22:54:05', 'Hermina Kilanta', '085394936882', 'P', '62thn', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Morotai', 'Kabupaten. Pulau Morotai', 'Maluku Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Hermina Kilanta', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3166, '2025-07-15 23:00:37', 'Yohanis Kananduang', '081340625293', 'L', '51thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung - Pardo', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yohanis Kananduang', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3167, '2025-07-16 09:00:57', 'Jeffry Yohan Langi', '0895429488881', 'L', '40 (thn)', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Kristus Gembala Parigi Dolong Bitung', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jeffry Yohan Langi', 'MCC RESORT **', 'Deluxe Sea View Room Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3168, '2025-07-16 09:36:34', 'Sarah Marlin Kakomba', '085159255672', 'P', '38 (thn)', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Parigi Dolong Bitung', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Jeffry Yohan Langi', 'MCC RESORT **', 'Deluxe Sea View Room Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3169, '2025-07-16 10:57:38', 'Bpk. Ramon Kakomba', '085159255672', 'L', '68 (thn)', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Parigi Dolong Bitung', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Bpk Ramon Kakomba', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3170, '2025-07-16 11:02:01', 'Pornika Olongsongke', '082249762774', 'P', '63 (thn)', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Kristus Gembala Parigi Dolong Bitung', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pornika Olongsongke', 'MCC RESORT **', 'Deluxe Sea View Room Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3171, '2025-07-16 11:11:25', 'Marie Berkipas', '-', 'P', '69 (thn)', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Parigi Dolong Bitung', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pornika Olongsongke', 'MCC RESORT **', 'Deluxe Sea View Room Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3172, '2025-07-16 11:17:51', 'Masye Rotty', '0895429488881', 'P', '67', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Parigi Dolong Bitung', 'Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Pornika Olongsongke ', 'MCC RESORT **', 'Deluxe Sea View Room Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3173, '2025-07-16 11:28:33', 'Johan Dauhan', '081340199455', 'L', '63 thn', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Bitung', 'Sulut', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Johan Dauhan', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3174, '2025-07-16 11:33:56', 'Masye S Kolibu', '081244698771', 'P', '57 thn', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Kota Bitung', 'Sulut', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Johan Dauhan', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3175, '2025-07-16 11:38:08', 'Valerie Dauhan', '081244698771', 'P', '8thn', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA BITUNG', 'Kota Bitung', 'Sulut', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Johan Dauhan', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3176, '2025-07-16 13:16:39', 'YUDA RUNDAY', '085752491969', 'L', '40', 'Imam-imam/Jemaat', 'GKTDI \"KRISTUS AJAIB\" SAMARINDA', 'SAMARINDA', 'KALIMANTAN TIMUR', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3177, '2025-07-16 13:32:38', 'Benyamin Rombang', '082253096145', 'L', '65', 'Imam-imam/Jemaat', 'GKTDI Kristus Ajaib Samarinda ', 'Samarinda ', 'Kalimantan Timur ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Eunike Runday', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:02'),
(3178, '2025-07-16 13:35:21', 'Debora Ramma', '082351443990', 'P', '57', 'Imam-imam/Jemaat', 'GKTDI Kristus Ajaib Samarinda ', 'Samarinda', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Eunike Runday', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3179, '2025-07-16 13:44:32', 'Zera Tonapa', '085340168680', 'P', '23 thn ', 'Imam-imam/Jemaat', 'GKTDI KRISTUS AJAIB SAMARINDA ', 'SAMARINDA ', 'KALIMANTAN TIMUR ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY ', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3180, '2025-07-16 14:06:20', 'Diber', '085172491012', 'L', '52', 'Imam-imam/Jemaat', 'GKTDI Kristus Ajaib Samarinda', 'Samarinda', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3181, '2025-07-16 14:22:20', 'Yohanis Lumbaa', '081327240844', 'L', '67', 'Imam-imam/Jemaat', 'GKTDI Kristus Ajaib Samarinda', 'Samarinda', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Eunike Runday', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3182, '2025-07-16 19:27:24', 'IRMA NURHAYATI MANAHAMPI', '082244888587', 'P', '38', 'Imam-imam/Jemaat', 'GKTDI KRISTUS AJAIB SAMARINDA ', 'SAMARINDA ', 'KALIMANTAN TIMUR ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3183, '2025-07-16 19:51:59', 'Delfi Lumiu', '082396722739', 'P', '42', 'Imam-imam/Jemaat', 'Gpt bulangan', 'Tondano minahasa', 'Sulut', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Keluarga', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3184, '2025-07-16 20:34:46', 'SARAH MANUELLA WELLEM', '082244888587', 'P', '8 THN', 'Imam-imam/Jemaat', 'GKTDI KRISTUS AJAIB SAMARINDA', 'SAMARINDA ', 'KALIMANTAN TIMUR ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3185, '2025-07-16 21:37:43', 'Ester Batto', '0823-9657-4420', 'P', '48 thn', 'Imam-imam/Jemaat', 'GKTDI SAMARINDA ', 'SAMARINDA', 'KALIMANTAN TIMUR ', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3186, '2025-07-17 09:43:09', 'BPK WELLEM', '081216513752', 'L', '75', 'Imam-imam/Jemaat', 'GKTDI KRISTUS AJAIB SAMARINDA', 'SAMARINDA', 'KALIMANTAN TIMUR', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'EUNIKE RUNDAY', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3187, '2025-07-17 10:00:50', 'Ezri Abram Rompis', '085337527552', 'L', '19 thn', 'Imam-imam/Jemaat', 'Gpt Kristus Gembala Manado', 'Manado', 'Sulawesi Utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Erris Rompis', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3188, '2025-07-17 10:04:20', 'Yenike Tindatu', '081356784336', 'P', '49 Tahun', 'Imam-imam/Jemaat', 'Gpt Kristus Gembala Bahu Manado', 'Manado', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Erris Rompis', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3189, '2025-07-17 10:07:28', 'Erris Rompis', '085256375387', 'L', '50 Tahun', 'Imam-imam/Jemaat', 'Gpt Kristus Gembala Bahu Manado', 'Manado', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Erris Rompis', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3190, '2025-07-17 10:09:45', 'Eloys E. Rompis', '081243110359', 'P', '14 Tahun', 'Imam-imam/Jemaat', 'Gpt Kristus Gembala Bahu Manado', 'Manado', 'Sulawesi utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Erris Rompis', 'MCC RESORT **', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3191, '2025-07-17 12:05:26', 'Christy NT', '085247000144', 'P', '38', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala ', 'Balikpapan', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Christy NT', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3192, '2025-07-19 13:21:54', 'ARIEL MONGILALA', '085242995974', 'L', '18', 'Imam-imam/Jemaat', 'GPT KRISTUS PENOLONG SAOJO', 'POSO', 'SULAWESI TENGAH', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bezaleel sewang (sudah diisikan di rekap HT)', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3193, '2025-07-19 23:32:43', 'Johannes Widhi Nugroho', '081340302386', 'L', '50', 'Imam-imam/Jemaat', 'GPT Gambirlaya', 'Cirebon', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Johannes Widhi Nugroho', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:03'),
(3194, '2025-07-19 23:35:30', 'Lea Bunga', '081355508442', 'P', '48', 'Imam-imam/Jemaat', 'GPT Gambirlaya', 'Cirebon', 'Jawa Barat', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Johannes Widhi Nugroho', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:03'),
(3195, '2025-07-19 23:39:44', 'Cornelius Eka Widhi Putra', '082293351431', 'L', '19', 'Imam-imam/Jemaat', 'GPSDI Kristus Kepala', 'Solo', 'Jawa Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Johannes Widhi Nugroho', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:03'),
(3196, '2025-07-20 21:54:38', 'Kezia Rahmawati', '087835665877', 'P', '23', 'Imam-imam/Jemaat', 'GPSDI', 'Bantul', 'Yogyakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yonatan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3197, '2025-07-20 21:57:40', 'Natalia Nugraheni', '087835665877', 'P', '15', 'Imam-imam/Jemaat', 'GPSDI', 'Bantul', 'Yogyakarta', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Yonatan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3198, '2025-07-21 12:11:32', 'Eliaser', '082148930891', 'L', '35', 'Imam-imam/Jemaat', 'GKTDI', 'Balikpapan', 'Kaltim', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Eliaser', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3199, '2025-07-22 22:08:22', 'Fran L Makahekung', '08124445144', 'L', '64thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung.', 'Bitung.', 'Sulawesi utara (Sulit)', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Fran L Makahekung.', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3200, '2025-07-22 22:16:19', 'Selvia Jacobus.', '089504227589.', 'P', '59 thn', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung.', 'Bitung.', 'Sulawesi Utara (Sulut).', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Fran L Makahekung.', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3201, '2025-07-23 06:22:46', 'Leksi Taghulihi', '081372871579', 'L', '61 Tahun ', 'Imam-imam/Jemaat', 'GPT Krisando-Kapeta ', 'Siau Tagulandang Biaro ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Leksi Taghulihi ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3202, '2025-07-23 06:25:01', 'Horting Lumonang', '081372871579', 'P', '63 Tahun', 'Imam-imam/Jemaat', 'GPT Krisando-Kapeta ', 'Siau Tagulandang Biaro ', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Leksi Taghulihi ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3203, '2025-07-24 12:57:19', 'Resky Paningo', '089678401980', 'L', '45', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Resky Paningo', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3204, '2025-07-24 13:01:02', 'Nolimas Lamunde', '082157680512', 'P', '42', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Resky Paningo', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3205, '2025-07-24 13:04:18', 'Grace Paningo', '082157680512', 'P', '13', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Resky Paningo', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3206, '2025-07-24 13:06:07', 'Eunice Paningo', '082157680512', 'P', '11', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bahu', 'Manado', 'Sulawesi Utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Resky Paningo', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3207, '2025-07-24 13:56:51', 'Rindy Lamunde', '082157680512', 'P', '24', 'Imam-imam/Jemaat', 'Bethany Wanea Plaza', 'Manado', 'Sulawesi Utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Rindy Lamunde', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3208, '2025-07-24 13:58:44', 'Rina Lamunde', '082157680512', 'P', '21', 'Imam-imam/Jemaat', 'Bethany Wanea Plaza', 'Manado', 'Sulawesi Utara', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Rindy Lamunde', 'FORMOSA ART HOTEL***', 'Standard Rp. 440.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3209, '2025-07-24 14:16:52', 'Andre P. R. Lengkong', '08124404456', 'P', '45', 'Imam-imam/Jemaat', 'GPT Kristus Gembala ', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Andre P. R. Lengkong', 'MCC RESORT**', 'Suite Room Rp. 650.000', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3210, '2025-07-24 14:20:24', 'Irene E. M. Mende', '08114344562', 'P', '48', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Andre P. R. Lengkong', 'MCC RESORT**', 'Suite Room Rp. 650.000', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3211, '2025-07-24 14:25:01', 'Peter N. Lengkong', '085342721178', 'L', '18', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Peter N. Lengkong', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3212, '2025-07-24 14:27:02', 'Joanna K. Lengkong', '081242052836', 'P', '16', 'Imam-imam/Jemaat', 'GPT Kristus Gembala', 'Manado', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Peter N. Lengkong', 'MCC RESORT**', 'Superior Room Rp. 400.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:03'),
(3213, '2025-07-24 14:38:44', 'Marlin Saselah', '082151969193', 'P', '24', 'Imam-imam/Jemaat', 'GPT Kristus anak Domba kapeta', 'Siau Tagulandang Biaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Marlin saselah', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3214, '2025-07-24 14:40:06', 'Sehylin Lumonang', '082151969193', 'P', '3', 'Imam-imam/Jemaat', 'GPT Kristus anak Domba kapeta', 'Siau Tagulandang Biaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Marlin saselah', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3215, '2025-07-24 14:40:52', 'Cicilia Lumonang', '082151969193', 'P', '5', 'Imam-imam/Jemaat', 'GPT Kristus anak Domba kapeta', 'Siau Tagulandang Biaro', 'Sulawesi utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Marlin saselah', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3216, '2025-07-24 14:46:29', 'Hienli Marengke', '082216873809', 'P', '31 Thn', 'Imam-imam/Jemaat', 'GKTDI Imanuel Watuawu', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Hienli Marengke', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3217, '2025-07-24 14:49:34', 'Yemima Towera', '082216873809', 'P', '3', 'Imam-imam/Jemaat', 'GKTDI Imanuel Watuawu', 'Poso', 'Sulawesi Tengah', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Hienli Marengke', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3218, '2025-07-26 09:31:21', 'Hengky Wellem', '082135921543', 'L', '37', 'Imam-imam/Jemaat', 'GKTDI \" Kristus Ajaib \" Samarinda', 'Samarinda', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Eunike Runday', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3219, '2025-07-26 09:38:26', 'Satri', '082346148439', 'P', '28 Tahun', 'Imam-imam/Jemaat', 'GKTDI \" Kristus Ajaib \" Samarinda', 'Samarinda', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Eunike Runday', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3220, '2025-07-26 09:44:33', 'Meira Claudya Wellem', '082135921543', 'P', '1 tahun', 'Imam-imam/Jemaat', 'GKTDI \" Kristus Ajaib \" Samarinda', 'Samarinda', 'Kalimantan Timur', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Eunike Runday', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3221, '2025-07-26 16:15:22', 'Valentino Kevin Manopo', '085796537927', 'L', '26', 'Imam-imam/Jemaat', 'GKTDI Ponompiaan', 'BOLAANG MONGONDOW', 'SULAWESI UTARA', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Stenfield Sabaru', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3222, '2025-07-27 13:14:38', 'Tiara Pondaag', '085754308237', 'P', '22 Thn', 'Imam-imam/Jemaat', 'GKTDI PONOMPIAAN', 'BOLAANG MONGONDOW', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Stenfield Sabaru', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3223, '2025-07-27 14:34:02', 'GIBSEN ALEXANDER RULAGHI', '082191122550', 'L', '29', 'Imam-imam/Jemaat', 'GPT KRISTUS RAJA BULANGAN', 'Kepulauan Sitaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'GIBSEN ALEXANDER RULAGHI', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3224, '2025-07-27 14:36:45', 'SUSANA  TATONTONG', '082145783124', 'P', '28', 'Imam-imam/Jemaat', 'GPT KRISTUS RAJA BULANGAN', 'Kepulauan Sitaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'SUSANA TATONTONG', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3225, '2025-07-27 15:26:07', 'Novanti Salontahi', '081244377131', 'P', '35 thn', 'Imam-imam/Jemaat', 'Gereja Pantekosta Tabernakel Kristus Raja Bulangan', 'Kab/kep. Siau Tagulandang Biaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Novanti Salontahi', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3226, '2025-07-27 15:31:26', 'Yosima Lampeang', '085143976927', 'P', '44 thn', 'Imam-imam/Jemaat', 'Gpt Kristus Raja Bulangan', 'Kep. Siau Tagulandang Biaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Yosima Lampeang', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3227, '2025-07-27 15:36:10', 'Niklas Lumiu', '081244377131', 'L', '47', 'Imam-imam/Jemaat', 'Gpt Kristus Raja Bulangan', 'Kep. Siau Tagulandang Biaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Niklas Lumiu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3228, '2025-07-27 16:57:07', 'Hefsibah Salontahi', '085129466378', 'P', '38 tĥn', 'Imam-imam/Jemaat', 'Gpt Kristus Raja Bulangan', 'Kep.Siau Tagulandang Biaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Hefsibah Salontahi', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3229, '2025-07-29 07:48:19', 'Kathlein Lumiu', '085226046697', 'P', '50', 'Imam-imam/Jemaat', 'Gpt. Kristus Raja Bulangan', 'Kep. Siau Tagulandang Biaro', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Kathlein Lumiu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3230, '2025-07-29 12:26:20', 'Okta via launde', '082196495450', 'P', 'TTL 30-10-89', 'Imam-imam/Jemaat', 'Gereja Pantekosta tabernakel (gorontalo)', 'gorontalo-pohuwato', 'gorontalo', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'sendiri', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3231, '2025-07-29 12:31:51', 'Okta via launde', '082196495450', 'P', '35', 'Imam-imam/Jemaat', 'gereja Pantekosta tabernakel (gorontalo)', 'pohuwato-gorontalo', 'gorontalo', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'tangung sendiri', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3232, '2025-07-29 17:15:44', 'DEIFKE LAUNDE', '082347439703', 'P', '29', 'Imam-imam/Jemaat', 'GPT KRISTUS RAJA BULANGAN', 'Kepulauan SITARO', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'DEIFKE LAUNDE', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3233, '2025-07-29 22:06:02', 'Rina Ta\'dung', '085345519980', 'P', '33th', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala - Penajam', 'Penajam Paser Utara', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Christy NT', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3234, '2025-07-31 07:08:27', 'Berce Balau', '082291327193', 'P', '47', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA WONGGARASI', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Berce Balau', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3235, '2025-07-31 10:37:30', 'Bertha Lahope', '082291327193', 'P', '59', 'Imam-imam/Jemaat', 'GPT KRISTUS GEMBALA WONGGARASI', 'Pohuwato', 'Gorontalo', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Bertha Lahope', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3236, '2025-08-01 17:33:54', 'Kefas natanael setiawan', '082233039933', 'L', '23', 'Imam-imam/Jemaat', 'GKTDI EFATA Lampung', 'Bandar lampung', 'Lampung', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Kefas ', 'BEST WESTERN THE LAGOON HOTEL****', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3237, '2025-08-01 21:22:36', 'Sri Injillia Sampelan', '081214841998', 'P', '39', 'Imam-imam/Jemaat', 'GPT Kristus Gembala Bitung - Pardo ', 'Kota Bitung', 'Sulawesi Utara', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Sri Injillia Sampelan', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3238, '2025-08-01 21:26:55', 'Mordekhai ointu', '0882020031252', 'L', '13', 'Imam-imam/Jemaat', 'Gpt Kristus gembala Bitung pardo', 'Bitung', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Mordekhai ointu ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3239, '2025-08-01 21:29:30', 'Maleakhi ointu', '0882022736513', 'L', '9thn', 'Imam-imam/Jemaat', 'Gpt Kristus gembala Bitung pardo ', 'Bitung', 'Sulawesi Utara ', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Maleakhi ointu ', '', '', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3240, '2025-08-01 22:50:11', 'zabdiel minggu', '081242014038', 'L', '22', 'Imam-imam/Jemaat', 'GKTDI Kristus Gembala Makassar', 'Makassar', 'Sulawesi Selatan', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'zabdiel minggu', '', '', 'Senin, 1 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3241, '2025-08-01 23:37:36', 'DEBORA', '082198385022', 'P', '56 th', 'Imam-imam/Jemaat', 'GKTDI BONTANG', 'Bontang / Kaltim', 'Kalimantan Timur', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'IBU IRNA', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Selasa, 2 September 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3242, '2025-08-02 17:02:20', 'Gamaliel EzraTantu', '082199119380', 'L', '22 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3243, '2025-08-02 17:02:21', 'Maria Army Bosawer', '081248047965', 'P', '27 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3244, '2025-08-02 17:02:25', 'Fitri Rahel Bosawer', '085244517658', 'P', '25 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3245, '2025-08-02 17:02:30', 'Priscilla Tidora Bosawer', '082398506267', 'P', '21 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3246, '2025-08-02 17:02:50', 'Hermina Kerenhapukh Bosawer', '081247883433', 'P', '19 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3247, '2025-08-02 17:03:20', 'Riko Tusan', '082299996319', 'L', '30 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3248, '2025-08-02 17:04:20', 'Ezri zsazsa Ivana Christianingtyas', '081248047965', 'P', '21 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3249, '2025-08-02 17:05:20', 'Markus Randy Kuninggir', '081376930055', 'L', '26 tahun', 'Imam-imam/Jemaat', 'GKTDI Imanuel', 'Kota Jayapura ', 'Papua', 'Akomodasi dan Konsumsi Mengurus Sendiri Diluar Panitia', 'Pdt Apseven Tantu', '', '', 'Senin, 1 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3250, '2025-08-09 14:49:13', 'Bpk Suhonggo', '', 'L', '61 tahun', 'Imam-imam/Jemaat', 'GKTDI Jkt Tn Abang', 'Jakarta', '', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Bpk Suhonggo', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3251, '2025-08-09 14:49:15', 'Ibu Niniek Ratnasari', '', 'P', '61 tahun', 'Imam-imam/Jemaat', 'GKTDI Jkt Tn Abang', 'Jakarta', '', 'Akomodasi Membayar Sendiri Melalui Panitia, Konsumsi Urus Sendiri', 'Bpk Suhonggo', '', '', 'Selasa, 2 September 2025', 'Sabtu, 6 September 2025', '2025-08-29 15:19:04'),
(3252, '2025-08-10 23:09:03', 'Anna Renyaan', '085254516764', 'P', '48 tahun', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Anna Renyaan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3253, '2025-08-10 23:09:05', 'Masye Renyaan', '081247469494', 'P', '46 tahun', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Anna Renyaan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3254, '2025-08-10 23:09:06', 'Lisa Renyaan', '085254516764', 'P', '44 tahun', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Anna Renyaan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3255, '2025-08-10 23:09:07', 'Mikael Kafiar', '081247469494', 'L', '9', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Anna Renyaan', 'FORMOSA ART HOTEL***', 'Quad Rp. 748.000,-', 'Minggu, 31 Agustus 2025', 'Jumat,  5 September 2025', '2025-08-29 15:19:04'),
(3256, '2025-08-15 23:21:01', 'Yosua', '082233039933', 'L', '', 'Imam-imam/Jemaat', 'GKTDI Efata Lampung', 'Lampung', 'Lampung', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yosua', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:04'),
(3257, '2025-08-15 23:21:15', 'Kezia', '082233039934', 'P', '', 'Imam-imam/Jemaat', 'GKTDI Efata Lampung', 'Lampung', 'Lampung', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Yosua', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3258, '2025-08-15 23:21:20', 'Stephanus Thie', '081247469494', 'L', '53 tahun', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Stephanus Thie', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Minggu, 31 Agustus 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3259, '2025-08-15 23:21:24', 'Irianti Silalahi', '081247469494', 'P', '43 tahun', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih Aimas', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Stephanus Thie', 'LION HOTEL***', 'Superior Rp. 400.000,-', 'Minggu, 31 Agustus 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3260, '2025-08-15 23:29:05', 'Greta Florida Lumare', '081340086232', 'P', '75 tahun', 'Imam-imam/Jemaat', 'GKTDI Kristus Raja Tn Abang', 'Jakarta', 'DKI Jakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Greta Florida Lumare', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3261, '2025-08-15 23:32:35', 'Jece Selmi Dalope', '081340086232', 'P', '70 tahun', 'Imam-imam/Jemaat', 'GKTDI Kristus Raja Tn Abang', 'Jakarta', 'DKI Jakarta', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Greta Florida Lumare', 'FORMOSA ART HOTEL***', 'Triple Rp. 615.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3262, '2025-08-16 07:13:23', 'Augustinus Bassy', '085229551075', 'L', '65 tahun', 'Imam-imam/Jemaat', 'GPT Katapop Sorong', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Augustinus Bassy', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Selasa, 2 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3263, '2025-08-16 07:16:09', 'Meithy Kondo', '082197820390', 'P', '60 tahun', 'Imam-imam/Jemaat', 'GPT Katapop Sorong', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Augustinus Bassy', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Selasa, 2 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3264, '2025-08-17 22:26:00', 'Akim Tobing', '085266911968', 'L', '', 'Imam-imam/Jemaat', 'GKTDI Kristus Kasih', 'Pekanbaru', 'Riau', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Akim Tobing', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3265, '2025-08-17 22:26:03', 'Faty Maryana', '085266911968', 'P', '', 'Imam-imam/Jemaat', 'GKTDI Kristus Kasih', 'Pekanbaru', 'Riau', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Akim Tobing', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3266, '2025-08-25 23:01:03', 'Martha Assem', '081244921805', 'P', '', 'Imam-imam/Jemaat', 'GPT Kristus Pengasih ', 'Sorong', 'Papua Barat', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Martha Assem', 'LION HOTEL***', 'Deluxe Rp. 450.000,-', 'Selasa, 2 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3267, '2025-08-29 13:14:22', 'Paulus Matualaga', '081241096586', 'L', '', 'Imam-imam/Jemaat', '', '', '', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Paulus Matualaga', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05'),
(3268, '2025-08-29 13:55:00', 'Ibu Yuli', '081241096586', 'P', '', 'Imam-imam/Jemaat', '', '', '', 'Akomodasi dan Konsumsi Membayar Sendiri Melalui Panitia', 'Paulus Matualaga', 'BEST WESTERN', 'Superior Room Rp. 550.000,-', 'Senin, 1 September 2025', 'Jumat, 5 September 2025', '2025-08-29 15:19:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `send_queue`
--

CREATE TABLE `send_queue` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) DEFAULT NULL,
  `nama_peserta` varchar(255) DEFAULT NULL,
  `nomor_whatsapp` varchar(20) DEFAULT NULL,
  `message_text` text DEFAULT NULL,
  `status` enum('pending','sending','success','failed') DEFAULT 'pending',
  `error_message` text DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_participants_duplicate` (`timestamp`,`nama_peserta`);

--
-- Indeks untuk tabel `send_queue`
--
ALTER TABLE `send_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_send_queue_status` (`status`),
  ADD KEY `idx_send_queue_participant` (`participant_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3269;

--
-- AUTO_INCREMENT untuk tabel `send_queue`
--
ALTER TABLE `send_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=621;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `send_queue`
--
ALTER TABLE `send_queue`
  ADD CONSTRAINT `fk_send_queue_participant` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE;
--
-- Database: `peserta_db`
--
CREATE DATABASE IF NOT EXISTS `peserta_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `peserta_db`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peserta`
--

CREATE TABLE `peserta` (
  `id` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `kepala` varchar(255) DEFAULT NULL,
  `hotel` varchar(255) DEFAULT NULL,
  `asal_gereja` varchar(255) DEFAULT NULL,
  `kota` varchar(255) DEFAULT NULL,
  `provinsi` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `peserta`
--

INSERT INTO `peserta` (`id`, `no_urut`, `nama`, `kepala`, `hotel`, `asal_gereja`, `kota`, `provinsi`, `created_at`) VALUES
(3270, 1, 'Pdt. Djery Hanny Kolamban', 'Pdt. Djery Hanny Kolamban', 'skyward', 'Gereja Pantekosta Tabernakel', 'Manado', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3271, 2, 'Yenlly Unggu Pinontoan', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3272, 3, 'Nushel Kuranta', 'Nushel Kuranta', 'skyward', 'GPT Kristus Ajaib Biau', 'Sitaro', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3273, 4, 'Darsini', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3274, 5, 'Pdt. Martolius Minggu', 'Pdt. Martolius Minggu', 'skyward', 'Gpt Kristus Gembala Gorontalo', 'Pohuwato', 'Gorontalo', '2025-09-04 15:47:44'),
(3275, 6, 'Ibu Nita Musa', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3276, 7, 'Selumiel Minggu', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3277, 8, 'Pdt. Edaaprelius Gawe', 'Pdt. Edaaprelius Gawe', 'skyward', 'GPT KRISTUS PENOLONG Bonebae 1', 'Tojo Unauna', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3278, 9, 'Diane Jeklien Tangkowit', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3279, 10, 'Arn Peter Aviezer Gawe', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3280, 11, 'Ibu Lidya Utami', 'Ibu Lidya Utami', 'skyward', 'Gktdi ponompiaan', 'Bolmong', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3281, 12, 'Ibu Lentji Karisoh', 'Ibu Lentji Karisoh', 'skyward', 'GKTDI Ponompiaan', 'Bolaang Mongondow', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3282, 13, 'Pdt. Yomy Kawengian', 'Pdt. Yomy Kawengian', 'skyward', 'GPdI Elgibbor ILOLOY', 'Minahasa selatan', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3283, 14, 'Ibu Geybi Maliangkay', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3284, 15, 'Pdt. Geret Hendrik Lapong', 'Pdt. Geret Hendrik Lapong', 'skyward', 'GPSDI ALFA OMEGA TARATARA', 'Tomohon', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3285, 16, 'Ibu Rosa Datu', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3286, 17, 'Pdt. Nathaniel Hendrik O', 'Pdt. Nathaniel Hendrik O', 'skyward', 'GPT. BUKIT SION MAKASSAR', 'Makassar', 'Sulawesi Selatan', '2025-09-04 15:47:44'),
(3287, 18, 'Ibu Yuna', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3288, 19, 'Pdt. Tri Luky', 'Pdt. Tri Luky', 'skyward', 'GPT LESAH', 'Sitaro', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3289, 20, 'Ibu Beatris Kuranta', 'Ibu Beatris Kuranta', 'skyward', 'GPT KRISTUS AJAIB BIAU', 'Siau Tagulandang Biaro', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3290, 21, 'Ibu Syeni Tatulus', 'Ibu Syeni Tatulus', 'skyward', 'GPdI Kasih Karunia', 'Sigibiromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3291, 22, 'Pdt. Marteyr Taroreh', 'Pdt. Marteyr Taroreh', 'skyward', 'GEREJA PANTEKOSTA TABERNAKEL', 'BOLAANG MONGONDOW', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3292, 23, 'Ibu Masye Wurara', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3293, 24, 'Pdt. Weldie Adolf Karoho, S.Th', 'Pdt. Weldie Adolf Karoho, S.Th', 'skyward', 'GPSDI Alfa Omega Kakenturan', 'Bitung', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3294, 25, 'Ibu Beatrix Hengkeng', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3295, 26, 'Pdt. Paulus Kurantha', 'Pdt. Paulus Kurantha', 'skyward', 'GPT KRISTUS AJAIB', 'Siau Tagulandang Biauro', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3296, 27, 'Ibu Merpati Laleda', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3297, 28, 'Ibu Christine Mosude', 'Ibu Christine Mosude', 'skyward', 'GPT Kristus Penolong Saojo', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3298, 29, 'Ibu Nutrian Eta', 'Ibu Nutrian Eta', 'skyward', 'GPT Kristus Penolong Saojo', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3299, 30, 'Weldumel Tumeleng', 'Weldumel Tumeleng', 'skyward', 'Gpt bukit Sion haasi', 'Sitaro', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3300, 31, 'Serli Katulung', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3301, 32, 'Pdt Murphi P. Palapa', 'Pdt Murphi P. Palapa', 'skyward', 'GPdI Immanuel Tenau Warembungan', 'Minahasa', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3302, 33, 'Deify H. Sondakh', '', 'skyward', '', '', '', '2025-09-04 15:47:44'),
(3303, 34, 'Pdt. Max Langi', 'Pdt. Max Langi', 'bahu bay', 'GPdI gunung potong', 'Sigi biromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3304, 35, 'Ranita Nainggolan', 'Ranita Nainggolan', 'bahu bay', 'GKTDI Imanuel Watuawu', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3305, 36, 'Priskila Suba', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3306, 37, 'Maria Yohana Suba', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3307, 38, 'Freddy Punisingon', 'Freddy Punisingon', 'bahu bay', 'GPSDI ALFA OMEGA TARATARA TOMOHON', 'Kota Tomohon', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3308, 39, 'Ibu Jein Manawan', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3309, 40, 'Pdt. Boy Pomantow', 'Pdt. Boy Pomantow', 'bahu bay', 'GPdI Watutau', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3310, 41, 'Pdt. Hace Mangande', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3311, 42, 'Pdt. Fadly Harimisa', 'Pdt. Fadly Harimisa', 'bahu bay', 'GPT EXODUS KARUNGO BIARO', 'SITARO', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3312, 43, 'Lidyanina Gulo', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3313, 44, 'Pdt. Ferry Hanoch Sangian', 'Pdt. Ferry Hanoch Sangian', 'bahu bay', 'GPdI Victory Kalawat', 'Minahasa Utara', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3314, 45, 'Ibu Deisye Sumolang', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3315, 46, 'Pdt. Simon Haloho', 'Pdt. Simon Haloho', 'bahu bay', 'GPT Krisando- Kapeta', 'Siau Tagulandang Biaro (Sitaro)', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3316, 47, 'Ibu Wiemach Puri Diansari', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3317, 48, 'Pdt. Arnold Nuban', 'Pdt. Arnold Nuban', 'bahu bay', 'Gpdi', 'Luwu', 'Sulawesi Selatan', '2025-09-04 15:47:44'),
(3318, 49, 'Ibu Wiesye Dumanauw', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3319, 50, 'Pdt. Yohanis Pangala', 'Pdt. Yohanis Pangala', 'bahu bay', 'GPT', 'Sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3320, 51, 'Ibu Rusmawati Pasaribu', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3321, 52, 'Pdt. Richard Rantung', 'Pdt. Richard Rantung', 'bahu bay', 'GPdI Imanuel Sejahtera', 'Sigibiromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3322, 53, 'Ibu Hanna Lengkoan', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3323, 54, 'Ibu Werlin Mawemba', 'Ibu Werlin Mawemba', 'bahu bay', 'GPdI KNPI', 'Sigibiromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3324, 55, 'Ibu Evi Repi', 'Ibu Evi Repi', 'bahu bay', 'GPdi Victory Kalawat', 'Minahasa Utara', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3325, 56, 'Ibu Meity Madadi', 'Ibu Meity Madadi', 'bahu bay', 'GSJA Tamaninjil kamarora', 'Kamarora kabupaten Sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3326, 57, 'Ibu Ein Palega', 'Ibu Ein Palega', 'bahu bay', 'gkst hermon dodolo napu', 'poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3327, 58, 'Pdt. Sonny J. Oroh', 'Pdt. Sonny J. Oroh', 'bahu bay', 'GSPDI', 'Langowan Minahasa', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3328, 59, 'Ibu Deby Sumampouw', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3329, 60, 'Pdt. Ngarijan Joshua', 'Pdt. Ngarijan Joshua', 'bahu bay', 'gpdi  zaitun Rahmat kec. Palolo', 'Sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3330, 61, 'Ibu Tinny Sepang', '', 'bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3331, 62, 'Pdt. Yohanes Indra', 'Pdt. Yohanes Indra', 'bahu bay', 'Gereja Pantekosta di Indonesia', 'Ds Bukit jaya Kec Toili jaya Kab Banggai', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3332, 63, 'Pdt. Yos Egeten', 'Pdt. Yos Egeten', 'bahu bay', 'GPdI Elshadai Tentena', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3333, 64, 'Pdt. Fence Liando', 'Pdt. Fence Liando', 'skyward', 'GPdI AGAPE Tiniawangko', 'Minsel', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3334, 65, 'Feybi Rambi', '', 'Skyward', '', '', '', '2025-09-04 15:47:44'),
(3335, 66, 'Pdt. Rio Wauran', 'Pdt. Rio Wauran', 'Bahu bay', 'GPdI Sion Sipulumg', 'Sigibiromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3336, 67, 'Ibu Riami Gea', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3337, 68, 'Pdt. Frits Tuwow', 'Pdt. Frits Tuwow', 'Bahu bay', 'GPdI bkt Kasih Kanonang', 'Minahasa', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3338, 69, 'Ibu Yunita Sekoh', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3339, 70, 'Pdt. Nicky Lumenta', 'Pdt. Nicky Lumenta', 'Bahu bay', 'GPdI Imanuel BAHAGIA', 'Sigi biromaru', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3340, 71, 'Ibu Jeklin Wowiling', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3341, 72, 'Pdt. Yusak Mentang', 'Pdt. Yusak Mentang', 'Bahu bay', 'Gpdi bukit Hermon', 'Bitung', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3342, 73, 'Ibu Stevie Liwe', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3343, 74, 'Ibu Betsy Tadoranggi', 'Ibu Betsy Tadoranggi', 'Bahu bay', 'Gpdi Torsina palu', 'Kota palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3344, 75, 'Ibu Merry Umbunan', 'Ibu Merry Umbunan', 'Bahu bay', 'GPdI Kora', 'Sigibiromaru Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3345, 76, 'Pdt. Fandra Tiwa', 'Pdt. Fandra Tiwa', 'Bahu bay', 'GPdI Ekklesia Kamarora Kec. Nokilalaki', 'Sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3346, 77, 'Yuike Kodong', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3347, 78, 'Pdt. Jones Wokas', 'Pdt. Jones Wokas', 'Bahu bay', 'Gereja Gerakan Pentakosta(GGP)', 'Minahasa Utara', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3348, 79, 'Ibu Lidya Mengko', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3349, 80, 'Pdt. Herry Pangau', 'Pdt. Herry Pangau', 'Bahu bay', 'GPDI ELSADHAI TONGOA', 'Sigi biromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3350, 81, 'Ibu Magdalena Mamahani', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3351, 82, 'Pdt. Wolfrets Gumambo', 'Pdt. Wolfrets Gumambo', 'Bahu bay', 'Gereja Bethany Indonesia', 'Minahasa Utara', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3352, 83, 'Ibu Venny Kending', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3353, 84, 'Pdt. Risci Taib Nasution', 'Pdt. Risci Taib Nasution', 'Bahu bay', 'Gereja Bethany Seretan', 'Minahasa', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3354, 85, 'Ibu Seysi Mawengkang', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3355, 86, 'Pdt. Ariel Ratag', 'Pdt. Ariel Ratag', 'Bahu bay', 'GPdI,Smirna uerani', 'Sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3356, 87, 'Ibu Frelly Walean', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3357, 88, 'Pdt. Thomas Pasomba', 'Pdt. Thomas Pasomba', 'Bahu bay', 'Gereja Pantekosta Tabernakel Wuasa', 'Kabupaten Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3358, 89, 'Ibu Debora Saleppa', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3359, 90, 'Pdt. Matheos Lambiombir', 'Pdt. Matheos Lambiombir', 'Bahu bay', 'GpdI', 'Bogor', 'Jawa Barat', '2025-09-04 15:47:44'),
(3360, 91, 'Pdt. Welly Gerungan', 'Pdt. Welly Gerungan', 'Bahu bay', 'GPDI', 'Kota', 'Jawa Barat', '2025-09-04 15:47:44'),
(3361, 92, 'Pdt. Junus Watulo', 'Pdt. Junus Watulo', 'Bahu bay', 'GPdI Ekklesia Family', 'Sidoarjo', 'Jawa Timur', '2025-09-04 15:47:44'),
(3362, 93, 'Ibu Metruly Lumenta', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3363, 94, 'Pdt. Sionitra Kambuno', 'Pdt. Sionitra Kambuno', 'Bahu bay', 'GPT', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3364, 95, 'Ibu Rismawati Abram', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3365, 96, 'Pdt. Steven Rantung', 'Pdt. Steven Rantung', 'Bahu bay', 'GPdI Olo Baru', 'Parigi Moutong', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3366, 97, 'Pdt. Vera Pasla', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3367, 98, 'Pdt. Denny Poluan', 'Pdt. Denny Poluan', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3368, 99, 'Ibu Yunita Ivone Tungka', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3369, 100, 'Pdt. Marten Luther Bakumawa', 'Pdt. Marten Luther Bakumawa', 'Bahu bay', 'GPdI SMIRNA DIDIRI', 'POSO', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3370, 101, 'Ibu Iray Risa Supit', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3371, 102, 'Pdm. Lazarus Jamatia', 'Pdm. Lazarus Jamatia', 'Bahu bay', 'Gpdi Bheterda', 'Banggai', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3372, 103, 'Ibu Mayke Mayambo', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3373, 104, 'Pdt. Polke Wotulo', 'Pdt. Polke Wotulo', 'Bahu bay', 'gpdi', 'banggai', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3374, 105, 'Ibu Fince Posumah', '', 'Bahu bay', '', '', '', '2025-09-04 15:47:44'),
(3375, 106, 'Pdt. Jackson Hizkia Tangkowit', 'Pdt. Jackson Hizkia Tangkowit', 'bahu bay', 'GPT KRISTUS PENOLONG Bonebae 1', 'Tojo Unauna', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3376, 107, 'Pdt. Frans Maasi', 'Pdt. Frans Maasi', 'bahu bay', 'GPdI', 'Ds Mekarsari.Kec Toili barat.kab Banggai', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3377, 108, 'Ibu Jean Walean', 'Ibu Jean Walean', 'prince', 'GPdI Ranteleda', 'Sigibiromaru, Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3378, 109, 'Ibu Siane Bantara', 'Ibu Siane Bantara', 'prince', 'GPdI', 'Sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3379, 110, 'Pdm Hizkia Imanuel Ongan', 'Pdm Hizkia Imanuel Ongan', 'prince', 'Gpt Kristus kasih', 'Kota palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3380, 111, 'Ibu Sarah Graciola Sampeliling', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3381, 112, 'Pdt Romi Tendean', 'Pdt Romi Tendean', 'prince', 'GPdI ELSHADAI PINEDAPA', 'POSO', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3382, 113, 'Pdt Rachmat Panjaitan', 'Pdt Rachmat Panjaitan', 'prince', 'GBI ROCK PENABUR', 'PEKANBARU', 'Kepulauan Riau', '2025-09-04 15:47:44'),
(3383, 114, 'Pdt. Hein Masambe', 'Pdt. Hein Masambe', 'prince', 'GPdI El-Olam kamarian', 'Kairatu/Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3384, 115, 'Ibu Norce Masambe', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3385, 116, 'Pdt. Abraham Soisa Batmanlusy', 'Pdt. Abraham Soisa Batmanlusy', 'prince', 'GPT Kristus Imam Besar Ambon', 'Ambon', 'Maluku', '2025-09-04 15:47:44'),
(3386, 117, 'Pdt. Hanny Kaawoan', 'Pdt. Hanny Kaawoan', 'prince', 'GPdI', 'Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3387, 118, 'Ibu Fenny Christiane Pongayow', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3388, 119, 'Pdt. Jetro Julis', 'Pdt. Jetro Julis', 'prince', 'GPdI Imanuel Kairatu', 'Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3389, 120, 'Pdt. Jong Tjoen Hau', 'Pdt. Jong Tjoen Hau', 'prince', 'GPMI BOL Filadelfia', 'Jakarta Barat', 'DKI Jakarta', '2025-09-04 15:47:44'),
(3390, 121, 'Ibu Imelda Juliana', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3391, 122, 'Pdt. Djhon D. Menangkoda', 'Pdt. Djhon D. Menangkoda', 'prince', 'GPdI Bethesda Waisamu', 'Kairatu/Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3392, 123, 'Pdt. Yusak Mokolomban', 'Pdt. Yusak Mokolomban', 'prince', 'GPdI Elsaday Lumalatal', 'Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3393, 124, 'Pdm. Jupri Tamudiman', 'Pdm. Jupri Tamudiman', 'prince', 'GKTDI MKCM Tobelo', 'Halmahera utara', 'Maluku utara', '2025-09-04 15:47:44'),
(3394, 125, 'Ibu Dorniu Wulanta', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3395, 126, 'Pdt. George Kursam', 'Pdt. George Kursam', 'prince', 'GPdI Eklesia Hatusua', 'Kairatu/Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3396, 127, 'Pdt. Iskandar Dachi', 'Pdt. Iskandar Dachi', 'prince', 'GBI LFC', 'Batam', 'Kepulauan Riau', '2025-09-04 15:47:44'),
(3397, 128, 'Ibu Lily Simaela', 'Ibu Lily Simaela', 'prince', 'GSJA Victory', 'Kairatu/ Seram  Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3398, 129, 'Ibu Kristin Titin Palapa', 'Ibu Kristin Titin Palapa', 'prince', 'GPdI Parakletos Taman Sidorejo', 'Sidoarjo', 'Jawa Timur', '2025-09-04 15:47:44'),
(3399, 130, 'Pdt. Jhony Stenley Piri', 'Pdt. Jhony Stenley Piri', 'prince', 'GBIS EBEN HESER', 'Muara Enim', 'Sumatera Selatan', '2025-09-04 15:47:44'),
(3400, 131, 'Pdt. Charles Marbun', 'Pdt. Charles Marbun', 'prince', 'Gereja Penyebaran Injil.', 'Kota Medan.', 'Sumatera Utara', '2025-09-04 15:47:44'),
(3401, 132, 'Pdt. Berthon Lombok Siahaan', 'Pdt. Berthon Lombok Siahaan', 'prince', 'GPT', 'Medan', 'Sumatera Utara', '2025-09-04 15:47:44'),
(3402, 133, 'Ibu Maria Ringoo', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3403, 134, 'Pdt. Joshua P. Nababan', 'Pdt. Joshua P. Nababan', 'prince', 'GPPS.Imanuel Jambi', 'kota Jambi', 'Jambi', '2025-09-04 15:47:44'),
(3404, 135, 'Ibu Tiromsi Gultom', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3405, 136, 'Pdt. Andy V. Palar', 'Pdt. Andy V. Palar', 'prince', 'Gereja Pantekosta di indonesia', 'Kab. Semarang', 'Jawa Tengah', '2025-09-04 15:47:44'),
(3406, 137, 'Ibu Indah Sunarti Palar', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3407, 138, 'Pdt. Dolfi Kirayon', 'Pdt. Dolfi Kirayon', 'prince', 'GPdi Poka', 'Ambon', 'Maluku', '2025-09-04 15:47:44'),
(3408, 139, 'Pdt. Akim Banjarnahor', 'Pdt. Akim Banjarnahor', 'prince', 'GPdI Filadelfia', 'Kab. Pati', 'Jawa Tengah', '2025-09-04 15:47:44'),
(3409, 140, 'Pdt. Donny Bantu', 'Pdt. Donny Bantu', 'prince', 'GPdI Miracle Tokelemo', 'Sigibiromaru Palu', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3410, 141, 'Ibu Octavina Seu', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3411, 142, 'Pdt. Joni Parangki', 'Pdt. Joni Parangki', 'prince', 'Gereja Pantekosta Tabernakel', 'Kab sigi', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3412, 143, 'Ibu Lidia Serdi', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3413, 144, 'Pdt. Nixen V. Lumempow', 'Pdt. Nixen V. Lumempow', 'prince', 'GPdI Gloria Kalait', 'Minahasa Tenggara', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3414, 145, 'Ibu Befy Najoan', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3415, 146, 'Pdt. Sardind Henoch Gononggo', 'Pdt. Sardind Henoch Gononggo', 'prince', 'Gereja Pantekosta di Indonesia (GPdI)', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3416, 147, 'Ibu Yulin Sepatondu', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3417, 148, 'Kezia Ivana Gononggo', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3418, 149, 'Bella Rondo', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3419, 150, 'Johana Febe Titahena', 'Johana Febe Titahena', 'prince', 'GPT Kristus Ajaib Wainitu', 'Ambon', 'Maluku', '2025-09-04 15:47:44'),
(3420, 151, 'Melly Polnaya', 'Melly Polnaya', 'prince', 'GPT Kristus Ajaib Wainitu', 'Ambon', 'Maluku', '2025-09-04 15:47:44'),
(3421, 152, 'Pdt. Donald Mustamu', 'Pdt. Donald Mustamu', 'prince', 'GKTDI Kristus Gembala Biak', 'Biak', 'Papua', '2025-09-04 15:47:44'),
(3422, 153, 'Ibu Sherly Tandidatu', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3423, 154, 'Pdt. Donny F. Wakari', 'Pdt. Donny F. Wakari', 'prince', 'GSPDI Filadelfia', 'Amurang', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3424, 155, 'Ibu Meity Pangaila', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3425, 156, 'Pdt. Ayub Yewun', 'Pdt. Ayub Yewun', 'prince', 'GPT KRISTUS PENOLONG', 'SORONG SELATAN', 'Papua Barat Daya', '2025-09-04 15:47:44'),
(3426, 157, 'Ibu Violet Engel Utama', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3427, 158, 'Pdt. Yahya Moloku', 'Pdt. Yahya Moloku', 'prince', 'GBAI.JEMAAT LOGOS MERAUKE', 'Merauke', 'Papua Selatan', '2025-09-04 15:47:44'),
(3428, 159, 'Ibu Yenny Moloku', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3429, 160, 'Pdt. Ifaludwich Stefanus E. Pattihahuan', 'Pdt. Ifaludwich Stefanus E. Pattihahuan', 'prince', 'GPdI Kolongan Tetempangan', 'Minahasa Utara', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3430, 161, 'Ibu Jeniffer J. C. Tairas', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3431, 162, 'Pdt. Geradus Wayoi', 'Pdt. Geradus Wayoi', 'prince', 'GBI', 'Sorong', 'Papua Barat Daya', '2025-09-04 15:47:44'),
(3432, 163, 'Pdt. Rudy Adolf Lumantauw', 'Pdt. Rudy Adolf Lumantauw', 'prince', 'Gereja Pantekosta di Indonesia', 'Tangerang Selatan', 'Banten', '2025-09-04 15:47:44'),
(3433, 164, 'Pdt. Ibrahim Tato', 'Pdt. Ibrahim Tato', 'prince', 'GPT BUKIT SION MAKASSAR', 'KOTA MAKASSAR', 'Sulawesi Selatan', '2025-09-04 15:47:44'),
(3434, 165, 'Pdt. Filemon Fonataba', 'Pdt. Filemon Fonataba', 'prince', 'GBI Maeanata', 'Kota Bekasi', 'Jawa Barat', '2025-09-04 15:47:44'),
(3435, 166, 'Pdt. Sonya K. Fonataba', 'Pdt. Sonya K. Fonataba', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3436, 167, 'Pdt. Stenly Lepar', 'Pdt. Stenly Lepar', 'prince', 'GPdI Eben Heazer Sentani', 'Jayapura', 'Papua', '2025-09-04 15:47:44'),
(3437, 168, 'Pdt. Yosua Suwidi', 'Pdt. Yosua Suwidi', 'prince', 'GPT Kristus Mulia', 'Jogja', 'DIY', '2025-09-04 15:47:44'),
(3438, 169, 'Ibu Wiwaha Parikesit', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3439, 170, 'Pdt. Tulus Sibarani', 'Pdt. Tulus Sibarani', 'prince', 'Gereja Pantekosta Tabernakel', 'Jambi', 'Jambi', '2025-09-04 15:47:44'),
(3440, 171, 'Pdt. Elim Daniel Sambe', 'Pdt. Elim Daniel Sambe', 'prince', 'Gpt Kristus Raja Makassar', 'Makassar', 'Sulawesi Selatan', '2025-09-04 15:47:44'),
(3441, 172, 'Pdt. Brayen Djamen', 'Pdt. Brayen Djamen', 'prince', 'GPdI bukit Hermon', 'Bitung', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3442, 173, 'Ibu Elisabeth Emilia Mentang', '', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3443, 174, 'Ibu Netty Tobing Mustamu', 'Ibu Netty Tobing Mustamu', 'prince', 'GKTDI Kristus Gembala Biak Papua', 'Biak', 'Papua', '2025-09-04 15:47:44'),
(3444, 175, 'Ibu Yuliana Agustina Hengkeng', 'Ibu Yuliana Agustina Hengkeng', 'prince', 'GPT Kristus Ajaib', 'Manokwari', 'Papua Barat', '2025-09-04 15:47:44'),
(3445, 176, 'Ibu Merry Kawengian', 'Ibu Merry Kawengian', 'prince', '', '', '', '2025-09-04 15:47:44'),
(3446, 177, 'Ibu Yohana Tanifan', 'Ibu Yohana Tanifan', 'prince', 'Gereja Suara Ketebusan Sorong', 'Sorong', 'Papua Barat', '2025-09-04 15:47:44'),
(3447, 178, 'Ibu Meltina Terry', 'Ibu Meltina Terry', 'prince', 'Gereja Suara Ketebusan Sorong', 'Sorong', 'Papua Barat', '2025-09-04 15:47:44'),
(3448, 179, 'Pdt. Hendra Butar-butar', 'Pdt. Hendra Butar-butar', 'formosa', 'GKTDI Kristus Gembala Morotai', 'Pulau Morotai', 'Maluku Utara', '2025-09-04 15:47:44'),
(3449, 180, 'Ibu Ribka Feybe Bawuna', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3450, 181, 'Paulus Butar-butar', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3451, 182, 'Ibu Elim Evianti Bawuna', 'Elim Evianti Bawuna', 'formosa', 'GKTDI KRISTUS GEMBALA', 'BALIKPAPAN', 'Kalimantan Timur', '2025-09-04 15:47:44'),
(3452, 183, 'Pdt. Abdiel S. Firmanto', 'Pdt. Abdiel S. Firmanto', 'formosa', 'GKTDI ponompiaan', 'Bolaang Mongondow', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3453, 184, 'Ibu Yuliske Lidia Kawulur', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3454, 185, 'Pdt Jahja Purwanto Sutan', 'Pdt Jahja Purwanto Sutan', 'formosa', 'GPT Kristus Roti Hidup labuan uki', 'Bolmong induk', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3455, 186, 'Ibu Meniat Lase', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3456, 187, 'Elisa Daniel Sutan', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3457, 188, 'Pdt. Steven Macpal', 'Pdt. Steven Macpal', 'formosa', 'GPT Charisma Didiri', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:44'),
(3458, 189, 'Ibu Debora Macpal', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3459, 190, 'Pdt. Rudy Marbun', 'Pdt. Rudy Marbun', 'formosa', 'GPT FILADELFIA GENTUMA', 'Gorontalo Utara', 'Gorontalo', '2025-09-04 15:47:44'),
(3460, 191, 'Ibu Ruth Sriutami', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3461, 192, 'Pdt. Samuel Tanifan', 'Pdt. Samuel Tanifan', 'formosa', 'GKTDI Kristus Raja', 'Kairatu/Seram Bagian Barat', 'Maluku', '2025-09-04 15:47:44'),
(3462, 193, 'Ibu Nova Tanifan', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3463, 194, 'Pdt. Martoni Waruwu', 'Pdt. Martoni Waruwu', 'formosa', 'GKTDI JEMAAT SHALOM MEDAN', 'Medan', 'Sumatera Utara', '2025-09-04 15:47:44'),
(3464, 195, 'Ibu Rina Sidabutar', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3465, 196, 'Pdt. Markus S. Gianau', 'Pdt. Markus S. Gianau', 'formosa', 'GPT Kristus Gembala Sentani Papua', 'Kabupaten Jayapura', 'Papua', '2025-09-04 15:47:44'),
(3466, 197, 'MC Yoseph Gianau', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3467, 198, 'Filadelfia T. Gianau', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3468, 199, 'Pdt. Jimmy Talumewo', 'Pdt. Jimmy Talumewo', 'formosa', 'GEREJA PANTEKOSTA TABERNAKEL', 'SITARO', 'Sulawesi Utara', '2025-09-04 15:47:44'),
(3469, 200, 'Ibu Rinny Julike Wowiling', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3470, 201, 'Pdt. Yehuda Kambuno', 'Pdt. Yehuda Kambuno', 'formosa', 'GPT', 'Makassar', 'Sulawesi Selatan', '2025-09-04 15:47:44'),
(3471, 202, 'Ibu Stevani Waha Palar', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3472, 203, 'Pdt. Johanis Revidesso', 'Pdt. Johanis Revidesso', 'formosa', 'Gereja Bethel Papua Barat di Tanah Papua Jemaat Petra', 'Kota Sorong', 'Papua Barat', '2025-09-04 15:47:44'),
(3473, 204, 'Ibu Hendrika', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3474, 205, 'Bonar Nathan Manurung', 'Bonar Nathan Manurung', 'formosa', 'GBIS ALPHA OMEGA', 'Palembang', 'Sumatera Selatan', '2025-09-04 15:47:44'),
(3475, 206, 'Kaleb Situmeang', '', 'formosa', '', '', '', '2025-09-04 15:47:44'),
(3476, 207, 'Zuhdi Fretto Siburian', 'Zuhdi Fretto Siburian', 'formosa', 'Gereja Pentakosta Kotabaru Jambi', 'Jambi', 'Jambi', '2025-09-04 15:47:45'),
(3477, 208, 'Elisabeth Waney', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3478, 209, 'Haniel Imanuel Ongan', 'Haniel Imanuel Ongan', 'formosa', 'GPT Kristus Penolong Saojo Maliwuko', 'Poso', 'Sulawesi Tengah', '2025-09-04 15:47:45'),
(3479, 210, 'Neysa Glenda Preciosa', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3480, 211, 'Shawn Eliot Ongan', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3481, 212, 'Corina Cencetta Ongan', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3482, 213, 'Nova Andriana Sewang', 'Nova Andriana Sewang', 'formosa', 'GPT KRISTUS PENOLONG SAOJO', 'POSO', 'Sulawesi Tengah', '2025-09-04 15:47:45'),
(3483, 214, 'Yosifia Talita Sewang', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3484, 215, 'Beryl Lantonio Sewang', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3485, 216, 'Yula Lustianto', 'Yula Lustianto', 'formosa', 'GPSDI Jangkungan', 'Salatiga', 'Jawa Tengah', '2025-09-04 15:47:45'),
(3486, 217, 'Sarah Yayuk Ariyani', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3487, 218, 'Nehemia Arla Yedija', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3488, 219, 'Euodia Arla Gracia', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3489, 220, 'Alfian Paningo', 'Alfian Paningo', 'formosa', 'GKTDI', 'BONTANG', 'Kalimantan Timur', '2025-09-04 15:47:45'),
(3490, 221, 'Alfrida Yacob', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3491, 222, 'Yusuf Nic Panjaitan', 'Yusuf Nic Panjaitan', 'formosa', 'GPSI', 'Jakarta Utara', 'DKI', '2025-09-04 15:47:45'),
(3492, 223, 'Rosmawati Siahaan', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3493, 224, 'Andareas Pasampang Sura', 'Andareas Pasampang Sura', 'formosa', 'GKTDI KRISTUS AJAIB', 'SAMARINDA', 'Kalimantan Timur', '2025-09-04 15:47:45'),
(3494, 225, 'Eunike Runday', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3495, 226, 'Yonatan', 'Yonatan', 'formosa', 'GPSDI', 'Bantul', 'DIY', '2025-09-04 15:47:45'),
(3496, 227, 'Ester Lustiari', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3497, 228, 'Kezia Rahmawati', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3498, 229, 'Natalia Nugraheni', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3499, 230, 'Pdt. Harun Eka Syama Kurniawan', 'Pdt. Harun Eka Syama Kurniawan', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3500, 231, 'Ibu Fonny Santy Kurniawan', '', 'formosa', '', '', '', '2025-09-04 15:47:45'),
(3501, 232, 'Pdt. Yosua Victoria', 'Pdt. Yosua Victoria', 'Best Western', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', '2025-09-04 15:47:45'),
(3502, 233, 'Ibu Sely Widiastanti', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3503, 234, 'Abraham Yose R.', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3504, 235, 'Pdt. Paulus Suparno Raharjo', 'Pdt. Paulus Suparno Raharjo', 'Best Western', 'GPSDI Mukiran', 'Kab.Semarang', 'Jawa Tengah', '2025-09-04 15:47:45'),
(3505, 236, 'Marta Titik Srisukamti', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3506, 237, 'Pdt. David Richard Tutu', 'Pdt. David Richard Tutu', 'Best Western', 'GPT Kristua Gembala', 'Manado', 'Sulawesi Utara', '2025-09-04 15:47:45'),
(3507, 238, 'Shivra Kezia Tutu', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3508, 239, 'Pdt. Tumim Panjaitan', 'Pdt. Tumim Panjaitan', 'Best Western', 'GKTDI Kristus Kasih', 'Pekanbaru', 'Riau', '2025-09-04 15:47:45'),
(3509, 240, 'Wastina Br Simanjuntak', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3510, 241, 'Pdt. Hendry Sutanto', 'Pdt. Hendry Sutanto', 'Best Western', 'GKTDI EFATA', 'Bandar Lampung', 'Lampung', '2025-09-04 15:47:45'),
(3511, 242, 'Eva Susianita Obed', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3512, 243, 'Zefanya Joseph Elnatan', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3513, 244, 'Pdt. Arinson Purba', 'Pdt. Arinson Purba', 'Best Western', 'GKTDI Kristus Penolong', 'Samarinda', 'Kalimantan Timur', '2025-09-04 15:47:45'),
(3514, 245, 'Lestariana Saragih', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3515, 246, 'Bpk. Anton Kornelius', 'Bpk. Anton Kornelius', 'Best Western', 'GKTDI Kristus Pengharapan - Kotaagung', 'Tanggamus', 'Lampung', '2025-09-04 15:47:45'),
(3516, 247, 'Ibu Yuniar Pandensolang', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3517, 248, 'Pdt. Poltak Pasaribu', 'Pdt. Poltak Pasaribu', 'Best Western', 'Gktdi Kristus Penolong Cileungsi', 'Bogor', 'Jawa Barat', '2025-09-04 15:47:45'),
(3518, 249, 'Ibu Tabita Tinambunan', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3519, 250, 'Pdt. Apseven Tantu', 'Pdt. Apseven Tantu', 'Best Western', 'GKTDI Imanuel', 'Kota Jayapura', 'Papua', '2025-09-04 15:47:45'),
(3520, 251, 'Ibu Naniek Susanti', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3521, 252, 'Pdt. Jonas Patar', 'Pdt. Jonas Patar', 'Best Western', 'GKTDI KRISTUS PENGASIH', 'Batanghari', 'JAMBI', '2025-09-04 15:47:45'),
(3522, 253, 'Ibu Debora Manalu', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3523, 254, 'Pdt. Hendy Sihombing', 'Pdt. Hendy Sihombing', 'Best Western', 'Gpt gunung hermon', 'Batam', 'Kepulauan Riau', '2025-09-04 15:47:45'),
(3524, 255, 'Ibu Priscilla Syenny Meriyana', '', 'Best Western', '', '', '', '2025-09-04 15:47:45'),
(3525, 256, 'Pdt. Emanuel Kardiman', 'Pdt. Emanuel Kardiman', 'Best Western', 'GKTDI Kristus Alfa & Omega', 'Bekasi, Bekasi Timur', 'Jawa Barat', '2025-09-04 15:47:45'),
(3526, 257, 'Pdt. Daniel Hendrawan', 'Pdt. Daniel Hendrawan', 'Best Western', 'GKTDI EBEN HAEZER YOGYAKARTA', 'Bantul', 'DIY', '2025-09-04 15:47:45');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `peserta`
--
ALTER TABLE `peserta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_nama` (`nama`),
  ADD KEY `idx_kota` (`kota`),
  ADD KEY `idx_provinsi` (`provinsi`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `peserta`
--
ALTER TABLE `peserta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3527;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data untuk tabel `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"kppm_sendmsg\",\"table\":\"participants\"},{\"db\":\"cfs_db\",\"table\":\"users\"}]');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data untuk tabel `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-11-05 03:16:18', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"id\"}');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indeks untuk tabel `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indeks untuk tabel `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indeks untuk tabel `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indeks untuk tabel `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indeks untuk tabel `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indeks untuk tabel `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indeks untuk tabel `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indeks untuk tabel `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indeks untuk tabel `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indeks untuk tabel `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
