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
    ],
    'footer' => [
        [
            'label' => 'Portal Minahasa',
            'href' => 'https://minahasa.go.id',
        ],
        [
            'label' => 'SIPADES',
            'href' => '#',
        ],
        [
            'label' => 'PPID Kabupaten',
            'href' => '#',
        ],
    ],
];

