<?php
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('WORDPRESS_DB_USER'));
define('DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD'));
define('DB_HOST', getenv('WORDPRESS_DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Authentication Unique Keys and Salts.
$keys_salts = file_get_contents('https://api.wordpress.org/secret-key/1.1/salt/');
eval($keys_salts);

$table_prefix = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
