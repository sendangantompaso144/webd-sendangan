<?php

declare(strict_types=1);

error_reporting(E_ALL);
ini_set('display_errors', '1');
date_default_timezone_set('Asia/Makassar');

require_once __DIR__ . '/helpers.php';

$envPath = base_path('.env');
load_env($envPath);

$appConfigPath = base_path('config/app.php');
$navigationPath = base_path('config/navigation.php');
$databaseConfigPath = base_path('config/database.php');

$GLOBALS['appConfig'] = is_file($appConfigPath) ? require $appConfigPath : [];
$GLOBALS['navigation'] = is_file($navigationPath) ? require $navigationPath : [];
$GLOBALS['databaseConfig'] = is_file($databaseConfigPath) ? require $databaseConfigPath : [];

