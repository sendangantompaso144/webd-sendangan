<?php

declare(strict_types=1);

require __DIR__ . '/layouts/BaseLayout.php';

$contactDefaults = [
    'kontak.telepon_desa' => '',
    'kontak.email_desa' => '',
];

$contactData = data_values($contactDefaults);
$teleponDesa = trim((string) ($contactData['kontak.telepon_desa'] ?? ''));
$emailDesa = trim((string) ($contactData['kontak.email_desa'] ?? ''));

$sanitizedNumber = preg_replace('/\D+/', '', $teleponDesa ?? '');
if (is_string($sanitizedNumber) && $sanitizedNumber !== '') {
    if (str_starts_with($sanitizedNumber, '0')) {
        $sanitizedNumber = '62' . substr($sanitizedNumber, 1);
    }
}

$whatsAppNumber = is_string($sanitizedNumber) ? $sanitizedNumber : '';
$hasWhatsAppNumber = $whatsAppNumber !== '';

render_base_layout([
    'title' => 'Kontak | ' . app_config('name', 'Desa Sendangan'),
    'description' => 'Ajukan pertanyaan atau permohonan layanan desa melalui WhatsApp resmi Pemerintah Desa Sendangan.',
    'activePage' => 'kontak',
    'bodyClass' => 'page-kontak contact-page',
    'content' => static function () use (
        $teleponDesa,
        $emailDesa,
        $whatsAppNumber,
        $hasWhatsAppNumber
    ): void {
        ?>
        <section class="page-hero contact-hero">
            <div class="container">
                <p class="eyebrow">Hubungi Kami</p>
                <h1>Kontak Desa Sendangan</h1>
                <p class="lead">
                    Sampaikan aspirasi, pertanyaan, atau kebutuhan administrasi Anda secara langsung kepada perangkat desa.
                    Gunakan formulir berikut untuk diarahkan ke WhatsApp resmi kami.
                </p>
            </div>
        </section>

        <section class="contact-information">
            <div class="container">
                <div class="info-grid">
                    <?php if ($teleponDesa !== ''): ?>
                        <div class="info-card">
                            <h3>WhatsApp Desa</h3>
                            <p class="info-value"><?= e($teleponDesa) ?></p>
                            <p>Gunakan nomor ini untuk layanan administrasi, pertanyaan, serta pelaporan warga.</p>
                        </div>
                    <?php endif; ?>
                    <?php if ($emailDesa !== ''): ?>
                        <div class="info-card">
                            <h3>Email Resmi</h3>
                            <p class="info-value"><?= e($emailDesa) ?></p>
                            <p>Kirimkan dokumen atau surat resmi melalui email apabila membutuhkan arsip tertulis.</p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </section>

        <section class="contact-form-section">
            <div class="container contact-card">
                <div class="contact-form-intro">
                    <h2>Formulir WhatsApp</h2>
                    <p>
                        Lengkapi data di bawah ini, kemudian klik <strong>Kirim Lewat WhatsApp</strong>.
                        Anda akan diarahkan ke aplikasi WhatsApp dengan pesan yang sudah tersusun otomatis.
                    </p>
                </div>
                <div class="contact-form-wrapper">
                    <?php if ($hasWhatsAppNumber): ?>
                        <form id="contact-whatsapp-form" class="contact-form" data-wa-number="<?= e($whatsAppNumber) ?>">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="contact-name">Nama Lengkap</label>
                                    <input type="text" id="contact-name" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label for="contact-origin">Domisili / Jaga</label>
                                    <input type="text" id="contact-origin" name="origin" placeholder="Mis. Jaga I Sendangan">
                                </div>
                                <div class="form-group">
                                    <label for="contact-phone">Nomor Telepon</label>
                                    <input type="tel" id="contact-phone" name="phone" placeholder="Mis. 0812xxxxxxx">
                                </div>
                                <div class="form-group">
                                    <label for="contact-topic">Keperluan</label>
                                    <select id="contact-topic" name="topic">
                                        <option value="Administrasi Kependudukan">Administrasi Kependudukan</option>
                                        <option value="Pelayanan Umum">Pelayanan Umum</option>
                                        <option value="Informasi Kegiatan">Informasi Kegiatan</option>
                                        <option value="Pengaduan">Pengaduan</option>
                                        <option value="Lainnya">Lainnya</option>
                                    </select>
                                </div>
                                <div class="form-group form-group--full">
                                    <label for="contact-message">Pesan</label>
                                    <textarea id="contact-message" name="message" rows="5" placeholder="Jelaskan kebutuhan Anda" required></textarea>
                                </div>
                            </div>
                            <button type="submit" class="btn-primary">Kirim Lewat WhatsApp</button>
                        </form>
                    <?php else: ?>
                        <div class="contact-alert">
                            <p>
                        Nomor WhatsApp desa belum tersedia. Silakan kirim email ke
                        <strong><?= e($emailDesa !== '' ? $emailDesa : 'admin@desa-sendangan.local') ?></strong>.
                            </p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </section>

        <?php if ($hasWhatsAppNumber): ?>
            <script>
                (function () {
                    const form = document.getElementById('contact-whatsapp-form');
                    if (!form) {
                        return;
                    }

                    const waNumber = form.getAttribute('data-wa-number');
                    if (!waNumber) {
                        return;
                    }

                    form.addEventListener('submit', function (event) {
                        event.preventDefault();

                        const name = (form.querySelector('[name="name"]')?.value || '').trim();
                        const origin = (form.querySelector('[name="origin"]')?.value || '').trim();
                        const phone = (form.querySelector('[name="phone"]')?.value || '').trim();
                        const topic = (form.querySelector('[name="topic"]')?.value || '').trim();
                        const message = (form.querySelector('[name="message"]')?.value || '').trim();

                        const intro = name !== ''
                            ? 'Halo Admin Desa Sendangan, saya ' + name + '.'
                            : 'Halo Admin Desa Sendangan.';

                        const lines = [
                            intro,
                        ];

                        if (origin !== '') {
                            lines.push('Domisili/Jaga: ' + origin);
                        }

                        if (phone !== '') {
                            lines.push('Kontak: ' + phone);
                        }

                        if (topic !== '') {
                            lines.push('Keperluan: ' + topic);
                        }

                        if (message !== '') {
                            lines.push('');
                            lines.push(message);
                        }

                        lines.push('');
                        lines.push('Terima kasih.');

                        const composedMessage = lines.join('\n');
                        const isMobile = /Android|iPhone|iPad|iPod|Opera Mini|IEMobile/i.test(navigator.userAgent || '');
                        const baseUrl = isMobile ? 'https://api.whatsapp.com/send' : 'https://web.whatsapp.com/send';
                        const url = baseUrl
                            + '?phone=' + encodeURIComponent(waNumber)
                            + '&text=' + encodeURIComponent(composedMessage);

                        window.open(url, '_blank', 'noopener');
                    });
                })();
            </script>
        <?php endif; ?>
        <?php
    },
]);
