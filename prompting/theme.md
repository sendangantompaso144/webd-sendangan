# 1. Konsep Desain Utama (UI/UX)
Tema: Minimalis Modern Humanistik
*Karakter visual utama:*
- Tata letak bersih, penuh ruang putih (white space) agar konten foto dan teks lebih bernapas.
- Warna lembut (pastel) yang menenangkan dan mudah dibaca, bukan kontras mencolok.
- Tipografi bersahabat, modern tetapi tetap hangat.
- Elemen lembut, misalnya sudut membulat (rounded corner) dan bayangan lembut (soft shadow).
- Animasi ringan saat scroll, seperti fade-in atau slide-up di tiap section.
# 2. warna Pastel Calm (Langit & Damai):
### Elemen
Primary: #90CAF9 (Biru Pastel) - Warna langit, tenang dan bersih
Secondary: #E3F2FD (Biru muda sangat lembut) - Background section.
Accent: #FFE082 (Kuning lembut) - Warna cerah untuk tombol.
Text: #263238 - Abu gelap yang tidak kontras.
Neutral: #F9FAFB - Latar belakang netral.
> Tema ini memberi kesan optimistis dan damai, cocok untuk desa dengan suasana tenang dan religius.
# 3. Tipografi
Gunakan dua keluarga font saja agar tetap harmonis:
Judul & Header: Poppins, Nunito, atau DM Sans
→ kesan modern, geometris, dan ramah.
Isi paragraf: Inter, Lato, atau Noto Sans
→ mudah dibaca di layar kecil maupun besar.
# 4. Gaya Layout dan Navigasi
*Struktur halaman utama (scrolling):*
- Gunakan layout vertikal blok penuh (100vh per section) untuk setiap segmen besar seperti “Tentang Desa”, “Data Singkat”, “Cerita Warga”.
- Transisi lembut antar section (scroll smooth).
- Tombol navigasi di pojok kanan atas (sticky navbar) dengan gaya underline-on-hover.
*Komponen Visual:*
- Card grid untuk galeri, program, dan data.
- Soft shadow (box-shadow: 0 2px 8px rgba(0,0,0,0.08))
- Rounded corner besar (border-radius: 1rem untuk foto dan card).
- Hover state lembut: ubah warna latar sedikit lebih terang, bukan efek neon.
- Untuk di satu halaman terdapat mini “table of contents” (scrollspy) yang sticky di atas halaman, berisi chip pendek untuk tiap section. Klik chip akan smooth scroll, dan chip aktif berubah saat pengguna scroll.
# 5. Detail UX yang Membuatnya “Hangat dan Hidup”
- Foto warga sebagai hero atau background blur pada beberapa section untuk menghadirkan sentuhan manusiawi.
- Transisi halus saat scroll (fade-up, slide-in) agar terasa modern tetapi tidak berlebihan.
- Warna tombol (CTA) gunakan nuansa lembut (contoh: hijau pastel → lebih muda saat hover).
- Gunakan icon ringan dari Lucide atau Feather agar selaras dengan gaya minimalis.
- untuk beberapa ilustrasi, gunakan alternatif dengan ilustrasi sederhana (misal vector sawah, rumah, peta) daripada foto penuh agar tetap ringan di GitHub Pages.
# 6. Moodboard Visual yang bisa anda ikuti:
> Bayangkan kombinasi seperti berikut:
- Background putih lembut atau krem muda.
- Elemen hijau atau biru pastel untuk header.
- Foto alami tanpa filter mencolok.
- Tipografi modern tanpa serif.
- Elemen berbentuk bulat dan lembut (tidak kaku).
- Ilustrasi kecil (bunga, daun, rumah) sebagai aksen dekoratif ringan.
# 7. Responsif dan Aksesibilitas
Karena website ini statis dan akan diakses dari HP warga:
- Gunakan ukuran font minimum 16px.
- Pastikan semua warna memiliki kontras cukup tinggi (uji dengan contrast checker).
- Tombol CTA besar, mudah disentuh.
- Gunakan lazy loading untuk foto-foto besar.