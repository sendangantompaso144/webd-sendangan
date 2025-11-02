<?php

declare(strict_types=1);

/**
 * Resolve an absolute path inside the project directory.
 */
function base_path(string $path = ''): string
{
    $root = realpath(__DIR__ . '/..') ?: __DIR__ . '/..';

    if ($path === '') {
        return $root;
    }

    return $root . DIRECTORY_SEPARATOR . str_replace(['/', '\\'], DIRECTORY_SEPARATOR, ltrim($path, '/\\'));
}

/**
 * Generate a URI relative to the project root (useful for assets and links).
 */
function base_uri(string $path = ''): string
{
    $scriptName = $_SERVER['SCRIPT_NAME'] ?? '';
    $directory = rtrim(str_replace('\\', '/', dirname($scriptName)), '/');

    if ($directory === '.' || $directory === '/') {
        $directory = '';
    }

    $prefix = $directory === '' ? '' : $directory;
    $normalizedPath = ltrim(str_replace('\\', '/', $path), '/');

    if ($normalizedPath === '') {
        return $prefix === '' ? '/' : $prefix;
    }

    return rtrim($prefix, '/') . '/' . $normalizedPath;
}

/**
 * Build an asset URI located inside the public assets directory.
 */
function asset(string $path): string
{
    return base_uri('assets/' . ltrim($path, '/'));
}

/**
 * Escape a string for safe HTML output.
 */
function e(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

/**
 * Retrieve a value from a nested array using dot-notation.
 *
 * @param array<mixed> $array
 */
function array_get(array $array, string $key, mixed $default = null): mixed
{
    if ($key === '') {
        return $array;
    }

    $segments = explode('.', $key);
    $value = $array;

    foreach ($segments as $segment) {
        if (!is_array($value) || !array_key_exists($segment, $value)) {
            return $default;
        }

        $value = $value[$segment];
    }

    return $value;
}

/**
 * Load the global application configuration.
 *
 * @return array<string, mixed>
 */
function app_config(string $key = '', mixed $default = null): mixed
{
    /** @var array<string, mixed> $appConfig */
    $appConfig = $GLOBALS['appConfig'] ?? [];

    if ($key === '') {
        return $appConfig;
    }

    return array_get($appConfig, $key, $default);
}

/**
 * Retrieve navigation sets defined in configuration.
 *
 * @return array<int, array<string, mixed>>
 */
function navigation(string $set = 'main'): array
{
    /** @var array<string, array<int, array<string, mixed>>> $navigation */
    $navigation = $GLOBALS['navigation'] ?? [];

    return $navigation[$set] ?? [];
}

/**
 * Render a component file and return its HTML.
 *
 * @param array<string, mixed> $data
 */
function render_component(string $name, array $data = []): string
{
    $componentPath = base_path('components/' . $name . '.php');

    if (!is_file($componentPath)) {
        return "<!-- Missing component: {$name} -->";
    }

    if ($data !== []) {
        extract($data, EXTR_SKIP);
    }

    ob_start();
    include $componentPath;

    return (string) ob_get_clean();
}

/**
 * Render a view (PHP file inside the pages directory) and return its HTML.
 *
 * @param array<string, mixed> $data
 */
function render_view(string $path, array $data = []): string
{
    $viewPath = base_path('pages/' . $path . '.php');

    if (!is_file($viewPath)) {
        return "<!-- Missing view: {$path} -->";
    }

    if ($data !== []) {
        extract($data, EXTR_SKIP);
    }

    ob_start();
    include $viewPath;

    return (string) ob_get_clean();
}

/**
 * Load a PHP data file from the data directory.
 */
function data_source(string $path, mixed $default = null): mixed
{
    $dataPath = base_path('data/' . $path . '.php');

    if (!is_file($dataPath)) {
        return $default;
    }

    return require $dataPath;
}

function format_currency(float|int $amount): string
{
    return 'Rp ' . number_format((float) $amount, 0, ',', '.');
}

