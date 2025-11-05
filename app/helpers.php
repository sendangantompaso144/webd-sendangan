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
 * Load environment variables from a .env file into $_ENV and $_SERVER.
 */
function load_env(string $path): void
{
    if (!is_file($path)) {
        return;
    }

    $lines = file($path, FILE_IGNORE_NEW_LINES);
    if ($lines === false) {
        return;
    }

    foreach ($lines as $line) {
        if ($line === null) {
            continue;
        }

        $trimmed = trim($line);
        if ($trimmed === '' || $trimmed[0] === '#' || $trimmed[0] === ';') {
            continue;
        }

        if (str_starts_with($trimmed, 'export ')) {
            $trimmed = substr($trimmed, 7);
        }

        $parts = explode('=', $trimmed, 2);
        if (count($parts) !== 2) {
            continue;
        }

        [$name, $value] = $parts;
        $name = trim($name);
        $value = ltrim($value);

        if ($name === '') {
            continue;
        }

        $quote = $value[0] ?? '';
        if ($quote === '"' || $quote === "'") {
            $value = substr($value, 1);
            $end = strrpos($value, $quote);
            if ($end !== false) {
                $value = substr($value, 0, $end);
            }
            if ($quote === '"') {
                $value = str_replace(['\\"', '\\n', '\\r'], ['"', "\n", "\r"], $value);
            }
        } else {
            $hashPos = strpos($value, '#');
            if ($hashPos !== false) {
                $value = substr($value, 0, $hashPos);
            }
            $value = rtrim($value);
        }

        if (!array_key_exists($name, $_ENV)) {
            $_ENV[$name] = $value;
        }
        if (!array_key_exists($name, $_SERVER)) {
            $_SERVER[$name] = $value;
        }
        putenv($name . '=' . $value);
    }
}

/**
 * Retrieve an environment variable with optional default.
 */
function env(string $key, mixed $default = null): mixed
{
    if ($key === '') {
        return $default;
    }

    $value = $_ENV[$key] ?? $_SERVER[$key] ?? getenv($key);

    if ($value === false || $value === null) {
        return $default;
    }

    if (is_string($value)) {
        $normalized = strtolower($value);
        if ($normalized === 'true') {
            return true;
        }
        if ($normalized === 'false') {
            return false;
        }
        if ($normalized === 'null') {
            return null;
        }
        if (is_numeric($value)) {
            return str_contains($value, '.') ? (float) $value : (int) $value;
        }
    }

    return $value;
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
 * Access the database configuration.
 *
 * @return array<string, mixed>
 */
function database_config(string $key = '', mixed $default = null): mixed
{
    /** @var array<string, mixed> $databaseConfig */
    $databaseConfig = $GLOBALS['databaseConfig'] ?? [];

    if ($key === '') {
        return $databaseConfig;
    }

    return array_get($databaseConfig, $key, $default);
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

/**
 * Cast a raw data table value to a PHP type based on the data_type column.
 */
function normalize_data_value(mixed $value, string $type, mixed $default): mixed
{
    if ($value === null) {
        return $default;
    }

    $type = strtolower($type);

    return match ($type) {
        'integer', 'int' => (int) $value,
        'float', 'double', 'decimal' => (float) $value,
        'boolean', 'bool' => filter_var($value, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? (bool) $default,
        'json' => json_decode((string) $value, true, 512, JSON_THROW_ON_ERROR),
        default => (string) $value,
    };
}

/**
 * Fetch multiple values from the `data` table with defaults.
 *
 * @param array<string, mixed> $defaults
 *
 * @return array<string, mixed>
 */
function data_values(array $defaults): array
{
    if ($defaults === []) {
        return [];
    }

    $result = $defaults;

    try {
        $keys = array_keys($defaults);
        $placeholders = implode(', ', array_fill(0, count($keys), '?'));

        $pdo = db();
        $stmt = $pdo->prepare('SELECT data_key, data_value, data_type FROM data WHERE data_key IN (' . $placeholders . ')');

        if ($stmt !== false && $stmt->execute($keys)) {
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $key = $row['data_key'] ?? null;

                if ($key === null || !array_key_exists($key, $result)) {
                    continue;
                }

                try {
                    $result[$key] = normalize_data_value(
                        $row['data_value'] ?? null,
                        (string) ($row['data_type'] ?? 'string'),
                        $result[$key]
                    );
                } catch (Throwable) {
                    // Ignore JSON decode or casting issues and keep default.
                }
            }
        }
    } catch (Throwable) {
        // If the query fails, fall back to provided defaults.
    }

    return $result;
}

/**
 * Get a shared PDO connection using configuration defaults.
 *
 * @throws RuntimeException
 */
function db(): PDO
{
    static $connection = null;

    if ($connection instanceof PDO) {
        return $connection;
    }

    $driver = (string) database_config('driver', 'mysql');
    $options = database_config('options', []);

    if (!is_array($options)) {
        $options = [];
    }

    switch ($driver) {
        case 'mysql':
        case 'pgsql':
        case 'sqlsrv':
            $host = (string) database_config('host', '127.0.0.1');
            $port = database_config('port');
            $database = (string) database_config('database', '');
            $charset = (string) database_config('charset', 'utf8mb4');
            $collation = (string) database_config('collation', '');
            $username = (string) database_config('username', '');
            $password = (string) database_config('password', '');

            if ($database === '' && $driver !== 'sqlsrv') {
                throw new RuntimeException('Database name is not configured. Set DB_DATABASE in your .env file.');
            }

            if ($driver === 'mysql') {
                $dsn = sprintf(
                    'mysql:host=%s;%sdbname=%s;charset=%s',
                    $host,
                    $port !== null ? 'port=' . (int) $port . ';' : '',
                    $database,
                    $charset
                );
                if ($collation !== '') {
                    $options[PDO::MYSQL_ATTR_INIT_COMMAND] = "SET NAMES {$charset} COLLATE {$collation}";
                }
            } elseif ($driver === 'pgsql') {
                $dsn = sprintf(
                    'pgsql:host=%s;%sdbname=%s',
                    $host,
                    $port !== null ? 'port=' . (int) $port . ';' : '',
                    $database
                );
            } else {
                $dsn = sprintf(
                    'sqlsrv:Server=%s%s;Database=%s',
                    $host,
                    $port !== null ? ',' . (int) $port : '',
                    $database
                );
            }

            $connection = new PDO($dsn, $username, $password, $options);
            break;

        case 'sqlite':
            $database = (string) database_config('database', '');
            if ($database === '') {
                throw new RuntimeException('SQLite database path is not configured. Set DB_DATABASE in your .env file.');
            }
            $path = str_starts_with($database, ':') ? $database : base_path($database);
            $connection = new PDO('sqlite:' . $path, null, null, $options);
            break;

        default:
            throw new RuntimeException(sprintf('Unsupported database driver "%s".', $driver));
    }

    return $connection;
}

function format_currency(float|int $amount): string
{
    return 'Rp ' . number_format((float) $amount, 0, ',', '.');
}
