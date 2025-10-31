CREATE TABLE data (
    data_key VARCHAR(255) PRIMARY KEY,
    data_value TEXT NOT NULL,
    data_type VARCHAR(100),
    data_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    data_updated_by VARCHAR(100)
); -- Karena data administrasi desa kompleks maka konsep tabel ini hanya untuk menyimpan data dan valuenya saja.

CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_nama VARCHAR(100) NOT NULL,
    admin_password VARCHAR(255) NOT NULL,
    admin_no_hp VARCHAR(15) unique,
    admin_email VARCHAR(100) unique,
    admin_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    admin_is_deleted smallint DEFAULT 0
);

CREATE TABLE berita (
    berita_id INT AUTO_INCREMENT PRIMARY KEY,
    berita_judul VARCHAR(255) NOT NULL,
    berita_isi TEXT NOT NULL,
    berita_gambar VARCHAR(255),
    berita_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    berita_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    berita_dilihat INT DEFAULT 0
);

create table permohonan_informasi (
    pi_id INT AUTO_INCREMENT PRIMARY KEY,
    pi_isi_permintaan TEXT NOT NULL,
    pi_email VARCHAR(100),
    pi_asal_instansi VARCHAR(255),
    pi_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pi_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    pi_selesai smallint DEFAULT 0
);

create table ppid_dokumen (
    ppid_id INT AUTO_INCREMENT PRIMARY KEY,
    ppid_judul VARCHAR(255) NOT NULL,
    ppid_namafile VARCHAR(255) NOT NULL,
    ppid_kategori VARCHAR(100),
    ppid_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ppid_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ppid_pi_id INT,
    FOREIGN KEY (ppid_pi_id) REFERENCES permohonan_informasi(pi_id)
);