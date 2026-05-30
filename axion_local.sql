-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- TablePlus 1.5.2
--
-- https://tableplus.com/
--
-- Database: mysql
-- Generation Time: 2026-05-26 22:17:28.019689
-- -------------------------------------------------------------

-- Save current session settings and set optimal values for import
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0;
SET NAMES utf8mb4;

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `platform` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `exports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exporter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exports_user_id_foreign` (`user_id`),
  CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `platforms_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `server_usage_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `server_id` bigint unsigned NOT NULL,
  `subscription_id` bigint unsigned NOT NULL,
  `bandwidth_used` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `server_usage_logs_subscription_id_foreign` (`subscription_id`),
  KEY `server_usage_logs_server_id_subscription_id_index` (`server_id`,`subscription_id`),
  CONSTRAINT `server_usage_logs_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `server_usage_logs_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` enum('singapore','japan','usa','thailand') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `capacity` int unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `servers_platform_id_region_is_active_index` (`platform_id`,`region`,`is_active`),
  CONSTRAINT `servers_platform_id_foreign` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration_days` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `region` enum('singapore','japan','usa','thailand') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_platform_id_region_is_active_index` (`platform_id`,`region`,`is_active`),
  CONSTRAINT `services_platform_id_foreign` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `subscription_provisions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint unsigned NOT NULL,
  `server_id` bigint unsigned NOT NULL,
  `outline_access_key_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `outline_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outline_port` int unsigned DEFAULT NULL,
  `data_limit_bytes` bigint unsigned DEFAULT NULL,
  `transferred_bytes` bigint unsigned NOT NULL DEFAULT '0',
  `last_synced_at` timestamp NULL DEFAULT NULL,
  `last_error` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','revoked') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscription_provisions_subscription_id_unique` (`subscription_id`),
  KEY `subscription_provisions_server_id_status_index` (`server_id`,`status`),
  KEY `subscription_provisions_outline_access_key_id_index` (`outline_access_key_id`),
  CONSTRAINT `subscription_provisions_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscription_provisions_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `service_id` bigint unsigned NOT NULL,
  `original_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `final_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `remark` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','expired','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_customer_id_foreign` (`customer_id`),
  KEY `subscriptions_service_id_foreign` (`service_id`),
  KEY `subscriptions_status_end_date_index` (`status`,`end_date`),
  CONSTRAINT `subscriptions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES ('axion-cache-spatie.permission.cache', 'a:3:{s:5:"alias";a:4:{s:1:"a";s:2:"id";s:1:"b";s:4:"name";s:1:"c";s:10:"guard_name";s:1:"r";s:5:"roles";}s:11:"permissions";a:99:{i:0;a:4:{s:1:"a";i:1;s:1:"b";s:16:"ViewAny:Customer";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:1;a:4:{s:1:"a";i:2;s:1:"b";s:13:"View:Customer";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:2;a:4:{s:1:"a";i:3;s:1:"b";s:15:"Create:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:3;a:4:{s:1:"a";i:4;s:1:"b";s:15:"Update:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:4;a:4:{s:1:"a";i:5;s:1:"b";s:15:"Delete:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:5;a:4:{s:1:"a";i:6;s:1:"b";s:18:"DeleteAny:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:6;a:4:{s:1:"a";i:7;s:1:"b";s:16:"Restore:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:7;a:4:{s:1:"a";i:8;s:1:"b";s:20:"ForceDelete:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:8;a:4:{s:1:"a";i:9;s:1:"b";s:23:"ForceDeleteAny:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:9;a:4:{s:1:"a";i:10;s:1:"b";s:19:"RestoreAny:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:10;a:4:{s:1:"a";i:11;s:1:"b";s:18:"Replicate:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:11;a:4:{s:1:"a";i:12;s:1:"b";s:16:"Reorder:Customer";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:12;a:4:{s:1:"a";i:13;s:1:"b";s:16:"ViewAny:Platform";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:13;a:4:{s:1:"a";i:14;s:1:"b";s:13:"View:Platform";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:14;a:4:{s:1:"a";i:15;s:1:"b";s:15:"Create:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:15;a:4:{s:1:"a";i:16;s:1:"b";s:15:"Update:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:16;a:4:{s:1:"a";i:17;s:1:"b";s:15:"Delete:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:17;a:4:{s:1:"a";i:18;s:1:"b";s:18:"DeleteAny:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:18;a:4:{s:1:"a";i:19;s:1:"b";s:16:"Restore:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:19;a:4:{s:1:"a";i:20;s:1:"b";s:20:"ForceDelete:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:20;a:4:{s:1:"a";i:21;s:1:"b";s:23:"ForceDeleteAny:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:21;a:4:{s:1:"a";i:22;s:1:"b";s:19:"RestoreAny:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:22;a:4:{s:1:"a";i:23;s:1:"b";s:18:"Replicate:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:23;a:4:{s:1:"a";i:24;s:1:"b";s:16:"Reorder:Platform";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:24;a:4:{s:1:"a";i:25;s:1:"b";s:14:"ViewAny:Server";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:25;a:4:{s:1:"a";i:26;s:1:"b";s:11:"View:Server";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:26;a:4:{s:1:"a";i:27;s:1:"b";s:13:"Create:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:27;a:4:{s:1:"a";i:28;s:1:"b";s:13:"Update:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:28;a:4:{s:1:"a";i:29;s:1:"b";s:13:"Delete:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:29;a:4:{s:1:"a";i:30;s:1:"b";s:16:"DeleteAny:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:30;a:4:{s:1:"a";i:31;s:1:"b";s:14:"Restore:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:31;a:4:{s:1:"a";i:32;s:1:"b";s:18:"ForceDelete:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:32;a:4:{s:1:"a";i:33;s:1:"b";s:21:"ForceDeleteAny:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:33;a:4:{s:1:"a";i:34;s:1:"b";s:17:"RestoreAny:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:34;a:4:{s:1:"a";i:35;s:1:"b";s:16:"Replicate:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:35;a:4:{s:1:"a";i:36;s:1:"b";s:14:"Reorder:Server";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:36;a:4:{s:1:"a";i:37;s:1:"b";s:15:"ViewAny:Service";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:37;a:4:{s:1:"a";i:38;s:1:"b";s:12:"View:Service";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:38;a:4:{s:1:"a";i:39;s:1:"b";s:14:"Create:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:39;a:4:{s:1:"a";i:40;s:1:"b";s:14:"Update:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:40;a:4:{s:1:"a";i:41;s:1:"b";s:14:"Delete:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:41;a:4:{s:1:"a";i:42;s:1:"b";s:17:"DeleteAny:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:42;a:4:{s:1:"a";i:43;s:1:"b";s:15:"Restore:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:43;a:4:{s:1:"a";i:44;s:1:"b";s:19:"ForceDelete:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:44;a:4:{s:1:"a";i:45;s:1:"b";s:22:"ForceDeleteAny:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:45;a:4:{s:1:"a";i:46;s:1:"b";s:18:"RestoreAny:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:46;a:4:{s:1:"a";i:47;s:1:"b";s:17:"Replicate:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:47;a:4:{s:1:"a";i:48;s:1:"b";s:15:"Reorder:Service";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:48;a:4:{s:1:"a";i:49;s:1:"b";s:29:"ViewAny:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:49;a:4:{s:1:"a";i:50;s:1:"b";s:26:"View:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:50;a:4:{s:1:"a";i:51;s:1:"b";s:28:"Create:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:51;a:4:{s:1:"a";i:52;s:1:"b";s:28:"Update:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:52;a:4:{s:1:"a";i:53;s:1:"b";s:28:"Delete:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:53;a:4:{s:1:"a";i:54;s:1:"b";s:31:"DeleteAny:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:54;a:4:{s:1:"a";i:55;s:1:"b";s:29:"Restore:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:55;a:4:{s:1:"a";i:56;s:1:"b";s:33:"ForceDelete:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:56;a:4:{s:1:"a";i:57;s:1:"b";s:36:"ForceDeleteAny:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:57;a:4:{s:1:"a";i:58;s:1:"b";s:32:"RestoreAny:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:58;a:4:{s:1:"a";i:59;s:1:"b";s:31:"Replicate:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:59;a:4:{s:1:"a";i:60;s:1:"b";s:29:"Reorder:SubscriptionProvision";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:60;a:4:{s:1:"a";i:61;s:1:"b";s:20:"ViewAny:Subscription";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:61;a:4:{s:1:"a";i:62;s:1:"b";s:17:"View:Subscription";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:62;a:4:{s:1:"a";i:63;s:1:"b";s:19:"Create:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:63;a:4:{s:1:"a";i:64;s:1:"b";s:19:"Update:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:64;a:4:{s:1:"a";i:65;s:1:"b";s:19:"Delete:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:65;a:4:{s:1:"a";i:66;s:1:"b";s:22:"DeleteAny:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:66;a:4:{s:1:"a";i:67;s:1:"b";s:20:"Restore:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:67;a:4:{s:1:"a";i:68;s:1:"b";s:24:"ForceDelete:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:68;a:4:{s:1:"a";i:69;s:1:"b";s:27:"ForceDeleteAny:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:69;a:4:{s:1:"a";i:70;s:1:"b";s:23:"RestoreAny:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:70;a:4:{s:1:"a";i:71;s:1:"b";s:22:"Replicate:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:71;a:4:{s:1:"a";i:72;s:1:"b";s:20:"Reorder:Subscription";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:72;a:4:{s:1:"a";i:73;s:1:"b";s:12:"ViewAny:Role";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:73;a:4:{s:1:"a";i:74;s:1:"b";s:9:"View:Role";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:74;a:4:{s:1:"a";i:75;s:1:"b";s:11:"Create:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:75;a:4:{s:1:"a";i:76;s:1:"b";s:11:"Update:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:76;a:4:{s:1:"a";i:77;s:1:"b";s:11:"Delete:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:77;a:4:{s:1:"a";i:78;s:1:"b";s:14:"DeleteAny:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:78;a:4:{s:1:"a";i:79;s:1:"b";s:12:"Restore:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:79;a:4:{s:1:"a";i:80;s:1:"b";s:16:"ForceDelete:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:80;a:4:{s:1:"a";i:81;s:1:"b";s:19:"ForceDeleteAny:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:81;a:4:{s:1:"a";i:82;s:1:"b";s:15:"RestoreAny:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:82;a:4:{s:1:"a";i:83;s:1:"b";s:14:"Replicate:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:83;a:4:{s:1:"a";i:84;s:1:"b";s:12:"Reorder:Role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:84;a:4:{s:1:"a";i:85;s:1:"b";s:13:"View:ListLogs";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:85;a:4:{s:1:"a";i:86;s:1:"b";s:12:"View:ViewLog";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:86;a:4:{s:1:"a";i:87;s:1:"b";s:8:"ViewLogs";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:87;a:4:{s:1:"a";i:88;s:1:"b";s:12:"ViewAny:User";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:88;a:4:{s:1:"a";i:89;s:1:"b";s:9:"View:User";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:89;a:4:{s:1:"a";i:90;s:1:"b";s:11:"Create:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:90;a:4:{s:1:"a";i:91;s:1:"b";s:11:"Update:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:91;a:4:{s:1:"a";i:92;s:1:"b";s:11:"Delete:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:92;a:4:{s:1:"a";i:93;s:1:"b";s:14:"DeleteAny:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:93;a:4:{s:1:"a";i:94;s:1:"b";s:12:"Restore:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:94;a:4:{s:1:"a";i:95;s:1:"b";s:16:"ForceDelete:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:95;a:4:{s:1:"a";i:96;s:1:"b";s:19:"ForceDeleteAny:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:96;a:4:{s:1:"a";i:97;s:1:"b";s:15:"RestoreAny:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:97;a:4:{s:1:"a";i:98;s:1:"b";s:14:"Replicate:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:98;a:4:{s:1:"a";i:99;s:1:"b";s:12:"Reorder:User";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}}s:5:"roles";a:3:{i:0;a:3:{s:1:"a";i:1;s:1:"b";s:11:"super_admin";s:1:"c";s:3:"web";}i:1;a:3:{s:1:"a";i:2;s:1:"b";s:5:"admin";s:1:"c";s:3:"web";}i:2;a:3:{s:1:"a";i:3;s:1:"b";s:7:"support";s:1:"c";s:3:"web";}}}', 1779895513);

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `platform`, `profile_url`, `created_at`, `updated_at`) VALUES 
(1, 'Mg Mg', NULL, NULL, 'facebook', 'http://127.0.0.1', '2026-05-26 12:52:07', '2026-05-26 12:52:07'),
(2, 'pyae sone', NULL, NULL, 'tiktok', 'http://127.0.0.2', '2026-05-26 12:58:16', '2026-05-26 12:58:16'),
(3, 'S paw', NULL, NULL, 'telegram', 'http://127.0.0.3', '2026-05-26 14:04:01', '2026-05-26 14:04:01'),
(4, 'discount test', NULL, NULL, 'tiktok', 'http://127.0.0.1', '2026-05-26 14:22:50', '2026-05-26 14:22:50');

INSERT INTO `exports` (`id`, `completed_at`, `file_disk`, `file_name`, `exporter`, `processed_rows`, `total_rows`, `successful_rows`, `user_id`, `created_at`, `updated_at`) VALUES 
(1, '2026-05-26 14:25:59', 'local', 'export-1-subscriptions', 'App\\Filament\\Exports\\SubscriptionExporter', 5, 5, 5, 1, '2026-05-26 14:24:42', '2026-05-26 14:25:59'),
(2, '2026-05-26 14:26:26', 'local', 'export-2-subscriptions', 'App\\Filament\\Exports\\SubscriptionExporter', 5, 5, 5, 1, '2026-05-26 14:26:24', '2026-05-26 14:26:26'),
(3, '2026-05-26 14:27:32', 'local', 'export-3-subscriptions', 'App\\Filament\\Exports\\SubscriptionExporter', 5, 5, 5, 1, '2026-05-26 14:27:32', '2026-05-26 14:27:32');

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES 
(1, '562ac4e8-676c-4249-9628-352ae61a0cc0', 'database', 'default', '{"uuid":"562ac4e8-676c-4249-9628-352ae61a0cc0","displayName":"Filament\\\\Notifications\\\\DatabaseNotification","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:1;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"mysql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:43:\\"Filament\\\\Notifications\\\\DatabaseNotification\\":2:{s:4:\\"data\\";a:11:{s:7:\\"actions\\";a:1:{i:0;a:23:{s:4:\\"name\\";s:13:\\"download_xlsx\\";s:18:\\"alpineClickHandler\\";N;s:5:\\"color\\";N;s:5:\\"event\\";N;s:9:\\"eventData\\";a:0:{}s:17:\\"dispatchDirection\\";b:0;s:19:\\"dispatchToComponent\\";N;s:15:\\"extraAttributes\\";a:0:{}s:4:\\"icon\\";N;s:12:\\"iconPosition\\";E:42:\\"Filament\\\\Support\\\\Enums\\\\IconPosition:Before\\";s:8:\\"iconSize\\";N;s:10:\\"isOutlined\\";b:0;s:10:\\"isDisabled\\";b:0;s:5:\\"label\\";s:14:\\"Download .xlsx\\";s:11:\\"shouldClose\\";b:0;s:16:\\"shouldMarkAsRead\\";b:1;s:18:\\"shouldMarkAsUnread\\";b:0;s:21:\\"shouldOpenUrlInNewTab\\";b:1;s:15:\\"shouldPostToUrl\\";b:0;s:4:\\"size\\";E:33:\\"Filament\\\\Support\\\\Enums\\\\Size:Small\\";s:7:\\"tooltip\\";N;s:3:\\"url\\";s:129:\\"\\/filament\\/exports\\/1\\/download?authGuard=web&format=xlsx&signature=7b7746faecb1f6a5ba2e5258d3343c2110a62d855b01aca57c01a0b9d6d4e8df\\";s:4:\\"view\\";s:25:\\"filament::components.link\\";}}s:4:\\"body\\";s:59:\\"Your subscription export has completed and 5 rows exported.\\";s:5:\\"color\\";N;s:8:\\"duration\\";s:10:\\"persistent\\";s:4:\\"icon\\";s:23:\\"heroicon-o-check-circle\\";s:9:\\"iconColor\\";s:7:\\"success\\";s:6:\\"status\\";s:7:\\"success\\";s:5:\\"title\\";s:16:\\"Export completed\\";s:4:\\"view\\";N;s:8:\\"viewData\\";a:0:{}s:6:\\"format\\";s:8:\\"filament\\";}s:2:\\"id\\";s:36:\\"118c8c9f-61aa-4725-8085-c2a4f1c36e8d\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}","batchId":null},"createdAt":1779805559,"delay":null}', 'PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table ''axion_v3.notifications'' doesn''t exist in /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php:47
Stack trace:
#0 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php(47): PDO->prepare()
#1 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php(827): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}()
#2 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php(794): Illuminate\\Database\\Connection->runQueryCallback()
#3 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php(42): Illuminate\\Database\\Connection->run()
#4 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(4121): Illuminate\\Database\\MySqlConnection->insert()
#5 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(2237): Illuminate\\Database\\Query\\Builder->insert()
#6 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1412): Illuminate\\Database\\Eloquent\\Builder->__call()
#7 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1240): Illuminate\\Database\\Eloquent\\Model->performInsert()
#8 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(391): Illuminate\\Database\\Eloquent\\Model->save()
#9 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}()
#10 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(388): tap()
#11 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create()
#12 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(161): Illuminate\\Notifications\\Channels\\DatabaseChannel->send()
#13 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(116): Illuminate\\Notifications\\NotificationSender->sendToNotifiable()
#14 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()
#15 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(111): Illuminate\\Notifications\\NotificationSender->withLocale()
#16 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(60): Illuminate\\Notifications\\NotificationSender->sendNow()
#17 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(118): Illuminate\\Notifications\\ChannelManager->sendNow()
#18 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle()
#19 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#20 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#21 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#22 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#23 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()
#24 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}()
#25 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#26 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()
#27 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(136): Illuminate\\Bus\\Dispatcher->dispatchNow()
#28 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}()
#29 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#30 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(129): Illuminate\\Pipeline\\Pipeline->then()
#31 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()
#32 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()
#33 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(493): Illuminate\\Queue\\Jobs\\Job->fire()
#34 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(443): Illuminate\\Queue\\Worker->process()
#35 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(208): Illuminate\\Queue\\Worker->runJob()
#36 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()
#37 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()
#38 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()
#39 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#40 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#41 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#42 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#43 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()
#44 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Command/Command.php(341): Illuminate\\Console\\Command->execute()
#45 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()
#46 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(1117): Illuminate\\Console\\Command->run()
#47 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand()
#48 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(195): Symfony\\Component\\Console\\Application->doRun()
#49 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(198): Symfony\\Component\\Console\\Application->run()
#50 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()
#51 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/artisan(16): Illuminate\\Foundation\\Application->handleCommand()
#52 {main}

Next Illuminate\\Database\\QueryException: SQLSTATE[42S02]: Base table or view not found: 1146 Table ''axion_v3.notifications'' doesn''t exist (Connection: mysql, Host: 127.0.0.1, Port: 3306, Database: axion_v3, SQL: insert into `notifications` (`id`, `type`, `data`, `read_at`, `notifiable_id`, `notifiable_type`, `updated_at`, `created_at`) values (118c8c9f-61aa-4725-8085-c2a4f1c36e8d, Filament\\Notifications\\DatabaseNotification, {"actions":[{"name":"download_xlsx","alpineClickHandler":null,"color":null,"event":null,"eventData":[],"dispatchDirection":false,"dispatchToComponent":null,"extraAttributes":[],"icon":null,"iconPosition":"before","iconSize":null,"isOutlined":false,"isDisabled":false,"label":"Download .xlsx","shouldClose":false,"shouldMarkAsRead":true,"shouldMarkAsUnread":false,"shouldOpenUrlInNewTab":true,"shouldPostToUrl":false,"size":"sm","tooltip":null,"url":"\\/filament\\/exports\\/1\\/download?authGuard=web&format=xlsx&signature=7b7746faecb1f6a5ba2e5258d3343c2110a62d855b01aca57c01a0b9d6d4e8df","view":"filament::components.link"}],"body":"Your subscription export has completed and 5 rows exported.","color":null,"duration":"persistent","icon":"heroicon-o-check-circle","iconColor":"success","status":"success","title":"Export completed","view":null,"viewData":[],"format":"filament"}, ?, 1, App\\Models\\User, 2026-05-26 14:25:59, 2026-05-26 14:25:59)) in /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php:838
Stack trace:
#0 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php(794): Illuminate\\Database\\Connection->runQueryCallback()
#1 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php(42): Illuminate\\Database\\Connection->run()
#2 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(4121): Illuminate\\Database\\MySqlConnection->insert()
#3 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(2237): Illuminate\\Database\\Query\\Builder->insert()
#4 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1412): Illuminate\\Database\\Eloquent\\Builder->__call()
#5 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1240): Illuminate\\Database\\Eloquent\\Model->performInsert()
#6 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(391): Illuminate\\Database\\Eloquent\\Model->save()
#7 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}()
#8 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(388): tap()
#9 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create()
#10 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(161): Illuminate\\Notifications\\Channels\\DatabaseChannel->send()
#11 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(116): Illuminate\\Notifications\\NotificationSender->sendToNotifiable()
#12 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()
#13 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(111): Illuminate\\Notifications\\NotificationSender->withLocale()
#14 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(60): Illuminate\\Notifications\\NotificationSender->sendNow()
#15 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(118): Illuminate\\Notifications\\ChannelManager->sendNow()
#16 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle()
#17 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#18 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#19 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#20 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#21 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()
#22 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}()
#23 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#24 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()
#25 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(136): Illuminate\\Bus\\Dispatcher->dispatchNow()
#26 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}()
#27 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#28 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(129): Illuminate\\Pipeline\\Pipeline->then()
#29 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()
#30 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()
#31 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(493): Illuminate\\Queue\\Jobs\\Job->fire()
#32 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(443): Illuminate\\Queue\\Worker->process()
#33 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(208): Illuminate\\Queue\\Worker->runJob()
#34 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()
#35 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()
#36 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()
#37 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#38 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#39 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#40 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#41 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()
#42 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Command/Command.php(341): Illuminate\\Console\\Command->execute()
#43 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()
#44 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(1117): Illuminate\\Console\\Command->run()
#45 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand()
#46 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(195): Symfony\\Component\\Console\\Application->doRun()
#47 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(198): Symfony\\Component\\Console\\Application->run()
#48 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()
#49 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/artisan(16): Illuminate\\Foundation\\Application->handleCommand()
#50 {main}', '2026-05-26 14:25:59'),
(2, 'db88b56f-1933-42ff-b7f3-46aaa539039a', 'database', 'default', '{"uuid":"db88b56f-1933-42ff-b7f3-46aaa539039a","displayName":"Filament\\\\Notifications\\\\DatabaseNotification","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:1;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"mysql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:43:\\"Filament\\\\Notifications\\\\DatabaseNotification\\":2:{s:4:\\"data\\";a:11:{s:7:\\"actions\\";a:1:{i:0;a:23:{s:4:\\"name\\";s:13:\\"download_xlsx\\";s:18:\\"alpineClickHandler\\";N;s:5:\\"color\\";N;s:5:\\"event\\";N;s:9:\\"eventData\\";a:0:{}s:17:\\"dispatchDirection\\";b:0;s:19:\\"dispatchToComponent\\";N;s:15:\\"extraAttributes\\";a:0:{}s:4:\\"icon\\";N;s:12:\\"iconPosition\\";E:42:\\"Filament\\\\Support\\\\Enums\\\\IconPosition:Before\\";s:8:\\"iconSize\\";N;s:10:\\"isOutlined\\";b:0;s:10:\\"isDisabled\\";b:0;s:5:\\"label\\";s:14:\\"Download .xlsx\\";s:11:\\"shouldClose\\";b:0;s:16:\\"shouldMarkAsRead\\";b:1;s:18:\\"shouldMarkAsUnread\\";b:0;s:21:\\"shouldOpenUrlInNewTab\\";b:1;s:15:\\"shouldPostToUrl\\";b:0;s:4:\\"size\\";E:33:\\"Filament\\\\Support\\\\Enums\\\\Size:Small\\";s:7:\\"tooltip\\";N;s:3:\\"url\\";s:129:\\"\\/filament\\/exports\\/2\\/download?authGuard=web&format=xlsx&signature=dc21bbfceabb47daaca907141c96d83f4d5144290083db39527e7a821d50e4b1\\";s:4:\\"view\\";s:25:\\"filament::components.link\\";}}s:4:\\"body\\";s:59:\\"Your subscription export has completed and 5 rows exported.\\";s:5:\\"color\\";N;s:8:\\"duration\\";s:10:\\"persistent\\";s:4:\\"icon\\";s:23:\\"heroicon-o-check-circle\\";s:9:\\"iconColor\\";s:7:\\"success\\";s:6:\\"status\\";s:7:\\"success\\";s:5:\\"title\\";s:16:\\"Export completed\\";s:4:\\"view\\";N;s:8:\\"viewData\\";a:0:{}s:6:\\"format\\";s:8:\\"filament\\";}s:2:\\"id\\";s:36:\\"06d818de-f19e-436a-9174-cf4abf46bce0\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}","batchId":null},"createdAt":1779805586,"delay":null}', 'PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table ''axion_v3.notifications'' doesn''t exist in /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php:47
Stack trace:
#0 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php(47): PDO->prepare()
#1 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php(827): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}()
#2 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php(794): Illuminate\\Database\\Connection->runQueryCallback()
#3 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php(42): Illuminate\\Database\\Connection->run()
#4 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(4121): Illuminate\\Database\\MySqlConnection->insert()
#5 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(2237): Illuminate\\Database\\Query\\Builder->insert()
#6 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1412): Illuminate\\Database\\Eloquent\\Builder->__call()
#7 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1240): Illuminate\\Database\\Eloquent\\Model->performInsert()
#8 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(391): Illuminate\\Database\\Eloquent\\Model->save()
#9 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}()
#10 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(388): tap()
#11 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create()
#12 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(161): Illuminate\\Notifications\\Channels\\DatabaseChannel->send()
#13 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(116): Illuminate\\Notifications\\NotificationSender->sendToNotifiable()
#14 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()
#15 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(111): Illuminate\\Notifications\\NotificationSender->withLocale()
#16 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(60): Illuminate\\Notifications\\NotificationSender->sendNow()
#17 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(118): Illuminate\\Notifications\\ChannelManager->sendNow()
#18 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle()
#19 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#20 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#21 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#22 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#23 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()
#24 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}()
#25 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#26 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()
#27 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(136): Illuminate\\Bus\\Dispatcher->dispatchNow()
#28 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}()
#29 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#30 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(129): Illuminate\\Pipeline\\Pipeline->then()
#31 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()
#32 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()
#33 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(493): Illuminate\\Queue\\Jobs\\Job->fire()
#34 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(443): Illuminate\\Queue\\Worker->process()
#35 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(208): Illuminate\\Queue\\Worker->runJob()
#36 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()
#37 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()
#38 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()
#39 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#40 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#41 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#42 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#43 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()
#44 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Command/Command.php(341): Illuminate\\Console\\Command->execute()
#45 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()
#46 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(1117): Illuminate\\Console\\Command->run()
#47 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand()
#48 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(195): Symfony\\Component\\Console\\Application->doRun()
#49 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(198): Symfony\\Component\\Console\\Application->run()
#50 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()
#51 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/artisan(16): Illuminate\\Foundation\\Application->handleCommand()
#52 {main}

Next Illuminate\\Database\\QueryException: SQLSTATE[42S02]: Base table or view not found: 1146 Table ''axion_v3.notifications'' doesn''t exist (Connection: mysql, Host: 127.0.0.1, Port: 3306, Database: axion_v3, SQL: insert into `notifications` (`id`, `type`, `data`, `read_at`, `notifiable_id`, `notifiable_type`, `updated_at`, `created_at`) values (06d818de-f19e-436a-9174-cf4abf46bce0, Filament\\Notifications\\DatabaseNotification, {"actions":[{"name":"download_xlsx","alpineClickHandler":null,"color":null,"event":null,"eventData":[],"dispatchDirection":false,"dispatchToComponent":null,"extraAttributes":[],"icon":null,"iconPosition":"before","iconSize":null,"isOutlined":false,"isDisabled":false,"label":"Download .xlsx","shouldClose":false,"shouldMarkAsRead":true,"shouldMarkAsUnread":false,"shouldOpenUrlInNewTab":true,"shouldPostToUrl":false,"size":"sm","tooltip":null,"url":"\\/filament\\/exports\\/2\\/download?authGuard=web&format=xlsx&signature=dc21bbfceabb47daaca907141c96d83f4d5144290083db39527e7a821d50e4b1","view":"filament::components.link"}],"body":"Your subscription export has completed and 5 rows exported.","color":null,"duration":"persistent","icon":"heroicon-o-check-circle","iconColor":"success","status":"success","title":"Export completed","view":null,"viewData":[],"format":"filament"}, ?, 1, App\\Models\\User, 2026-05-26 14:26:26, 2026-05-26 14:26:26)) in /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php:838
Stack trace:
#0 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Connection.php(794): Illuminate\\Database\\Connection->runQueryCallback()
#1 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/MySqlConnection.php(42): Illuminate\\Database\\Connection->run()
#2 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(4121): Illuminate\\Database\\MySqlConnection->insert()
#3 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(2237): Illuminate\\Database\\Query\\Builder->insert()
#4 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1412): Illuminate\\Database\\Eloquent\\Builder->__call()
#5 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1240): Illuminate\\Database\\Eloquent\\Model->performInsert()
#6 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(391): Illuminate\\Database\\Eloquent\\Model->save()
#7 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}()
#8 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/HasOneOrMany.php(388): tap()
#9 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create()
#10 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(161): Illuminate\\Notifications\\Channels\\DatabaseChannel->send()
#11 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(116): Illuminate\\Notifications\\NotificationSender->sendToNotifiable()
#12 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()
#13 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(111): Illuminate\\Notifications\\NotificationSender->withLocale()
#14 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(60): Illuminate\\Notifications\\NotificationSender->sendNow()
#15 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(118): Illuminate\\Notifications\\ChannelManager->sendNow()
#16 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle()
#17 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#18 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#19 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#20 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#21 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()
#22 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}()
#23 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#24 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()
#25 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(136): Illuminate\\Bus\\Dispatcher->dispatchNow()
#26 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}()
#27 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}()
#28 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(129): Illuminate\\Pipeline\\Pipeline->then()
#29 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()
#30 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()
#31 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(493): Illuminate\\Queue\\Jobs\\Job->fire()
#32 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(443): Illuminate\\Queue\\Worker->process()
#33 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(208): Illuminate\\Queue\\Worker->runJob()
#34 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()
#35 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()
#36 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()
#37 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()
#38 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()
#39 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()
#40 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Container/Container.php(799): Illuminate\\Container\\BoundMethod::call()
#41 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()
#42 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Command/Command.php(341): Illuminate\\Console\\Command->execute()
#43 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()
#44 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(1117): Illuminate\\Console\\Command->run()
#45 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand()
#46 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/symfony/console/Application.php(195): Symfony\\Component\\Console\\Application->doRun()
#47 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(198): Symfony\\Component\\Console\\Application->run()
#48 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()
#49 /home/pyae-sone-phyo/Desktop/My_projects/axion_ds/artisan(16): Illuminate\\Foundation\\Application->handleCommand()
#50 {main}', '2026-05-26 14:26:26');

INSERT INTO `job_batches` (`id`, `name`, `total_jobs`, `pending_jobs`, `failed_jobs`, `failed_job_ids`, `options`, `cancelled_at`, `created_at`, `finished_at`) VALUES 
('a1df53cf-fc62-4dd6-8752-8f43284e3fc2', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:7993:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:1:{s:4:"next";O:44:"Filament\\Actions\\Exports\\Jobs\\CreateXlsxFile":6:{s:11:" * exporter";O:41:"App\\Filament\\Exports\\SubscriptionExporter":3:{s:9:" * export";O:38:"Filament\\Actions\\Exports\\Models\\Export":35:{s:13:" * connection";s:5:"mysql";s:8:" * table";N;s:13:" * primaryKey";s:2:"id";s:10:" * keyType";s:3:"int";s:12:"incrementing";b:1;s:7:" * with";a:0:{}s:12:" * withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:" * perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:" * escapeWhenCastingToString";b:0;s:13:" * attributes";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:24:42";s:10:"created_at";s:19:"2026-05-26 14:24:42";s:2:"id";i:1;s:9:"file_name";s:22:"export-1-subscriptions";}s:11:" * original";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:24:42";s:10:"created_at";s:19:"2026-05-26 14:24:42";s:2:"id";i:1;s:9:"file_name";s:22:"export-1-subscriptions";}s:10:" * changes";a:1:{s:9:"file_name";s:22:"export-1-subscriptions";}s:11:" * previous";a:0:{}s:8:" * casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:" * classCastCache";a:0:{}s:21:" * attributeCastCache";a:0:{}s:13:" * dateFormat";N;s:10:" * appends";a:0:{}s:19:" * dispatchesEvents";a:0:{}s:14:" * observables";a:0:{}s:12:" * relations";a:0:{}s:10:" * touches";a:0:{}s:27:" * relationAutoloadCallback";N;s:26:" * relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:" * hidden";a:0:{}s:10:" * visible";a:0:{}s:11:" * fillable";a:0:{}s:10:" * guarded";a:0:{}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:9:" * export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:1;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}s:7:"chained";a:1:{i:0;s:3778:"O:46:"Filament\\Actions\\Exports\\Jobs\\ExportCompletion":6:{s:11:" * exporter";O:41:"App\\Filament\\Exports\\SubscriptionExporter":3:{s:9:" * export";O:38:"Filament\\Actions\\Exports\\Models\\Export":35:{s:13:" * connection";s:5:"mysql";s:8:" * table";N;s:13:" * primaryKey";s:2:"id";s:10:" * keyType";s:3:"int";s:12:"incrementing";b:1;s:7:" * with";a:0:{}s:12:" * withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:" * perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:" * escapeWhenCastingToString";b:0;s:13:" * attributes";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:24:42";s:10:"created_at";s:19:"2026-05-26 14:24:42";s:2:"id";i:1;s:9:"file_name";s:22:"export-1-subscriptions";}s:11:" * original";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:24:42";s:10:"created_at";s:19:"2026-05-26 14:24:42";s:2:"id";i:1;s:9:"file_name";s:22:"export-1-subscriptions";}s:10:" * changes";a:1:{s:9:"file_name";s:22:"export-1-subscriptions";}s:11:" * previous";a:0:{}s:8:" * casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:" * classCastCache";a:0:{}s:21:" * attributeCastCache";a:0:{}s:13:" * dateFormat";N;s:10:" * appends";a:0:{}s:19:" * dispatchesEvents";a:0:{}s:14:" * observables";a:0:{}s:12:" * relations";a:0:{}s:10:" * touches";a:0:{}s:27:" * relationAutoloadCallback";N;s:26:" * relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:" * hidden";a:0:{}s:10:" * visible";a:0:{}s:11:" * fillable";a:0:{}s:10:" * guarded";a:0:{}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:9:" * export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:1;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * formats";a:1:{i:0;E:48:"Filament\\Actions\\Exports\\Enums\\ExportFormat:Xlsx";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}s:12:" * authGuard";s:3:"web";}";}s:19:"chainCatchCallbacks";a:0:{}}}s:8:"function";s:266:"function (\\Illuminate\\Bus\\Batch $batch) use ($next) {
                if (! $batch->cancelled()) {
                    \\Illuminate\\Container\\Container::getInstance()->make(\\Illuminate\\Contracts\\Bus\\Dispatcher::class)->dispatch($next);
                }
            }";s:5:"scope";s:27:"Illuminate\\Bus\\ChainedBatch";s:4:"this";N;s:4:"self";s:32:"0000000000000c960000000000000000";}";s:4:"hash";s:44:"EW5xN7rkmt+NY/WbxyvlYvI5MtqGwwLaqLeIZ1uAofQ=";}}}}', NULL, 1779805559, 1779805559),
('a1df53f9-a2fb-470b-b6d5-b6c061d49bf2', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:7993:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:1:{s:4:"next";O:44:"Filament\\Actions\\Exports\\Jobs\\CreateXlsxFile":6:{s:11:" * exporter";O:41:"App\\Filament\\Exports\\SubscriptionExporter":3:{s:9:" * export";O:38:"Filament\\Actions\\Exports\\Models\\Export":35:{s:13:" * connection";s:5:"mysql";s:8:" * table";N;s:13:" * primaryKey";s:2:"id";s:10:" * keyType";s:3:"int";s:12:"incrementing";b:1;s:7:" * with";a:0:{}s:12:" * withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:" * perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:" * escapeWhenCastingToString";b:0;s:13:" * attributes";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:26:24";s:10:"created_at";s:19:"2026-05-26 14:26:24";s:2:"id";i:2;s:9:"file_name";s:22:"export-2-subscriptions";}s:11:" * original";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:26:24";s:10:"created_at";s:19:"2026-05-26 14:26:24";s:2:"id";i:2;s:9:"file_name";s:22:"export-2-subscriptions";}s:10:" * changes";a:1:{s:9:"file_name";s:22:"export-2-subscriptions";}s:11:" * previous";a:0:{}s:8:" * casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:" * classCastCache";a:0:{}s:21:" * attributeCastCache";a:0:{}s:13:" * dateFormat";N;s:10:" * appends";a:0:{}s:19:" * dispatchesEvents";a:0:{}s:14:" * observables";a:0:{}s:12:" * relations";a:0:{}s:10:" * touches";a:0:{}s:27:" * relationAutoloadCallback";N;s:26:" * relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:" * hidden";a:0:{}s:10:" * visible";a:0:{}s:11:" * fillable";a:0:{}s:10:" * guarded";a:0:{}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-06";s:13:"created_until";s:10:"2026-05-31";}}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-06";s:13:"created_until";s:10:"2026-05-31";}}s:9:" * export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:2;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-06";s:13:"created_until";s:10:"2026-05-31";}s:7:"chained";a:1:{i:0;s:3778:"O:46:"Filament\\Actions\\Exports\\Jobs\\ExportCompletion":6:{s:11:" * exporter";O:41:"App\\Filament\\Exports\\SubscriptionExporter":3:{s:9:" * export";O:38:"Filament\\Actions\\Exports\\Models\\Export":35:{s:13:" * connection";s:5:"mysql";s:8:" * table";N;s:13:" * primaryKey";s:2:"id";s:10:" * keyType";s:3:"int";s:12:"incrementing";b:1;s:7:" * with";a:0:{}s:12:" * withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:" * perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:" * escapeWhenCastingToString";b:0;s:13:" * attributes";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:26:24";s:10:"created_at";s:19:"2026-05-26 14:26:24";s:2:"id";i:2;s:9:"file_name";s:22:"export-2-subscriptions";}s:11:" * original";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:26:24";s:10:"created_at";s:19:"2026-05-26 14:26:24";s:2:"id";i:2;s:9:"file_name";s:22:"export-2-subscriptions";}s:10:" * changes";a:1:{s:9:"file_name";s:22:"export-2-subscriptions";}s:11:" * previous";a:0:{}s:8:" * casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:" * classCastCache";a:0:{}s:21:" * attributeCastCache";a:0:{}s:13:" * dateFormat";N;s:10:" * appends";a:0:{}s:19:" * dispatchesEvents";a:0:{}s:14:" * observables";a:0:{}s:12:" * relations";a:0:{}s:10:" * touches";a:0:{}s:27:" * relationAutoloadCallback";N;s:26:" * relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:" * hidden";a:0:{}s:10:" * visible";a:0:{}s:11:" * fillable";a:0:{}s:10:" * guarded";a:0:{}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-06";s:13:"created_until";s:10:"2026-05-31";}}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-06";s:13:"created_until";s:10:"2026-05-31";}}s:9:" * export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:2;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * formats";a:1:{i:0;E:48:"Filament\\Actions\\Exports\\Enums\\ExportFormat:Xlsx";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-06";s:13:"created_until";s:10:"2026-05-31";}s:12:" * authGuard";s:3:"web";}";}s:19:"chainCatchCallbacks";a:0:{}}}s:8:"function";s:266:"function (\\Illuminate\\Bus\\Batch $batch) use ($next) {
                if (! $batch->cancelled()) {
                    \\Illuminate\\Container\\Container::getInstance()->make(\\Illuminate\\Contracts\\Bus\\Dispatcher::class)->dispatch($next);
                }
            }";s:5:"scope";s:27:"Illuminate\\Bus\\ChainedBatch";s:4:"this";N;s:4:"self";s:32:"0000000000000d370000000000000000";}";s:4:"hash";s:44:"xD+NfPLE49MG4/Fo1MAgFeitjj2rNnpVX88/Jg19/4s=";}}}}', NULL, 1779805586, 1779805586),
('a1df545e-b688-4a94-a368-873286ff5b0c', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:7993:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:1:{s:4:"next";O:44:"Filament\\Actions\\Exports\\Jobs\\CreateXlsxFile":6:{s:11:" * exporter";O:41:"App\\Filament\\Exports\\SubscriptionExporter":3:{s:9:" * export";O:38:"Filament\\Actions\\Exports\\Models\\Export":35:{s:13:" * connection";s:5:"mysql";s:8:" * table";N;s:13:" * primaryKey";s:2:"id";s:10:" * keyType";s:3:"int";s:12:"incrementing";b:1;s:7:" * with";a:0:{}s:12:" * withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:" * perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:" * escapeWhenCastingToString";b:0;s:13:" * attributes";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:27:32";s:10:"created_at";s:19:"2026-05-26 14:27:32";s:2:"id";i:3;s:9:"file_name";s:22:"export-3-subscriptions";}s:11:" * original";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:27:32";s:10:"created_at";s:19:"2026-05-26 14:27:32";s:2:"id";i:3;s:9:"file_name";s:22:"export-3-subscriptions";}s:10:" * changes";a:1:{s:9:"file_name";s:22:"export-3-subscriptions";}s:11:" * previous";a:0:{}s:8:" * casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:" * classCastCache";a:0:{}s:21:" * attributeCastCache";a:0:{}s:13:" * dateFormat";N;s:10:" * appends";a:0:{}s:19:" * dispatchesEvents";a:0:{}s:14:" * observables";a:0:{}s:12:" * relations";a:0:{}s:10:" * touches";a:0:{}s:27:" * relationAutoloadCallback";N;s:26:" * relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:" * hidden";a:0:{}s:10:" * visible";a:0:{}s:11:" * fillable";a:0:{}s:10:" * guarded";a:0:{}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:9:" * export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:3;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}s:7:"chained";a:1:{i:0;s:3778:"O:46:"Filament\\Actions\\Exports\\Jobs\\ExportCompletion":6:{s:11:" * exporter";O:41:"App\\Filament\\Exports\\SubscriptionExporter":3:{s:9:" * export";O:38:"Filament\\Actions\\Exports\\Models\\Export":35:{s:13:" * connection";s:5:"mysql";s:8:" * table";N;s:13:" * primaryKey";s:2:"id";s:10:" * keyType";s:3:"int";s:12:"incrementing";b:1;s:7:" * with";a:0:{}s:12:" * withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:" * perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:" * escapeWhenCastingToString";b:0;s:13:" * attributes";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:27:32";s:10:"created_at";s:19:"2026-05-26 14:27:32";s:2:"id";i:3;s:9:"file_name";s:22:"export-3-subscriptions";}s:11:" * original";a:8:{s:7:"user_id";i:1;s:8:"exporter";s:41:"App\\Filament\\Exports\\SubscriptionExporter";s:10:"total_rows";i:5;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-05-26 14:27:32";s:10:"created_at";s:19:"2026-05-26 14:27:32";s:2:"id";i:3;s:9:"file_name";s:22:"export-3-subscriptions";}s:10:" * changes";a:1:{s:9:"file_name";s:22:"export-3-subscriptions";}s:11:" * previous";a:0:{}s:8:" * casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:" * classCastCache";a:0:{}s:21:" * attributeCastCache";a:0:{}s:13:" * dateFormat";N;s:10:" * appends";a:0:{}s:19:" * dispatchesEvents";a:0:{}s:14:" * observables";a:0:{}s:12:" * relations";a:0:{}s:10:" * touches";a:0:{}s:27:" * relationAutoloadCallback";N;s:26:" * relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:" * hidden";a:0:{}s:10:" * visible";a:0:{}s:11:" * fillable";a:0:{}s:10:" * guarded";a:0:{}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}}s:9:" * export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:3;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:" * columnMap";a:12:{s:2:"id";s:15:"Subscription ID";s:13:"customer.name";s:8:"Customer";s:12:"service.name";s:7:"Service";s:21:"service.platform.name";s:8:"Platform";s:14:"original_price";s:13:"Service Price";s:8:"discount";s:8:"Discount";s:11:"final_price";s:11:"Final Price";s:6:"status";s:6:"Status";s:10:"start_date";s:10:"Start Date";s:8:"end_date";s:8:"End Date";s:6:"remark";s:6:"Remark";s:10:"created_at";s:10:"Created At";}s:10:" * formats";a:1:{i:0;E:48:"Filament\\Actions\\Exports\\Enums\\ExportFormat:Xlsx";}s:10:" * options";a:2:{s:12:"created_from";s:10:"2026-05-01";s:13:"created_until";s:10:"2026-05-31";}s:12:" * authGuard";s:3:"web";}";}s:19:"chainCatchCallbacks";a:0:{}}}s:8:"function";s:266:"function (\\Illuminate\\Bus\\Batch $batch) use ($next) {
                if (! $batch->cancelled()) {
                    \\Illuminate\\Container\\Container::getInstance()->make(\\Illuminate\\Contracts\\Bus\\Dispatcher::class)->dispatch($next);
                }
            }";s:5:"scope";s:27:"Illuminate\\Bus\\ChainedBatch";s:4:"this";N;s:4:"self";s:32:"0000000000000ae50000000000000000";}";s:4:"hash";s:44:"QmWu2P76Iid9BzF3WjE2zDUSV1QN+FAi7P2nr0tXX4k=";}}}}', NULL, 1779805652, 1779805652);

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES 
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_05_26_000100_create_customers_table', 1),
(5, '2026_05_26_000110_create_platforms_table', 1),
(6, '2026_05_26_000120_create_servers_table', 1),
(7, '2026_05_26_000130_create_services_table', 1),
(8, '2026_05_26_000140_create_subscriptions_table', 1),
(9, '2026_05_26_000150_create_subscription_provisions_table', 1),
(10, '2026_05_26_000160_create_server_usage_logs_table', 1),
(11, '2026_05_26_000050_create_permission_tables', 2),
(12, '2026_05_26_000125_add_api_url_to_servers_table', 3),
(13, '2026_05_26_000170_add_outline_fields_to_subscription_provisions_table', 4),
(14, '2026_05_26_000175_add_pricing_fields_to_subscriptions_table', 5),
(15, '2026_05_26_000180_create_exports_table', 5),
(16, '2026_05_26_000190_create_notifications_table', 6);

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES 
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 1),
(3, 'App\\Models\\User', 1),
(4, 'App\\Models\\User', 1),
(5, 'App\\Models\\User', 1),
(6, 'App\\Models\\User', 1),
(7, 'App\\Models\\User', 1),
(8, 'App\\Models\\User', 1),
(9, 'App\\Models\\User', 1),
(10, 'App\\Models\\User', 1),
(11, 'App\\Models\\User', 1),
(12, 'App\\Models\\User', 1),
(13, 'App\\Models\\User', 1),
(14, 'App\\Models\\User', 1),
(15, 'App\\Models\\User', 1),
(16, 'App\\Models\\User', 1),
(17, 'App\\Models\\User', 1),
(18, 'App\\Models\\User', 1),
(19, 'App\\Models\\User', 1),
(20, 'App\\Models\\User', 1),
(21, 'App\\Models\\User', 1),
(22, 'App\\Models\\User', 1),
(23, 'App\\Models\\User', 1),
(24, 'App\\Models\\User', 1),
(25, 'App\\Models\\User', 1),
(26, 'App\\Models\\User', 1),
(27, 'App\\Models\\User', 1),
(28, 'App\\Models\\User', 1),
(29, 'App\\Models\\User', 1),
(30, 'App\\Models\\User', 1),
(31, 'App\\Models\\User', 1),
(32, 'App\\Models\\User', 1),
(33, 'App\\Models\\User', 1),
(34, 'App\\Models\\User', 1),
(35, 'App\\Models\\User', 1),
(36, 'App\\Models\\User', 1),
(37, 'App\\Models\\User', 1),
(38, 'App\\Models\\User', 1),
(39, 'App\\Models\\User', 1),
(40, 'App\\Models\\User', 1),
(41, 'App\\Models\\User', 1),
(42, 'App\\Models\\User', 1),
(43, 'App\\Models\\User', 1),
(44, 'App\\Models\\User', 1),
(45, 'App\\Models\\User', 1),
(46, 'App\\Models\\User', 1),
(47, 'App\\Models\\User', 1),
(48, 'App\\Models\\User', 1),
(49, 'App\\Models\\User', 1),
(50, 'App\\Models\\User', 1),
(51, 'App\\Models\\User', 1),
(52, 'App\\Models\\User', 1),
(53, 'App\\Models\\User', 1),
(54, 'App\\Models\\User', 1),
(55, 'App\\Models\\User', 1),
(56, 'App\\Models\\User', 1),
(57, 'App\\Models\\User', 1),
(58, 'App\\Models\\User', 1),
(59, 'App\\Models\\User', 1),
(60, 'App\\Models\\User', 1),
(61, 'App\\Models\\User', 1),
(62, 'App\\Models\\User', 1),
(63, 'App\\Models\\User', 1),
(64, 'App\\Models\\User', 1),
(65, 'App\\Models\\User', 1),
(66, 'App\\Models\\User', 1),
(67, 'App\\Models\\User', 1),
(68, 'App\\Models\\User', 1),
(69, 'App\\Models\\User', 1),
(70, 'App\\Models\\User', 1),
(71, 'App\\Models\\User', 1),
(72, 'App\\Models\\User', 1),
(73, 'App\\Models\\User', 1),
(74, 'App\\Models\\User', 1),
(75, 'App\\Models\\User', 1),
(76, 'App\\Models\\User', 1),
(77, 'App\\Models\\User', 1),
(78, 'App\\Models\\User', 1),
(79, 'App\\Models\\User', 1),
(80, 'App\\Models\\User', 1),
(81, 'App\\Models\\User', 1),
(82, 'App\\Models\\User', 1),
(83, 'App\\Models\\User', 1),
(84, 'App\\Models\\User', 1),
(85, 'App\\Models\\User', 1),
(86, 'App\\Models\\User', 1),
(87, 'App\\Models\\User', 1),
(88, 'App\\Models\\User', 1),
(89, 'App\\Models\\User', 1),
(90, 'App\\Models\\User', 1),
(91, 'App\\Models\\User', 1),
(92, 'App\\Models\\User', 1),
(93, 'App\\Models\\User', 1),
(94, 'App\\Models\\User', 1),
(95, 'App\\Models\\User', 1),
(96, 'App\\Models\\User', 1),
(97, 'App\\Models\\User', 1),
(98, 'App\\Models\\User', 1),
(99, 'App\\Models\\User', 1);

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES 
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2);

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES 
('1b77ffc4-2737-4b3f-b0d6-ff907898d1c7', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 1, '{"actions":[{"name":"download_xlsx","alpineClickHandler":null,"color":null,"event":null,"eventData":[],"dispatchDirection":false,"dispatchToComponent":null,"extraAttributes":[],"icon":null,"iconPosition":"before","iconSize":null,"isOutlined":false,"isDisabled":false,"label":"Download .xlsx","shouldClose":false,"shouldMarkAsRead":true,"shouldMarkAsUnread":false,"shouldOpenUrlInNewTab":true,"shouldPostToUrl":false,"size":"sm","tooltip":null,"url":"\\/filament\\/exports\\/3\\/download?authGuard=web&format=xlsx&signature=99a5273ec431a1136dd9d35fb9688bbe8a2de138347dd843b3e09479ed23e591","view":"filament::components.link"}],"body":"Your subscription export has completed and 5 rows exported.","color":null,"duration":"persistent","icon":"heroicon-o-check-circle","iconColor":"success","status":"success","title":"Export completed","view":null,"viewData":[],"format":"filament"}', '2026-05-26 14:29:11', '2026-05-26 14:27:32', '2026-05-26 14:29:11'),
('7b3c235b-6dfd-4060-a19e-f02981699f0e', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 1, '{"actions":[],"body":"1 active subscription(s) will expire on 27 May 2026. Please contact customers for renewal follow-up.","color":null,"duration":"persistent","icon":"heroicon-o-exclamation-circle","iconColor":"warning","status":"warning","title":"Subscriptions Expiring Tomorrow","view":null,"viewData":[],"format":"filament"}', NULL, '2026-05-26 15:08:18', '2026-05-26 15:08:18'),
('9887ff24-95bd-4689-9a2e-d3aa851c9856', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 2, '{"actions":[],"body":"1 active subscription(s) will expire on 27 May 2026. Please contact customers for renewal follow-up.","color":null,"duration":"persistent","icon":"heroicon-o-exclamation-circle","iconColor":"warning","status":"warning","title":"Subscriptions Expiring Tomorrow","view":null,"viewData":[],"format":"filament"}', NULL, '2026-05-26 15:08:18', '2026-05-26 15:08:18');

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES 
(1, 'ViewAny:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(2, 'View:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(3, 'Create:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(4, 'Update:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(5, 'Delete:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(6, 'DeleteAny:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(7, 'Restore:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(8, 'ForceDelete:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(9, 'ForceDeleteAny:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(10, 'RestoreAny:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(11, 'Replicate:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(12, 'Reorder:Customer', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(13, 'ViewAny:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(14, 'View:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(15, 'Create:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(16, 'Update:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(17, 'Delete:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(18, 'DeleteAny:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(19, 'Restore:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(20, 'ForceDelete:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(21, 'ForceDeleteAny:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(22, 'RestoreAny:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(23, 'Replicate:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(24, 'Reorder:Platform', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(25, 'ViewAny:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(26, 'View:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(27, 'Create:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(28, 'Update:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(29, 'Delete:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(30, 'DeleteAny:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(31, 'Restore:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(32, 'ForceDelete:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(33, 'ForceDeleteAny:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(34, 'RestoreAny:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(35, 'Replicate:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(36, 'Reorder:Server', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(37, 'ViewAny:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(38, 'View:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(39, 'Create:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(40, 'Update:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(41, 'Delete:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(42, 'DeleteAny:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(43, 'Restore:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(44, 'ForceDelete:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(45, 'ForceDeleteAny:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(46, 'RestoreAny:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(47, 'Replicate:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(48, 'Reorder:Service', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(49, 'ViewAny:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(50, 'View:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(51, 'Create:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(52, 'Update:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(53, 'Delete:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(54, 'DeleteAny:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(55, 'Restore:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(56, 'ForceDelete:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(57, 'ForceDeleteAny:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(58, 'RestoreAny:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(59, 'Replicate:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(60, 'Reorder:SubscriptionProvision', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(61, 'ViewAny:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(62, 'View:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(63, 'Create:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(64, 'Update:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(65, 'Delete:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(66, 'DeleteAny:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(67, 'Restore:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(68, 'ForceDelete:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(69, 'ForceDeleteAny:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(70, 'RestoreAny:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(71, 'Replicate:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(72, 'Reorder:Subscription', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(73, 'ViewAny:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(74, 'View:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(75, 'Create:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(76, 'Update:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(77, 'Delete:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(78, 'DeleteAny:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(79, 'Restore:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(80, 'ForceDelete:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(81, 'ForceDeleteAny:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(82, 'RestoreAny:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(83, 'Replicate:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(84, 'Reorder:Role', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(85, 'View:ListLogs', 'web', '2026-05-26 12:35:26', '2026-05-26 12:35:26'),
(86, 'View:ViewLog', 'web', '2026-05-26 12:35:26', '2026-05-26 12:35:26'),
(87, 'ViewLogs', 'web', '2026-05-26 12:35:26', '2026-05-26 12:35:26'),
(88, 'ViewAny:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(89, 'View:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(90, 'Create:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(91, 'Update:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(92, 'Delete:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(93, 'DeleteAny:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(94, 'Restore:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(95, 'ForceDelete:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(96, 'ForceDeleteAny:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(97, 'RestoreAny:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(98, 'Replicate:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24'),
(99, 'Reorder:User', 'web', '2026-05-26 13:38:24', '2026-05-26 13:38:24');

INSERT INTO `platforms` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (1, 'Outline VPN', NULL, '2026-05-26 12:48:49', '2026-05-26 12:48:49');

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(37, 2),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(42, 2),
(43, 2),
(44, 2),
(45, 2),
(46, 2),
(47, 2),
(48, 2),
(49, 2),
(50, 2),
(51, 2),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(56, 2),
(57, 2),
(58, 2),
(59, 2),
(60, 2),
(61, 2),
(62, 2),
(63, 2),
(64, 2),
(65, 2),
(66, 2),
(67, 2),
(68, 2),
(69, 2),
(70, 2),
(71, 2),
(72, 2),
(1, 3),
(2, 3),
(13, 3),
(14, 3),
(25, 3),
(26, 3),
(37, 3),
(38, 3),
(49, 3),
(50, 3),
(61, 3),
(62, 3),
(73, 3),
(74, 3),
(85, 3),
(86, 3),
(87, 3),
(88, 3),
(89, 3);

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES 
(1, 'super_admin', 'web', '2026-05-26 12:35:25', '2026-05-26 12:35:25'),
(2, 'admin', 'web', '2026-05-26 12:36:14', '2026-05-26 12:36:14'),
(3, 'support', 'web', '2026-05-26 12:36:14', '2026-05-26 12:36:14');

INSERT INTO `servers` (`id`, `platform_id`, `name`, `ip`, `api_url`, `region`, `price`, `capacity`, `is_active`, `created_at`, `updated_at`) VALUES (1, 1, 'Outline-sgp-1cpu-1gb-1', '152.42.176.34', 'https://152.42.176.34:10743/mmUJocZgY3_qbBT3-A0wkw', 'singapore', 6.00, 25, 1, '2026-05-26 12:50:06', '2026-05-26 13:47:33');

INSERT INTO `services` (`id`, `platform_id`, `name`, `duration_days`, `price`, `region`, `is_active`, `created_at`, `updated_at`) VALUES 
(1, 1, 'Outline VPN 30 Days (Singapore)', 30, 5000.00, 'singapore', 1, '2026-05-26 12:50:33', '2026-05-26 12:50:33'),
(2, 1, 'Outline VPN 60 Days (Singapore)', 60, 10000.00, 'singapore', 1, '2026-05-26 14:03:29', '2026-05-26 14:03:29');

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES 
('iF4AzkwHSi1nsT4KYiwahG9lCHSdQJBaIg3dAuZY', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo4OntzOjM6InVybCI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi91c2Vycy8yL2VkaXQiO3M6NToicm91dGUiO3M6MzU6ImZpbGFtZW50LmFkbWluLnJlc291cmNlcy51c2Vycy5lZGl0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo2OiJfdG9rZW4iO3M6NDA6IjFKZVNXYWNqRWtQbmZuWHJUSWZQZlNqdFBZTk9NcVh5U1F1NUh2YlciO3M6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6ImNiMmYxZWM3ZTE4NmUyY2YwZTllNDhmNmVhNzBjZjhmMWRkNzFjY2JmNTBiZjcwY2JhODU0NzBhNzBmZGE5MDAiO3M6NjoidGFibGVzIjthOjExOntzOjQwOiI1ZGEwMmYxZjYzZjgxNzNkYTgzZWVhOTZlMzc5OWE0N19jb2x1bW5zIjthOjk6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoyOiJpZCI7czo1OiJsYWJlbCI7czoxNToiU3Vic2NyaXB0aW9uIElEIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoiY3VzdG9tZXIubmFtZSI7czo1OiJsYWJlbCI7czo4OiJDdXN0b21lciI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTI6InNlcnZpY2UubmFtZSI7czo1OiJsYWJlbCI7czo3OiJTZXJ2aWNlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoyMToic2VydmljZS5wbGF0Zm9ybS5uYW1lIjtzOjU6ImxhYmVsIjtzOjg6IlBsYXRmb3JtIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMToiZmluYWxfcHJpY2UiO3M6NToibGFiZWwiO3M6MTE6IkZpbmFsIFByaWNlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJzdGF0dXMiO3M6NToibGFiZWwiO3M6NjoiU3RhdHVzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoic3RhcnRfZGF0ZSI7czo1OiJsYWJlbCI7czoxMDoiU3RhcnQgZGF0ZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjc7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6ODoiZW5kX2RhdGUiO3M6NToibGFiZWwiO3M6ODoiRW5kIGRhdGUiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo4O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjIyOiJwcm92aXNpb25zLnNlcnZlci5uYW1lIjtzOjU6ImxhYmVsIjtzOjY6IlNlcnZlciI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiZTY0NDgzM2Y0ZTRlMDg3MTIzMTVkYTcxYjMzZmFjZDJfY29sdW1ucyI7YTo0OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtZSI7czo1OiJsYWJlbCI7czo0OiJOYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJlbWFpbCI7czo1OiJsYWJlbCI7czo1OiJFbWFpbCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6InJvbGVzLm5hbWUiO3M6NToibGFiZWwiO3M6NToiUm9sZXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjU6ImxhYmVsIjtzOjEwOiJDcmVhdGVkIGF0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX1zOjQwOiIyM2IwNzQ0ZjcwZmI4N2JlMDQ3NWE5MmJiY2JhOThkNV9jb2x1bW5zIjthOjEwOntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoiZGF0ZSI7czo1OiJsYWJlbCI7czo0OiJEYXRlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czozOiJhbGwiO3M6NToibGFiZWwiO3M6NDUzOiI8c3ZnIHN0eWxlPSJjb2xvcjogIzhBOEE4QSIgY2xhc3M9ImZpLWljb24gZmktc2l6ZS1zbSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTYgMTYiIGZpbGw9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiIGRhdGEtc2xvdD0iaWNvbiI+CiAgPHBhdGggZD0iTTMgNC43NWExIDEgMCAxIDAgMC0yIDEgMSAwIDAgMCAwIDJaTTYuMjUgM2EuNzUuNzUgMCAwIDAgMCAxLjVoN2EuNzUuNzUgMCAwIDAgMC0xLjVoLTdaTTYuMjUgNy4yNWEuNzUuNzUgMCAwIDAgMCAxLjVoN2EuNzUuNzUgMCAwIDAgMC0xLjVoLTdaTTYuMjUgMTEuNWEuNzUuNzUgMCAwIDAgMCAxLjVoN2EuNzUuNzUgMCAwIDAgMC0xLjVoLTdaTTQgMTIuMjVhMSAxIDAgMSAxLTIgMCAxIDEgMCAwIDEgMiAwWk0zIDlhMSAxIDAgMSAwIDAtMiAxIDEgMCAwIDAgMCAyWiIvPgo8L3N2Zz4iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjk6ImVtZXJnZW5jeSI7czo1OiJsYWJlbCI7czoxNTQ5OiI8c3ZnIHN0eWxlPSJjb2xvcjogI0I3MUMxQyIgY2xhc3M9ImZpLWljb24gZmktc2l6ZS1zbSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTYgMTYiIGZpbGw9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiIGRhdGEtc2xvdD0iaWNvbiI+CiAgPHBhdGggZD0iTTExLjk4MyAxLjM2NGEuNzUuNzUgMCAwIDAtMS4yODEuNzhjLjA5Ni4xNTguMTg0LjMyMS4yNjQuNDg5YTUuNDggNS40OCAwIDAgMS0uNzEzLjM4NkEyLjk5MyAyLjk5MyAwIDAgMCA4IDJjLS44OTggMC0xLjcwMy4zOTQtMi4yNTMgMS4wMmE1LjQ4NSA1LjQ4NSAwIDAgMS0uNzEzLS4zODdjLjA4LS4xNjguMTY4LS4zMy4yNjQtLjQ4OWEuNzUuNzUgMCAxIDAtMS4yOC0uNzhjLS4yNDUuNDAxLS40NS44My0uNjEgMS4yNzhhLjc1Ljc1IDAgMCAwIC4yMzkuODQgNyA3IDAgMCAwIDEuNDIyLjg3NkEzLjAxIDMuMDEgMCAwIDAgNSA1YzAgLjEyNi4wNzIuMjQuMTgzLjMuMzg2LjIwNS43OTYuMzcgMS4yMjcuNDg3LS4xMjYuMTY1LS4yMjcuMzUtLjI5Ny41NDlBMTAuNDE4IDEwLjQxOCAwIDAgMSAzLjUxIDUuNWExMC42ODYgMTAuNjg2IDAgMCAxLS4wMDgtLjczMy43NS43NSAwIDAgMC0xLjUtLjAzMyAxMi4yMjIgMTIuMjIyIDAgMCAwIC4wNDEgMS4zMS43NS43NSAwIDAgMCAuNC42QTExLjkyMiAxMS45MjIgMCAwIDAgNi4xOTkgNy44N2MuMDQuMDg0LjA4OC4xNjYuMTQuMjQzbC0uMjE0LjAzMS0uMDI3LjAwNWMtMS4yOTkuMjA3LTIuNTI5LjYyMi0zLjY1NCAxLjIxMWEuNzUuNzUgMCAwIDAtLjQuNiAxMi4xNDggMTIuMTQ4IDAgMCAwIC4xOTcgMy40NDMuNzUuNzUgMCAwIDAgMS40Ny0uMjk5IDEwLjU1MSAxMC41NTEgMCAwIDEtLjItMi42Yy4zNTItLjE2Ny43MTQtLjMxNCAxLjA4NS0uNDQxLS4wNjMuMy0uMDk2LjYxNC0uMDk2LjkzNiAwIDIuMjEgMS41NjcgNCAzLjUgNHMzLjUtMS43OSAzLjUtNGMwLS4zMjItLjAzNC0uNjM2LS4wOTctLjkzNy4zNzIuMTI4LjczNC4yNzUgMS4wODUuNDQyYTEwLjcwMyAxMC43MDMgMCAwIDEtLjE5OSAyLjYuNzUuNzUgMCAxIDAgMS40Ny4zIDEyLjA0OSAxMi4wNDkgMCAwIDAgLjE5Ny0zLjQ0My43NS43NSAwIDAgMC0uNC0uNiAxMS45MjEgMTEuOTIxIDAgMCAwLTMuNjcxLTEuMjE1bC0uMDExLS4wMDJhMTEuOTUgMTEuOTUgMCAwIDAtLjIxMy0uMDNjLjA1Mi0uMDc4LjEtLjE2LjE0LS4yNDQgMS4zMzYtLjIwMiAyLjYtLjYyMyAzLjc1NS0xLjIyN2EuNzUuNzUgMCAwIDAgLjQtLjYgMTIuMTc4IDEyLjE3OCAwIDAgMCAuMDQxLTEuMzEuNzUuNzUgMCAwIDAtMS41LjAzMyAxMS4wNjEgMTEuMDYxIDAgMCAxLS4wMDguNzMzYy0uODE1LjM4Ni0xLjY4OC42Ny0yLjYwMi44MzYtLjA3LS4yLS4xNy0uMzg0LS4yOTctLjU1LjQzLS4xMTcuODQyLS4yODIgMS4yMjgtLjQ4OEEuMzQuMzQgMCAwIDAgMTEgNWMwLS4yMi0uMDI0LS40MzUtLjA2OS0uNjQyYTcgNyAwIDAgMCAxLjQyMi0uODc2Ljc1Ljc1IDAgMCAwIC4yNC0uODQgNi45NyA2Ljk3IDAgMCAwLS42MS0xLjI3OFoiLz4KPC9zdmc+IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJhbGVydCI7czo1OiJsYWJlbCI7czo2NDU6Ijxzdmcgc3R5bGU9ImNvbG9yOiAjRDMyRjJGIiBjbGFzcz0iZmktaWNvbiBmaS1zaXplLXNtIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSIgZGF0YS1zbG90PSJpY29uIj4KICA8cGF0aCBkPSJNMTMuNDA3IDIuNTlhLjc1Ljc1IDAgMCAwLTEuNDY0LjMyNmMuMzY1IDEuNjM2LjU1NyAzLjMzNy41NTcgNS4wODQgMCAxLjc0Ny0uMTkyIDMuNDQ4LS41NTcgNS4wODRhLjc1Ljc1IDAgMCAwIDEuNDY0LjMyN2MuMjY0LTEuMTg1LjQ0NC0yLjQwMi41MzEtMy42NDRhMiAyIDAgMCAwIDAtMy41MzQgMjQuNzM2IDI0LjczNiAwIDAgMC0uNTMxLTMuNjQzWk00LjM0OCAxMUg0YTMgMyAwIDAgMSAwLTZoMmMxLjY0NyAwIDMuMjE3LS4zMzIgNC42NDYtLjkzM0MxMC44NzggNS4zNDEgMTEgNi42NTUgMTEgOGMwIDEuMzQ1LS4xMjIgMi42NTktLjM1NCAzLjkzM2ExMS45NDYgMTEuOTQ2IDAgMCAwLTQuMjMtLjkyNWMuMjAzLjcxOC40NzggMS40MDcuODE2IDIuMDU3LjEyLjIzLjA1Ny41MTUtLjE1NS42NjNsLS44MjguNThhLjQ4NC40ODQgMCAwIDEtLjcwNy0uMTZBMTIuOTEgMTIuOTEgMCAwIDEgNC4zNDggMTFaIi8+Cjwvc3ZnPiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6ODoiY3JpdGljYWwiO3M6NToibGFiZWwiO3M6NjYyOiI8c3ZnIHN0eWxlPSJjb2xvcjogI0Y0NDMzNiIgY2xhc3M9ImZpLWljb24gZmktc2l6ZS1zbSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTYgMTYiIGZpbGw9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiIGRhdGEtc2xvdD0iaWNvbiI+CiAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNOC4wNzQuOTQ1QTQuOTkzIDQuOTkzIDAgMCAwIDYgNXYuMDMyYy4wMDQuNi4xMTQgMS4xNzYuMzExIDEuNzA5LjE2LjQyOC0uMjA0LjkxLS42MS43YTUuMDIzIDUuMDIzIDAgMCAxLTEuODY4LTEuNjc3Yy0uMjAyLS4zMDQtLjY0OC0uMzYzLS44NDgtLjA1OGE2IDYgMCAxIDAgOC4wMTctMS45MDFsLS4wMDQtLjAwN2E0Ljk4IDQuOTggMCAwIDEtMi4xOC0yLjU3NGMtLjExNi0uMzEtLjQ3Ny0uNDcyLS43NDQtLjI4Wm0uNzggNi4xNzhhMy4wMDEgMy4wMDEgMCAxIDEtMy40NzMgNC4zNDFjLS4yMDUtLjM2NS4yMTUtLjY5NC42Mi0uNTlhNC4wMDggNC4wMDggMCAwIDAgMS44NzMuMDNjLjI4OC0uMDY1LjQxMy0uMzg2LjMyMS0uNjY2QTMuOTk3IDMuOTk3IDAgMCAxIDggOC45OTljMC0uNTg1LjEyNi0xLjE0LjM1MS0xLjY0MWEuNDIuNDIgMCAwIDEgLjUwMy0uMjM1WiIgY2xpcC1ydWxlPSJldmVub2RkIi8+Cjwvc3ZnPiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToiZXJyb3IiO3M6NToibGFiZWwiO3M6NDUyOiI8c3ZnIHN0eWxlPSJjb2xvcjogI0ZGNTcyMiIgY2xhc3M9ImZpLWljb24gZmktc2l6ZS1zbSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTYgMTYiIGZpbGw9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiIGRhdGEtc2xvdD0iaWNvbiI+CiAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNOCAxNUE3IDcgMCAxIDAgOCAxYTcgNyAwIDAgMCAwIDE0Wm0yLjc4LTQuMjJhLjc1Ljc1IDAgMCAxLTEuMDYgMEw4IDkuMDZsLTEuNzIgMS43MmEuNzUuNzUgMCAxIDEtMS4wNi0xLjA2TDYuOTQgOCA1LjIyIDYuMjhhLjc1Ljc1IDAgMCAxIDEuMDYtMS4wNkw4IDYuOTRsMS43Mi0xLjcyYS43NS43NSAwIDEgMSAxLjA2IDEuMDZMOS4wNiA4bDEuNzIgMS43MmEuNzUuNzUgMCAwIDEgMCAxLjA2WiIgY2xpcC1ydWxlPSJldmVub2RkIi8+Cjwvc3ZnPiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6Nzoid2FybmluZyI7czo1OiJsYWJlbCI7czo0MzE6Ijxzdmcgc3R5bGU9ImNvbG9yOiAjRkY5MTAwIiBjbGFzcz0iZmktaWNvbiBmaS1zaXplLXNtIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSIgZGF0YS1zbG90PSJpY29uIj4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik02LjcwMSAyLjI1Yy41NzctMSAyLjAyLTEgMi41OTggMGw1LjE5NiA5YTEuNSAxLjUgMCAwIDEtMS4yOTkgMi4yNUgyLjgwNGExLjUgMS41IDAgMCAxLTEuMy0yLjI1bDUuMTk3LTlaTTggNGEuNzUuNzUgMCAwIDEgLjc1Ljc1djNhLjc1Ljc1IDAgMSAxLTEuNSAwdi0zQS43NS43NSAwIDAgMSA4IDRabTAgOGExIDEgMCAxIDAgMC0yIDEgMSAwIDAgMCAwIDJaIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiLz4KPC9zdmc+IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJub3RpY2UiO3M6NToibGFiZWwiO3M6MzYyOiI8c3ZnIHN0eWxlPSJjb2xvcjogIzRDQUY1MCIgY2xhc3M9ImZpLWljb24gZmktc2l6ZS1zbSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTYgMTYiIGZpbGw9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiIGRhdGEtc2xvdD0iaWNvbiI+CiAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNOCAxNUE3IDcgMCAxIDAgOCAxYTcgNyAwIDAgMCAwIDE0Wk04IDRhLjc1Ljc1IDAgMCAxIC43NS43NXYzYS43NS43NSAwIDAgMS0xLjUgMHYtM0EuNzUuNzUgMCAwIDEgOCA0Wm0wIDhhMSAxIDAgMSAwIDAtMiAxIDEgMCAwIDAgMCAyWiIgY2xpcC1ydWxlPSJldmVub2RkIi8+Cjwvc3ZnPiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjg7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoiaW5mbyI7czo1OiJsYWJlbCI7czozODE6Ijxzdmcgc3R5bGU9ImNvbG9yOiAjMTk3NkQyIiBjbGFzcz0iZmktaWNvbiBmaS1zaXplLXNtIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSIgZGF0YS1zbG90PSJpY29uIj4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xNSA4QTcgNyAwIDEgMSAxIDhhNyA3IDAgMCAxIDE0IDBaTTkgNWExIDEgMCAxIDEtMiAwIDEgMSAwIDAgMSAyIDBaTTYuNzUgOGEuNzUuNzUgMCAwIDAgMCAxLjVoLjc1djEuNzVhLjc1Ljc1IDAgMCAwIDEuNSAwdi0yLjVBLjc1Ljc1IDAgMCAwIDguMjUgOGgtMS41WiIgY2xpcC1ydWxlPSJldmVub2RkIi8+Cjwvc3ZnPiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjk7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToiZGVidWciO3M6NToibGFiZWwiO3M6NDc5OiI8c3ZnIHN0eWxlPSJjb2xvcjogIzkwQ0FGOSIgY2xhc3M9ImZpLWljb24gZmktc2l6ZS1zbSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTYgMTYiIGZpbGw9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiIGRhdGEtc2xvdD0iaWNvbiI+CiAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNMiA0YTIgMiAwIDAgMSAyLTJoOGEyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkg0YTIgMiAwIDAgMS0yLTJWNFptMi4yMiAxLjk3YS43NS43NSAwIDAgMCAwIDEuMDZsLjk3Ljk3LS45Ny45N2EuNzUuNzUgMCAxIDAgMS4wNiAxLjA2bDEuNS0xLjVhLjc1Ljc1IDAgMCAwIDAtMS4wNmwtMS41LTEuNWEuNzUuNzUgMCAwIDAtMS4wNiAwWk04Ljc1IDguNWEuNzUuNzUgMCAwIDAgMCAxLjVoMi41YS43NS43NSAwIDAgMCAwLTEuNWgtMi41WiIgY2xpcC1ydWxlPSJldmVub2RkIi8+Cjwvc3ZnPiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiNzFjOWU4MWIyMzZkNTdlMzVjYmIyMWFiMWU5YTRjNDNfY29sdW1ucyI7YTo1OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtZSI7czo1OiJsYWJlbCI7czo0OiJOYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiZ3VhcmRfbmFtZSI7czo1OiJsYWJlbCI7czoxMDoiR3VhcmQgTmFtZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6OToidGVhbS5uYW1lIjtzOjU6ImxhYmVsIjtzOjQ6IlRlYW0iO3M6ODoiaXNIaWRkZW4iO2I6MTtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE3OiJwZXJtaXNzaW9uc19jb3VudCI7czo1OiJsYWJlbCI7czoxMToiUGVybWlzc2lvbnMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjU6ImxhYmVsIjtzOjEwOiJVcGRhdGVkIEF0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX1zOjQwOiIzMTU3NGEyMzNhNDVjNTQ0YWFhYzRkYWE3N2Y2ZjEzMF9jb2x1bW5zIjthOjk6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoicGxhdGZvcm0ubmFtZSI7czo1OiJsYWJlbCI7czo4OiJQbGF0Zm9ybSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtZSI7czo1OiJsYWJlbCI7czo0OiJOYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoyOiJpcCI7czo1OiJsYWJlbCI7czoxMDoiSVAgQWRkcmVzcyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NzoiYXBpX3VybCI7czo1OiJsYWJlbCI7czo3OiJBUEkgVVJMIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InJlZ2lvbiI7czo1OiJsYWJlbCI7czo2OiJSZWdpb24iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo1O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6InByaWNlIjtzOjU6ImxhYmVsIjtzOjU6IlByaWNlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo4OiJjYXBhY2l0eSI7czo1OiJsYWJlbCI7czo4OiJDYXBhY2l0eSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjc7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MjM6ImFjdGl2ZV9wcm92aXNpb25zX2NvdW50IjtzOjU6ImxhYmVsIjtzOjEwOiJQcm92aXNpb25zIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6ODthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo5OiJpc19hY3RpdmUiO3M6NToibGFiZWwiO3M6NjoiU3RhdHVzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX1zOjQwOiIxNWMxYTIzYjg2NmY0NTA0MjU4ODExY2MyMjJmYjliMF9jb2x1bW5zIjthOjY6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoicGxhdGZvcm0ubmFtZSI7czo1OiJsYWJlbCI7czo4OiJQbGF0Zm9ybSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtZSI7czo1OiJsYWJlbCI7czo0OiJOYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoiZHVyYXRpb25fZGF5cyI7czo1OiJsYWJlbCI7czoxMzoiRHVyYXRpb24gZGF5cyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToicHJpY2UiO3M6NToibGFiZWwiO3M6NToiUHJpY2UiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InJlZ2lvbiI7czo1OiJsYWJlbCI7czo2OiJSZWdpb24iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo1O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjk6ImlzX2FjdGl2ZSI7czo1OiJsYWJlbCI7czo2OiJTdGF0dXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6IjBmMjU5ZTBjNTVhNmU5YjQ0ZjdmOTJjZjBiMjlmYzA2X2NvbHVtbnMiO2E6MTA6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxNToic3Vic2NyaXB0aW9uLmlkIjtzOjU6ImxhYmVsIjtzOjE1OiJTdWJzY3JpcHRpb24gSUQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjI2OiJzdWJzY3JpcHRpb24uY3VzdG9tZXIubmFtZSI7czo1OiJsYWJlbCI7czo4OiJDdXN0b21lciI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTE6InNlcnZlci5uYW1lIjtzOjU6ImxhYmVsIjtzOjY6IlNlcnZlciI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTY6ImV4dGVybmFsX3VzZXJfaWQiO3M6NToibGFiZWwiO3M6MTY6IkV4dGVybmFsIHVzZXIgaWQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MjE6Im91dGxpbmVfYWNjZXNzX2tleV9pZCI7czo1OiJsYWJlbCI7czoxNDoiT3V0bGluZSBLZXkgSUQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6ODoia2V5X25hbWUiO3M6NToibGFiZWwiO3M6ODoiS2V5IG5hbWUiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo2O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InN0YXR1cyI7czo1OiJsYWJlbCI7czo2OiJTdGF0dXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo3O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE2OiJkYXRhX2xpbWl0X2J5dGVzIjtzOjU6ImxhYmVsIjtzOjEwOiJEYXRhIExpbWl0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9aTo4O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE3OiJ0cmFuc2ZlcnJlZF9ieXRlcyI7czo1OiJsYWJlbCI7czoxMToiVHJhbnNmZXJyZWQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjowO31pOjk7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IkNyZWF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6IjU2MjJkOTVkMzQ0OTg0NmQxYzU1OWE4MTM0ZTJmN2U4X2NvbHVtbnMiO2E6Nzp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjExOiJzZXJ2ZXIubmFtZSI7czo1OiJsYWJlbCI7czo2OiJTZXJ2ZXIiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE2OiJleHRlcm5hbF91c2VyX2lkIjtzOjU6ImxhYmVsIjtzOjE2OiJFeHRlcm5hbCB1c2VyIGlkIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjg6ImtleV9uYW1lIjtzOjU6ImxhYmVsIjtzOjg6IktleSBuYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJzdGF0dXMiO3M6NToibGFiZWwiO3M6NjoiU3RhdHVzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiYWNjZXNzX2tleSI7czo1OiJsYWJlbCI7czoxMDoiQWNjZXNzIGtleSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTc6InRyYW5zZmVycmVkX2J5dGVzIjtzOjU6ImxhYmVsIjtzOjExOiJUcmFuc2ZlcnJlZCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IkNyZWF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6ImI4NDVkZDEwY2FlMWMwMmMwNzBlMWE2NDM2ZTExMDExX2NvbHVtbnMiO2E6NDp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWUiO3M6NToibGFiZWwiO3M6NDoiTmFtZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjU6ImxhYmVsIjtzOjExOiJEZXNjcmlwdGlvbiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjE7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtiOjA7fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoic2VydmVyc19jb3VudCI7czo1OiJsYWJlbCI7czo3OiJTZXJ2ZXJzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxNDoic2VydmljZXNfY291bnQiO3M6NToibGFiZWwiO3M6ODoiU2VydmljZXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6ImQ0MjJjOTUyNzE1MDFiZTEzNTJkOWNmZmI0YzczNzczX2NvbHVtbnMiO2E6Njp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWUiO3M6NToibGFiZWwiO3M6NDoiTmFtZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6ODoicGxhdGZvcm0iO3M6NToibGFiZWwiO3M6MTM6IkxlYWQgUGxhdGZvcm0iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6ImVtYWlsIjtzOjU6ImxhYmVsIjtzOjU6IkVtYWlsIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MDt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6InBob25lIjtzOjU6ImxhYmVsIjtzOjU6IlBob25lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MDt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE5OiJzdWJzY3JpcHRpb25zX2NvdW50IjtzOjU6ImxhYmVsIjtzOjEzOiJTdWJzY3JpcHRpb25zIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiY3JlYXRlZF9hdCI7czo1OiJsYWJlbCI7czoxMDoiQ3JlYXRlZCBhdCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjA7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjE7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtiOjE7fX1zOjQwOiI5YjZlODM2OTRkMmIzODJlOGQ4OTZmMGQ5Nzg2MDJlNV9jb2x1bW5zIjthOjc6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoyOiJpZCI7czo1OiJsYWJlbCI7czoxNToiU3Vic2NyaXB0aW9uIElEIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMjoic2VydmljZS5uYW1lIjtzOjU6ImxhYmVsIjtzOjc6IlNlcnZpY2UiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjIxOiJzZXJ2aWNlLnBsYXRmb3JtLm5hbWUiO3M6NToibGFiZWwiO3M6ODoiUGxhdGZvcm0iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InN0YXR1cyI7czo1OiJsYWJlbCI7czo2OiJTdGF0dXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEwOiJzdGFydF9kYXRlIjtzOjU6ImxhYmVsIjtzOjEwOiJTdGFydCBkYXRlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo4OiJlbmRfZGF0ZSI7czo1OiJsYWJlbCI7czo4OiJFbmQgZGF0ZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MjI6InByb3Zpc2lvbnMuc2VydmVyLm5hbWUiO3M6NToibGFiZWwiO3M6NjoiU2VydmVyIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX19czo4OiJmaWxhbWVudCI7YTowOnt9fQ==', 1779809457),
('VgtDeLg7JknfZKZ9yUOHf7xxNJju1UVt0rEwMC2O', 2, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiaHlrTHMwUHhmbWRhZ2p6cFdUcVA3STFsTEZPMzd2ZVc2YzNEN1JKNSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9zdWJzY3JpcHRpb24tcHJvdmlzaW9ucyI7czo1OiJyb3V0ZSI7czo1NDoiZmlsYW1lbnQuYWRtaW4ucmVzb3VyY2VzLnN1YnNjcmlwdGlvbi1wcm92aXNpb25zLmluZGV4Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiMDQwMzE3M2JmNTM4OTE2OTE1Njg5ZWExMTgwYmI1MDg3ZTYyZTRjZmYyYzE4ZmUyMWU5MDI2NTAzZTIxOTc5ZSI7czo2OiJ0YWJsZXMiO2E6NTp7czo0MDoiYjg0NWRkMTBjYWUxYzAyYzA3MGUxYTY0MzZlMTEwMTFfY29sdW1ucyI7YTo0OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtZSI7czo1OiJsYWJlbCI7czo0OiJOYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMToiZGVzY3JpcHRpb24iO3M6NToibGFiZWwiO3M6MTE6IkRlc2NyaXB0aW9uIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MDt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEzOiJzZXJ2ZXJzX2NvdW50IjtzOjU6ImxhYmVsIjtzOjc6IlNlcnZlcnMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE0OiJzZXJ2aWNlc19jb3VudCI7czo1OiJsYWJlbCI7czo4OiJTZXJ2aWNlcyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiMTVjMWEyM2I4NjZmNDUwNDI1ODgxMWNjMjIyZmI5YjBfY29sdW1ucyI7YTo2OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTM6InBsYXRmb3JtLm5hbWUiO3M6NToibGFiZWwiO3M6ODoiUGxhdGZvcm0iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWUiO3M6NToibGFiZWwiO3M6NDoiTmFtZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTM6ImR1cmF0aW9uX2RheXMiO3M6NToibGFiZWwiO3M6MTM6IkR1cmF0aW9uIGRheXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6InByaWNlIjtzOjU6ImxhYmVsIjtzOjU6IlByaWNlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJyZWdpb24iO3M6NToibGFiZWwiO3M6NjoiUmVnaW9uIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo5OiJpc19hY3RpdmUiO3M6NToibGFiZWwiO3M6NjoiU3RhdHVzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX1zOjQwOiJkNDIyYzk1MjcxNTAxYmUxMzUyZDljZmZiNGM3Mzc3M19jb2x1bW5zIjthOjY6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJuYW1lIjtzOjU6ImxhYmVsIjtzOjQ6Ik5hbWUiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjg6InBsYXRmb3JtIjtzOjU6ImxhYmVsIjtzOjEzOiJMZWFkIFBsYXRmb3JtIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJlbWFpbCI7czo1OiJsYWJlbCI7czo1OiJFbWFpbCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjE7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtiOjA7fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJwaG9uZSI7czo1OiJsYWJlbCI7czo1OiJQaG9uZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjE7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtiOjA7fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxOToic3Vic2NyaXB0aW9uc19jb3VudCI7czo1OiJsYWJlbCI7czoxMzoiU3Vic2NyaXB0aW9ucyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IkNyZWF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO319czo0MDoiNWRhMDJmMWY2M2Y4MTczZGE4M2VlYTk2ZTM3OTlhNDdfY29sdW1ucyI7YTo5OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MjoiaWQiO3M6NToibGFiZWwiO3M6MTU6IlN1YnNjcmlwdGlvbiBJRCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTM6ImN1c3RvbWVyLm5hbWUiO3M6NToibGFiZWwiO3M6ODoiQ3VzdG9tZXIiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEyOiJzZXJ2aWNlLm5hbWUiO3M6NToibGFiZWwiO3M6NzoiU2VydmljZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MjE6InNlcnZpY2UucGxhdGZvcm0ubmFtZSI7czo1OiJsYWJlbCI7czo4OiJQbGF0Zm9ybSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTE6ImZpbmFsX3ByaWNlIjtzOjU6ImxhYmVsIjtzOjExOiJGaW5hbCBQcmljZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6Njoic3RhdHVzIjtzOjU6ImxhYmVsIjtzOjY6IlN0YXR1cyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6InN0YXJ0X2RhdGUiO3M6NToibGFiZWwiO3M6MTA6IlN0YXJ0IGRhdGUiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo3O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjg6ImVuZF9kYXRlIjtzOjU6ImxhYmVsIjtzOjg6IkVuZCBkYXRlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6ODthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoyMjoicHJvdmlzaW9ucy5zZXJ2ZXIubmFtZSI7czo1OiJsYWJlbCI7czo2OiJTZXJ2ZXIiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6IjBmMjU5ZTBjNTVhNmU5YjQ0ZjdmOTJjZjBiMjlmYzA2X2NvbHVtbnMiO2E6MTA6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxNToic3Vic2NyaXB0aW9uLmlkIjtzOjU6ImxhYmVsIjtzOjE1OiJTdWJzY3JpcHRpb24gSUQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjI2OiJzdWJzY3JpcHRpb24uY3VzdG9tZXIubmFtZSI7czo1OiJsYWJlbCI7czo4OiJDdXN0b21lciI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTE6InNlcnZlci5uYW1lIjtzOjU6ImxhYmVsIjtzOjY6IlNlcnZlciI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTY6ImV4dGVybmFsX3VzZXJfaWQiO3M6NToibGFiZWwiO3M6MTY6IkV4dGVybmFsIHVzZXIgaWQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MjE6Im91dGxpbmVfYWNjZXNzX2tleV9pZCI7czo1OiJsYWJlbCI7czoxNDoiT3V0bGluZSBLZXkgSUQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6ODoia2V5X25hbWUiO3M6NToibGFiZWwiO3M6ODoiS2V5IG5hbWUiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo2O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InN0YXR1cyI7czo1OiJsYWJlbCI7czo2OiJTdGF0dXMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo3O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE2OiJkYXRhX2xpbWl0X2J5dGVzIjtzOjU6ImxhYmVsIjtzOjEwOiJEYXRhIExpbWl0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9aTo4O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE3OiJ0cmFuc2ZlcnJlZF9ieXRlcyI7czo1OiJsYWJlbCI7czoxMToiVHJhbnNmZXJyZWQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjowO31pOjk7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IkNyZWF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fX19', 1779810436);

INSERT INTO `subscription_provisions` (`id`, `subscription_id`, `server_id`, `outline_access_key_id`, `external_user_id`, `access_key`, `key_name`, `outline_method`, `outline_port`, `data_limit_bytes`, `transferred_bytes`, `last_synced_at`, `last_error`, `status`, `created_at`, `updated_at`) VALUES 
(1, 1, 1, NULL, 'vpn-1-fupb7wxppo37', 'ss://OY9ROZ2J2L6VDSPC8CDEGSWO5L93AMAP@152.42.176.34#SUB-1-Outline-sgp-1cpu-1gb-1', 'SUB-1-Outline-sgp-1cpu-1gb-1', NULL, NULL, NULL, 0, NULL, NULL, 'active', '2026-05-26 12:52:21', '2026-05-26 12:52:21'),
(2, 2, 1, NULL, 'vpn-1-vbcjx8cxm2u7', 'ss://TWXHDQMFYWFGFSA3HTDIYMQWHP8HEI9F@152.42.176.34#SUB-2-Outline-sgp-1cpu-1gb-1', 'SUB-2-Outline-sgp-1cpu-1gb-1', NULL, NULL, NULL, 0, NULL, NULL, 'active', '2026-05-26 12:58:16', '2026-05-26 12:58:16'),
(3, 4, 1, '4', '4', 'ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpVM2xXdldPSG5WR2k1MTJpZDFjdW9W@152.42.176.34:18365/?outline=1', 'SUB-4-Outline-sgp-1cpu-1gb-1', 'chacha20-ietf-poly1305', 18365, 10737418240, 26631621, '2026-05-26 14:09:51', NULL, 'active', '2026-05-26 13:58:41', '2026-05-26 14:09:51'),
(4, 5, 1, '5', '5', 'ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpMaU40d25mVVBMZ3lpUlBwNnVWUHg3@152.42.176.34:18365/?outline=1', 'testing-myserver-1', 'chacha20-ietf-poly1305', 18365, 107374182400, 0, '2026-05-26 14:09:19', NULL, 'active', '2026-05-26 14:04:01', '2026-05-26 14:09:19'),
(5, 6, 1, '6', '6', 'ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpwd1EyWUExWkJ2bmtNOFRTNUd1MlpC@152.42.176.34:18365/?outline=1', 'SUB-6-Outline-sgp-1cpu-1gb-1', 'chacha20-ietf-poly1305', 18365, NULL, 0, '2026-05-26 14:52:30', NULL, 'revoked', '2026-05-26 14:22:50', '2026-05-26 14:52:30'),
(6, 7, 1, '7', '7', 'ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpuTjdRVWdNdlloWXFmMzJLRThwblVl@152.42.176.34:18365/?outline=1', 'SUB-7-Outline-sgp-1cpu-1gb-1', 'chacha20-ietf-poly1305', 18365, NULL, 0, '2026-05-26 15:08:57', NULL, 'revoked', '2026-05-26 15:05:01', '2026-05-26 15:08:57');

INSERT INTO `subscriptions` (`id`, `customer_id`, `service_id`, `original_price`, `discount`, `final_price`, `remark`, `status`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES 
(1, 1, 1, 0.00, 0.00, 300000.00, NULL, 'active', '2026-05-26', '2026-06-25', '2026-04-25 12:52:21', '2026-05-26 12:52:21'),
(2, 2, 1, 0.00, 0.00, 40000.00, NULL, 'active', '2026-05-26', '2026-06-25', '2026-05-25 12:58:16', '2026-05-26 12:58:16'),
(4, 2, 1, 0.00, 0.00, 0.00, NULL, 'active', '2026-05-26', '2026-06-25', '2026-05-26 13:58:41', '2026-05-26 13:58:41'),
(5, 3, 2, 0.00, 0.00, 0.00, NULL, 'active', '2026-05-26', '2026-07-25', '2026-05-26 14:04:01', '2026-05-26 14:04:01'),
(6, 4, 1, 5000.00, 2000.00, 30000.00, 'test', 'active', '2026-06-27', '2026-06-25', '2026-05-26 14:22:50', '2026-05-26 14:22:50'),
(7, 2, 1, 5000.00, 0.00, 5000.00, NULL, 'expired', '2026-04-26', '2026-05-25', '2026-05-26 15:04:58', '2026-05-26 15:08:57');

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES 
(1, 'Axion Super Admin', 'admin@axionservice.shop', NULL, '$2y$12$NYJgdkZDzpB4ZefFbnhHa.DJ6mVFoiz3W9d8ikd9/v6AO.s61v7ie', 'Tml94mAVqYIzeHsmbdrZHpzIG1ZEbSYE3QU7WGrPecBvwSMJH5BMTWcdQfbc', '2026-05-26 12:36:14', '2026-05-26 13:38:24'),
(2, 'Admin', 'admin@admin.com', NULL, '$2y$12$ydKxcf5P.PSmmPOWinpCV.r4K7LLL9xOcP.reMOgGPfcvYoJKP4KS', 'RVkpjSPWjLxdeCtjUa0FEvtdQOc48Vu9zaxXPINO1qET5pAMbcMx8OUP0CzJ', '2026-05-26 13:39:16', '2026-05-26 13:39:16');


-- Restore original session settings
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET SQL_MODE=@OLD_SQL_MODE;
SET SQL_NOTES=@OLD_SQL_NOTES;
