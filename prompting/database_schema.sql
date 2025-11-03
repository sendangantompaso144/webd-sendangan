CREATE TABLE data (
    data_key VARCHAR(255) PRIMARY KEY,
    data_value TEXT NOT NULL,
    data_type enum('string', 'integer', 'float', 'boolean', 'date') NOT NULL default 'string',
    data_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    data_updated_by VARCHAR(100)
); -- Karena data administrasi desa kompleks maka konsep tabel ini hanya untuk menyimpan data dan valuenya saja.

CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_nama VARCHAR(100) NOT NULL,
    admin_password VARCHAR(255) NOT NULL,
    admin_no_hp VARCHAR(15) unique,
    admin_email VARCHAR(100) unique,
    admin_is_superadmin smallint DEFAULT 0,
    admin_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    admin_is_deleted smallint DEFAULT 0
);

CREATE TABLE berita (
    berita_id INT AUTO_INCREMENT PRIMARY KEY,
    berita_judul VARCHAR(255) NOT NULL,
    berita_isi TEXT NOT NULL,
    berita_gambar VARCHAR(255),
    berita_dilihat INT DEFAULT 0,
    berita_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    berita_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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

CREATE TABLE pengumuman (
    pengumuman_id INT AUTO_INCREMENT PRIMARY KEY,
    pengumuman_isi TEXT NOT NULL,
    pengumuman_valid_hingga TIMESTAMP NOT NULL,
    pengumuman_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pengumuman_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table potensi_desa (
    potensi_id INT AUTO_INCREMENT PRIMARY KEY,
    potensi_judul VARCHAR(255) NOT NULL,
    potensi_isi TEXT NOT NULL,
    potensi_kategori enum('Wisata', 'Budaya', 'Kuliner', 'UMKM') NOT NULL,
    potensi_gmaps_link VARCHAR(255),
    potensi_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    potensi_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table gambar_potensi_desa (
    gambar_id INT AUTO_INCREMENT PRIMARY KEY,
    potensi_id INT,
    gambar_namafile VARCHAR(255) NOT NULL,
    gambar_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (potensi_id) REFERENCES potensi_desa(potensi_id) 
);

create table fasilitas (
    fasilitas_id INT AUTO_INCREMENT PRIMARY KEY,
    fasilitas_nama VARCHAR(255) NOT NULL,
    fasilitas_gambar VARCHAR(255),
    fasilitas_gmaps_link VARCHAR(255),
    fasilitas_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fasilitas_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table program_desa (
    program_id INT AUTO_INCREMENT PRIMARY KEY,
    program_nama VARCHAR(255) NOT NULL,
    program_deskripsi TEXT NOT NULL,
    program_gambar VARCHAR(255),
    program_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    program_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table struktur_organisasi (
    struktur_id INT AUTO_INCREMENT PRIMARY KEY,
    struktur_nama VARCHAR(255) NOT NULL,
    struktur_jabatan VARCHAR(100) NOT NULL,
    struktur_foto VARCHAR(255),
    struktur_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    struktur_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table galeri (
    galeri_id int AUTO_INCREMENT PRIMARY KEY,
    galeri_namafile VARCHAR(255) NOT NULL,
    galeri_keterangan TEXT,
    galeri_gambar VARCHAR(50),
    galeri_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table apbdes (
    apbdes_id INT AUTO_INCREMENT PRIMARY KEY,
    apbdes_judul VARCHAR(255) NOT NULL,
    apbdes_file VARCHAR(255) NOT NULL,
    apbdes_edited_by VARCHAR(100),
    apbdes_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    apbdes_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); -- Atribut dari APBDes masih belum jelas sehingga konsep dari halaman ini adalah menyajikan gambar/file pdf dari APBDes itu sendiri.

