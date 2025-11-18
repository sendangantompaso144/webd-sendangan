<?php

declare(strict_types=1);

return [
    'main' => [
        [
            'label' => 'Beranda',
            'href' => 'index.php',
            'page' => 'home',
        ],
        [
            'label' => 'Profil Desa',
            'href' => 'profil.php',
            'page' => 'profil',
        ],
        [
            'label' => 'Informasi Publik',
            'href' => 'info_publik.php',
            'page' => 'informasi',
            'children' => [
                ['label' => 'Berita Desa', 'href' => 'info_publik.php?tab=berita'],
                ['label' => 'Pengumuman', 'href' => 'info_publik.php?tab=pengumuman'],
                ['label' => 'Galeri', 'href' => 'info_publik.php?tab=galeri'],
            ],
        ],
        [
            'label' => 'APBDes',
            'href' => 'apbdes.php',
            'page' => 'apbdes',
        ],
        [
            'label' => 'Potensi Desa',
            'href' => 'potensi.php',
            'page' => 'potensi',
        ],
        [
            'label' => 'Kontak',
            'href' => 'kontak.php',
            'page' => 'kontak',
        ],
    ],
    'footer' => [
        [
            'label' => 'Portal Minahasa',
            'href' => 'https://minahasa.go.id',
        ],
        [
            'label' => 'Universitas Sam Ratulangi',
            'href' => 'https://www.unsrat.ac.id/',
        ],
        [
            'label' => 'IG KKT 144 Sendangan-Tompaso',
            'href' => 'https://www.instagram.com/kkt144.sendangan_tompaso/',
        ],
    ],
];

