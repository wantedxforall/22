-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 22, 2025 at 01:03 AM
-- Server version: 10.6.16-MariaDB-cll-lve
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sozllwze_123`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `api_token` varchar(64) DEFAULT NULL,
  `tsc` varchar(255) DEFAULT NULL,
  `ts` tinyint(1) DEFAULT 0,
  `tv` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `status`, `email_verified_at`, `image`, `password`, `remember_token`, `api_token`, `tsc`, `ts`, `tv`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@example.com', 'admin', 1, NULL, '6893b0836a6441754509443.png', '$2y$10$ZOWPSwbB7098UQHq/GZX5uGq43wfuDDjMBNASktSNK55T/4jC/xvy', 'JPq0OZbOMQTjzjh3LSywUIITwYnnznRBE7jWr2k2hKqkjoHJhRv5JMrZClM1', 'mMxKL7QZEJLqN3d1T2V1gesd3eg0rf04TrJjSVSvE5ktxZGtc4eip3uvUmNd', NULL, 0, 1, NULL, '2025-08-07 12:01:19');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `title` varchar(255) DEFAULT NULL,
  `read_status` tinyint(1) NOT NULL DEFAULT 0,
  `click_url` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_notifications`
--

INSERT INTO `admin_notifications` (`id`, `user_id`, `title`, `read_status`, `click_url`, `created_at`, `updated_at`) VALUES
(1, 1, 'New member registered', 1, '/admin/manage/users/detail/1', '2025-07-03 23:45:37', '2025-07-03 23:49:51'),
(2, 0, 'SMTP Error: Could not connect to SMTP host. Failed to connect to server', 1, '#', '2025-07-03 23:45:39', '2025-07-03 23:47:19'),
(3, 0, 'SMTP Error: Could not connect to SMTP host. Failed to connect to server', 0, '#', '2025-07-03 23:48:01', '2025-07-03 23:48:01'),
(4, 2, 'New member registered', 0, '/admin/manage/users/detail/2', '2025-07-03 23:48:18', '2025-07-03 23:48:18'),
(5, 0, 'SMTP Error: Could not connect to SMTP host. Failed to connect to server', 0, '#', '2025-07-03 23:48:20', '2025-07-03 23:48:20'),
(6, 0, 'SMTP Error: Could not connect to SMTP host. Failed to connect to server', 0, '#', '2025-07-03 23:50:23', '2025-07-03 23:50:23'),
(7, 0, 'SMTP Error: Could not connect to SMTP host. Failed to connect to server', 0, '#', '2025-07-03 21:05:46', '2025-07-03 21:05:46'),
(8, 3, 'New member registered', 0, '/admin/manage/users/detail/3', '2025-07-03 21:17:45', '2025-07-03 21:17:45'),
(9, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-07-03 21:32:41', '2025-07-03 21:32:41'),
(10, 4, 'New member registered', 0, '/admin/manage/users/detail/4', '2025-07-03 22:09:54', '2025-07-03 22:09:54'),
(11, 5, 'New member registered', 0, '/admin/manage/users/detail/5', '2025-07-03 23:57:54', '2025-07-03 23:57:54'),
(12, 4, 'Plan Subscribe from rrrrrr', 0, '/admin/manage/users/detail/4', '2025-07-16 08:57:21', '2025-07-16 08:57:21'),
(13, 6, 'New member registered', 0, '/admin/manage/users/detail/6', '2025-07-16 09:28:13', '2025-07-16 09:28:13'),
(14, 1, 'Plan Subscribe from mohammed', 0, '/admin/manage/users/detail/1', '2025-07-16 09:47:21', '2025-07-16 09:47:21'),
(15, 7, 'New member registered', 0, '/admin/manage/users/detail/7', '2025-07-16 11:14:57', '2025-07-16 11:14:57'),
(16, 1, 'Plan Subscribe from mohammed', 0, '/admin/manage/users/detail/1', '2025-07-16 23:38:26', '2025-07-16 23:38:26'),
(17, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-07-17 02:53:24', '2025-07-17 02:53:24'),
(18, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-07-17 02:54:55', '2025-07-17 02:54:55'),
(19, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-07-17 03:04:37', '2025-07-17 03:04:37'),
(20, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-07-17 12:32:05', '2025-07-17 12:32:05'),
(21, 3, 'New support ticket has opened', 0, '/admin/support/tickets/view/1', '2025-07-28 08:25:25', '2025-07-28 08:25:25'),
(22, 7, 'Deposit request from 212121', 0, '/admin/manage/deposits/details/5', '2025-07-28 12:06:46', '2025-07-28 12:06:46'),
(23, 7, 'Deposit request from 212121', 0, '/admin/manage/deposits/details/6', '2025-07-28 12:08:17', '2025-07-28 12:08:17'),
(24, 8, 'New member registered', 0, '/admin/manage/users/detail/8', '2025-07-31 23:16:54', '2025-07-31 23:16:54'),
(25, 9, 'New member registered', 0, '/admin/manage/users/detail/9', '2025-08-07 02:27:26', '2025-08-07 02:27:26'),
(26, 0, 'SMTP Error: Could not connect to SMTP host. Failed to connect to server', 0, '#', '2025-08-07 05:30:59', '2025-08-07 05:30:59'),
(27, 0, 'SMTP Error: Could not authenticate.', 0, '#', '2025-08-07 05:31:16', '2025-08-07 05:31:16'),
(28, 10, 'New member registered', 0, '/admin/manage/users/detail/10', '2025-08-07 06:08:56', '2025-08-07 06:08:56'),
(29, 10, 'Plan Subscribe from 1232323', 0, '/admin/manage/users/detail/10', '2025-08-15 16:39:23', '2025-08-15 16:39:23'),
(30, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 16:41:02', '2025-08-15 16:41:02'),
(31, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 16:55:53', '2025-08-15 16:55:53'),
(32, 2, 'Plan Subscribe from 123123', 0, 'http://127.0.0.1/admin/manage/users/detail/2', '2025-08-15 17:05:39', '2025-08-15 17:05:39'),
(33, 2, 'Plan Subscribe from 123123', 0, 'http://127.0.0.1/admin/manage/users/detail/2', '2025-08-15 17:06:02', '2025-08-15 17:06:02'),
(34, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 17:08:34', '2025-08-15 17:08:34'),
(35, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 17:11:45', '2025-08-15 17:11:45'),
(36, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 17:14:52', '2025-08-15 17:14:52'),
(37, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 19:15:33', '2025-08-15 19:15:33'),
(38, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 19:28:10', '2025-08-15 19:28:10'),
(39, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 20:08:21', '2025-08-15 20:08:21'),
(40, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 20:50:06', '2025-08-15 20:50:06'),
(41, 7, 'Plan Subscribe from 212121', 0, '/admin/manage/users/detail/7', '2025-08-15 23:26:51', '2025-08-15 23:26:51'),
(42, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-15 23:39:19', '2025-08-15 23:39:19'),
(43, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-16 00:05:50', '2025-08-16 00:05:50'),
(44, 3, 'Plan Subscribe from tl6udf456', 0, '/admin/manage/users/detail/3', '2025-08-20 16:31:06', '2025-08-20 16:31:06'),
(45, 10, 'Plan Subscribe from 1232323', 0, '/admin/manage/users/detail/10', '2025-08-21 01:13:02', '2025-08-21 01:13:02'),
(46, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 01:16:33', '2025-08-21 01:16:33'),
(47, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 01:17:20', '2025-08-21 01:17:20'),
(48, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 02:09:41', '2025-08-21 02:09:41'),
(49, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 03:00:05', '2025-08-21 03:00:05'),
(50, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 03:40:35', '2025-08-21 03:40:35'),
(51, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 03:41:50', '2025-08-21 03:41:50'),
(52, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:03:41', '2025-08-21 04:03:41'),
(53, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:05:52', '2025-08-21 04:05:52'),
(54, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:31:28', '2025-08-21 04:31:28'),
(55, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:32:33', '2025-08-21 04:32:33'),
(56, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:47:21', '2025-08-21 04:47:21'),
(57, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:47:47', '2025-08-21 04:47:47'),
(58, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:51:23', '2025-08-21 04:51:23'),
(59, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:52:54', '2025-08-21 04:52:54'),
(60, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 04:53:26', '2025-08-21 04:53:26'),
(61, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 05:05:06', '2025-08-21 05:05:06'),
(62, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 05:05:45', '2025-08-21 05:05:45'),
(63, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 05:06:41', '2025-08-21 05:06:41'),
(64, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 05:12:48', '2025-08-21 05:12:48'),
(65, 10, 'Plan Subscribe from 1232323', 0, '/admin/manage/users/detail/10', '2025-08-21 22:40:12', '2025-08-21 22:40:12'),
(66, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-21 23:52:35', '2025-08-21 23:52:35'),
(67, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:04:34', '2025-08-22 01:04:34'),
(68, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:13:28', '2025-08-22 01:13:28'),
(69, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:13:43', '2025-08-22 01:13:43'),
(70, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:20:09', '2025-08-22 01:20:09'),
(71, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:22:54', '2025-08-22 01:22:54'),
(72, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:24:45', '2025-08-22 01:24:45'),
(73, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:25:14', '2025-08-22 01:25:14'),
(74, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:27:31', '2025-08-22 01:27:31'),
(75, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:28:06', '2025-08-22 01:28:06'),
(76, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:28:46', '2025-08-22 01:28:46'),
(77, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:29:25', '2025-08-22 01:29:25'),
(78, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:42:32', '2025-08-22 01:42:32'),
(79, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:54:13', '2025-08-22 01:54:13'),
(80, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:54:54', '2025-08-22 01:54:54'),
(81, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 01:55:53', '2025-08-22 01:55:53'),
(82, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:22:35', '2025-08-22 02:22:35'),
(83, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:22:54', '2025-08-22 02:22:54'),
(84, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:23:09', '2025-08-22 02:23:09'),
(85, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:23:46', '2025-08-22 02:23:46'),
(86, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:25:13', '2025-08-22 02:25:13'),
(87, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:26:46', '2025-08-22 02:26:46'),
(88, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:34:39', '2025-08-22 02:34:39'),
(89, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:35:59', '2025-08-22 02:35:59'),
(90, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:36:20', '2025-08-22 02:36:20'),
(91, 2, 'Plan Subscribe from 123123', 0, '/admin/manage/users/detail/2', '2025-08-22 02:40:14', '2025-08-22 02:40:14'),
(92, 8, 'Plan Subscribe from wwwwwwwwww', 0, '/tash/manage/users/detail/8', '2025-08-22 04:38:35', '2025-08-22 04:38:35');

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `token` varchar(40) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` int(11) NOT NULL,
  `ad_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ad_name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `code` varchar(40) NOT NULL,
  `redirect_url` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `resolution` varchar(255) NOT NULL,
  `allocated_credits` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`id`, `ad_type_id`, `user_id`, `ad_name`, `title`, `code`, `redirect_url`, `image`, `resolution`, `allocated_credits`, `status`, `created_at`, `updated_at`) VALUES
(36, 16, NULL, 'Leaderboard Banner', 'ad-1', 'ad_q5eg', 'https://wstacks.com/', '657abf4d13b7b1702543181.png', '728x90', 0, 1, '2023-12-14 07:57:38', '2023-12-14 08:39:41');

-- --------------------------------------------------------

--
-- Table structure for table `ad_types`
--

CREATE TABLE `ad_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `width` varchar(255) NOT NULL,
  `height` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ad_types`
--

INSERT INTO `ad_types` (`id`, `name`, `type`, `width`, `height`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(13, 'Square', 'image', '250', '250', '250x250', 1, '2023-12-14 07:45:17', '2023-12-14 07:45:17'),
(14, 'Small Square', 'image', '200', '200', '200x200', 1, '2023-12-14 07:45:38', '2023-12-14 07:45:38'),
(15, 'Banner', 'image', '468', '60', '468x60', 1, '2023-12-14 07:45:58', '2023-12-14 07:45:58'),
(16, 'Leaderboard Banner', 'image', '728', '90', '728x90', 1, '2023-12-14 07:46:15', '2023-12-14 07:46:15'),
(17, 'Skyscraper', 'image', '120', '600', '120x600', 1, '2023-12-14 07:46:52', '2023-12-14 07:46:52'),
(18, 'Wide Skyscraper', 'image', '160', '600', '160x600', 1, '2023-12-14 07:47:12', '2023-12-14 07:47:12'),
(19, 'Large Leaderboard', 'image', '970', '90', '970x90', 1, '2023-12-14 07:47:49', '2023-12-14 07:47:49');

-- --------------------------------------------------------

--
-- Table structure for table `apify_actors`
--

CREATE TABLE `apify_actors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `actor_id` varchar(255) NOT NULL,
  `metric` varchar(50) NOT NULL DEFAULT 'followers',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `value_field` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `apify_actors`
--

INSERT INTO `apify_actors` (`id`, `name`, `actor_id`, `metric`, `created_at`, `updated_at`, `value_field`) VALUES
(1, 'Facebook Followers', 'apify~facebook-pages-scraper', 'startUrls', '2025-07-31 08:44:17', '2025-08-08 12:42:41', 'followers'),
(2, 'instagram follo', 'apify~instagram-profile-scraper', 'usernames', '2025-07-31 09:16:08', '2025-08-08 12:46:48', 'followersCount'),
(3, 'tiktok', 'karamelo~tiktok-profile-scraper', 'urls', '2025-07-31 09:16:35', '2025-08-08 12:48:37', 'followerCount'),
(4, 'Facebook Likes', 'mina_safwat~facebook-post-scraper-ppr', 'url', '2025-08-07 22:32:06', '2025-08-13 05:29:37', 'data.statistics.reaction_count.count'),
(5, 'facebook comment', 'mina_safwat~facebook-post-scraper-ppr', 'url', '2025-08-08 12:50:59', '2025-08-13 05:29:33', 'data.statistics.comment_count'),
(6, 'facebook share', 'mina_safwat~facebook-post-scraper-ppr', 'url', '2025-08-08 12:52:18', '2025-08-13 05:29:29', 'data.statistics.shares_count');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `apify_actor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `min_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `apify_actor_id`, `image`, `status`, `created_at`, `updated_at`, `min_points`) VALUES
(1, 'متابعين فيسبوك 🔥', 1, '6892b5d64e8cd1754445270.png', 1, '2025-07-03 21:14:51', '2025-08-08 07:57:14', 15),
(2, 'متابعين إنستغرام 🔥', 2, '6892b5f4111541754445300.png', 1, '2025-07-03 21:21:06', '2025-08-08 07:57:10', 6),
(3, 'متابعين تيك توك 🔥', 3, '6892b5f92f9f31754445305.jpg', 1, '2025-08-01 05:31:42', '2025-08-06 01:55:05', 4),
(4, 'لايكات فيسبوك🔥', 4, 'sRnEARTwSw6azeKSFUqaXyvcIhpGwFEYP0DHAKOX.png', 1, '2025-08-06 07:04:37', '2025-08-08 12:49:02', 13),
(5, 'تعليقات فيسبوك🔥', 5, 'MrY8T60VDD00NjmwSOhDuBlJ5FKASf2yWABpOpCY.png', 1, '2025-08-08 12:50:07', '2025-08-08 12:51:46', 20),
(6, 'مشاركات فيسبوك🔥', 6, 'WReYJkKXQUcLF3wONs238a8aTUCcy4so1jctqnz3.png', 1, '2025-08-08 12:52:45', '2025-08-19 09:30:54', 20),
(7, 'test', NULL, 'iQvK68yDQKsuRlK258tBu4OpT8Sqxrmdq8qY3ec2.png', 1, '2025-08-19 09:32:15', '2025-08-19 09:32:15', 165);

-- --------------------------------------------------------

--
-- Table structure for table `commission_logs`
--

CREATE TABLE `commission_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `who` bigint(20) UNSIGNED NOT NULL,
  `level` varchar(255) NOT NULL,
  `amount` decimal(28,8) NOT NULL,
  `main_amo` decimal(28,8) NOT NULL,
  `title` varchar(255) NOT NULL,
  `trx` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_logs`
--

INSERT INTO `commission_logs` (`id`, `user_id`, `who`, `level`, `amount`, `main_amo`, `title`, `trx`, `created_at`, `updated_at`) VALUES
(1, 2, 10, '1 level Referral Commission', 0.01000000, 357.01000000, 'commission for plan subscribe', '4', '2025-08-21 01:13:02', '2025-08-21 01:13:02'),
(2, 2, 10, '1 level Referral Commission', 0.01000000, 338.52000000, 'commission for plan subscribe', '4', '2025-08-21 22:40:12', '2025-08-21 22:40:12');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `plan_id` int(11) DEFAULT NULL,
  `method_code` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `original_amount_lyd` decimal(28,8) DEFAULT NULL,
  `method_currency` varchar(40) DEFAULT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `final_amo` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `detail` text DEFAULT NULL,
  `btc_amo` varchar(255) DEFAULT NULL,
  `btc_wallet` varchar(255) DEFAULT NULL,
  `trx` varchar(40) DEFAULT NULL,
  `try` int(10) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT 0,
  `admin_feedback` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `user_id`, `plan_id`, `method_code`, `amount`, `original_amount_lyd`, `method_currency`, `charge`, `rate`, `final_amo`, `detail`, `btc_amo`, `btc_wallet`, `trx`, `try`, `status`, `from_api`, `admin_feedback`, `created_at`, `updated_at`) VALUES
(1, 3, NULL, 101, 3.00000000, NULL, 'USD', 1.03000000, 1.00000000, 4.03000000, NULL, '0', '', 'SBT75OQVHZ81', 0, 0, 0, NULL, '2025-07-03 21:56:39', '2025-07-03 21:56:39'),
(2, 3, 1, 101, 10.00000000, NULL, 'USD', 1.10000000, 1.00000000, 11.10000000, NULL, '0', '', 'Z1714QUBEGHJ', 0, 0, 0, NULL, '2025-07-03 22:08:49', '2025-07-03 22:08:49'),
(5, 7, NULL, 1000, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, '[]', '0', '', 'NH9CCBSJJGVM', 0, 2, 0, NULL, '2025-07-28 12:06:25', '2025-07-28 12:06:46'),
(6, 7, NULL, 1000, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, '[]', '0', '', '1KR89GCFCKX2', 0, 2, 0, NULL, '2025-07-28 12:07:52', '2025-07-28 12:08:17'),
(7, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'VS4UC5SPPBRS', 0, 0, 0, NULL, '2025-07-28 12:08:54', '2025-07-28 12:08:54'),
(8, 7, NULL, 115, 4.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 4.00000000, NULL, '0', '', 'HXAU9RRC7R2G', 0, 0, 0, NULL, '2025-07-28 12:27:35', '2025-07-28 12:27:35'),
(9, 7, NULL, 115, 4.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 4.00000000, NULL, '0', '', 'TR4U53EBKDJ5', 0, 0, 0, NULL, '2025-07-28 12:32:10', '2025-07-28 12:32:10'),
(10, 7, NULL, 115, 4.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 4.00000000, NULL, '0', '', 'ACO5BWY3ANA3', 0, 0, 0, NULL, '2025-07-28 12:32:29', '2025-07-28 12:32:29'),
(11, 7, NULL, 115, 4.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 4.00000000, NULL, '0', '', '6AZMU6MQQ554', 0, 0, 0, NULL, '2025-07-28 12:34:25', '2025-07-28 12:34:25'),
(12, 7, NULL, 115, 4.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 4.00000000, NULL, '0', '', 'YTFHZVXFGTTD', 0, 0, 0, NULL, '2025-07-28 12:34:49', '2025-07-28 12:34:49'),
(13, 7, NULL, 115, 3.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 3.00000000, NULL, '0', '', 'HAUR3TOST3YE', 0, 0, 0, NULL, '2025-07-28 12:37:01', '2025-07-28 12:37:01'),
(14, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', 'YXDQ2KGGQ351', 0, 0, 0, NULL, '2025-07-28 12:37:10', '2025-07-28 12:37:10'),
(15, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', 'G4EWUD3ZGJSU', 0, 0, 0, NULL, '2025-07-28 12:41:00', '2025-07-28 12:41:00'),
(16, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', '29NARDKGPHVB', 0, 0, 0, NULL, '2025-07-28 12:43:13', '2025-07-28 12:43:13'),
(17, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', 'QNKWY87PVFOM', 0, 0, 0, NULL, '2025-07-28 12:48:07', '2025-07-28 12:48:07'),
(18, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', 'TD3O695TPD6G', 0, 0, 0, NULL, '2025-07-28 12:57:12', '2025-07-28 12:57:12'),
(19, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', 'YS98YNGF82SH', 0, 0, 0, NULL, '2025-07-28 13:13:19', '2025-07-28 13:13:19'),
(20, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', '1T353ROPXEDZ', 0, 0, 0, NULL, '2025-07-28 13:19:51', '2025-07-28 13:19:51'),
(21, 7, NULL, 115, 11.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 11.00000000, NULL, '0', '', 'OGUKVQ8S6JSE', 0, 0, 0, NULL, '2025-07-28 14:05:56', '2025-07-28 14:05:56'),
(22, 7, NULL, 115, 34.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 34.00000000, NULL, '0', '', '5JWC63W52FKY', 0, 0, 0, NULL, '2025-07-28 14:43:43', '2025-07-28 14:43:43'),
(23, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', '96Q7TP9S4G68', 0, 0, 0, NULL, '2025-07-28 14:58:41', '2025-07-28 14:58:41'),
(24, 7, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 2.00000000, NULL, '0', '', 'V5SK5J1AH13Z', 0, 0, 0, NULL, '2025-07-28 15:14:56', '2025-07-28 15:14:56'),
(25, 7, NULL, 115, 33.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 33.00000000, NULL, '0', '', '5BMC9OKQM9OP', 0, 0, 0, NULL, '2025-07-28 15:28:12', '2025-07-28 15:28:12'),
(26, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', '52E3CENCM1J8', 0, 0, 0, NULL, '2025-07-28 15:36:51', '2025-07-28 15:36:51'),
(27, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'K7YU3T7V2CBE', 0, 0, 0, NULL, '2025-07-29 04:07:20', '2025-07-29 04:07:20'),
(28, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'XJ1RMTFR2GD4', 0, 0, 0, NULL, '2025-07-29 04:37:40', '2025-07-29 04:37:40'),
(29, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', '5WB5XHT94BAJ', 0, 0, 0, NULL, '2025-07-29 05:03:26', '2025-07-29 05:03:26'),
(30, 7, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 2.00000000, NULL, '0', '', 'G9PAWUMUHR5S', 0, 0, 0, NULL, '2025-07-29 05:28:11', '2025-07-29 05:28:11'),
(31, 7, NULL, 115, 11.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 11.00000000, NULL, '0', '', '6KEBOTWVG779', 0, 0, 0, NULL, '2025-07-29 06:01:12', '2025-07-29 06:01:12'),
(32, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', '9TQAYRF3YBHJ', 0, 0, 0, NULL, '2025-07-29 07:26:25', '2025-07-29 07:26:25'),
(33, 7, NULL, 115, 11.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 11.00000000, NULL, '0', '', 'HEOMR9S5KSMT', 0, 0, 0, NULL, '2025-07-29 07:27:08', '2025-07-29 07:27:08'),
(34, 7, NULL, 115, 10.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 10.00000000, NULL, '0', '', '3GQSU3O2E2ZP', 0, 0, 0, NULL, '2025-07-29 07:55:54', '2025-07-29 07:55:54'),
(35, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', '91638G97GBMY', 0, 0, 0, NULL, '2025-07-29 08:16:32', '2025-07-29 08:16:32'),
(37, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'B2BM4EWN3ERY', 0, 0, 0, NULL, '2025-07-29 09:23:57', '2025-07-29 09:23:57'),
(40, 6, NULL, 115, 5.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 5.00000000, NULL, '0', '', 'TEY5JQUC4SP6', 0, 0, 0, NULL, '2025-07-29 10:02:24', '2025-07-29 10:02:24'),
(42, 7, NULL, 115, 7.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 7.00000000, NULL, '0', '', 'PR7KW67ERMER', 0, 0, 0, NULL, '2025-08-01 02:58:02', '2025-08-01 02:58:02'),
(46, 7, NULL, 115, 3.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 3.00000000, NULL, '0', '', 'JRBMBE47JHMD', 0, 0, 0, NULL, '2025-08-06 16:41:41', '2025-08-06 16:41:41'),
(47, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'C3UVNOQGB7XF', 0, 0, 0, NULL, '2025-08-07 03:34:14', '2025-08-07 03:34:14'),
(48, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', '4HZMGZN8RVXD', 0, 0, 0, NULL, '2025-08-07 04:26:19', '2025-08-07 04:26:19'),
(68, 10, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, '\"Libyana payment confirmed for phone: 920000000\"', '0', '', '7R8EK4MU542V', 0, 1, 0, NULL, '2025-08-07 08:33:50', '2025-08-07 08:34:09'),
(69, 10, NULL, 115, 100.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 100.00000000, '\"Libyana payment confirmed for phone: 920000000\"', '0', '', '4DX637PCNAQ5', 0, 1, 0, NULL, '2025-08-07 08:38:25', '2025-08-07 08:39:12'),
(73, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', '8WG5YETPW445', 0, 0, 0, NULL, '2025-08-11 06:37:51', '2025-08-11 06:37:51'),
(74, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'AOCPXNCJOJSN', 0, 0, 0, NULL, '2025-08-11 06:41:23', '2025-08-11 06:41:23'),
(75, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'S36ENTOTFUQZ', 0, 0, 0, NULL, '2025-08-11 06:46:31', '2025-08-11 06:46:31'),
(76, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'MDQ7BYXMRVP4', 0, 0, 0, NULL, '2025-08-11 06:59:38', '2025-08-11 06:59:38'),
(77, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', '3ECMY2ZQJ273', 0, 0, 0, NULL, '2025-08-11 07:03:42', '2025-08-11 07:03:42'),
(78, 7, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 1.00000000, NULL, '0', '', 'HMJ3KQGN6X6X', 0, 0, 0, NULL, '2025-08-11 07:09:30', '2025-08-11 07:09:30'),
(79, 7, NULL, 115, 9.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 9.00000000, NULL, '0', '', 'UXVO9DOAGGNN', 0, 0, 0, NULL, '2025-08-11 07:10:54', '2025-08-11 07:10:54'),
(89, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2}\"', '0', '', 'PQQDP8N5P682', 0, 1, 0, NULL, '2025-08-20 05:28:27', '2025-08-20 07:44:08'),
(90, 10, NULL, 115, 3.00000000, NULL, NULL, 0.00000000, 2.00000000, 3.00000000, NULL, NULL, NULL, '19KAZYEM6P08', 0, 1, 0, NULL, '2025-08-20 07:31:05', '2025-08-20 07:31:05'),
(91, 10, NULL, 115, 2.00000000, NULL, NULL, 0.00000000, 2.00000000, 2.00000000, NULL, NULL, NULL, '37TEIVQLZHKE', 0, 1, 0, NULL, '2025-08-20 07:33:43', '2025-08-20 07:33:43'),
(92, 10, NULL, 115, 3.00000000, NULL, NULL, 0.00000000, 2.00000000, 3.00000000, NULL, NULL, NULL, 'IIANAF5DAIUC', 0, 1, 0, NULL, '2025-08-20 07:34:57', '2025-08-20 07:34:57'),
(93, 10, NULL, 115, 2.00000000, NULL, NULL, 0.00000000, 2.00000000, 2.00000000, NULL, NULL, NULL, 'Y5PPPLV2WOZK', 0, 1, 0, NULL, '2025-08-20 07:36:41', '2025-08-20 07:36:41'),
(94, 10, NULL, 115, 2.00000000, NULL, NULL, 0.00000000, 2.00000000, 2.00000000, NULL, NULL, NULL, 'D7GCQM7QHON0', 0, 1, 0, NULL, '2025-08-20 07:51:12', '2025-08-20 07:51:12'),
(95, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2}\"', NULL, NULL, 'PY4ZPCYXNFTR', 0, 1, 0, NULL, '2025-08-20 07:59:22', '2025-08-20 07:59:22'),
(96, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"user_amount\\\":2}\"', NULL, NULL, 'O9PWAPUCRBYT', 0, 1, 0, NULL, '2025-08-20 08:38:38', '2025-08-20 08:38:38'),
(97, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\"}\"', NULL, NULL, 'SOCUOBHVBQ94', 0, 1, 0, NULL, '2025-08-20 08:41:23', '2025-08-20 08:41:23'),
(98, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2}\"', NULL, NULL, 'O4CYCZ7XPJJL', 0, 1, 0, NULL, '2025-08-20 08:41:51', '2025-08-20 08:41:51'),
(99, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2}\"', NULL, NULL, 'DSH3JIH38MEP', 0, 1, 0, NULL, '2025-08-20 08:42:22', '2025-08-20 08:42:22'),
(100, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2,\\\"user_amount\\\":2}\"', NULL, NULL, 'STQMKT3MGPIX', 0, 1, 0, NULL, '2025-08-20 09:04:17', '2025-08-20 09:04:17'),
(101, 10, NULL, 115, 200.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"amount_source\\\":\\\"regex:value\\\",\\\"inferred\\\":false,\\\"provider_amt\\\":200,\\\"user_amount\\\":2}\"', NULL, NULL, 'MCSXC9ZDLOY1', 0, 1, 0, NULL, '2025-08-20 09:26:51', '2025-08-20 09:26:51'),
(102, 10, NULL, 115, 200.00000000, NULL, 'LYD', 0.00000000, 1.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"api_rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"amount_source\\\":\\\"regex:value\\\",\\\"inferred\\\":false,\\\"provider_amt\\\":200,\\\"user_amount\\\":2}\"', NULL, NULL, 'URREBSKNE3CR', 0, 1, 0, NULL, '2025-08-20 09:31:21', '2025-08-20 09:31:21'),
(103, 10, NULL, 115, 2.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"amount_source\\\":\\\"regex:value\\\",\\\"inferred\\\":false,\\\"usd_raw\\\":200,\\\"usd_saved\\\":2,\\\"normalized_by\\\":\\\"\\u00f7100_generic\\\",\\\"fx_supplied\\\":2,\\\"fx_used\\\":2,\\\"expected_usd\\\":1,\\\"lyd_user\\\":2,\\\"lyd_admin_sent\\\":4,\\\"lyd_diff\\\":2}\"', NULL, NULL, 'SF6BUJ25UOPM', 0, 1, 0, NULL, '2025-08-20 09:41:57', '2025-08-20 09:41:57'),
(104, 10, NULL, 115, 2.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"amount_source\\\":\\\"regex:value\\\",\\\"inferred\\\":false,\\\"usd_raw\\\":200,\\\"usd_saved\\\":2,\\\"normalized_by\\\":\\\"\\u00f7100_generic\\\",\\\"fx_supplied\\\":2,\\\"fx_used\\\":2,\\\"expected_usd\\\":1,\\\"lyd_user\\\":2,\\\"lyd_admin_sent\\\":4,\\\"lyd_diff\\\":2}\"', NULL, NULL, 'X4PY5MOPWONV', 0, 1, 0, NULL, '2025-08-20 09:42:25', '2025-08-20 09:42:25'),
(105, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'ZHGCH5HJNZ1H', 0, 1, 0, NULL, '2025-08-20 10:06:14', '2025-08-20 10:06:14'),
(106, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'QQBMV27ECFLD', 0, 1, 0, NULL, '2025-08-20 10:11:22', '2025-08-20 10:11:22'),
(107, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'AMP01BTRYSFI', 0, 1, 0, NULL, '2025-08-20 10:28:14', '2025-08-20 10:28:14'),
(108, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'QRTNE5EKOP7Y', 0, 1, 0, NULL, '2025-08-20 10:29:29', '2025-08-20 10:29:29'),
(109, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'QLAW7JPO7IES', 0, 1, 0, NULL, '2025-08-20 10:34:29', '2025-08-20 10:34:29'),
(110, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2}\"', NULL, NULL, '2TQRSERJEPAC', 0, 1, 0, NULL, '2025-08-20 10:42:11', '2025-08-20 10:42:11'),
(111, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"rate\\\":2,\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"extotal\\\":2}\"', NULL, NULL, 'DYGWAIDQ3YPP', 0, 1, 0, NULL, '2025-08-20 10:42:33', '2025-08-20 10:42:33'),
(112, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'YWTD2GYCKZRC', 0, 1, 0, NULL, '2025-08-20 10:43:08', '2025-08-20 10:43:08'),
(113, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, '9RMVZ5RHFZ4B', 0, 1, 0, NULL, '2025-08-20 10:58:54', '2025-08-20 10:58:54'),
(114, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'AEYFPHV8RQYE', 0, 1, 0, NULL, '2025-08-20 11:18:22', '2025-08-20 11:18:22'),
(115, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'HOXA39HNKQJT', 0, 1, 0, NULL, '2025-08-20 11:18:34', '2025-08-20 11:18:34'),
(116, 10, NULL, 115, 2.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"user_entered_lyd\\\":2,\\\"provider_lyd\\\":2}\"', NULL, NULL, 'RRKDBGIGUHQE', 0, 1, 0, NULL, '2025-08-20 11:21:23', '2025-08-20 11:21:23'),
(117, 1, NULL, 115, 0.40000000, NULL, 'USD', 0.00000000, 5.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":5,\\\"computed_usd\\\":0.4,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'VGWVH7STTSTS', 0, 1, 0, NULL, '2025-08-20 11:36:42', '2025-08-20 11:36:42'),
(118, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, 'WD0FBVYZAXO9', 0, 1, 0, NULL, '2025-08-20 11:50:00', '2025-08-20 11:50:00'),
(119, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, 'KUWGEPFX32SJ', 0, 1, 0, NULL, '2025-08-20 12:28:37', '2025-08-20 12:28:37'),
(120, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, 'UMB0LCBPY4PU', 0, 1, 0, NULL, '2025-08-20 12:29:13', '2025-08-20 12:29:13'),
(121, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, '52RLWRO11PLZ', 0, 1, 0, NULL, '2025-08-20 12:29:51', '2025-08-20 12:29:51'),
(122, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, 'OU3TQKNG8J46', 0, 1, 0, NULL, '2025-08-20 12:30:28', '2025-08-20 12:30:28'),
(123, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, 'DGN2X1MLXQJM', 0, 1, 0, NULL, '2025-08-20 12:37:31', '2025-08-20 12:37:31'),
(124, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, '2SO0TKAUP6WG', 0, 1, 0, NULL, '2025-08-20 12:43:22', '2025-08-20 12:43:22'),
(125, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, 'MGZXNJ7ZQMXE', 0, 1, 0, NULL, '2025-08-20 13:00:14', '2025-08-20 13:00:14'),
(126, 10, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"store_id\\\":\\\"11\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":1,\\\"entered_lyd\\\":2,\\\"hash\\\":\\\"6e74f7aebd23\\\",\\\"details\\\":\\\"920000000.6e74f7aebd23\\\\\\/2\\\"}\"', NULL, NULL, '6YBHIDF0YLRS', 0, 1, 0, NULL, '2025-08-20 13:13:03', '2025-08-20 13:13:03'),
(129, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, '6BGVTVCBAV9R', 0, 1, 0, NULL, '2025-08-20 14:08:43', '2025-08-20 14:13:19'),
(131, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, 'QUUN1WOMR7KB', 0, 1, 0, NULL, '2025-08-20 14:32:06', '2025-08-20 14:34:44'),
(132, 3, NULL, 115, 10.00000000, 2.00000000, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":10,\\\"entered_lyd\\\":2}\"', NULL, NULL, '13SMOZHCGS61', 0, 1, 0, NULL, '2025-08-20 14:34:44', '2025-08-20 14:34:44'),
(133, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, 'WF31A7EA855E', 0, 1, 0, NULL, '2025-08-20 14:35:25', '2025-08-20 14:36:38'),
(134, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, 'YYPBRU9JARWR', 0, 1, 0, NULL, '2025-08-20 14:36:38', '2025-08-20 14:37:24'),
(135, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, 'E2OY58UJR7GC', 0, 1, 0, NULL, '2025-08-20 14:37:24', '2025-08-20 14:38:53'),
(136, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, 'P247CZQZAZBO', 0, 1, 0, NULL, '2025-08-20 14:38:53', '2025-08-20 14:45:37'),
(137, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, 'Z9V4QZC6UKNO', 0, 1, 0, NULL, '2025-08-20 14:45:37', '2025-08-20 14:46:46'),
(138, 3, NULL, 115, 1.00000000, NULL, 'LYD', 0.00000000, 2.00000000, 1.00000000, NULL, NULL, NULL, '6WV88EHR89WB', 0, 1, 0, NULL, '2025-08-20 14:46:46', '2025-08-20 14:48:44'),
(139, 3, NULL, 115, 10.00000000, 2.00000000, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":10,\\\"entered_lyd\\\":2}\"', NULL, NULL, '28556KCJW4MP', 0, 1, 0, NULL, '2025-08-20 14:48:44', '2025-08-20 14:48:44'),
(140, 3, NULL, 115, 10.00000000, 2.00000000, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"computed_usd\\\":10,\\\"entered_lyd\\\":2}\"', NULL, NULL, 'WMT6BJZ88MB1', 0, 1, 0, NULL, '2025-08-20 14:55:14', '2025-08-20 14:55:14'),
(141, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'TEDBWBGD3P67', 0, 1, 0, NULL, '2025-08-20 15:12:05', '2025-08-20 15:12:05'),
(142, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'FZDZXPUHWWZ0', 0, 1, 0, NULL, '2025-08-20 15:13:22', '2025-08-20 15:13:22'),
(150, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 1.00000000, '\"{\\\"match_hash\\\":\\\"da5f10b9f537\\\",\\\"provider_code\\\":2,\\\"user_phone\\\":\\\"920000000\\\",\\\"entered_lyd\\\":2,\\\"info_rate\\\":2}\"', NULL, NULL, 'TUG74QSPZ8QA', 0, 1, 0, NULL, '2025-08-20 15:47:12', '2025-08-20 15:57:42'),
(151, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 1.00000000, 1.00000000, '\"{\\\"details\\\":\\\"920000000.68a58e276fedf\\\\\\/2\\\",\\\"match_hash\\\":\\\"68a58e276fedf\\\",\\\"provider_code\\\":2}\"', NULL, NULL, 'CA67ZWB5HEU4', 0, 1, 0, NULL, '2025-08-20 15:50:33', '2025-08-20 15:50:33'),
(152, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 1.00000000, 1.00000000, '\"{\\\"details\\\":\\\"920000000.68a58e276fedf\\\\\\/2\\\",\\\"match_hash\\\":\\\"68a58e276fedf\\\",\\\"provider_code\\\":2}\"', NULL, NULL, 'UWHCUFYCR4SQ', 0, 1, 0, NULL, '2025-08-20 15:53:29', '2025-08-20 15:53:29'),
(153, 3, NULL, 115, 1.50000000, NULL, 'USD', 0.00000000, 1.00000000, 1.50000000, '\"{\\\"details\\\":\\\"920000000.68a5957b689c8\\\\\\/2\\\",\\\"match_hash\\\":\\\"68a5957b689c8\\\",\\\"provider_code\\\":2}\"', NULL, NULL, 'F16WEKPMYFK2', 0, 1, 0, NULL, '2025-08-20 15:54:11', '2025-08-20 15:54:11'),
(154, 3, NULL, 115, 1.50000000, 3.00000000, 'USD', 0.00000000, 2.00000000, 3.00000000, '{\"provider\":\"libyana\",\"user_phone\":\"920000000\",\"dest_phone\":\"0924261960\",\"provider_msg\":\"\",\"store_id\":\"11\",\"provider_amt\":null,\"provider_reply\":[]}', NULL, NULL, 'K1H3WCVTEEEZ', 0, 1, 0, NULL, '2025-08-20 15:54:12', '2025-08-20 15:55:57'),
(155, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'TFO4ARH0JI53', 0, 1, 0, NULL, '2025-08-20 15:57:42', '2025-08-20 15:57:42'),
(156, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'Q41XL4FIFH2W', 0, 1, 0, NULL, '2025-08-20 15:58:19', '2025-08-20 15:58:19'),
(157, 3, NULL, 115, 1.50000000, NULL, 'USD', 0.00000000, 2.00000000, 3.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":3,\\\"provider_amt\\\":1.5,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'YPFD5B4ACZYG', 0, 1, 0, NULL, '2025-08-20 15:58:54', '2025-08-20 15:58:54'),
(158, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'LDFBVU06V9WP', 0, 1, 0, NULL, '2025-08-20 16:10:17', '2025-08-20 16:10:17'),
(159, 3, NULL, 115, 1.50000000, NULL, 'USD', 0.00000000, 2.00000000, 3.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":3,\\\"provider_amt\\\":1.5,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'PRNADAGU6X35', 0, 1, 0, NULL, '2025-08-20 16:10:52', '2025-08-20 16:10:52'),
(160, 3, NULL, 115, 1.00000000, NULL, 'USD', 0.00000000, 2.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261960\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":2,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, '3RXBZZSU4RFC', 0, 1, 0, NULL, '2025-08-20 16:11:52', '2025-08-20 16:11:52'),
(161, 3, NULL, 115, 0.17000000, NULL, 'USD', 0.00000000, 12.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":0.17,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, '0B94CRB3FTPD', 0, 1, 0, NULL, '2025-08-20 16:21:19', '2025-08-20 16:21:19'),
(162, 3, NULL, 116, 1.00000000, NULL, 'USD', 0.00000000, 12.00000000, 12.00000000, '\"{\\\"provider\\\":\\\"almadar\\\",\\\"user_phone\\\":\\\"218910000000\\\",\\\"dest_phone\\\":\\\"218913363413\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":12,\\\"provider_amt\\\":1,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'OIOOJV8WIXDH', 0, 1, 0, NULL, '2025-08-20 16:29:31', '2025-08-20 16:29:31'),
(163, 8, NULL, 115, 0.17000000, NULL, 'USD', 0.00000000, 12.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":0.17,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, '5N3Y989HMTPJ', 0, 1, 0, NULL, '2025-08-22 04:18:44', '2025-08-22 04:18:44'),
(164, 2, NULL, 115, 0.25000000, NULL, 'USD', 0.00000000, 12.00000000, 3.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":3,\\\"provider_amt\\\":0.25,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'G3J6UK0DQ94Y', 0, 1, 0, NULL, '2025-08-22 08:29:08', '2025-08-22 08:29:08'),
(165, 2, NULL, 115, 0.17000000, NULL, 'USD', 0.00000000, 12.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":0.17,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'HJZ0ID0THQGG', 0, 1, 0, NULL, '2025-08-22 09:14:39', '2025-08-22 09:14:39'),
(166, 2, NULL, 115, 0.25000000, NULL, 'USD', 0.00000000, 12.00000000, 3.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":3,\\\"provider_amt\\\":0.25,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'TNPT9J0MR1CI', 0, 1, 0, NULL, '2025-08-22 09:31:58', '2025-08-22 09:31:58'),
(167, 2, NULL, 115, 0.17000000, NULL, 'USD', 0.00000000, 12.00000000, 2.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":2,\\\"provider_amt\\\":0.17,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'L7ZW6UTREKFY', 0, 1, 0, NULL, '2025-08-22 10:27:02', '2025-08-22 10:27:02'),
(168, 2, NULL, 115, 0.25000000, NULL, 'USD', 0.00000000, 12.00000000, 3.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":3,\\\"provider_amt\\\":0.25,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'IGL6WZZUUDG2', 0, 1, 0, NULL, '2025-08-22 10:38:05', '2025-08-22 10:38:05'),
(169, 2, NULL, 115, 0.33000000, NULL, 'USD', 0.00000000, 12.00000000, 4.00000000, '\"{\\\"provider\\\":\\\"libyana\\\",\\\"user_phone\\\":\\\"920000000\\\",\\\"dest_phone\\\":\\\"0924261944\\\",\\\"provider_msg\\\":\\\"<div class=\\\\\\\"alert alert-primary\\\\\\\">Success Transaction<\\\\\\/div>\\\",\\\"info_rate\\\":12,\\\"entered_lyd\\\":4,\\\"provider_amt\\\":0.33,\\\"confirmed_by\\\":\\\"computed_by_rate\\\"}\"', NULL, NULL, 'M2LP44DNWKSC', 0, 1, 0, NULL, '2025-08-22 11:02:03', '2025-08-22 11:02:03');

-- --------------------------------------------------------

--
-- Table structure for table `extensions`
--

CREATE TABLE `extensions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `script` text DEFAULT NULL,
  `shortcode` text DEFAULT NULL COMMENT 'object',
  `support` text DEFAULT NULL COMMENT 'help section',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `extensions`
--

INSERT INTO `extensions` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'tawk-chat', 'Live Chat(Tawk.to)', 'Key location is shown bellow', 'chat-png.png', '<script>\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\n                        (function(){\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\n                        s1.async=true;\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\n                        s1.charset=\"UTF-8\";\n                        s1.setAttribute(\"crossorigin\",\"*\");\n                        s0.parentNode.insertBefore(s1,s0);\n                        })();\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"55\"}}', 'twak.png', 1, NULL, '2019-10-18 23:16:05', '2025-08-01 02:56:30'),
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'Key location is shown bellow', 'recaptcha2.png', '\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>', '{\"site_key\":{\"title\":\"Site Key\",\"value\":\"6LdPC88fAAAAADQlUf_DV6Hrvgm-pZuLJFSLDOWV\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"6LdPC88fAAAAAG5SVaRYDnV2NpCrptLg2XLYKRKB\"}}', 'recaptcha.png', 0, NULL, '2019-10-18 23:16:05', '2025-08-01 02:56:59');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) DEFAULT NULL,
  `form_data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`id`, `act`, `form_data`, `created_at`, `updated_at`) VALUES
(1, 'manual_deposit', '[]', '2025-07-28 11:44:10', '2025-07-28 11:44:10');

-- --------------------------------------------------------

--
-- Table structure for table `frontends`
--

CREATE TABLE `frontends` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data_keys` varchar(40) DEFAULT NULL,
  `data_values` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `frontends`
--

INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `created_at`, `updated_at`) VALUES
(1, 'seo.data', '{\"seo_image\":\"1\",\"keywords\":[\"website\",\"like4like\",\"social page promotion\",\"credits earn\"],\"description\":\"Discover a secure and user-friendly exchange platform. Trade cryptocurrencies effortlessly with advanced features. Join now for seamless transactions!\",\"social_title\":\"Follow Exchange\",\"social_description\":\"Discover a secure and user-friendly exchange platform. Trade cryptocurrencies effortlessly with advanced features. Join now for seamless transactions!\",\"image\":\"66361cc2b9a971714822338.png\"}', '2020-07-04 23:42:52', '2024-05-04 11:34:08'),
(24, 'about.content', '{\"has_image\":\"1\",\"top_heading\":\"What We Provide\",\"heading\":\"Best Follow Exchange Platform In The WorldWide\",\"description\":\"The platform\'s versatility shines through its feature-rich interface, enabling users to launch follow campaigns, track their engagement statistics, and manage their credits effortlessly. Boasting support for over 10 payment gateways, FExchange ensures accessibility and convenience for users worldwide.\",\"about_image\":\"662e2ae50ae071714301669.png\"}', '2020-10-28 00:51:20', '2024-05-05 12:09:50'),
(25, 'blog.content', '{\"top_heading\":\"Blogs\",\"heading\":\"Our Latest Blogs\",\"sub_heading\":\"Offering users an avenue to bolster their online presence through reciprocal interactions.\"}', '2020-10-28 00:51:34', '2024-05-05 12:10:41'),
(26, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Get More Free Instagram Likes\",\"description\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum orem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam.<\\/p><h3>How to Earn<\\/h3><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quiLorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem it. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime<\\/p>\",\"blog_image\":\"6635c3e7910031714799591.png\"}', '2020-10-28 00:57:19', '2024-05-04 11:02:29'),
(27, 'contact_us.content', '{\"has_image\":\"1\",\"title\":\"Auctor gravida vestibulu\",\"short_details\":\"Lorem ipsum dolor, sit amet consectetur adipisicing elit\",\"email_address\":\"admin@test.com\",\"contact_details\":\"688967896896\",\"contact_number\":\"9876897689698\",\"latitude\":\"876768\",\"longitude\":\"67867868\",\"website_footer\":\"<p>Copyright 2024. All rights reserved.<\\/p>\",\"contact_image\":\"6635d4dbc87141714803931.png\"}', '2020-10-28 00:59:19', '2024-05-04 06:25:31'),
(28, 'counter.content', '{\"heading\":\"Clients\",\"subheading\":\"Auctor gravida vestibulu\"}', '2020-10-28 01:04:02', '2022-09-28 14:02:14'),
(31, 'social_icon.element', '{\"title\":\"Facebook\",\"social_icon\":\"<i class=\\\"fab fa-facebook-f\\\"><\\/i>\",\"url\":\"https:\\/\\/www.facebook.com\\/\"}', '2020-11-12 04:07:30', '2024-04-28 12:38:29'),
(33, 'feature.content', '{\"heading\":\"asdf\",\"sub_heading\":\"asdf\"}', '2021-01-03 23:40:54', '2021-01-03 23:40:55'),
(34, 'feature.element', '{\"title\":\"asdf\",\"description\":\"asdf\",\"feature_icon\":\"asdf\"}', '2021-01-03 23:41:02', '2021-01-03 23:41:02'),
(35, 'service.element', '{\"trx_type\":\"withdraw\",\"service_icon\":\"<i class=\\\"las la-highlighter\\\"><\\/i>\",\"title\":\"asdfasdf\",\"description\":\"asdfasdfasdfasdf\"}', '2021-03-06 01:12:10', '2021-03-06 01:12:10'),
(36, 'service.content', '{\"trx_type\":\"deposit\",\"heading\":\"asdf fffff\",\"subheading\":\"555\"}', '2021-03-06 01:27:34', '2022-03-30 08:07:06'),
(39, 'banner.content', '{\"has_image\":\"1\",\"top_heading\":\"SIMPLE, QUICK, SECURED\",\"heading\":\"Biggest Action Exchange Platform\",\"sub_heading\":\"Exchange likes, follows, subscriptions etc\",\"banner_image\":\"6635bf68159241714798440.png\"}', '2021-05-02 06:09:30', '2024-05-05 12:01:57'),
(41, 'cookie.data', '{\"short_desc\":\"We use cookies to enhance your browsing experience, serve personalized ads or content, and analyze our traffic. By clicking \\\"Accept\\\", you consent to our use of cookies.\",\"description\":\"<h4>GDPR, cookies and compliance&nbsp;<\\/h4><ul><li>The&nbsp;General Data Protection Regulation (GDPR)&nbsp;is an EU legislation that governs all collection and processing of personal data from individuals inside the EU.<\\/li><li>Under the EU\\u2019s GDPR, it is the&nbsp;legal responsibility of website owners and operators&nbsp;to make sure that personal data is collected and processed lawfully.<\\/li><li>A website outside of the EU is required to comply with the GDPR if it collects&nbsp;data from users inside the EU.<\\/li><\\/ul><p>&nbsp;<\\/p><p>Even though cookies are mentioned only once in the GDPR,&nbsp;cookie consent&nbsp;is nonetheless a cornerstone of compliance for websites with EU-located users.<\\/p><p>This is because&nbsp;one of the most common ways for personal data to be collected and shared online is through website cookies. The GDPR sets out specific rules for the use of cookies.<\\/p><p>That\\u2019s why end-user consent to cookies is the GDPR\\u2019s most used legal basis that allows websites to process personal data and use cookies.&nbsp;<\\/p>\",\"status\":1}', '2020-07-04 23:42:52', '2023-02-18 09:03:29'),
(42, 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<h3><strong>Sed ut perspiciatis unde omnis iste\\u00a0<\\/strong><\\/h3><p>natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.<\\/p><p>\\u00a0<\\/p><ul><li>Consequuntur quia consequuntur\\u00a0<\\/li><li>Eos qui ratione voluptatem\\u00a0<\\/li><li>Dolores eos qui ratione voluptatem<\\/li><li>Quis autem vel eum iure\\u00a0<\\/li><\\/ul><p>\\u00a0<\\/p><h3><strong>Nisi ut aliquid ex ea commodi consequatur<\\/strong><\\/h3><p>qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p><p>\\u00a0<\\/p><h3><strong>Sed ut perspiciatis unde omnis iste\\u00a0<\\/strong><\\/h3><ul><li>Consequuntur quia consequuntur\\u00a0<\\/li><li>Eos qui ratione voluptatem\\u00a0<\\/li><li>Dolores eos qui ratione voluptatem<\\/li><li>Quis autem vel eum iure\\u00a0<\\/li><\\/ul><p>\\u00a0<\\/p><h3><strong>Nisi ut aliquid ex ea commodi consequatur<\\/strong><\\/h3><ul><li>Consequuntur quia consequuntur\\u00a0<\\/li><li>Eos qui ratione voluptatem\\u00a0<\\/li><li>Dolores eos qui ratione voluptatem<\\/li><li>Quis autem vel eum iure\\u00a0<\\/li><\\/ul><p>qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p><p>\\u00a0<\\/p><h3><strong>Sed ut perspiciatis unde omnis iste\\u00a0<\\/strong><\\/h3><p>natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.\\u00a0<\\/p><p>\\u00a0<\\/p><h3><strong>Nisi ut aliquid ex ea commodi consequatur<\\/strong><\\/h3><p>qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p>\"}', '2021-06-09 08:50:42', '2022-12-17 06:01:31'),
(43, 'policy_pages.element', '{\"title\":\"Terms of Service\",\"details\":\"<h3><strong>Sed ut perspiciatis unde omnis iste\\u00a0<\\/strong><\\/h3><p>natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.<\\/p><p>\\u00a0<\\/p><ul><li>Consequuntur quia consequuntur\\u00a0<\\/li><li>Eos qui ratione voluptatem\\u00a0<\\/li><li>Dolores eos qui ratione voluptatem<\\/li><li>Quis autem vel eum iure\\u00a0<\\/li><\\/ul><p>\\u00a0<\\/p><h3><strong>Nisi ut aliquid ex ea commodi consequatur<\\/strong><\\/h3><p>qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p><p>\\u00a0<\\/p><h3><strong>Sed ut perspiciatis unde omnis iste\\u00a0<\\/strong><\\/h3><ul><li>Consequuntur quia consequuntur\\u00a0<\\/li><li>Eos qui ratione voluptatem\\u00a0<\\/li><li>Dolores eos qui ratione voluptatem<\\/li><li>Quis autem vel eum iure\\u00a0<\\/li><\\/ul><p>\\u00a0<\\/p><h3><strong>Nisi ut aliquid ex ea commodi consequatur<\\/strong><\\/h3><ul><li>Consequuntur quia consequuntur\\u00a0<\\/li><li>Eos qui ratione voluptatem\\u00a0<\\/li><li>Dolores eos qui ratione voluptatem<\\/li><li>Quis autem vel eum iure\\u00a0<\\/li><\\/ul><p>qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p><p>\\u00a0<\\/p><h3><strong>Sed ut perspiciatis unde omnis iste\\u00a0<\\/strong><\\/h3><p>natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.\\u00a0<\\/p><p>\\u00a0<\\/p><h3><strong>Nisi ut aliquid ex ea commodi consequatur<\\/strong><\\/h3><p>qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p>\"}', '2021-06-09 08:51:18', '2022-12-17 06:01:43'),
(44, 'maintenance.data', '{\"description\":\"<div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"text-align: center; font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">What information do we collect?<\\/h3><p class=\\\"font-18\\\" style=\\\"text-align: center; margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/p><\\/div>\"}', '2020-07-04 23:42:52', '2022-05-11 03:57:17'),
(45, 'feature.element', '{\"title\":\"sytry\",\"description\":\"ertyerty\",\"feature_icon\":\"<i class=\\\"fas fa-address-book\\\"><\\/i>\"}', '2022-10-17 10:23:22', '2022-10-17 10:23:22'),
(46, 'feature.element', '{\"title\":\"sytry\",\"description\":\"ertyerty\",\"feature_icon\":\"<i class=\\\"fas fa-address-book\\\"><\\/i>\"}', '2022-10-17 10:23:22', '2022-10-17 10:23:22'),
(51, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Modus melioreex has in decore\",\"description\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum orem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam.<\\/p><h3>How to Earn<\\/h3><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quiLorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem it. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime<\\/p>\",\"blog_image\":\"6635c3f2edb381714799602.png\"}', '2023-03-21 08:45:08', '2024-05-04 10:05:19'),
(52, 'about.element', '{\"icon\":\"<i class=\\\"fas fa-users\\\"><\\/i>\",\"title\":\"Join our Community\",\"description\":\"Embark on your social media journey with a startup bonus of 30 credits when you become part of our vibrant community.\"}', '2024-04-28 10:57:33', '2024-04-28 10:57:33'),
(53, 'about.element', '{\"icon\":\"<i class=\\\"fas fa-store\\\"><\\/i>\",\"title\":\"Showcase\",\"description\":\"Promote the platform that matters most to you by adding your social network page to our community.\"}', '2024-04-28 10:58:42', '2024-04-28 10:58:42'),
(54, 'about.element', '{\"icon\":\"<i class=\\\"fas fa-file-invoice-dollar\\\"><\\/i>\",\"title\":\"Earn Credits\",\"description\":\"Whether you prefer to buy credits or enjoy the perks of free credits.\"}', '2024-04-28 10:59:26', '2024-04-28 11:02:59'),
(55, 'about.element', '{\"icon\":\"<i class=\\\"fas fa-fire\\\"><\\/i>\",\"title\":\"Boost Your Presence\",\"description\":\"Witness your followers and likes soar as you actively participate in our community.\"}', '2024-04-28 10:59:53', '2024-04-28 10:59:53'),
(56, 'support.content', '{\"top_heading\":\"Support Social\",\"heading\":\"We Support All Major Social Media Networks\"}', '2024-04-28 11:25:30', '2024-04-28 11:25:30'),
(57, 'support.element', '{\"has_image\":[\"1\"],\"title\":\"Followers, Shares on Facebook\",\"description\":\"Looking to boost your social media presence? Our service offers free likes, followers, and shares on Facebook, helping you reach a wider audience and increase engagement\",\"support_image\":\"662e32c0e86dd1714303680.png\"}', '2024-04-28 11:28:00', '2024-05-01 10:38:14'),
(58, 'support.element', '{\"has_image\":[\"1\"],\"title\":\"Likes,Shares on Instagram\",\"description\":\"Looking to boost your social media presence? Our service offers free likes, followers, and shares on Facebook, helping you reach a wider audience and increase engagement\",\"support_image\":\"662e32d8b58721714303704.png\"}', '2024-04-28 11:28:24', '2024-05-01 10:38:31'),
(59, 'support.element', '{\"has_image\":[\"1\"],\"title\":\"Likes, Shares on Tiktkok\",\"description\":\"Looking to boost your social media presence? Our service offers free likes, followers, and shares on Facebook, helping you reach a wider audience and increase engagement\",\"support_image\":\"662e32f0a815b1714303728.png\"}', '2024-04-28 11:28:48', '2024-05-01 10:38:46'),
(60, 'faq.content', '{\"has_image\":\"1\",\"top_heading\":\"FAQ\",\"heading\":\"Frequently Asked Questions\",\"faq_image\":\"662e37b9d7ddd1714304953.png\"}', '2024-04-28 11:49:04', '2024-04-28 11:49:14'),
(61, 'faq.element', '{\"question\":\"Where can I find Follower?\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-04-28 11:50:21', '2024-04-28 11:50:21'),
(62, 'faq.element', '{\"question\":\"What skills do I need?\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-04-28 11:50:43', '2024-04-28 11:50:43'),
(63, 'faq.element', '{\"question\":\"I have Received my withdrawal?\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-04-28 11:51:05', '2024-04-28 11:54:01'),
(64, 'faq.element', '{\"question\":\"I have not Receive My Withdrawal\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-04-28 11:52:59', '2024-04-28 11:52:59'),
(65, 'faq.element', '{\"question\":\"What are the payment options available?\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-04-28 11:55:28', '2024-04-28 11:55:28'),
(66, 'faq.element', '{\"question\":\"How long does it take to gain followers?\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-04-28 11:55:37', '2024-04-28 11:55:37'),
(67, 'reffer.content', '{\"has_image\":\"1\",\"heading\":\"Refer and  Earn\",\"description\":\"Unlock incredible rewards with our referral program! By inviting friends and colleagues to join our platform, you not only help them enhance their social media presence but also earn lucrative bonuses for yourself. In our Referral section, you can effortlessly track your referral\'s progress and watch your credits soar. With each successful referral, you stand to collect over 2,000 credits in bonuses. But it doesn\'t stop there \\u2013 the more referrals you accumulate, the more you can earn. Join now and start maximizing your rewards today\",\"reffer_image\":\"6635c26669d661714799206.png\"}', '2024-04-28 11:59:43', '2024-05-04 05:06:46'),
(68, 'testimonial.content', '{\"top_heading\":\"Say Client\",\"heading\":\"Client Feedback\",\"sub_heading\":\"Offering users an avenue to bolster their online presence through reciprocal interactions.\"}', '2024-04-28 12:07:49', '2024-05-05 12:11:25'),
(69, 'testimonial.element', '{\"has_image\":[\"1\"],\"name\":\"John Doe\",\"designation\":\"Software Engineer\",\"star_count\":\"5\",\"description\":\"Lorem ipsum dolor sit amet consectetur, adipisicing elit. Amet minima sunt nesciunt cupiditate atque? Beatae voluptate nihil tempora provident? Nostrum obcaecati totam\",\"client_image\":\"662e3c48364d21714306120.png\"}', '2024-04-28 12:08:40', '2024-04-28 12:08:40'),
(70, 'testimonial.element', '{\"has_image\":[\"1\"],\"name\":\"Jack Ma\",\"designation\":\"CEO and Founder\",\"star_count\":\"5\",\"description\":\"Lorem ipsum dolor sit amet consectetur, adipisicing elit. Amet minima sunt nesciunt cupiditate atque? Beatae voluptate nihil tempora provident? Nostrum obcaecati totam\",\"client_image\":\"662e3c64585ac1714306148.png\"}', '2024-04-28 12:09:08', '2024-04-28 12:09:08'),
(71, 'testimonial.element', '{\"has_image\":[\"1\"],\"name\":\"Dolland\",\"designation\":\"Polititian\",\"star_count\":\"4\",\"description\":\"Lorem ipsum dolor sit amet consectetur, adipisicing elit. Amet minima sunt nesciunt cupiditate atque? Beatae voluptate nihil tempora provident? Nostrum obcaecati totam\",\"client_image\":\"662e3c7cbcf401714306172.png\"}', '2024-04-28 12:09:32', '2024-04-28 12:09:32'),
(72, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Modus melioreex has in decore\",\"description\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum orem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam.<\\/p><p>\\u00a0<\\/p><h3>How to Earn<\\/h3><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quiLorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem it. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime<\\/p>\",\"blog_image\":\"6635c3ff47b751714799615.png\"}', '2024-04-28 12:27:38', '2024-05-04 05:13:35'),
(73, 'social_icon.element', '{\"title\":\"Instagram\",\"social_icon\":\"<i class=\\\"fab fa-instagram\\\"><\\/i>\",\"url\":\"https:\\/\\/www.instagram.com\\/\"}', '2024-04-28 12:38:47', '2024-04-28 12:38:47'),
(74, 'social_icon.element', '{\"title\":\"LinkedIn\",\"social_icon\":\"<i class=\\\"fab fa-linkedin\\\"><\\/i>\",\"url\":\"https:\\/\\/www.linkedin.com\\/\"}', '2024-04-28 12:39:13', '2024-04-28 12:39:13'),
(75, 'plan.content', '{\"top_heading\":\"Buy Credits\",\"heading\":\"Popular Credits Plan\",\"sub_heading\":\"Offering users an avenue to bolster their online presence through reciprocal interactions.\"}', '2024-04-29 05:23:33', '2024-05-05 12:11:10'),
(76, 'faq.element', '{\"question\":\"Where can I find Follower?\",\"answer\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi, numquam alias. Laborum maiores non iure, laudantium odio, ipsa magni a ducimus nobis consequuntur<\\/p>\"}', '2024-05-01 09:58:08', '2024-05-01 09:58:08'),
(77, 'footer_important_links.element', '{\"title\":\"Login\",\"url\":\"\\/user\\/login\"}', '2024-05-01 10:00:02', '2024-05-01 10:00:02'),
(78, 'footer_important_links.element', '{\"title\":\"Contact\",\"url\":\"\\/contact\"}', '2024-05-01 10:00:16', '2024-05-01 10:00:16'),
(79, 'footer_important_links.element', '{\"title\":\"Buy Credits\",\"url\":\"\\/plan\"}', '2024-05-01 10:00:30', '2025-08-07 07:15:08'),
(80, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Best time to post on Social\",\"description\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum orem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam.<\\/p><h3>How to Earn<\\/h3><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quiLorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem it. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime<\\/p>\",\"blog_image\":\"663607c7c9c161714816967.png\"}', '2024-05-04 10:02:47', '2024-05-04 11:03:05'),
(81, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Modus melioreex has in decore\",\"description\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum orem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam.<\\/p><h3>How to Earn<\\/h3><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quiLorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem it. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime<\\/p>\",\"blog_image\":\"663607ea727301714817002.png\"}', '2024-05-04 10:03:22', '2024-05-04 10:03:22'),
(82, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Modus melioreex has in decore\",\"description\":\"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum orem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam.<\\/p><h3>How to Earn<\\/h3><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quiLorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem it. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime dolorum. Impedit, quibusdam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis atque excepturi cupiditate soluta nisi aperiam illum maxime<\\/p>\",\"blog_image\":\"663607fd6edba1714817021.png\"}', '2024-05-04 10:03:41', '2024-05-04 10:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `code` int(10) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `alias` varchar(40) NOT NULL DEFAULT 'NULL',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `gateway_parameters` text DEFAULT NULL,
  `supported_currencies` text DEFAULT NULL,
  `crypto` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: fiat currency, 1: crypto currency',
  `extra` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`) VALUES
(1, 0, 101, 'Paypal', 'Paypal', 1, '{\"paypal_email\":{\"title\":\"PayPal Email\",\"global\":true,\"value\":\"abdocenter@gmail.com\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2025-07-03 21:34:33'),
(2, 0, 102, 'Perfect Money', 'PerfectMoney', 1, '{\"passphrase\":{\"title\":\"ALTERNATE PASSPHRASE\",\"global\":true,\"value\":\"---------------------\"},\"wallet_id\":{\"title\":\"PM Wallet\",\"global\":false,\"value\":\"\"}}', '{\"USD\":\"$\",\"EUR\":\"\\u20ac\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2022-11-26 07:50:01'),
(3, 0, 105, 'PayTM', 'Paytm', 1, '{\"MID\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"-----------\"},\"merchant_key\":{\"title\":\"Merchant Key\",\"global\":true,\"value\":\"--------------------\"},\"WEBSITE\":{\"title\":\"Paytm Website\",\"global\":true,\"value\":\"example.com\"},\"INDUSTRY_TYPE_ID\":{\"title\":\"Industry Type\",\"global\":true,\"value\":\"Retail\"},\"CHANNEL_ID\":{\"title\":\"CHANNEL ID\",\"global\":true,\"value\":\"WEB\"},\"transaction_url\":{\"title\":\"Transaction URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/oltp-web\\/processTransaction\"},\"transaction_status_url\":{\"title\":\"Transaction STATUS URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/paytmchecksum\\/paytmCallback.jsp\"}}', '{\"AUD\":\"AUD\",\"ARS\":\"ARS\",\"BDT\":\"BDT\",\"BRL\":\"BRL\",\"BGN\":\"BGN\",\"CAD\":\"CAD\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"HRK\":\"HRK\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EGP\":\"EGP\",\"EUR\":\"EUR\",\"GEL\":\"GEL\",\"GHS\":\"GHS\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"KES\":\"KES\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"MAD\":\"MAD\",\"NPR\":\"NPR\",\"NZD\":\"NZD\",\"NGN\":\"NGN\",\"NOK\":\"NOK\",\"PKR\":\"PKR\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"ZAR\":\"ZAR\",\"KRW\":\"KRW\",\"LKR\":\"LKR\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"UGX\":\"UGX\",\"UAH\":\"UAH\",\"AED\":\"AED\",\"GBP\":\"GBP\",\"USD\":\"USD\",\"VND\":\"VND\",\"XOF\":\"XOF\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2022-11-26 08:10:37'),
(4, 0, 107, 'PayStack', 'Paystack', 1, '{\"public_key\":{\"title\":\"Public key\",\"global\":true,\"value\":\"--------\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"----------------\"}}', '{\"USD\":\"USD\",\"NGN\":\"NGN\"}', 0, '{\"callback\":{\"title\": \"Callback URL\",\"value\":\"ipn.Paystack\"},\"webhook\":{\"title\": \"Webhook URL\",\"value\":\"ipn.Paystack\"}}\r\n', NULL, '2019-09-14 13:14:22', '2022-11-26 07:49:18'),
(5, 0, 108, 'VoguePay', 'Voguepay', 1, '{\"merchant_id\":{\"title\":\"MERCHANT ID\",\"global\":true,\"value\":\"-------------------\"}}', '{\"USD\":\"USD\",\"GBP\":\"GBP\",\"EUR\":\"EUR\",\"GHS\":\"GHS\",\"NGN\":\"NGN\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2022-11-26 07:50:14'),
(6, 0, 109, 'Flutterwave', 'Flutterwave', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------------\"},\"encryption_key\":{\"title\":\"Encryption Key\",\"global\":true,\"value\":\"------------------\"}}', '{\"BIF\":\"BIF\",\"CAD\":\"CAD\",\"CDF\":\"CDF\",\"CVE\":\"CVE\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"GHS\":\"GHS\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"KES\":\"KES\",\"LRD\":\"LRD\",\"MWK\":\"MWK\",\"MZN\":\"MZN\",\"NGN\":\"NGN\",\"RWF\":\"RWF\",\"SLL\":\"SLL\",\"STD\":\"STD\",\"TZS\":\"TZS\",\"UGX\":\"UGX\",\"USD\":\"USD\",\"XAF\":\"XAF\",\"XOF\":\"XOF\",\"ZMK\":\"ZMK\",\"ZMW\":\"ZMW\",\"ZWD\":\"ZWD\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-06-05 11:37:45'),
(7, 0, 110, 'RazorPay', 'Razorpay', 1, '{\"key_id\":{\"title\":\"Key Id\",\"global\":true,\"value\":\"------------\"},\"key_secret\":{\"title\":\"Key Secret \",\"global\":true,\"value\":\"--------\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:51:32'),
(8, 0, 112, 'Instamojo', 'Instamojo', 1, '{\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"------------\"},\"auth_token\":{\"title\":\"Auth Token\",\"global\":true,\"value\":\"---------\"},\"salt\":{\"title\":\"Salt\",\"global\":true,\"value\":\"-------\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2022-11-26 08:00:15'),
(9, 0, 503, 'CoinPayments', 'Coinpayments', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"---------------\"},\"private_key\":{\"title\":\"Private Key\",\"global\":true,\"value\":\"------------\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"----------------\"}}', '{\"BTC\":\"Bitcoin\",\"BTC.LN\":\"Bitcoin (Lightning Network)\",\"LTC\":\"Litecoin\",\"CPS\":\"CPS Coin\",\"VLX\":\"Velas\",\"APL\":\"Apollo\",\"AYA\":\"Aryacoin\",\"BAD\":\"Badcoin\",\"BCD\":\"Bitcoin Diamond\",\"BCH\":\"Bitcoin Cash\",\"BCN\":\"Bytecoin\",\"BEAM\":\"BEAM\",\"BITB\":\"Bean Cash\",\"BLK\":\"BlackCoin\",\"BSV\":\"Bitcoin SV\",\"BTAD\":\"Bitcoin Adult\",\"BTG\":\"Bitcoin Gold\",\"BTT\":\"BitTorrent\",\"CLOAK\":\"CloakCoin\",\"CLUB\":\"ClubCoin\",\"CRW\":\"Crown\",\"CRYP\":\"CrypticCoin\",\"CRYT\":\"CryTrExCoin\",\"CURE\":\"CureCoin\",\"DASH\":\"DASH\",\"DCR\":\"Decred\",\"DEV\":\"DeviantCoin\",\"DGB\":\"DigiByte\",\"DOGE\":\"Dogecoin\",\"EBST\":\"eBoost\",\"EOS\":\"EOS\",\"ETC\":\"Ether Classic\",\"ETH\":\"Ethereum\",\"ETN\":\"Electroneum\",\"EUNO\":\"EUNO\",\"EXP\":\"EXP\",\"Expanse\":\"Expanse\",\"FLASH\":\"FLASH\",\"GAME\":\"GameCredits\",\"GLC\":\"Goldcoin\",\"GRS\":\"Groestlcoin\",\"KMD\":\"Komodo\",\"LOKI\":\"LOKI\",\"LSK\":\"LSK\",\"MAID\":\"MaidSafeCoin\",\"MUE\":\"MonetaryUnit\",\"NAV\":\"NAV Coin\",\"NEO\":\"NEO\",\"NMC\":\"Namecoin\",\"NVST\":\"NVO Token\",\"NXT\":\"NXT\",\"OMNI\":\"OMNI\",\"PINK\":\"PinkCoin\",\"PIVX\":\"PIVX\",\"POT\":\"PotCoin\",\"PPC\":\"Peercoin\",\"PROC\":\"ProCurrency\",\"PURA\":\"PURA\",\"QTUM\":\"QTUM\",\"RES\":\"Resistance\",\"RVN\":\"Ravencoin\",\"RVR\":\"RevolutionVR\",\"SBD\":\"Steem Dollars\",\"SMART\":\"SmartCash\",\"SOXAX\":\"SOXAX\",\"STEEM\":\"STEEM\",\"STRAT\":\"STRAT\",\"SYS\":\"Syscoin\",\"TPAY\":\"TokenPay\",\"TRIGGERS\":\"Triggers\",\"TRX\":\" TRON\",\"UBQ\":\"Ubiq\",\"UNIT\":\"UniversalCurrency\",\"USDT\":\"Tether USD (Omni Layer)\",\"USDT.BEP20\":\"Tether USD (BSC Chain)\",\"USDT.ERC20\":\"Tether USD (ERC20)\",\"USDT.TRC20\":\"Tether USD (Tron/TRC20)\",\"VTC\":\"Vertcoin\",\"WAVES\":\"Waves\",\"XCP\":\"Counterparty\",\"XEM\":\"NEM\",\"XMR\":\"Monero\",\"XSN\":\"Stakenet\",\"XSR\":\"SucreCoin\",\"XVG\":\"VERGE\",\"XZC\":\"ZCoin\",\"ZEC\":\"ZCash\",\"ZEN\":\"Horizen\"}', 1, NULL, NULL, '2019-09-14 13:14:22', '2022-10-29 07:29:51'),
(10, 0, 506, 'Coinbase Commerce', 'CoinbaseCommerce', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"---------\"},\"secret\":{\"title\":\"Webhook Shared Secret\",\"global\":true,\"value\":\"----------------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"JPY\":\"JPY\",\"GBP\":\"GBP\",\"AUD\":\"AUD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CNY\":\"CNY\",\"SEK\":\"SEK\",\"NZD\":\"NZD\",\"MXN\":\"MXN\",\"SGD\":\"SGD\",\"HKD\":\"HKD\",\"NOK\":\"NOK\",\"KRW\":\"KRW\",\"TRY\":\"TRY\",\"RUB\":\"RUB\",\"INR\":\"INR\",\"BRL\":\"BRL\",\"ZAR\":\"ZAR\",\"AED\":\"AED\",\"AFN\":\"AFN\",\"ALL\":\"ALL\",\"AMD\":\"AMD\",\"ANG\":\"ANG\",\"AOA\":\"AOA\",\"ARS\":\"ARS\",\"AWG\":\"AWG\",\"AZN\":\"AZN\",\"BAM\":\"BAM\",\"BBD\":\"BBD\",\"BDT\":\"BDT\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"BIF\":\"BIF\",\"BMD\":\"BMD\",\"BND\":\"BND\",\"BOB\":\"BOB\",\"BSD\":\"BSD\",\"BTN\":\"BTN\",\"BWP\":\"BWP\",\"BYN\":\"BYN\",\"BZD\":\"BZD\",\"CDF\":\"CDF\",\"CLF\":\"CLF\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"CRC\":\"CRC\",\"CUC\":\"CUC\",\"CUP\":\"CUP\",\"CVE\":\"CVE\",\"CZK\":\"CZK\",\"DJF\":\"DJF\",\"DKK\":\"DKK\",\"DOP\":\"DOP\",\"DZD\":\"DZD\",\"EGP\":\"EGP\",\"ERN\":\"ERN\",\"ETB\":\"ETB\",\"FJD\":\"FJD\",\"FKP\":\"FKP\",\"GEL\":\"GEL\",\"GGP\":\"GGP\",\"GHS\":\"GHS\",\"GIP\":\"GIP\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"GTQ\":\"GTQ\",\"GYD\":\"GYD\",\"HNL\":\"HNL\",\"HRK\":\"HRK\",\"HTG\":\"HTG\",\"HUF\":\"HUF\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"IMP\":\"IMP\",\"IQD\":\"IQD\",\"IRR\":\"IRR\",\"ISK\":\"ISK\",\"JEP\":\"JEP\",\"JMD\":\"JMD\",\"JOD\":\"JOD\",\"KES\":\"KES\",\"KGS\":\"KGS\",\"KHR\":\"KHR\",\"KMF\":\"KMF\",\"KPW\":\"KPW\",\"KWD\":\"KWD\",\"KYD\":\"KYD\",\"KZT\":\"KZT\",\"LAK\":\"LAK\",\"LBP\":\"LBP\",\"LKR\":\"LKR\",\"LRD\":\"LRD\",\"LSL\":\"LSL\",\"LYD\":\"LYD\",\"MAD\":\"MAD\",\"MDL\":\"MDL\",\"MGA\":\"MGA\",\"MKD\":\"MKD\",\"MMK\":\"MMK\",\"MNT\":\"MNT\",\"MOP\":\"MOP\",\"MRO\":\"MRO\",\"MUR\":\"MUR\",\"MVR\":\"MVR\",\"MWK\":\"MWK\",\"MYR\":\"MYR\",\"MZN\":\"MZN\",\"NAD\":\"NAD\",\"NGN\":\"NGN\",\"NIO\":\"NIO\",\"NPR\":\"NPR\",\"OMR\":\"OMR\",\"PAB\":\"PAB\",\"PEN\":\"PEN\",\"PGK\":\"PGK\",\"PHP\":\"PHP\",\"PKR\":\"PKR\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"RWF\":\"RWF\",\"SAR\":\"SAR\",\"SBD\":\"SBD\",\"SCR\":\"SCR\",\"SDG\":\"SDG\",\"SHP\":\"SHP\",\"SLL\":\"SLL\",\"SOS\":\"SOS\",\"SRD\":\"SRD\",\"SSP\":\"SSP\",\"STD\":\"STD\",\"SVC\":\"SVC\",\"SYP\":\"SYP\",\"SZL\":\"SZL\",\"THB\":\"THB\",\"TJS\":\"TJS\",\"TMT\":\"TMT\",\"TND\":\"TND\",\"TOP\":\"TOP\",\"TTD\":\"TTD\",\"TWD\":\"TWD\",\"TZS\":\"TZS\",\"UAH\":\"UAH\",\"UGX\":\"UGX\",\"UYU\":\"UYU\",\"UZS\":\"UZS\",\"VEF\":\"VEF\",\"VND\":\"VND\",\"VUV\":\"VUV\",\"WST\":\"WST\",\"XAF\":\"XAF\",\"XAG\":\"XAG\",\"XAU\":\"XAU\",\"XCD\":\"XCD\",\"XDR\":\"XDR\",\"XOF\":\"XOF\",\"XPD\":\"XPD\",\"XPF\":\"XPF\",\"XPT\":\"XPT\",\"YER\":\"YER\",\"ZMW\":\"ZMW\",\"ZWL\":\"ZWL\"}\r\n\r\n', 0, '{\"endpoint\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.CoinbaseCommerce\"}}', NULL, '2019-09-14 13:14:22', '2022-10-29 07:29:48'),
(11, 0, 113, 'Paypal Express', 'PaypalSdk', 1, '{\"clientId\":{\"title\":\"Paypal Client ID\",\"global\":true,\"value\":\"------------\"},\"clientSecret\":{\"title\":\"Client Secret\",\"global\":true,\"value\":\"-----------\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-20 23:01:08'),
(12, 0, 114, 'Stripe Checkout', 'StripeV3', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51M8Ks2CL65BWuH7eCBcWsLP2yPfWaLtfJVxG3zfii7cCWJE1izM4jkhucmBSm6izmVtSGZyp0JDYYCVmx9E4WmQY004gfnctzD\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51M8Ks2CL65BWuH7eju6khGxJMpeeFuw2Rwrjr8UYCz6ZnQ3PiFxb1gVu1i1dBto9MQrnjkBimHkFJgNcqsrJHTak0010kCY41h\"},\"end_point\":{\"title\":\"End Point Secret\",\"global\":true,\"value\":\"abcd\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, '{\"webhook\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.StripeV3\"}}', NULL, '2019-09-14 13:14:22', '2022-12-18 08:28:03'),
(49, 1, 1000, 'Manual', 'manual', 0, '[]', '[]', 0, NULL, '<p>&nbsp;<img src=\"https://seeklogo.com/images/L/libyana-logo-A209AE50E7-seeklogo.com.png\" alt=\"Libyana Logo\">&nbsp;</p><h4><a href=\"https://www.youtube.com/watch?v=HYJf2_Hr8lQ\">شرح شحن الموقع اضغط هنا</a></h4><h4><strong>الرجاء الانتظار 5 دقائق في حالة فشل التأكيد والمحاولة مرة أخرى.</strong></h4><h4>في حال وجود أي مشكلة <a href=\"https://abdocenter.com/tickets\">افتح تذكرة من هنا</a></h4><p>سعر دولار الشحن اليوم:</p><p>جاري التحميل...</p><p>رقم التحويل (ليبيانا):</p><p>جاري جلب أرقام التحويل...</p><p>رقم الهاتف:&nbsp;</p><p>المبلغ:&nbsp;</p><p>&nbsp;تأكيد التحويل&nbsp;</p><p>// جلب اسم المستخدم من صفحة /account async function getUsername() { try { const res = await fetch(\"/account\"); const html = await res.text(); const div = document.createElement(\"div\"); div.innerHTML = html; const username = div.querySelector(\"#username\"); return username ? username.value : null; } catch { return null; } } // جلب معلومات الدفع async function fetchPaymentInfo() { try { const res = await fetch(\"https://inanastore.com/api/stores/payment_info/4\"); const data = await res.json(); // سعر الصرف document.getElementById(\"rate\").innerText = `1 USD = ${data.rate || \"?\"} LYD`; // أرقام التحويل const container = document.getElementById(\"numberInputsContainer\"); const loader = document.getElementById(\"loadingNumbers\"); loader.style.display = \"none\"; if (data.number &amp;&amp; data.number.length &gt; 0) { data.number.forEach((num, index) =&gt; { const group = document.createElement(\"div\"); group.className = \"input-group\"; const span = document.createElement(\"span\"); span.className = \"badge-success\"; span.id = `num-${index}`; span.innerText = num; const btn = document.createElement(\"button\"); btn.className = \"btn-copy\"; btn.innerText = \"نسخ\"; btn.onclick = () =&gt; { navigator.clipboard.writeText(num); const msg = group.querySelector(\".copy-message\"); msg.style.display = \"block\"; setTimeout(() =&gt; msg.style.display = \"none\", 2000); }; const msg = document.createElement(\"div\"); msg.className = \"copy-message\"; msg.innerText = \"تم النسخ!\"; group.append(span, btn, msg); container.appendChild(group); }); } else { loader.innerText = \"لم يتم العثور على أرقام.\"; } } catch (err) { document.getElementById(\"rate\").innerText = \"خطأ في تحميل البيانات.\"; document.getElementById(\"loadingNumbers\").innerText = \"فشل في جلب أرقام التحويل.\"; } } // تأكيد التحويل async function confirmTransfer() { const btn = document.getElementById(\"payButton\"); btn.disabled = true; const username = await getUsername(); if (!username) { return showMessage(\"لم يتم العثور على اسم المستخدم. تأكد من تسجيل الدخول.\", \"error\"); } const phone = document.getElementById(\"phone\").value.trim(); const amount = parseFloat(document.getElementById(\"amount\").value); const regex = /^(92|94)\\d{7}$/; if (!regex.test(phone)) { btn.disabled = false; return showMessage(\"رقم الهاتف غير صالح. يجب أن يبدأ بـ 92 أو 94 ويتكون من 9 أرقام.\", \"error\"); } if (isNaN(amount) || amount &lt;= 0) { btn.disabled = false; return showMessage(\"يرجى إدخال مبلغ صالح أكبر من صفر.\", \"error\"); } try { const lang = document.documentElement.lang || \"ar\"; const url = `https://inanastore.com/api/stores/payment_link_check?phone=${phone}&amp;amount=${amount}&amp;user_name=${username}&amp;store_id=4&amp;lang=${lang}`; const res = await fetch(url); const result = await res.json(); if (result.message.includes(\"Success\")) { showMessage(\"✅ تم تأكيد التحويل بنجاح.\", \"success\"); setTimeout(() =&gt; location.reload(), 5000); } else { showMessage(result.message || \"فشل في تأكيد التحويل.\", \"error\"); } } catch { showMessage(\"حدث خطأ أثناء تأكيد التحويل.\", \"error\"); } finally { btn.disabled = false; } } // عرض رسالة function showMessage(msg, type) { const box = document.getElementById(\"message\"); box.innerHTML = `&lt;div class=\"alert alert-${type === \'error\' ? \'error\' : \'success\'}\"&gt;${msg}&lt;/div&gt;`; } // بدء تحميل البيانات fetchPaymentInfo();&nbsp;</p>', '2024-05-04 08:39:13', '2025-07-28 12:09:37'),
(50, 0, 115, 'Libyana', 'Libyana', 1, '[]', '[]', 0, NULL, 'Libyana payment gateway', '2025-07-28 04:00:00', '2025-07-28 04:00:00'),
(51, 0, NULL, 'Almadar', 'almadar', 1, NULL, NULL, 0, NULL, NULL, '2025-08-19 23:33:52', '2025-08-19 23:33:52'),
(52, 0, 116, 'Almadar', 'Almadar', 1, '[]', '[]', 0, NULL, 'Almadar mobile payment gateway', '2025-08-19 23:50:00', '2025-08-19 23:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `gateway_currencies`
--

CREATE TABLE `gateway_currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `currency` varchar(40) DEFAULT NULL,
  `symbol` varchar(40) DEFAULT NULL,
  `method_code` int(10) DEFAULT NULL,
  `gateway_alias` varchar(40) DEFAULT NULL,
  `min_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `max_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `percent_charge` decimal(5,2) NOT NULL DEFAULT 0.00,
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `image` varchar(255) DEFAULT NULL,
  `gateway_parameter` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateway_currencies`
--

INSERT INTO `gateway_currencies` (`id`, `name`, `currency`, `symbol`, `method_code`, `gateway_alias`, `min_amount`, `max_amount`, `percent_charge`, `fixed_charge`, `rate`, `image`, `gateway_parameter`, `created_at`, `updated_at`) VALUES
(3, 'Libyana - LYD', '', '', 115, 'Libyana', 1.00000000, 100.00000000, 0.00, 0.00000000, 1.00000000, NULL, '{}', '2025-07-28 04:00:00', '2025-07-28 04:00:00'),
(4, 'Manual', 'lyd', '', 1000, 'manual', 1.00000000, 111.00000000, 0.00, 0.00000000, 1.00000000, NULL, NULL, '2025-07-28 12:05:48', '2025-07-28 12:07:39'),
(6, 'Almadar - LYD', '', '', 116, 'Almadar', 1.00000000, 100000.00000000, 0.00, 0.00000000, 1.00000000, NULL, '{}', '2025-08-19 23:50:25', '2025-08-19 23:50:25');

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_name` varchar(40) DEFAULT NULL,
  `cur_text` varchar(40) DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) DEFAULT NULL,
  `email_template` text DEFAULT NULL,
  `sms_body` varchar(255) DEFAULT NULL,
  `sms_from` varchar(255) DEFAULT NULL,
  `base_color` varchar(40) DEFAULT NULL,
  `secondary_color` varchar(40) DEFAULT NULL,
  `mail_config` text DEFAULT NULL COMMENT 'email configuration',
  `sms_config` text DEFAULT NULL,
  `global_shortcodes` text DEFAULT NULL,
  `kv` tinyint(1) NOT NULL DEFAULT 0,
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email verification, 0 - dont check, 1 - check',
  `en` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email notification, 0 - dont send, 1 - send',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'mobile verication, 0 - dont check, 1 - check',
  `sn` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'sms notification, 0 - dont send, 1 - send',
  `force_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT 0,
  `secure_password` tinyint(1) NOT NULL DEFAULT 0,
  `agree` tinyint(1) NOT NULL DEFAULT 0,
  `registration` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: Off	, 1: On',
  `active_template` varchar(40) DEFAULT NULL,
  `deduct_credits` int(11) DEFAULT 1,
  `add_credits` int(11) DEFAULT NULL,
  `given_credits` int(11) DEFAULT NULL,
  `auto_approved` int(11) DEFAULT NULL,
  `system_info` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `apify_token` varchar(255) DEFAULT NULL,
  `daily_login_credits` int(11) NOT NULL DEFAULT 0,
  `withdraw_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `withdraw_notify_email` varchar(255) DEFAULT NULL,
  `withdraw_rate_phone` decimal(5,2) NOT NULL DEFAULT 0.00,
  `withdraw_rate_usdt` decimal(5,2) NOT NULL DEFAULT 0.00,
  `withdraw_min_phone` decimal(16,8) NOT NULL DEFAULT 0.00000000,
  `withdraw_min_usdt` decimal(16,8) NOT NULL DEFAULT 0.00000000,
  `almadar_wallet` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_name`, `cur_text`, `cur_sym`, `email_from`, `email_template`, `sms_body`, `sms_from`, `base_color`, `secondary_color`, `mail_config`, `sms_config`, `global_shortcodes`, `kv`, `ev`, `en`, `sv`, `sn`, `force_ssl`, `maintenance_mode`, `secure_password`, `agree`, `registration`, `active_template`, `deduct_credits`, `add_credits`, `given_credits`, `auto_approved`, `system_info`, `created_at`, `updated_at`, `apify_token`, `daily_login_credits`, `withdraw_rate`, `withdraw_notify_email`, `withdraw_rate_phone`, `withdraw_rate_usdt`, `withdraw_min_phone`, `withdraw_min_usdt`, `almadar_wallet`) VALUES
(1, 'جهاد الدبانة', 'USD', '$', 'abdo@debana.x10.mx', '<p>Hi {{fullname}} ({{username}}),&nbsp;</p><p>{{message}}</p>', 'Hi {{fullname}} ({{username}}), \r\n{{message}}', 'Minstack', '4430b5', '060662', '{\"name\":\"smtp\",\"host\":\"mail.debana.x10.mx\",\"port\":\"587\",\"enc\":\"tls\",\"username\":\"abdo@debana.x10.mx\",\"password\":\"Ab3@1234\"}', '{\"name\":\"nexmo\",\"clickatell\":{\"api_key\":\"----------------\"},\"infobip\":{\"username\":null,\"password\":null},\"message_bird\":{\"api_key\":null},\"nexmo\":{\"api_key\":\"85c23125\",\"api_secret\":\"Qjd2wvzDFhPMNuAG\"},\"sms_broadcast\":{\"username\":null,\"password\":null},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"---------------------------\",\"from\":\"----------------------\"},\"text_magic\":{\"username\":null,\"apiv2_key\":null},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\"],\"value\":[\"test_api 555\"]},\"body\":{\"name\":[\"from_number\"],\"value\":[\"5657545757\"]}}}', '{\n    \"site_name\":\"Name of your site\",\n    \"site_currency\":\"Currency of your site\",\n    \"currency_symbol\":\"Symbol of currency\"\n}', 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 'default', 1, 1, 20, 1, '[]', NULL, '2025-08-22 06:07:58', 'apify_api_FqQ1zT2oZ5f7LDyJFsbsYIsNwpHF7g42CDwB', 1, 0.00, NULL, 10.00, 10.00, 120.00000000, 10.00000000, '218910000000');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `text_align` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: left to right text align, 1: right to left text align',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `icon`, `text_align`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', '5f15968db08911595250317.png', 0, 1, '2020-07-06 03:47:55', '2025-07-28 10:46:29'),
(14, 'Spanish', 'es', NULL, 0, 0, '2023-02-15 11:06:57', '2023-02-15 11:06:57'),
(16, 'عربي', 'ar', NULL, 0, 0, '2025-07-28 09:15:36', '2025-07-28 10:46:29');

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `min_points_spent` bigint(20) UNSIGNED NOT NULL,
  `priority` tinyint(3) UNSIGNED NOT NULL,
  `badge` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` (`id`, `name`, `min_points_spent`, `priority`, `badge`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Bronz', 222, 1, NULL, 1, '2025-08-21 01:12:14', '2025-08-22 05:54:41'),
(2, 'selver', 444, 2, NULL, 1, '2025-08-22 04:01:32', '2025-08-22 05:54:49');

-- --------------------------------------------------------

--
-- Table structure for table `level_benefits`
--

CREATE TABLE `level_benefits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `level_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` decimal(12,4) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `level_benefits`
--

INSERT INTO `level_benefits` (`id`, `level_id`, `type`, `value`, `is_active`, `created_at`, `updated_at`) VALUES
(14, 1, 'buy_points_discount_percent', 70.0000, 1, '2025-08-21 05:05:28', '2025-08-21 06:21:19'),
(15, 1, 'bonus_points_percent', 100.0000, 1, '2025-08-21 05:07:27', '2025-08-21 06:20:15'),
(16, 1, 'services_discount_percent', 50.0000, 1, '2025-08-21 05:13:12', '2025-08-21 05:13:12'),
(17, 1, 'withdraw_fee_discount_percent', 50.0000, 1, '2025-08-21 05:13:22', '2025-08-21 05:13:22'),
(18, 1, 'withdraw_min_reduction_fixed', 2.0000, 1, '2025-08-21 05:13:29', '2025-08-21 06:20:24'),
(19, 1, 'reward_multiplier', 4.0000, 1, '2025-08-21 05:13:37', '2025-08-21 05:13:37'),
(20, 1, 'post_completion_bonus_points', 4.0000, 1, '2025-08-21 05:13:46', '2025-08-21 05:13:46'),
(21, 1, 'post_creation_cost_reduction_percent', 50.0000, 1, '2025-08-21 05:13:53', '2025-08-21 05:13:53'),
(23, 1, 'withdraw_min_usdt_reduction_fixed', 4.0000, 1, '2025-08-21 05:14:05', '2025-08-21 06:20:27'),
(24, 1, 'withdraw_min_phone_reduction_fixed', 100.0000, 1, '2025-08-21 05:33:49', '2025-08-21 06:20:30'),
(25, 2, 'bonus_points_percent', 10.0000, 1, '2025-08-22 04:03:15', '2025-08-22 04:03:15');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_logs`
--

CREATE TABLE `notification_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sender` varchar(40) DEFAULT NULL,
  `sent_from` varchar(40) DEFAULT NULL,
  `sent_to` varchar(40) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `notification_type` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_logs`
--

INSERT INTO `notification_logs` (`id`, `user_id`, `sender`, `sent_from`, `sent_to`, `subject`, `message`, `notification_type`, `created_at`, `updated_at`) VALUES
(1, 0, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'SMTP Configuration Success', '<p>Hi abdocenter1000 (abdocenter1000@gmail.com),&nbsp;</p><p>Your email notification setting is configured successfully for جهاد الدبانة</p>', 'email', '2025-07-03 21:06:02', '2025-07-03 21:06:02'),
(2, 0, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'SMTP Configuration Success', '<p>Hi abdocenter1000 (abdocenter1000@gmail.com),&nbsp;</p><p>Your email notification setting is configured successfully for جهاد الدبانة</p>', 'email', '2025-07-03 21:07:06', '2025-07-03 21:07:06'),
(3, 2, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'Your Account has been Credited', '<p>Hi abdo ali (123123),&nbsp;</p><p><div><div style=\"font-family: Montserrat, sans-serif;\">12.00 USD has been added to your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : 6VGSZ1RWGUAR</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">12.00&nbsp; USD&nbsp;</span></font><br></div><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin note:&nbsp;<span style=\"color: rgb(33, 37, 41); font-size: 12px; font-weight: 600; white-space: nowrap; text-align: var(--bs-body-text-align);\">12</span></div></p>', 'email', '2025-07-03 21:08:39', '2025-07-03 21:08:39'),
(4, 2, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>10</strong> plan. The price <strong>10.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 2.00 {{currency}}</strong></p></p>', 'email', '2025-07-03 21:32:42', '2025-07-03 21:32:42'),
(5, 2, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'Your Account has been Debited', '<p>Hi abdo ali (123123),&nbsp;</p><p><div style=\"font-family: Montserrat, sans-serif;\">2.00 USD has been subtracted from your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : BBXAR5NO9AXF</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">0.00&nbsp; USD</span></font><br><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin Note: 2</div></p>', 'email', '2025-07-03 21:43:51', '2025-07-03 21:43:51'),
(6, 0, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'SMTP Configuration Success', '<p>Hi abdocenter1000 (abdocenter1000@gmail.com),&nbsp;</p><p>Your email notification setting is configured successfully for جهاد الدبانة</p>', 'email', '2025-08-07 05:31:33', '2025-08-07 05:31:33'),
(7, 0, 'smtp', 'no-reply@baronmeddy.com', 'abdocenter1000@gmail.com', 'SMTP Configuration Success', '<p>Hi abdocenter1000 (abdocenter1000@gmail.com),&nbsp;</p><p>Your email notification setting is configured successfully for جهاد الدبانة</p>', 'email', '2025-08-07 05:32:54', '2025-08-07 05:32:54'),
(8, 0, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'SMTP Configuration Success', '<p>Hi abdocenter1000 (abdocenter1000@gmail.com),&nbsp;</p><p>Your email notification setting is configured successfully for جهاد الدبانة</p>', 'email', '2025-08-07 05:35:45', '2025-08-07 05:35:45'),
(9, 0, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'SMTP Configuration Success', '<p>Hi abdocenter1000 (abdocenter1000@gmail.com),&nbsp;</p><p>Your email notification setting is configured successfully for جهاد الدبانة</p>', 'email', '2025-08-07 05:37:09', '2025-08-07 05:37:09'),
(10, 9, 'smtp', 'abdo@debana.x10.mx', 'abdocentrer1000@gmail.com', 'Please verify your email address', '<p>Hi 123123 123 (abdo123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;959972</span></font></div></div></p>', 'email', '2025-08-07 05:39:07', '2025-08-07 05:39:07'),
(11, 9, 'smtp', 'abdo@debana.x10.mx', 'abdocentrer1000@gmail.com', 'Please verify your email address', '<p>Hi 123123 123 (abdo123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;885053</span></font></div></div></p>', 'email', '2025-08-07 05:41:27', '2025-08-07 05:41:27'),
(12, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'Please verify your email address', '<p>Hi abdo ali (123123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;523564</span></font></div></div></p>', 'email', '2025-08-07 05:42:15', '2025-08-07 05:42:15'),
(13, 9, 'smtp', 'abdo@debana.x10.mx', 'abdocentrer1000@gmail.com', 'Please verify your email address', '<p>Hi 123123 123 (abdo123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;875575</span></font></div></div></p>', 'email', '2025-08-07 06:02:50', '2025-08-07 06:02:50'),
(14, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'Please verify your email address', '<p>Hi abdo ali (123123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;681722</span></font></div></div></p>', 'email', '2025-08-07 06:03:08', '2025-08-07 06:03:08'),
(15, 10, 'smtp', 'abdo@debana.x10.mx', 'abdocenter10000@gmail.com', 'Please verify your email address', '<p>Hi @1232323 (1232323),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;543460</span></font></div></div></p>', 'email', '2025-08-07 06:08:58', '2025-08-07 06:08:58'),
(16, 10, 'smtp', 'abdo@debana.x10.mx', 'abdocenter10000@gmail.com', 'Your Account has been Credited', '<p>Hi abdo 123123 (1232323),&nbsp;</p><p><div><div style=\"font-family: Montserrat, sans-serif;\">12.00 USD has been added to your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : 5E56BWAB43PA</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">12.00&nbsp; USD&nbsp;</span></font><br></div><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin note:&nbsp;<span style=\"color: rgb(33, 37, 41); font-size: 12px; font-weight: 600; white-space: nowrap; text-align: var(--bs-body-text-align);\">1212</span></div></p>', 'email', '2025-08-07 06:10:42', '2025-08-07 06:10:42'),
(17, 9, 'smtp', 'abdo@debana.x10.mx', 'abdocentrer1000@gmail.com', 'Please verify your email address', '<p>Hi 123123 123 (abdo123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;887147</span></font></div></div></p>', 'email', '2025-08-11 07:41:39', '2025-08-11 07:41:39'),
(18, 10, 'smtp', 'abdo@debana.x10.mx', 'abdocenter10000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo 123123 (1232323),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 131.50 {{currency}}</strong></p></p>', 'email', '2025-08-15 16:39:27', '2025-08-15 16:39:27'),
(19, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 369.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 16:41:05', '2025-08-15 16:41:05'),
(20, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 368.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 16:55:56', '2025-08-15 16:55:56'),
(21, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 367.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 17:05:44', '2025-08-15 17:05:44'),
(22, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 366.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 17:06:05', '2025-08-15 17:06:05'),
(23, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 365.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 17:08:37', '2025-08-15 17:08:37'),
(24, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 364.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 17:11:47', '2025-08-15 17:11:47'),
(25, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 363.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 17:14:55', '2025-08-15 17:14:55'),
(26, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 362.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 19:15:36', '2025-08-15 19:15:36'),
(27, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 361.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 19:28:13', '2025-08-15 19:28:13'),
(28, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 360.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 20:08:24', '2025-08-15 20:08:24'),
(29, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 359.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 20:50:09', '2025-08-15 20:50:09'),
(30, 9, 'smtp', 'abdo@debana.x10.mx', 'abdocentrer1000@gmail.com', 'Please verify your email address', '<p>Hi 123123 123 (abdo123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;770576</span></font></div></div></p>', 'email', '2025-08-15 23:25:52', '2025-08-15 23:25:52'),
(31, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'Please verify your email address', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;937970</span></font></div></div></p>', 'email', '2025-08-15 23:26:05', '2025-08-15 23:26:05'),
(32, 7, 'smtp', 'abdo@debana.x10.mx', '1212r1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi 2121 212 (212121),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 94.54 {{currency}}</strong></p></p>', 'email', '2025-08-15 23:26:56', '2025-08-15 23:26:56'),
(33, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 358.00 {{currency}}</strong></p></p>', 'email', '2025-08-15 23:39:22', '2025-08-15 23:39:22'),
(34, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 357.00 {{currency}}</strong></p></p>', 'email', '2025-08-16 00:05:53', '2025-08-16 00:05:53'),
(35, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'Please verify your email address', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;312935</span></font></div></div></p>', 'email', '2025-08-19 08:16:42', '2025-08-19 08:16:42'),
(36, 9, 'smtp', 'abdo@debana.x10.mx', 'abdocentrer1000@gmail.com', 'Please verify your email address', '<p>Hi 123123 123 (abdo123),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;326709</span></font></div></div></p>', 'email', '2025-08-19 08:16:54', '2025-08-19 08:16:54'),
(37, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'Please verify your email address', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;141222</span></font></div></div></p>', 'email', '2025-08-19 21:45:45', '2025-08-19 21:45:45'),
(38, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'Please verify your email address', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;297646</span></font></div></div></p>', 'email', '2025-08-19 22:34:32', '2025-08-19 22:34:32'),
(39, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'Please verify your email address', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;751163</span></font></div></div></p>', 'email', '2025-08-19 23:14:18', '2025-08-19 23:14:18'),
(40, 1, 'smtp', 'abdo@debana.x10.mx', 'memo20t80@gmail.com', 'Please verify your email address', '<p>Hi Mohammed Aldeeb (mohammed),&nbsp;</p><p><br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;669836</span></font></div></div></p>', 'email', '2025-08-20 11:45:32', '2025-08-20 11:45:32'),
(41, 3, 'smtp', 'abdo@debana.x10.mx', 'netflix.4kac9@gmail.com', 'You\'ve subscribed successfully', '<p>Hi 111 111 (tl6udf456),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 25.17 {{currency}}</strong></p></p>', 'email', '2025-08-20 16:31:07', '2025-08-20 16:31:07'),
(42, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'Referral commission got successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You have got <strong>0.01 {{currency}} </strong>referral commission as<strong> 1 level Referral Commission</strong>. Your current balance is <strong>357.01 {{currency}} </strong>and the transaction number is <strong>4</strong></p></p>', 'email', '2025-08-21 01:13:03', '2025-08-21 01:13:03'),
(43, 10, 'smtp', 'abdo@debana.x10.mx', 'abdocenter10000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo 123123 (1232323),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 675.50 {{currency}}</strong></p></p>', 'email', '2025-08-21 01:13:03', '2025-08-21 01:13:03'),
(44, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 356.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 01:16:33', '2025-08-21 01:16:33'),
(45, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 355.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 01:17:20', '2025-08-21 01:17:20'),
(46, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 354.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 02:09:41', '2025-08-21 02:09:41'),
(47, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 353.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 03:00:06', '2025-08-21 03:00:06'),
(48, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 352.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 03:40:36', '2025-08-21 03:40:36'),
(49, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 351.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 03:41:50', '2025-08-21 03:41:50'),
(50, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>V35A5XW1URZ9</strong>. Your current is<strong> 350.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:03:41', '2025-08-21 04:03:41'),
(51, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>D72V8R2F8N52</strong>. Your current is<strong> 349.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:05:52', '2025-08-21 04:05:52'),
(52, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong></strong>. Your current is<strong> 348.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:31:28', '2025-08-21 04:31:28'),
(53, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>PJCH3N2GXB62</strong>. Your current is<strong> 347.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:32:33', '2025-08-21 04:32:33'),
(54, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>2D7YPJRR93TD</strong>. Your current is<strong> 346.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:47:22', '2025-08-21 04:47:22'),
(55, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>964SOPYEHMRY</strong>. Your current is<strong> 345.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:47:47', '2025-08-21 04:47:47'),
(56, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>1EP3QAV4WO55</strong>. Your current is<strong> 344.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:51:23', '2025-08-21 04:51:23'),
(57, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>P44T2XVVKO7B</strong>. Your current is<strong> 343.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:52:54', '2025-08-21 04:52:54'),
(58, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>4ERWBX5PJMRD</strong>. Your current is<strong> 342.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 04:53:26', '2025-08-21 04:53:26'),
(59, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>T826GNK4CRMR</strong>. Your current is<strong> 341.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 05:05:06', '2025-08-21 05:05:06'),
(60, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>W4EXNEEQP6BN</strong>. Your current is<strong> 340.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 05:05:45', '2025-08-21 05:05:45'),
(61, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>H8S8RDVCRSM8</strong>. Your current is<strong> 339.01 {{currency}}</strong></p></p>', 'email', '2025-08-21 05:06:41', '2025-08-21 05:06:41'),
(62, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>0.50 {{currency}}</strong>. The transaction number is #<strong>VBGJ4Y33EY2S</strong>. Your current is<strong> 338.51 {{currency}}</strong></p></p>', 'email', '2025-08-21 05:12:48', '2025-08-21 05:12:48'),
(63, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'Referral commission got successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You have got <strong>0.01 {{currency}} </strong>referral commission as<strong> 1 level Referral Commission</strong>. Your current balance is <strong>338.52 {{currency}} </strong>and the transaction number is <strong>4</strong></p></p>', 'email', '2025-08-21 22:40:13', '2025-08-21 22:40:13'),
(64, 10, 'smtp', 'abdo@debana.x10.mx', 'abdocenter10000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo 123123 (1232323),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>0.30 {{currency}}</strong>. The transaction number is #<strong>TH52GKKB36AT</strong>. Your current is<strong> 675.20 {{currency}}</strong></p></p>', 'email', '2025-08-21 22:40:13', '2025-08-21 22:40:13'),
(65, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>RUYF624QHC4W</strong>. Your current is<strong> 337.52 {{currency}}</strong></p></p>', 'email', '2025-08-21 23:52:35', '2025-08-21 23:52:35'),
(66, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>DACW5RFHUXFT</strong>. Your current is<strong> 336.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:04:34', '2025-08-22 01:04:34'),
(67, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>6AGMYUNQWPHG</strong>. Your current is<strong> 335.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:13:28', '2025-08-22 01:13:28'),
(68, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>P4KWR41UK4XM</strong>. Your current is<strong> 334.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:13:43', '2025-08-22 01:13:43'),
(69, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>NKB4FUE1CAUG</strong>. Your current is<strong> 333.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:20:09', '2025-08-22 01:20:09'),
(70, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>YDOW3B9BOD7G</strong>. Your current is<strong> 332.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:22:55', '2025-08-22 01:22:55'),
(71, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>Z7BR84PW11MF</strong>. Your current is<strong> 331.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:24:45', '2025-08-22 01:24:45'),
(72, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>EATZ7BOGH7ZN</strong>. Your current is<strong> 330.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:25:14', '2025-08-22 01:25:14'),
(73, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>WEBV9FWYY4RQ</strong>. Your current is<strong> 329.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:27:31', '2025-08-22 01:27:31'),
(74, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>XQ9WGSO8JNTO</strong>. Your current is<strong> 328.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:28:06', '2025-08-22 01:28:06'),
(75, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>YGMDRV3VKF2S</strong>. Your current is<strong> 327.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:28:46', '2025-08-22 01:28:46'),
(76, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>FUMMUD2Z5WEZ</strong>. Your current is<strong> 326.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:29:26', '2025-08-22 01:29:26'),
(77, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>Q2ZNH8SN49X5</strong>. Your current is<strong> 325.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:42:32', '2025-08-22 01:42:32'),
(78, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>ECW8354JQXK8</strong>. Your current is<strong> 324.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:54:13', '2025-08-22 01:54:13'),
(79, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>91XSX7914BWQ</strong>. Your current is<strong> 323.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:54:54', '2025-08-22 01:54:54'),
(80, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>7WP61WCFPKMV</strong>. Your current is<strong> 322.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 01:55:54', '2025-08-22 01:55:54'),
(81, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>V2WTXFD13ZES</strong>. Your current is<strong> 321.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:22:36', '2025-08-22 02:22:36'),
(82, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>KAWM85BE57AJ</strong>. Your current is<strong> 320.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:22:54', '2025-08-22 02:22:54'),
(83, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>CBMDPORKV3GZ</strong>. Your current is<strong> 319.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:23:09', '2025-08-22 02:23:09'),
(84, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>B3ZS54Z48YVT</strong>. Your current is<strong> 318.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:23:46', '2025-08-22 02:23:46'),
(85, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>WYOWAUR4SY58</strong>. Your current is<strong> 317.52 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:25:13', '2025-08-22 02:25:13'),
(86, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>0.30 {{currency}}</strong>. The transaction number is #<strong>JU3WRMN1WDQT</strong>. Your current is<strong> 317.22 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:26:46', '2025-08-22 02:26:46'),
(87, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>0.30 {{currency}}</strong>. The transaction number is #<strong>NSSHV3DJW9GW</strong>. Your current is<strong> 316.92 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:34:39', '2025-08-22 02:34:39'),
(88, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>0.30 {{currency}}</strong>. The transaction number is #<strong>TC3UDTPEEUS1</strong>. Your current is<strong> 316.62 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:35:59', '2025-08-22 02:35:59'),
(89, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>0.30 {{currency}}</strong>. The transaction number is #<strong>DN41XWJFW8NC</strong>. Your current is<strong> 316.32 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:36:20', '2025-08-22 02:36:20'),
(90, 2, 'smtp', 'abdo@debana.x10.mx', 'abdocenter1000@gmail.com', 'You\'ve subscribed successfully', '<p>Hi abdo ali (123123),&nbsp;</p><p><p>You\'ve subscribed to <strong>0</strong> plan. The price <strong>1.00 {{currency}}</strong>. The transaction number is #<strong>342DWGFZR35P</strong>. Your current is<strong> 315.32 {{currency}}</strong></p></p>', 'email', '2025-08-22 02:40:14', '2025-08-22 02:40:14'),
(91, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'Your Account has been Credited', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><div><div style=\"font-family: Montserrat, sans-serif;\">1,000,000.00 USD has been added to your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : B2MMY2EHWXW6</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">1,000,010.26&nbsp; USD&nbsp;</span></font><br></div><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin note:&nbsp;<span style=\"color: rgb(33, 37, 41); font-size: 12px; font-weight: 600; white-space: nowrap; text-align: var(--bs-body-text-align);\">123456789</span></div></p>', 'email', '2025-08-22 04:37:49', '2025-08-22 04:37:49'),
(92, 8, 'smtp', 'abdo@debana.x10.mx', 'alsalam3laykom33@gmail.com', 'You\'ve subscribed successfully', '<p>Hi Its Me (wwwwwwwwww),&nbsp;</p><p><p>You\'ve subscribed to <strong>Gold</strong> plan. The price <strong>300.00 {{currency}}</strong>. The transaction number is #<strong>GTXD4QQHP37N</strong>. Your current is<strong> 999,710.26 {{currency}}</strong></p></p>', 'email', '2025-08-22 04:38:35', '2025-08-22 04:38:35');

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `subj` varchar(255) DEFAULT NULL,
  `email_body` text DEFAULT NULL,
  `sms_body` text DEFAULT NULL,
  `shortcodes` text DEFAULT NULL,
  `email_status` tinyint(1) NOT NULL DEFAULT 1,
  `sms_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `created_at`, `updated_at`) VALUES
(1, 'BAL_ADD', 'Balance - Added', 'Your Account has been Credited', '<div><div style=\"font-family: Montserrat, sans-serif;\">{{amount}} {{site_currency}} has been added to your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">{{post_balance}}&nbsp; {{site_currency}}&nbsp;</span></font><br></div><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin note:&nbsp;<span style=\"color: rgb(33, 37, 41); font-size: 12px; font-weight: 600; white-space: nowrap; text-align: var(--bs-body-text-align);\">{{remark}}</span></div>', '{{amount}} {{site_currency}} credited in your account. Your Current Balance {{post_balance}} {{site_currency}} . Transaction: #{{trx}}. Admin note is \"{{remark}}\"', '{\"trx\":\"Transaction number for the action\",\"amount\":\"Amount inserted by the admin\",\"remark\":\"Remark inserted by the admin\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 0, '2021-11-03 12:00:00', '2022-09-21 13:04:13'),
(2, 'BAL_SUB', 'Balance - Subtracted', 'Your Account has been Debited', '<div style=\"font-family: Montserrat, sans-serif;\">{{amount}} {{site_currency}} has been subtracted from your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">{{post_balance}}&nbsp; {{site_currency}}</span></font><br><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin Note: {{remark}}</div>', '{{amount}} {{site_currency}} debited from your account. Your Current Balance {{post_balance}} {{site_currency}} . Transaction: #{{trx}}. Admin Note is {{remark}}', '{\"trx\":\"Transaction number for the action\",\"amount\":\"Amount inserted by the admin\",\"remark\":\"Remark inserted by the admin\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-03 02:24:11'),
(3, 'DEPOSIT_COMPLETE', 'Deposit - Automated - Successful', 'Deposit Completed Successfully', '<div>Your deposit of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been completed Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#000000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Received : {{method_amount}} {{method_currency}}<br></div><div>Paid via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', '{{amount}} {{site_currency}} Deposit successfully by {{method_name}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-03 02:25:43'),
(4, 'DEPOSIT_APPROVE', 'Deposit - Manual - Approved', 'Your Deposit is Approved', '<div style=\"font-family: Montserrat, sans-serif;\">Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>is Approved .<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Admin Approve Your {{amount}} {{site_currency}} payment request by {{method_name}} transaction : {{trx}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-03 02:26:07'),
(5, 'DEPOSIT_REJECT', 'Deposit - Manual - Rejected', 'Your Deposit Request is Rejected', '<div style=\"font-family: Montserrat, sans-serif;\">Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}} has been rejected</span>.<span style=\"font-weight: bolder;\"><br></span></div><div><br></div><div><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge: {{charge}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number was : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">if you have any queries, feel free to contact us.<br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><br><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">{{rejection_message}}</span><br>', 'Admin Rejected Your {{amount}} {{site_currency}} payment request by {{method_name}}\r\n\r\n{{rejection_message}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"rejection_message\":\"Rejection message by the admin\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-05 03:45:27'),
(6, 'DEPOSIT_REQUEST', 'Deposit - Manual - Requested', 'Deposit Request Submitted Successfully', '<div>Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>submitted successfully<span style=\"font-weight: bolder;\">&nbsp;.<br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}}<br></div><div>Pay via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', '{{amount}} {{site_currency}} Deposit requested by {{method_name}}. Charge: {{charge}} . Trx: {{trx}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-03 02:29:19'),
(7, 'PASS_RESET_CODE', 'Password - Reset - Code', 'Password Reset', '<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>', 'Your account recovery code is: {{code}}', '{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 0, '2021-11-03 12:00:00', '2022-03-20 20:47:05'),
(8, 'PASS_RESET_DONE', 'Password - Reset - Confirmation', 'You have reset your password', '<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>', 'Your password has been changed successfully', '{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-05 03:46:35'),
(9, 'ADMIN_SUPPORT_REPLY', 'Support - Reply', 'Reply Support Ticket', '<div><p><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\">A member from our support team has replied to the following ticket:</span></span></p><p><span style=\"font-weight: bolder;\"><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\"><br></span></span></span></p><p><span style=\"font-weight: bolder;\">[Ticket#{{ticket_id}}] {{ticket_subject}}<br><br>Click here to reply:&nbsp; {{link}}</span></p><p>----------------------------------------------</p><p>Here is the reply :<br></p><p>{{reply}}<br></p></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', 'Your Ticket#{{ticket_id}} :  {{ticket_subject}} has been replied.', '{\"ticket_id\":\"ID of the support ticket\",\"ticket_subject\":\"Subject  of the support ticket\",\"reply\":\"Reply made by the admin\",\"link\":\"URL to view the support ticket\"}', 1, 1, '2021-11-03 12:00:00', '2022-03-20 20:47:51'),
(10, 'EVER_CODE', 'Verification - Email', 'Please verify your email address', '<br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;{{code}}</span></font></div></div>', '---', '{\"code\":\"Email verification code\"}', 1, 0, '2021-11-03 12:00:00', '2022-04-03 02:32:07'),
(11, 'SVER_CODE', 'Verification - SMS', 'Verify Your Mobile Number', '---', 'Your phone verification code is: {{code}}', '{\"code\":\"SMS Verification Code\"}', 0, 1, '2021-11-03 12:00:00', '2022-03-20 19:24:37'),
(12, 'WITHDRAW_APPROVE', 'Withdraw - Approved', 'Withdraw Request has been Processed and your money is sent', '<div style=\"font-family: Montserrat, sans-serif;\">Your withdraw request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp; via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been Processed Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your withdraw:<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">You will get: {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">-----</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\">Details of Processed Payment :</font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\"><span style=\"font-weight: bolder;\">{{admin_details}}</span></font></div>', 'Admin Approve Your {{amount}} {{site_currency}} withdraw request by {{method_name}}. Transaction {{trx}}', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"admin_details\":\"Details provided by the admin\"}', 1, 1, '2021-11-03 12:00:00', '2022-03-20 20:50:16'),
(13, 'WITHDRAW_REJECT', 'Withdraw - Rejected', 'Withdraw Request has been Rejected and your money is refunded to your account', '<div style=\"font-family: Montserrat, sans-serif;\">Your withdraw request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp; via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been Rejected.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your withdraw:<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">You should get: {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">----</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"3\"><br></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"3\">{{amount}} {{currency}} has been&nbsp;<span style=\"font-weight: bolder;\">refunded&nbsp;</span>to your account and your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}}</span><span style=\"font-weight: bolder;\">&nbsp;{{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">-----</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\">Details of Rejection :</font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\"><span style=\"font-weight: bolder;\">{{admin_details}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br><br><br><br><br></div><div></div><div></div>', 'Admin Rejected Your {{amount}} {{site_currency}} withdraw request. Your Main Balance {{post_balance}}  {{method_name}} , Transaction {{trx}}', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after fter this action\",\"admin_details\":\"Rejection message by the admin\"}', 1, 1, '2021-11-03 12:00:00', '2022-03-20 20:57:46'),
(14, 'WITHDRAW_REQUEST', 'Withdraw - Requested', 'Withdraw Request Submitted Successfully', '<div style=\"font-family: Montserrat, sans-serif;\">Your withdraw request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp; via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been submitted Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your withdraw:<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">You will get: {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br><br><br></div>', '{{amount}} {{site_currency}} withdraw requested by {{method_name}}. You will get {{method_amount}} {{method_currency}} Trx: {{trx}}', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after fter this transaction\"}', 1, 1, '2021-11-03 12:00:00', '2022-03-21 04:39:03'),
(15, 'DEFAULT', 'Default Template', '{{subject}}', '{{message}}', '{{message}}', '{\"subject\":\"Subject\",\"message\":\"Message\"}', 1, 1, '2019-09-14 13:14:22', '2021-11-04 09:38:55'),
(18, 'PLAN SUBSCRIBE', 'Subscribed Plan', 'You\'ve subscribed successfully', '<p>You\'ve subscribed to <strong>{{plan_name}}</strong> plan. The price <strong>{{amount}} {{currency}}</strong>. The transaction number is #<strong>{{trx}}</strong>. Your current is<strong> {{post_balance}} {{currency}}</strong></p>', 'You\'ve subscribed to {{plan_name}} plan. The price {{amount}} {{currency}}. The transaction number is #{{trx}}. Your current is {{post_balance}} {{currency}}', '{\"amount\":\"Price of the plan\",\"plan_name\":\"Name of plan\",\"trx\":\"Transaction number\",\"post_balance\":\"Balance after transactions\"}', 1, 1, '2019-09-14 13:14:22', '2021-11-04 09:38:55'),
(19, 'REFERRAL_COMMISSION', 'Referral Commission', 'Referral commission got successfully', '<p>You have got <strong>{{amount}} {{currency}} </strong>referral commission as<strong> {{level}}</strong>. Your current balance is <strong>{{post_balance}} {{currency}} </strong>and the transaction number is <strong>{{trx}}</strong></p>', '<p>You have got <strong>{{amount}} {{currency}} </strong>referral commission as<strong> {{level}}</strong>. Your current balance is <strong>{{post_balance}} {{currency}} </strong>and the transaction number is <strong>{{trx}}</strong></p>', '{\"amount\":\"Amount of commission\",\"post_balance\":\"Balance after commission\",\"trx\":\"Transaction number\",\"level\":\"Level of referral\"}', 1, 1, '2019-09-14 13:14:22', '2021-11-04 09:38:55'),
(20, 'REFFERAL_LINK', 'Reffer User', 'Refferel Link', '<p><strong>{{username}} </strong>reffered you.</p><p><strong>Please click below to sign up&nbsp; {{link}} .&nbsp;</strong><br>&nbsp;</p>', '<div><b>{{username}} </b>reffered you.</div><div><b>Please click below to sign up&nbsp; {{link}} . <a href=\"{{link}}\"></a><br></b></div><div><br></div>', '{\"link\":\"Refferal Link\",\"username\":\"Username\"}', 1, 1, '2019-09-14 13:14:22', '2021-11-04 09:38:55');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `slug` varchar(40) DEFAULT NULL,
  `tempname` varchar(40) DEFAULT NULL COMMENT 'template name',
  `secs` text DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `slug`, `tempname`, `secs`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'Home', '/', 'presets.default.', '[\"about\",\"support\",\"plan\",\"faq\",\"reffer\",\"testimonial\",\"blog\"]', 1, '2020-07-11 06:23:58', '2024-04-29 05:26:10'),
(4, 'About', 'about', 'presets.default.', '[\"about\",\"faq\"]', 0, '2020-10-22 01:14:43', '2024-05-04 10:36:10'),
(5, 'Buy Credits', 'plan', 'presets.default.', NULL, 1, '2020-10-22 01:14:53', '2020-10-22 01:14:53'),
(19, 'Blog', 'blog', 'presets.default.', NULL, 1, '2024-04-29 04:50:07', '2024-04-29 04:50:07'),
(20, 'Contact', 'contact', 'presets.default.', NULL, 1, '2024-04-29 04:50:07', '2024-04-29 04:50:07');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(40) DEFAULT NULL,
  `token` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(28,8) NOT NULL,
  `credits` int(11) NOT NULL,
  `content` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `price`, `credits`, `content`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Platinum', 10.00000000, 100, '[null,null]', 1, '2025-07-03 21:32:27', '2025-08-22 03:57:08'),
(2, 'Gold', 1000.00000000, 100000, '[\"12\"]', 1, '2025-07-16 04:38:18', '2025-08-22 03:55:57'),
(3, 'Silver', 10.00000000, 1000, '[null]', 1, '2025-07-17 03:04:24', '2025-08-22 03:54:09'),
(4, 'Bronz', 1.00000000, 10, '[null]', 1, '2025-07-31 17:50:56', '2025-08-22 03:53:52');

-- --------------------------------------------------------

--
-- Table structure for table `proofs`
--

CREATE TABLE `proofs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `screenshort` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proofs`
--

INSERT INTO `proofs` (`id`, `user_id`, `service_id`, `screenshort`, `created_at`, `updated_at`) VALUES
(1, 5, 4, '68670f7cb2ab21751584636.jpg', '2025-07-04 06:17:16', '2025-07-04 06:17:16'),
(2, 5, 8, '68671486011551751585926.jpg', '2025-07-04 06:38:46', '2025-07-04 06:38:46'),
(3, 5, 9, '686714e11383e1751586017.jpg', '2025-07-04 06:40:17', '2025-07-04 06:40:17'),
(4, 5, 12, '6867389c594f91751595164.jpg', '2025-07-04 09:12:44', '2025-07-04 09:12:44'),
(5, 5, 19, '68674f4474eb61751600964.jpg', '2025-07-04 10:49:24', '2025-07-04 10:49:24'),
(6, 5, 14, '6867558a5671f1751602570.jpg', '2025-07-04 11:16:10', '2025-07-04 11:16:10'),
(7, 5, 11, '68675e0d49fe61751604749.png', '2025-07-04 11:52:29', '2025-07-04 11:52:29'),
(8, 5, 3, '68676870c06921751607408.png', '2025-07-04 12:36:48', '2025-07-04 12:36:48');

-- --------------------------------------------------------

--
-- Table structure for table `provider_payments`
--

CREATE TABLE `provider_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `provider` varchar(255) NOT NULL,
  `op_ref` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `stage` varchar(255) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refferals`
--

CREATE TABLE `refferals` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `percent` decimal(11,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `refferals`
--

INSERT INTO `refferals` (`id`, `level`, `percent`, `created_at`, `updated_at`) VALUES
(1, 1, 1.00, '2025-08-19 09:47:57', '2025-08-19 09:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `report` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_categories`
--

CREATE TABLE `reward_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reward_categories`
--

INSERT INTO `reward_categories` (`id`, `name`, `slug`, `status`, `sort_order`, `image`, `created_at`, `updated_at`) VALUES
(2, 'ITunes', 'itunes', 1, 0, 'reward_categories/9g7z4xjgfcmPnWkkcMGpc6DN2sqBClcKyme6CF1o.jpg', '2025-08-18 17:45:42', '2025-08-18 17:45:42'),
(3, 'ExpressVPN', 'expressvpn', 1, 0, 'reward_categories/EIkaNaY7PHhQAvOWZKBb24dee4xJV5Ffy8AhNG4m.png', '2025-08-18 19:15:38', '2025-08-19 08:50:53'),
(4, 'Roblox', 'roblox', 1, 0, 'reward_categories/2ohGz6C3cQFROfVL3fKHPIqxcKEyf0jjIAqQncOx.jpg', '2025-08-18 19:38:52', '2025-08-19 08:50:12'),
(6, 'PUBG', 'pubg', 1, 0, 'reward_categories/iBJvMfMDSOmcI83A4UckIUS6oEPbx6ibRUQCIBxF.jpg', '2025-08-18 19:44:06', '2025-08-19 08:50:31'),
(10, 'FreeFire', 'freefire', 1, 0, 'reward_categories/uke6mpgQFsW2QXRH3SL33TBho4ad1JBIhVlfJEyK.jpg', '2025-08-18 20:33:20', '2025-08-19 08:50:40'),
(11, 'عملات تيك توك', 'aamlat-tyk-tok', 1, 0, 'reward_categories/mnWZMz6AIhSrwrtKZsPg6t8CC4DLUwL6rfU1TYRf.jpg', '2025-08-18 23:45:58', '2025-08-19 07:52:02'),
(12, 'Razer Gold', 'razer-gold', 1, 0, 'reward_categories/m9LdhyFs1ZemZRQyi1kp165THXDMf0WkqaGo9vI9.jpg', '2025-08-18 23:52:42', '2025-08-19 08:50:22'),
(14, 'Binance', 'binance', 1, 0, 'reward_categories/OHw1T1jnL1Sh2RyWreCdaURiXo805HLKz3H9LOyr.png', '2025-08-19 08:00:51', '2025-08-19 08:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `reward_items`
--

CREATE TABLE `reward_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price_points` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `stock` int(10) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `delivery_method` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reward_items`
--

INSERT INTO `reward_items` (`id`, `sort_order`, `category_id`, `name`, `description`, `image`, `price_points`, `stock`, `is_active`, `created_at`, `updated_at`, `deleted_at`, `quantity`, `delivery_method`) VALUES
(1, 0, NULL, 'تعليقات فيسبوك', NULL, 'reward_items/0FU0Vh2nBYXAKfE9DvFiuzZk0BV3Yl1QdBBgve89.jpg', 12, NULL, 1, '2025-08-18 01:33:27', '2025-08-18 02:12:35', '2025-08-18 02:12:35', NULL, NULL),
(2, 0, NULL, 'face', NULL, 'reward_items/DfHHNvfu6jcSjCod6fbLhtfqMeI6Rmc5mGh6ZN3b.png', 22, NULL, 1, '2025-08-18 02:12:57', '2025-08-18 05:25:48', '2025-08-18 05:25:48', NULL, NULL),
(3, 0, NULL, '2222', NULL, 'reward_items/ybH2RBCrpdYfTvLL3OpB0zH1m1pxOFhokP61XmG2.png', 22, NULL, 1, '2025-08-18 04:41:05', '2025-08-18 05:25:46', '2025-08-18 05:25:46', NULL, NULL),
(4, 0, 10, '110 جوهرة', NULL, 'reward_items/MDa3jVmT4zPy1elbgk80bWhMc1Lc5odbvAk7lxfs.jpg', 120, NULL, 1, '2025-08-18 05:25:57', '2025-08-19 08:48:39', NULL, NULL, NULL),
(5, 0, 2, '10$', NULL, 'reward_items/4SCBjvxljrjDefi22SKq74qgp6r3nhMEcRXcP0UY.jpg', 55, NULL, 1, '2025-08-18 06:06:35', '2025-08-19 08:02:22', NULL, NULL, NULL),
(6, 0, 3, 'اشتراك شهر', NULL, 'reward_items/TJQc0ewfeFiKPYcvuHcme9MY18EuW0kDZisa8TTu.png', 250, NULL, 1, '2025-08-18 17:44:44', '2025-08-19 08:49:14', NULL, NULL, NULL),
(7, 0, 14, '10$', NULL, 'reward_items/AzrACygM7Uke1EOyccOMs26idkblBsR7F3gQCuGU.png', 2500, NULL, 1, '2025-08-18 22:46:35', '2025-08-19 08:01:10', NULL, NULL, NULL),
(8, 0, 11, '666', NULL, 'reward_items/7cCLkI7z57KxHeehRVTwm7GYmmLWk3WE1052wVxR.jpg', 666, NULL, 0, '2025-08-18 23:46:16', '2025-08-18 23:52:52', '2025-08-18 23:52:52', NULL, NULL),
(9, 0, 6, '60 UC', NULL, 'reward_items/WWg66vPs18xyviObf1AkULwP2hjpAVgV8P5CJurF.jpg', 777, NULL, 1, '2025-08-18 23:53:02', '2025-08-19 07:59:26', NULL, NULL, NULL),
(10, 0, 12, '100$', NULL, 'reward_items/eiVOisCUlLsIZA4rhezlmZbQTiMQd6MPJDMxJAhf.jpg', 7500, NULL, 1, '2025-08-19 08:03:37', '2025-08-19 08:49:45', NULL, NULL, NULL),
(11, 0, 4, '500 ROBOX', NULL, 'reward_items/fXLKNOAsH4Zf5HbMQZA0eQjTcxaBWFm8uiuimqc3.jpg', 2500, NULL, 1, '2025-08-19 08:04:13', '2025-08-19 08:49:56', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reward_orders`
--

CREATE TABLE `reward_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `token` char(36) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `reward_item_id` bigint(20) UNSIGNED NOT NULL,
  `price_points` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected','cancelled') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `acted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `acted_at` timestamp NULL DEFAULT NULL,
  `gift` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reward_orders`
--

INSERT INTO `reward_orders` (`id`, `token`, `user_id`, `reward_item_id`, `price_points`, `status`, `admin_note`, `acted_by`, `acted_at`, `gift`, `created_at`, `updated_at`) VALUES
(16, NULL, 2, 6, 44, 'rejected', NULL, 1, '2025-08-19 00:52:12', NULL, '2025-08-19 00:11:13', '2025-08-19 00:52:12'),
(17, NULL, 2, 6, 44, 'approved', NULL, 1, '2025-08-19 00:52:07', '345643643', '2025-08-19 00:34:55', '2025-08-19 00:52:07'),
(18, '4d00612b-df53-43c3-8494-2e1b24505ade', 2, 6, 44, 'approved', NULL, NULL, NULL, NULL, '2025-08-19 00:52:36', '2025-08-19 00:52:36'),
(19, '8064e29a-32e5-4c03-82ca-ee3c2ae5fafa', 2, 6, 44, 'approved', NULL, NULL, NULL, NULL, '2025-08-19 00:52:48', '2025-08-19 00:52:48'),
(20, 'b430fbc5-3f74-4cdd-b75c-8fc30e2d6699', 2, 6, 44, 'approved', NULL, NULL, NULL, NULL, '2025-08-19 00:53:40', '2025-08-19 00:53:40'),
(21, 'e69cb0cb-57ea-413a-97a1-22999b96e512', 2, 6, 44, 'approved', NULL, 1, '2025-08-19 00:56:03', '234234', '2025-08-19 00:55:19', '2025-08-19 00:56:03'),
(22, '76c7a93b-d719-4e8b-89ab-14269c94f470', 2, 9, 777, 'cancelled', NULL, 1, '2025-08-19 00:56:10', NULL, '2025-08-19 00:55:52', '2025-08-19 00:56:10'),
(23, 'b61622f8-a53d-4a5e-bc5d-e3e03e423e5e', 2, 6, 44, 'approved', NULL, 1, '2025-08-19 00:57:07', '23423434', '2025-08-19 00:56:58', '2025-08-19 00:57:07'),
(24, '0f01595c-0169-47f4-9c4e-1cf6acda85d8', 10, 9, 777, 'approved', NULL, 1, '2025-08-19 08:18:13', '2345345f34q52345', '2025-08-19 08:17:53', '2025-08-19 08:18:13'),
(25, 'a801e3ed-f7f8-4876-9c5f-5c5e3592c709', 8, 9, 777, 'approved', '10UC', 1, '2025-08-22 04:48:05', 'T3cdAyBM2T58u075r1', '2025-08-19 23:16:12', '2025-08-22 04:48:05'),
(26, 'e749e3a4-8279-459d-89c8-f65e00f1062e', 2, 5, 55, 'pending', NULL, NULL, NULL, NULL, '2025-08-21 03:04:53', '2025-08-21 03:04:53'),
(27, '54f5e3ab-f410-47c4-a6af-41b1d5bd562e', 8, 9, 777, 'pending', NULL, NULL, NULL, NULL, '2025-08-22 04:38:57', '2025-08-22 04:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `platform` enum('facebook','instagram','tiktok') DEFAULT NULL,
  `link_description` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `allocated_credits` int(11) NOT NULL DEFAULT 0,
  `spent_credits` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `credit_value` int(11) NOT NULL DEFAULT 1,
  `credit_per_click` int(11) DEFAULT 1,
  `metric` varchar(255) NOT NULL DEFAULT 'followers'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `user_id`, `category_id`, `name`, `link`, `platform`, `link_description`, `status`, `allocated_credits`, `spent_credits`, `created_at`, `updated_at`, `credit_value`, `credit_per_click`, `metric`) VALUES
(22, 7, 3, 'tiktok', 'https://www.tiktok.com/@wxf45', 'tiktok', '', 1, 1, 1, '2025-07-31 07:43:27', '2025-08-02 01:00:59', 1, 1, 'followers'),
(23, 7, 3, 'tik', 'https://www.tiktok.com/@wxf45', 'tiktok', '', 1, 1, 0, '2025-07-31 09:17:23', '2025-08-01 05:34:42', 1, 1, 'followers'),
(24, 7, 1, 'fb', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 1, 1, '2025-07-31 10:15:40', '2025-07-31 10:17:13', 1, 1, 'followers'),
(25, 7, 1, 'fb', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 1, 1, '2025-07-31 10:52:21', '2025-07-31 11:04:44', 1, 1, 'followers'),
(26, 7, 1, 'fb2', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 1, 1, '2025-07-31 10:52:43', '2025-07-31 16:58:26', 1, 1, 'followers'),
(32, 7, 1, 'fbb', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 4, 1, '2025-07-31 13:12:38', '2025-07-31 16:13:43', 1, 1, 'followers'),
(33, 7, 1, 'fbbbb', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 3, 1, '2025-07-31 13:13:03', '2025-08-02 00:52:13', 1, 1, 'followers'),
(34, 7, 3, 'toktok', 'https://www.tiktok.com/@wxf455', 'tiktok', '', 1, 5, 1, '2025-07-31 13:56:53', '2025-08-02 00:51:49', 1, 1, 'followers'),
(35, 7, 2, 'iu', 'https://www.instagram.com/abdocenter', 'instagram', '', 1, 1, 2, '2025-07-31 17:22:11', '2025-08-06 16:38:48', 1, 1, 'followers'),
(36, 2, 1, 'fb', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 9, 0, '2025-07-31 17:26:18', '2025-07-31 17:26:18', 1, 1, 'followers'),
(37, 2, 1, 'in', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 8, 1, '2025-07-31 17:26:29', '2025-07-31 23:36:10', 1, 1, 'followers'),
(38, 2, 1, 'tik', 'https://www.tiktok.com/@wxf45', 'tiktok', '', 1, 6, 0, '2025-07-31 17:26:56', '2025-08-02 00:59:46', 1, 1, 'followers'),
(39, 8, 1, 'For likes', 'https://www.facebook.com/ahmed.abozed.2025', 'facebook', '<p>https://www.facebook.com/share/p/1BLoQEbwxf/</p>', 1, 1, 0, '2025-07-31 23:34:51', '2025-08-02 03:53:55', 1, 1, 'followers'),
(40, 2, 1, 'inst', 'https://www.instagram.com/malak_said97', 'instagram', '', 1, 3, 1, '2025-08-01 03:04:04', '2025-08-01 22:49:05', 1, 1, 'followers'),
(41, 2, 3, 'متابعين تيك توك', 'https://www.tiktok.com/@wxf45', 'tiktok', '', 1, 5, 0, '2025-08-01 22:51:36', '2025-08-02 00:59:19', 1, 1, 'followers'),
(42, 2, 2, 'متابعين انستقرام', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 2, 3, '2025-08-01 22:56:27', '2025-08-21 06:27:24', 1, 1, 'followers'),
(43, 2, 2, 'انستقرام', 'https://www.instagram.com/abdocenter.tn', 'instagram', '', 1, 66, 4, '2025-08-01 22:58:33', '2025-08-22 04:15:52', 1, 1, 'followers'),
(44, 8, 1, '2', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 15, 3, '2025-08-05 22:42:56', '2025-08-06 04:34:28', 1, 1, 'followers'),
(45, 7, 3, '5', 'https://www.tiktok.com/@wxf45', 'tiktok', '', 1, 5, 0, '2025-08-06 16:56:54', '2025-08-06 16:56:54', 1, 1, 'followers'),
(46, 7, 3, '5', 'https://www.tiktok.com/@wxf45', 'tiktok', '', 1, 5, 0, '2025-08-06 16:56:54', '2025-08-06 16:56:54', 1, 1, 'followers'),
(47, 10, 2, 'insta', 'https://www.instagram.com/abdocenter', 'instagram', '', 1, 12, 2, '2025-08-07 06:11:31', '2025-08-21 06:02:28', 1, 1, 'followers'),
(48, 3, 4, 'تعليقات فيسبوك', 'https://www.facebook.com/AbdoCenter1/posts/pfbid02jMCTnQ4esuTb7eJnjU6fqb3FDN1ok1ENab8QugwpHQkBQeM4jXJsMLFNTAVApJLyl?rdid=9kM9B4V5J6APOfxi#', 'facebook', '', 0, 13, 0, '2025-08-07 22:35:37', '2025-08-13 07:24:26', 1, 1, 'followers'),
(49, 2, 4, 'لايك منشور فيسبوك', 'https://www.facebook.com/AbdoCenter1/posts/pfbid029kTF1zaD3u5DhrCHirrruXcCgVnHeJawmPqC8pj5D1zrtcWpaVWikYx6hZLwdXiSl?comment_id=1420403799243500', 'facebook', '', 1, 127, 0, '2025-08-08 13:02:46', '2025-08-08 13:02:46', 1, 1, 'followers'),
(50, 2, 2, 'insta', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 9, 1, '2025-08-08 13:06:22', '2025-08-15 21:28:35', 1, 1, 'followers'),
(51, 2, 1, 'فيس', 'https://www.facebook.com/AbdoCenter1', 'facebook', '', 1, 15, 0, '2025-08-15 21:00:11', '2025-08-15 21:00:11', 1, 1, 'followers'),
(52, 2, 2, 'debana', 'https://www.instagram.com/malak_said97', 'instagram', '', 1, 6, 2, '2025-08-15 21:01:26', '2025-08-21 23:22:09', 1, 1, 'followers'),
(53, 6, 2, '123', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 11, 2, '2025-08-15 21:24:55', '2025-08-21 23:14:03', 1, 1, 'followers'),
(54, 6, 2, '123', 'https://www.instagram.com/abdocenter/', 'instagram', '', 0, 42, 0, '2025-08-15 21:54:06', '2025-08-15 21:54:48', 1, 1, 'followers'),
(55, 10, 3, 'متابعين تيك توك', 'https://www.tiktok.com/@user91070423378130', 'tiktok', '', 1, 4, 0, '2025-08-19 08:11:11', '2025-08-19 08:11:11', 1, 1, 'followers'),
(56, 6, 2, 'instagram', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 10, 2, '2025-08-21 05:53:33', '2025-08-21 06:00:56', 1, 1, 'followers'),
(57, 10, 2, 'instagram follo', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 15, 1, '2025-08-21 05:56:45', '2025-08-21 05:59:19', 1, 1, 'followers'),
(58, 10, 2, 'instagram follo', 'https://www.instagram.com/abdocenter/', 'instagram', '', 1, 6, 1, '2025-08-21 05:57:03', '2025-08-21 05:57:48', 1, 1, 'followers');

-- --------------------------------------------------------

--
-- Table structure for table `service_views`
--

CREATE TABLE `service_views` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `view_date` varchar(255) DEFAULT NULL,
  `credits` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_views`
--

INSERT INTO `service_views` (`id`, `service_id`, `user_id`, `view_date`, `credits`, `created_at`, `updated_at`) VALUES
(1, 3, 7, '2025-07-17', 99, '2025-07-17 12:32:31', '2025-07-17 12:32:31'),
(2, 5, 7, '2025-07-17', 99, '2025-07-17 12:33:38', '2025-07-17 12:33:38'),
(3, 6, 2, '2025-07-17', 5, '2025-07-17 12:35:30', '2025-07-17 12:35:30'),
(4, 6, 5, '2025-07-17', 4, '2025-07-17 12:36:13', '2025-07-17 12:36:13'),
(5, 3, 4, '2025-07-17', 98, '2025-07-17 13:17:17', '2025-07-17 13:17:17'),
(6, 5, 4, '2025-07-17', 98, '2025-07-17 13:17:42', '2025-07-17 13:17:42'),
(7, 6, 4, '2025-07-17', 5, '2025-07-17 13:18:05', '2025-07-17 13:18:05'),
(8, 9, 7, '2025-07-17', 12, '2025-07-17 13:37:11', '2025-07-17 13:37:11'),
(9, 11, 4, '2025-07-17', 55, '2025-07-17 13:49:08', '2025-07-17 13:49:08'),
(10, 5, 1, '2025-07-28', 97, '2025-07-28 04:34:27', '2025-07-28 04:34:27'),
(11, 9, 1, '2025-07-28', 11, '2025-07-28 04:36:23', '2025-07-28 04:36:23'),
(12, 13, 2, '2025-07-28', 18, '2025-07-28 04:38:30', '2025-07-28 04:38:30'),
(13, 13, 6, '2025-07-28', 17, '2025-07-28 04:39:30', '2025-07-28 04:39:30'),
(14, 6, 3, '2025-07-28', 4, '2025-07-28 04:41:45', '2025-07-28 04:41:45'),
(15, 10, 3, '2025-07-28', 1, '2025-07-28 05:10:10', '2025-07-28 05:10:10'),
(16, 8, 3, '2025-07-28', 1, '2025-07-28 05:11:35', '2025-07-28 05:11:35'),
(17, 7, 3, '2025-07-28', 1, '2025-07-28 06:35:46', '2025-07-28 06:35:46'),
(18, 15, 3, '2025-07-28', 1, '2025-07-28 07:29:44', '2025-07-28 07:29:44'),
(19, 16, 3, '2025-07-28', 1, '2025-07-28 07:33:42', '2025-07-28 07:33:42'),
(20, 17, 3, '2025-07-28', 1, '2025-07-28 07:44:41', '2025-07-28 07:44:41'),
(21, 18, 3, '2025-07-28', 1, '2025-07-28 07:45:50', '2025-07-28 07:45:50'),
(22, 5, 3, '2025-07-28', 1, '2025-07-28 07:49:52', '2025-07-28 07:49:52'),
(23, 13, 3, '2025-07-28', 1, '2025-07-28 07:51:15', '2025-07-28 07:51:15'),
(24, 9, 3, '2025-07-28', 1, '2025-07-28 07:51:50', '2025-07-28 07:51:50'),
(25, 3, 3, '2025-07-28', 1, '2025-07-28 08:05:59', '2025-07-28 08:05:59'),
(26, 14, 2, '2025-07-28', 1, '2025-07-28 08:39:44', '2025-07-28 08:39:44'),
(27, 19, 3, '2025-07-28', 1, '2025-07-28 08:40:10', '2025-07-28 08:40:10'),
(28, 20, 2, '2025-07-29', 1, '2025-07-29 09:50:57', '2025-07-29 09:50:57'),
(29, 7, 2, '2025-07-29', 1, '2025-07-29 09:52:00', '2025-07-29 09:52:00'),
(30, 10, 2, '2025-07-29', 1, '2025-07-29 09:53:03', '2025-07-29 09:53:03'),
(31, 5, 6, '2025-07-29', 1, '2025-07-29 09:56:03', '2025-07-29 09:56:03'),
(32, 21, 2, '2025-07-29', 1, '2025-07-29 09:57:27', '2025-07-29 09:57:27'),
(33, 1, 2, '2025-07-29', 1, '2025-07-29 09:57:58', '2025-07-29 09:57:58'),
(34, 13, 7, '2025-07-31', 1, '2025-07-31 06:31:42', '2025-07-31 06:31:42'),
(35, 16, 7, '2025-07-31', 1, '2025-07-31 06:47:56', '2025-07-31 06:47:56'),
(36, 22, 2, '2025-07-31', 1, '2025-07-31 09:52:56', '2025-07-31 09:52:56'),
(37, 24, 2, '2025-07-31', 1, '2025-07-31 10:17:13', '2025-07-31 10:17:13'),
(38, 25, 2, '2025-07-31', 1, '2025-07-31 11:04:44', '2025-07-31 11:04:44'),
(39, 15, 7, '2025-07-31', 1, '2025-07-31 11:40:58', '2025-07-31 11:40:58'),
(40, 9, 2, '2025-07-31', 1, '2025-07-31 12:02:54', '2025-07-31 12:02:54'),
(41, 32, 2, '2025-07-31', 1, '2025-07-31 16:13:43', '2025-07-31 16:13:43'),
(42, 26, 2, '2025-07-31', 1, '2025-07-31 16:58:26', '2025-07-31 16:58:26'),
(43, 34, 2, '2025-07-31', 1, '2025-07-31 16:59:41', '2025-07-31 16:59:41'),
(44, 35, 8, '2025-07-31', 1, '2025-07-31 23:27:09', '2025-07-31 23:27:09'),
(45, 37, 8, '2025-07-31', 1, '2025-07-31 23:36:10', '2025-07-31 23:36:10'),
(46, 40, 8, '2025-07-31', 1, '2025-08-01 03:07:13', '2025-08-01 03:07:13'),
(47, 35, 2, '2025-08-01', 1, '2025-08-01 22:32:32', '2025-08-01 22:32:32'),
(48, 33, 2, '2025-08-01', 1, '2025-08-01 22:47:22', '2025-08-01 22:47:22'),
(49, 43, 1, '2025-08-01', 1, '2025-08-01 23:01:22', '2025-08-01 23:01:22'),
(50, 42, 8, '2025-08-01', 1, '2025-08-02 03:46:11', '2025-08-02 03:46:11'),
(51, 44, 2, '2025-08-06', 1, '2025-08-06 04:28:05', '2025-08-06 04:28:05'),
(52, 44, 7, '2025-08-06', 1, '2025-08-06 04:30:56', '2025-08-06 04:30:56'),
(53, 44, 6, '2025-08-06', 1, '2025-08-06 04:34:28', '2025-08-06 04:34:28'),
(54, 43, 3, '2025-08-07', 1, '2025-08-08 00:16:14', '2025-08-08 00:16:14'),
(55, 52, 6, '2025-08-15', 1, '2025-08-15 21:27:19', '2025-08-15 21:27:19'),
(56, 50, 6, '2025-08-15', 1, '2025-08-15 21:28:35', '2025-08-15 21:28:35'),
(57, 42, 10, '2025-08-19', 1, '2025-08-19 09:26:48', '2025-08-19 09:26:48'),
(58, 47, 2, '2025-08-21', 1, '2025-08-21 05:49:40', '2025-08-21 05:49:40'),
(59, 53, 2, '2025-08-21', 1, '2025-08-21 05:51:32', '2025-08-21 05:51:32'),
(60, 56, 10, '2025-08-21', 1, '2025-08-21 05:54:31', '2025-08-21 05:54:31'),
(61, 58, 2, '2025-08-21', 1, '2025-08-21 05:57:48', '2025-08-21 05:57:48'),
(62, 57, 2, '2025-08-21', 1, '2025-08-21 05:59:19', '2025-08-21 05:59:19'),
(63, 56, 4, '2025-08-21', 1, '2025-08-21 06:00:56', '2025-08-21 06:00:56'),
(64, 47, 4, '2025-08-21', 1, '2025-08-21 06:02:28', '2025-08-21 06:02:28'),
(65, 42, 4, '2025-08-21', 1, '2025-08-21 06:27:24', '2025-08-21 06:27:24'),
(66, 43, 10, '2025-08-21', 1, '2025-08-21 22:56:35', '2025-08-21 22:56:35'),
(67, 53, 10, '2025-08-21', 1, '2025-08-21 23:14:03', '2025-08-21 23:14:03'),
(68, 52, 10, '2025-08-21', 1, '2025-08-21 23:22:09', '2025-08-21 23:22:09'),
(69, 43, 8, '2025-08-22', 1, '2025-08-22 04:15:52', '2025-08-22 04:15:52');

-- --------------------------------------------------------

--
-- Table structure for table `social_checks`
--

CREATE TABLE `social_checks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `followers_before` bigint(20) UNSIGNED NOT NULL,
  `followers_after` bigint(20) UNSIGNED DEFAULT NULL,
  `difference` bigint(20) DEFAULT NULL,
  `status` enum('pending','confirmed','failed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `social_checks`
--

INSERT INTO `social_checks` (`id`, `service_id`, `user_id`, `followers_before`, `followers_after`, `difference`, `status`, `created_at`, `updated_at`) VALUES
(1, 19, 7, 0, 0, NULL, 'pending', '2025-07-31 06:02:31', '2025-07-31 06:13:00'),
(2, 15, 7, 0, NULL, NULL, 'failed', '2025-07-31 07:24:52', '2025-07-31 07:28:37'),
(3, 15, 7, 0, NULL, NULL, 'pending', '2025-07-31 07:28:38', '2025-07-31 07:28:38'),
(4, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 07:44:38', '2025-07-31 07:51:49'),
(5, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 07:51:53', '2025-07-31 07:54:05'),
(6, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 07:54:11', '2025-07-31 07:58:53'),
(7, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 07:58:57', '2025-07-31 08:46:17'),
(8, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 08:46:23', '2025-07-31 08:53:53'),
(9, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 08:53:58', '2025-07-31 08:56:00'),
(10, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 08:56:06', '2025-07-31 08:56:29'),
(11, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 08:56:33', '2025-07-31 09:08:54'),
(12, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:08:55', '2025-07-31 09:09:09'),
(13, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:09:10', '2025-07-31 09:09:49'),
(14, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:09:50', '2025-07-31 09:11:41'),
(15, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:11:42', '2025-07-31 09:12:29'),
(16, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:12:33', '2025-07-31 09:24:32'),
(17, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:17:40', '2025-07-31 09:17:48'),
(18, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:17:49', '2025-07-31 09:23:26'),
(19, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:23:27', '2025-07-31 09:42:16'),
(20, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:24:33', '2025-07-31 09:26:33'),
(21, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:26:34', '2025-07-31 09:30:13'),
(22, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:30:14', '2025-07-31 09:39:43'),
(23, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:39:44', '2025-07-31 09:40:29'),
(24, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:40:33', '2025-07-31 09:47:15'),
(25, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:42:17', '2025-07-31 09:42:48'),
(26, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:42:49', '2025-07-31 09:43:31'),
(27, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:43:37', '2025-07-31 09:46:53'),
(28, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:46:54', '2025-07-31 09:59:14'),
(29, 22, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:47:16', '2025-07-31 09:48:07'),
(30, 22, 2, 0, 17287, 17287, 'confirmed', '2025-07-31 09:48:12', '2025-07-31 09:52:56'),
(31, 22, 2, 17287, 17287, 0, 'failed', '2025-07-31 09:53:20', '2025-07-31 09:58:42'),
(32, 22, 2, 0, NULL, NULL, 'pending', '2025-07-31 09:53:26', '2025-07-31 09:53:26'),
(33, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 09:59:24', '2025-07-31 10:02:08'),
(34, 23, 2, 0, NULL, NULL, 'failed', '2025-07-31 10:02:23', '2025-07-31 10:45:22'),
(35, 24, 2, 0, 17287, 17287, 'confirmed', '2025-07-31 10:16:18', '2025-07-31 10:17:13'),
(36, 24, 2, 0, NULL, NULL, 'pending', '2025-07-31 10:17:44', '2025-07-31 10:17:44'),
(37, 23, 2, 0, 0, 0, 'failed', '2025-07-31 10:45:30', '2025-07-31 13:39:08'),
(38, 25, 2, 17287, 17288, 1, 'confirmed', '2025-07-31 10:52:44', '2025-07-31 11:04:44'),
(39, 26, 2, 0, 0, 0, 'failed', '2025-07-31 11:03:59', '2025-07-31 12:38:41'),
(40, 25, 2, 0, NULL, NULL, 'pending', '2025-07-31 11:05:14', '2025-07-31 11:05:14'),
(41, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 12:38:39', '2025-07-31 12:38:39'),
(42, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 12:39:11', '2025-07-31 12:39:11'),
(43, 32, 2, 0, 0, 0, 'failed', '2025-07-31 13:18:47', '2025-07-31 13:19:11'),
(44, 32, 2, 0, 0, 0, 'failed', '2025-07-31 13:21:40', '2025-07-31 13:22:08'),
(45, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 13:38:32', '2025-07-31 13:38:32'),
(46, 23, 2, 0, NULL, NULL, 'pending', '2025-07-31 13:39:01', '2025-07-31 13:39:01'),
(47, 33, 2, 0, 0, 0, 'failed', '2025-07-31 13:42:25', '2025-07-31 13:43:32'),
(48, 33, 2, 0, NULL, NULL, 'pending', '2025-07-31 13:43:04', '2025-07-31 13:43:04'),
(49, 33, 2, 0, NULL, NULL, 'pending', '2025-07-31 13:47:01', '2025-07-31 13:47:01'),
(50, 33, 2, 0, 0, 0, 'failed', '2025-07-31 13:49:59', '2025-07-31 13:50:57'),
(51, 33, 2, 17288, 17288, 0, 'failed', '2025-07-31 13:54:36', '2025-07-31 13:55:15'),
(52, 23, 2, 0, NULL, NULL, 'pending', '2025-07-31 13:55:46', '2025-07-31 13:55:46'),
(53, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 13:57:18', '2025-07-31 13:57:18'),
(54, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:04:51', '2025-07-31 14:04:51'),
(55, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:10:34', '2025-07-31 14:10:34'),
(56, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:13:08', '2025-07-31 14:13:08'),
(57, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:13:55', '2025-07-31 14:13:55'),
(58, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:17:54', '2025-07-31 14:17:54'),
(59, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:21:33', '2025-07-31 14:21:33'),
(60, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:23:00', '2025-07-31 14:23:00'),
(61, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:23:57', '2025-07-31 14:23:57'),
(62, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:26:22', '2025-07-31 14:26:22'),
(63, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:26:35', '2025-07-31 14:26:35'),
(64, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:29:12', '2025-07-31 14:29:12'),
(65, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:32:33', '2025-07-31 14:32:33'),
(66, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:35:59', '2025-07-31 14:35:59'),
(67, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:37:05', '2025-07-31 14:37:05'),
(68, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:37:21', '2025-07-31 14:37:21'),
(69, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 14:40:21', '2025-07-31 14:40:21'),
(70, 32, 2, 17287, 17287, 0, 'failed', '2025-07-31 15:03:40', '2025-07-31 15:06:34'),
(71, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:07:04', '2025-07-31 15:07:04'),
(72, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:11:49', '2025-07-31 15:11:49'),
(73, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:13:46', '2025-07-31 15:13:46'),
(74, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:15:04', '2025-07-31 15:15:04'),
(75, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:15:21', '2025-07-31 15:15:21'),
(76, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:19:28', '2025-07-31 15:19:28'),
(77, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:25:53', '2025-07-31 15:25:53'),
(78, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:27:52', '2025-07-31 15:27:52'),
(79, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:29:52', '2025-07-31 15:29:52'),
(80, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:36:46', '2025-07-31 15:36:46'),
(81, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:39:10', '2025-07-31 15:39:10'),
(82, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:40:45', '2025-07-31 15:40:45'),
(83, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:42:29', '2025-07-31 15:42:29'),
(84, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:44:31', '2025-07-31 15:44:31'),
(85, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:44:34', '2025-07-31 15:44:34'),
(86, 32, 2, 17287, 1, -17286, 'failed', '2025-07-31 15:46:01', '2025-07-31 15:46:19'),
(87, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:52:33', '2025-07-31 15:52:33'),
(88, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:53:29', '2025-07-31 15:53:29'),
(89, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:54:46', '2025-07-31 15:54:46'),
(90, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 15:57:19', '2025-07-31 15:57:19'),
(91, 32, 2, 17287, NULL, NULL, 'pending', '2025-07-31 16:02:10', '2025-07-31 16:02:10'),
(92, 32, 2, 17287, NULL, NULL, 'pending', '2025-07-31 16:04:41', '2025-07-31 16:04:41'),
(93, 32, 2, 0, 17287, 17287, 'confirmed', '2025-07-31 16:12:20', '2025-07-31 16:13:43'),
(94, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:14:20', '2025-07-31 16:14:20'),
(95, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:15:55', '2025-07-31 16:15:55'),
(96, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:21:43', '2025-07-31 16:21:43'),
(97, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:23:05', '2025-07-31 16:23:05'),
(98, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:25:06', '2025-07-31 16:25:06'),
(99, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:27:48', '2025-07-31 16:27:48'),
(100, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:29:35', '2025-07-31 16:29:35'),
(101, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:31:11', '2025-07-31 16:31:11'),
(102, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:32:00', '2025-07-31 16:32:00'),
(103, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:32:18', '2025-07-31 16:32:18'),
(104, 32, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:32:41', '2025-07-31 16:32:41'),
(105, 32, 2, 17287, NULL, NULL, 'pending', '2025-07-31 16:33:33', '2025-07-31 16:33:33'),
(106, 32, 2, 17287, NULL, NULL, 'pending', '2025-07-31 16:34:35', '2025-07-31 16:34:35'),
(107, 26, 2, 17287, NULL, NULL, 'pending', '2025-07-31 16:35:01', '2025-07-31 16:35:01'),
(108, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:36:29', '2025-07-31 16:36:29'),
(109, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:39:06', '2025-07-31 16:39:06'),
(110, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:40:08', '2025-07-31 16:40:08'),
(111, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:42:24', '2025-07-31 16:42:24'),
(112, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:44:17', '2025-07-31 16:44:17'),
(113, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:44:42', '2025-07-31 16:44:42'),
(114, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:47:21', '2025-07-31 16:47:21'),
(115, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:47:32', '2025-07-31 16:47:32'),
(116, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:48:31', '2025-07-31 16:48:31'),
(117, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:48:52', '2025-07-31 16:48:52'),
(118, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:51:29', '2025-07-31 16:51:29'),
(119, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:51:34', '2025-07-31 16:51:34'),
(120, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:52:07', '2025-07-31 16:52:07'),
(121, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:53:49', '2025-07-31 16:53:49'),
(122, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:53:58', '2025-07-31 16:53:58'),
(123, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:55:18', '2025-07-31 16:55:18'),
(124, 26, 2, 0, 17287, 17287, 'confirmed', '2025-07-31 16:55:56', '2025-07-31 16:58:26'),
(125, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:57:16', '2025-07-31 16:57:16'),
(126, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:58:44', '2025-07-31 16:58:44'),
(127, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 16:59:02', '2025-07-31 16:59:02'),
(128, 34, 2, 0, 426, 426, 'confirmed', '2025-07-31 16:59:27', '2025-07-31 16:59:41'),
(129, 26, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:00:12', '2025-07-31 17:00:12'),
(130, 33, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:01:01', '2025-07-31 17:01:01'),
(131, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:06:25', '2025-07-31 17:06:25'),
(132, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:06:44', '2025-07-31 17:06:44'),
(133, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:07:13', '2025-07-31 17:07:13'),
(134, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:09:20', '2025-07-31 17:09:20'),
(135, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:09:45', '2025-07-31 17:09:45'),
(136, 33, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:10:59', '2025-07-31 17:10:59'),
(137, 34, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:11:37', '2025-07-31 17:11:37'),
(138, 33, 2, 0, NULL, NULL, 'pending', '2025-07-31 17:11:44', '2025-07-31 17:11:44'),
(139, 34, 2, 426, NULL, NULL, 'pending', '2025-07-31 17:23:56', '2025-07-31 17:23:56'),
(140, 33, 2, 17287, 17287, 0, 'failed', '2025-07-31 17:24:07', '2025-07-31 17:24:55'),
(141, 35, 2, 70868, 70868, 0, 'failed', '2025-07-31 17:24:09', '2025-07-31 17:24:38'),
(142, 34, 2, 426, NULL, NULL, 'pending', '2025-07-31 17:24:57', '2025-07-31 17:24:57'),
(143, 38, 7, 1393, 1393, 0, 'failed', '2025-07-31 17:27:20', '2025-07-31 17:27:39'),
(144, 37, 7, 70868, 70868, 0, 'failed', '2025-07-31 17:27:26', '2025-07-31 17:27:41'),
(145, 36, 7, 17287, 17287, 0, 'failed', '2025-07-31 17:27:32', '2025-07-31 17:27:56'),
(146, 23, 2, 112900, 112900, 0, 'failed', '2025-07-31 17:46:16', '2025-07-31 17:46:46'),
(147, 35, 2, 70868, 70868, 0, 'failed', '2025-07-31 17:46:18', '2025-07-31 17:46:52'),
(148, 33, 2, 17287, 17287, 0, 'failed', '2025-07-31 17:46:22', '2025-07-31 17:47:11'),
(149, 24, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:22:05', '2025-07-31 23:22:05'),
(150, 24, 8, 17278, 17278, 0, 'failed', '2025-07-31 23:22:06', '2025-07-31 23:22:54'),
(151, 24, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:22:42', '2025-07-31 23:22:42'),
(152, 24, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:22:52', '2025-07-31 23:22:52'),
(153, 26, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:24:32', '2025-07-31 23:24:32'),
(154, 35, 8, 70868, 70867, -1, 'failed', '2025-07-31 23:24:35', '2025-07-31 23:24:45'),
(155, 24, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:24:54', '2025-07-31 23:24:54'),
(156, 35, 8, 70867, NULL, NULL, 'pending', '2025-07-31 23:25:12', '2025-07-31 23:25:12'),
(157, 35, 8, 70868, 70868, 0, 'failed', '2025-07-31 23:25:15', '2025-07-31 23:25:33'),
(158, 22, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:25:25', '2025-07-31 23:25:25'),
(159, 35, 8, 70868, 70868, 0, 'failed', '2025-07-31 23:25:25', '2025-07-31 23:26:13'),
(160, 35, 8, 70868, NULL, NULL, 'pending', '2025-07-31 23:26:06', '2025-07-31 23:26:06'),
(161, 35, 8, 70867, 70868, 1, 'confirmed', '2025-07-31 23:26:48', '2025-07-31 23:27:09'),
(162, 35, 8, 70868, NULL, NULL, 'pending', '2025-07-31 23:27:02', '2025-07-31 23:27:02'),
(163, 37, 8, 70867, NULL, NULL, 'pending', '2025-07-31 23:35:36', '2025-07-31 23:35:36'),
(164, 37, 8, 70867, 70868, 1, 'confirmed', '2025-07-31 23:35:52', '2025-07-31 23:36:10'),
(165, 26, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:37:49', '2025-07-31 23:37:49'),
(166, 24, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:38:00', '2025-07-31 23:38:00'),
(167, 32, 8, 17278, NULL, NULL, 'pending', '2025-07-31 23:38:01', '2025-07-31 23:38:01'),
(168, 40, 8, 954, 954, 0, 'failed', '2025-08-01 03:06:07', '2025-08-01 03:06:28'),
(169, 40, 8, 954, 955, 1, 'confirmed', '2025-08-01 03:06:53', '2025-08-01 03:07:13'),
(170, 39, 7, 0, NULL, NULL, 'pending', '2025-08-01 05:45:27', '2025-08-01 05:45:27'),
(171, 35, 2, 70777, NULL, NULL, 'pending', '2025-08-01 22:25:04', '2025-08-01 22:25:04'),
(172, 35, 2, 70776, 70777, 1, 'confirmed', '2025-08-01 22:32:13', '2025-08-01 22:32:32'),
(173, 23, 2, 112900, NULL, NULL, 'pending', '2025-08-01 22:35:13', '2025-08-01 22:35:13'),
(174, 23, 2, 112900, 112900, 0, 'failed', '2025-08-01 22:37:20', '2025-08-01 22:38:22'),
(175, 23, 2, 112900, 112900, 0, 'failed', '2025-08-01 22:39:09', '2025-08-01 22:39:35'),
(176, 23, 2, 112900, 112900, 0, 'failed', '2025-08-01 22:40:08', '2025-08-01 22:40:25'),
(177, 33, 2, 17264, 17263, -1, 'failed', '2025-08-01 22:42:12', '2025-08-01 22:44:14'),
(178, 33, 2, 17263, 17264, 1, 'confirmed', '2025-08-01 22:44:51', '2025-08-01 22:47:22'),
(179, 43, 1, 6322, 6323, 1, 'confirmed', '2025-08-01 23:00:40', '2025-08-01 23:01:22'),
(180, 23, 2, 112900, 112900, 0, 'failed', '2025-08-02 00:39:52', '2025-08-02 00:40:15'),
(181, 23, 2, 112900, 112900, 0, 'failed', '2025-08-02 00:40:34', '2025-08-02 00:41:14'),
(182, 22, 8, 1394, NULL, NULL, 'pending', '2025-08-02 00:55:24', '2025-08-02 00:55:24'),
(183, 22, 8, 1394, NULL, NULL, 'pending', '2025-08-02 01:00:23', '2025-08-02 01:00:23'),
(184, 22, 8, 112900, NULL, NULL, 'pending', '2025-08-02 01:01:17', '2025-08-02 01:01:17'),
(185, 25, 8, 17262, NULL, NULL, 'pending', '2025-08-02 01:02:20', '2025-08-02 01:02:20'),
(186, 42, 8, 70777, NULL, NULL, 'pending', '2025-08-02 03:45:01', '2025-08-02 03:45:01'),
(187, 42, 8, 70777, NULL, NULL, 'pending', '2025-08-02 03:45:26', '2025-08-02 03:45:26'),
(188, 42, 8, 70776, 70777, 1, 'confirmed', '2025-08-02 03:45:46', '2025-08-02 03:46:11'),
(189, 43, 8, 6324, NULL, NULL, 'pending', '2025-08-05 21:52:27', '2025-08-05 21:52:27'),
(190, 43, 8, 6324, 6324, 0, 'failed', '2025-08-05 22:01:19', '2025-08-05 22:01:37'),
(191, 44, 2, 17251, 17252, 1, 'confirmed', '2025-08-06 04:27:39', '2025-08-06 04:28:05'),
(192, 44, 2, 17251, NULL, NULL, 'pending', '2025-08-06 04:29:23', '2025-08-06 04:29:23'),
(193, 44, 7, 17251, 17252, 1, 'confirmed', '2025-08-06 04:30:23', '2025-08-06 04:30:56'),
(194, 44, 6, 17252, 17253, 1, 'confirmed', '2025-08-06 04:32:47', '2025-08-06 04:34:28'),
(195, 39, 7, 0, 0, 0, 'failed', '2025-08-06 16:39:12', '2025-08-06 16:39:31'),
(196, 40, 7, 949, 949, 0, 'failed', '2025-08-06 16:55:33', '2025-08-06 16:55:50'),
(197, 43, 10, 6308, NULL, NULL, 'pending', '2025-08-07 10:28:57', '2025-08-07 10:28:57'),
(198, 43, 10, 6308, NULL, NULL, 'pending', '2025-08-07 10:31:44', '2025-08-07 10:31:44'),
(199, 43, 10, 6308, 6308, 0, 'failed', '2025-08-07 10:32:37', '2025-08-07 10:33:05'),
(200, 43, 10, 6308, NULL, NULL, 'pending', '2025-08-07 10:49:43', '2025-08-07 10:49:43'),
(201, 45, 3, 112900, NULL, NULL, 'pending', '2025-08-07 21:11:41', '2025-08-07 21:11:41'),
(202, 35, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:15:21', '2025-08-07 23:15:21'),
(203, 35, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:15:42', '2025-08-07 23:15:42'),
(204, 42, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:37:48', '2025-08-07 23:37:48'),
(205, 42, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:39:20', '2025-08-07 23:39:20'),
(206, 42, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:39:33', '2025-08-07 23:39:33'),
(207, 42, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:43:02', '2025-08-07 23:43:02'),
(208, 42, 3, 0, NULL, NULL, 'pending', '2025-08-07 23:43:23', '2025-08-07 23:43:23'),
(209, 42, 3, 70598, NULL, NULL, 'pending', '2025-08-08 00:11:40', '2025-08-08 00:11:40'),
(210, 33, 3, 17248, NULL, NULL, 'pending', '2025-08-08 00:12:46', '2025-08-08 00:12:46'),
(211, 23, 3, 112900, NULL, NULL, 'pending', '2025-08-08 00:13:54', '2025-08-08 00:13:54'),
(212, 43, 3, 6305, 6306, 1, 'confirmed', '2025-08-08 00:15:39', '2025-08-08 00:16:14'),
(213, 48, 2, 17248, NULL, NULL, 'pending', '2025-08-08 00:16:47', '2025-08-08 00:16:47'),
(214, 45, 3, 0, NULL, NULL, 'pending', '2025-08-08 00:23:11', '2025-08-08 00:23:11'),
(215, 45, 3, 0, NULL, NULL, 'pending', '2025-08-08 00:24:23', '2025-08-08 00:24:23'),
(216, 45, 3, 112900, NULL, NULL, 'pending', '2025-08-08 00:24:41', '2025-08-08 00:24:41'),
(217, 40, 3, 948, NULL, NULL, 'pending', '2025-08-08 05:09:50', '2025-08-08 05:09:50'),
(218, 40, 3, 948, NULL, NULL, 'pending', '2025-08-08 05:10:04', '2025-08-08 05:10:04'),
(219, 23, 2, 112900, NULL, NULL, 'pending', '2025-08-08 05:11:20', '2025-08-08 05:11:20'),
(220, 41, 3, 0, NULL, NULL, 'pending', '2025-08-08 05:21:35', '2025-08-08 05:21:35'),
(221, 41, 3, 0, NULL, NULL, 'pending', '2025-08-08 05:21:38', '2025-08-08 05:21:38'),
(222, 47, 2, 70591, NULL, NULL, 'pending', '2025-08-08 05:35:14', '2025-08-08 05:35:14'),
(223, 47, 2, 70591, NULL, NULL, 'pending', '2025-08-08 06:00:48', '2025-08-08 06:00:48'),
(224, 47, 2, 70591, NULL, NULL, 'pending', '2025-08-08 06:00:54', '2025-08-08 06:00:54'),
(225, 47, 2, 70591, NULL, NULL, 'pending', '2025-08-08 06:01:12', '2025-08-08 06:01:12'),
(226, 47, 2, 70591, NULL, NULL, 'pending', '2025-08-08 06:01:25', '2025-08-08 06:01:25'),
(227, 41, 3, 112900, NULL, NULL, 'pending', '2025-08-08 06:04:36', '2025-08-08 06:04:36'),
(228, 45, 2, 112900, NULL, NULL, 'pending', '2025-08-08 07:05:29', '2025-08-08 07:05:29'),
(229, 48, 2, 17250, NULL, NULL, 'pending', '2025-08-08 07:18:07', '2025-08-08 07:18:07'),
(230, 45, 2, 0, NULL, NULL, 'pending', '2025-08-08 07:52:21', '2025-08-08 07:52:21'),
(231, 45, 2, 0, NULL, NULL, 'pending', '2025-08-08 07:56:24', '2025-08-08 07:56:24'),
(232, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 07:57:20', '2025-08-08 07:57:20'),
(233, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 07:58:12', '2025-08-08 07:58:12'),
(234, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 07:58:42', '2025-08-08 07:58:42'),
(235, 45, 2, 0, NULL, NULL, 'pending', '2025-08-08 08:02:10', '2025-08-08 08:02:10'),
(236, 45, 2, 0, NULL, NULL, 'pending', '2025-08-08 08:02:19', '2025-08-08 08:02:19'),
(237, 45, 2, 112900, NULL, NULL, 'pending', '2025-08-08 08:07:59', '2025-08-08 08:07:59'),
(238, 45, 2, 112900, NULL, NULL, 'pending', '2025-08-08 08:24:07', '2025-08-08 08:24:07'),
(239, 45, 2, 112900, NULL, NULL, 'pending', '2025-08-08 08:25:08', '2025-08-08 08:25:08'),
(240, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 08:25:25', '2025-08-08 08:25:25'),
(241, 48, 2, 17249, NULL, NULL, 'pending', '2025-08-08 08:25:54', '2025-08-08 08:25:54'),
(242, 35, 3, 70591, NULL, NULL, 'pending', '2025-08-08 08:38:24', '2025-08-08 08:38:24'),
(243, 48, 2, 0, NULL, NULL, 'pending', '2025-08-08 08:57:41', '2025-08-08 08:57:41'),
(244, 48, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:19:09', '2025-08-08 09:19:09'),
(245, 48, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:20:55', '2025-08-08 09:20:55'),
(246, 47, 2, 70591, NULL, NULL, 'pending', '2025-08-08 09:23:24', '2025-08-08 09:23:24'),
(247, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:23:59', '2025-08-08 09:23:59'),
(248, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:25:32', '2025-08-08 09:25:32'),
(249, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:26:54', '2025-08-08 09:26:54'),
(250, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:28:58', '2025-08-08 09:28:58'),
(251, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:34:39', '2025-08-08 09:34:39'),
(252, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:35:31', '2025-08-08 09:35:31'),
(253, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 09:46:52', '2025-08-08 09:46:52'),
(254, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 10:03:47', '2025-08-08 10:03:47'),
(255, 45, 2, 112900, NULL, NULL, 'pending', '2025-08-08 10:07:49', '2025-08-08 10:07:49'),
(256, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 10:12:12', '2025-08-08 10:12:12'),
(257, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 10:12:47', '2025-08-08 10:12:47'),
(258, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 10:53:07', '2025-08-08 10:53:07'),
(259, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 10:57:16', '2025-08-08 10:57:16'),
(260, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:04:17', '2025-08-08 11:04:17'),
(261, 23, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:04:33', '2025-08-08 11:04:33'),
(262, 23, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:06:22', '2025-08-08 11:06:22'),
(263, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:06:30', '2025-08-08 11:06:30'),
(264, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:06:53', '2025-08-08 11:06:53'),
(265, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:06:58', '2025-08-08 11:06:58'),
(266, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:07:02', '2025-08-08 11:07:02'),
(267, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:07:07', '2025-08-08 11:07:07'),
(268, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:07:42', '2025-08-08 11:07:42'),
(269, 46, 2, 112900, NULL, NULL, 'pending', '2025-08-08 11:08:48', '2025-08-08 11:08:48'),
(270, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:09:00', '2025-08-08 11:09:00'),
(271, 46, 2, 112900, NULL, NULL, 'pending', '2025-08-08 11:09:23', '2025-08-08 11:09:23'),
(272, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:09:40', '2025-08-08 11:09:40'),
(273, 46, 2, 112900, NULL, NULL, 'pending', '2025-08-08 11:09:59', '2025-08-08 11:09:59'),
(274, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:13:04', '2025-08-08 11:13:04'),
(275, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:15:03', '2025-08-08 11:15:03'),
(276, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:17:27', '2025-08-08 11:17:27'),
(277, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:20:15', '2025-08-08 11:20:15'),
(278, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:21:16', '2025-08-08 11:21:16'),
(279, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:22:23', '2025-08-08 11:22:23'),
(280, 46, 2, 112900, NULL, NULL, 'pending', '2025-08-08 11:26:31', '2025-08-08 11:26:31'),
(281, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:29:24', '2025-08-08 11:29:24'),
(282, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:40:57', '2025-08-08 11:40:57'),
(283, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:48:51', '2025-08-08 11:48:51'),
(284, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 11:50:01', '2025-08-08 11:50:01'),
(285, 46, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:01:30', '2025-08-08 12:01:30'),
(286, 47, 2, 0, 0, 0, 'failed', '2025-08-08 12:01:39', '2025-08-08 12:02:27'),
(287, 23, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:23:31', '2025-08-08 12:23:31'),
(288, 23, 2, 112900, NULL, NULL, 'pending', '2025-08-08 12:26:16', '2025-08-08 12:26:16'),
(289, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:26:32', '2025-08-08 12:26:32'),
(290, 47, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:31:02', '2025-08-08 12:31:02'),
(291, 48, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:33:24', '2025-08-08 12:33:24'),
(292, 48, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:41:56', '2025-08-08 12:41:56'),
(293, 39, 2, 0, NULL, NULL, 'pending', '2025-08-08 12:43:10', '2025-08-08 12:43:10'),
(294, 44, 3, 17249, NULL, NULL, 'pending', '2025-08-08 12:45:41', '2025-08-08 12:45:41'),
(295, 47, 2, 70590, NULL, NULL, 'pending', '2025-08-08 12:47:29', '2025-08-08 12:47:29'),
(296, 48, 2, 179, NULL, NULL, 'pending', '2025-08-08 12:48:20', '2025-08-08 12:48:20'),
(297, 48, 2, 179, NULL, NULL, 'pending', '2025-08-08 13:11:13', '2025-08-08 13:11:13'),
(298, 25, 6, 17253, 17253, 0, 'failed', '2025-08-13 05:29:22', '2025-08-13 05:30:24'),
(299, 48, 6, 466, 466, 0, 'failed', '2025-08-13 05:29:54', '2025-08-13 05:30:21'),
(300, 49, 6, 180, 180, 0, 'failed', '2025-08-13 05:29:59', '2025-08-13 05:30:26'),
(301, 39, 2, 0, NULL, NULL, 'pending', '2025-08-15 20:52:51', '2025-08-15 20:52:51'),
(302, 23, 2, 112900, 112900, 0, 'failed', '2025-08-15 20:53:10', '2025-08-15 20:53:25'),
(303, 52, 6, 929, 930, 1, 'confirmed', '2025-08-15 21:26:38', '2025-08-15 21:27:19'),
(304, 50, 6, 70346, 70347, 1, 'confirmed', '2025-08-15 21:28:26', '2025-08-15 21:28:35'),
(305, 39, 10, 0, 0, 0, 'failed', '2025-08-19 08:06:44', '2025-08-19 08:07:06'),
(306, 36, 10, 17257, 17257, 0, 'failed', '2025-08-19 09:25:20', '2025-08-19 09:25:52'),
(307, 46, 10, 112900, NULL, NULL, 'pending', '2025-08-19 09:26:16', '2025-08-19 09:26:16'),
(308, 46, 10, 112900, NULL, NULL, 'pending', '2025-08-19 09:26:21', '2025-08-19 09:26:21'),
(309, 42, 10, 70278, 70279, 1, 'confirmed', '2025-08-19 09:26:37', '2025-08-19 09:26:48'),
(310, 47, 2, 70251, NULL, NULL, 'pending', '2025-08-21 05:48:01', '2025-08-21 05:48:01'),
(311, 47, 2, 70250, 70251, 1, 'confirmed', '2025-08-21 05:49:23', '2025-08-21 05:49:40'),
(312, 53, 2, 70250, 70251, 1, 'confirmed', '2025-08-21 05:51:21', '2025-08-21 05:51:32'),
(313, 56, 10, 70251, NULL, NULL, 'pending', '2025-08-21 05:54:10', '2025-08-21 05:54:10'),
(314, 56, 10, 70250, 70251, 1, 'confirmed', '2025-08-21 05:54:18', '2025-08-21 05:54:31'),
(315, 58, 2, 70250, 70251, 1, 'confirmed', '2025-08-21 05:57:35', '2025-08-21 05:57:48'),
(316, 57, 2, 70250, 70251, 1, 'confirmed', '2025-08-21 05:59:02', '2025-08-21 05:59:19'),
(317, 56, 4, 70250, 70251, 1, 'confirmed', '2025-08-21 06:00:31', '2025-08-21 06:00:56'),
(318, 47, 4, 70250, 70251, 1, 'confirmed', '2025-08-21 06:02:13', '2025-08-21 06:02:28'),
(319, 42, 4, 70251, NULL, NULL, 'pending', '2025-08-21 06:26:53', '2025-08-21 06:26:53'),
(320, 42, 4, 70250, 70251, 1, 'confirmed', '2025-08-21 06:27:10', '2025-08-21 06:27:24'),
(321, 43, 10, 6244, NULL, NULL, 'pending', '2025-08-21 22:55:23', '2025-08-21 22:55:23'),
(322, 43, 10, 6244, 6245, 1, 'confirmed', '2025-08-21 22:55:53', '2025-08-21 22:56:35'),
(323, 53, 10, 70227, 70227, 0, 'failed', '2025-08-21 23:12:26', '2025-08-21 23:12:40'),
(324, 53, 10, 70227, 70228, 1, 'confirmed', '2025-08-21 23:13:28', '2025-08-21 23:14:03'),
(325, 52, 10, 923, 924, 1, 'confirmed', '2025-08-21 23:21:53', '2025-08-21 23:22:09'),
(326, 56, 2, 70221, NULL, NULL, 'pending', '2025-08-22 04:14:15', '2025-08-22 04:14:15'),
(327, 43, 8, 6244, NULL, NULL, 'pending', '2025-08-22 04:14:28', '2025-08-22 04:14:28'),
(328, 43, 8, 6245, 6245, 0, 'failed', '2025-08-22 04:14:48', '2025-08-22 04:14:56'),
(329, 43, 8, 6244, NULL, NULL, 'pending', '2025-08-22 04:15:14', '2025-08-22 04:15:14'),
(330, 43, 8, 6244, NULL, NULL, 'pending', '2025-08-22 04:15:34', '2025-08-22 04:15:34'),
(331, 43, 8, 6244, 6245, 1, 'confirmed', '2025-08-22 04:15:39', '2025-08-22 04:15:52');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_attachments`
--

CREATE TABLE `support_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_message_id` int(10) UNSIGNED DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `support_attachments`
--

INSERT INTO `support_attachments` (`id`, `support_message_id`, `attachment`, `created_at`, `updated_at`) VALUES
(1, 1, '6886a755e83671753655125.png', '2025-07-28 08:25:25', '2025-07-28 08:25:25');

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `message` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `support_messages`
--

INSERT INTO `support_messages` (`id`, `support_ticket_id`, `admin_id`, `message`, `created_at`, `updated_at`) VALUES
(1, 1, 0, '13123123', '2025-07-28 08:25:25', '2025-07-28 08:25:25');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) DEFAULT 0,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `ticket` varchar(40) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: Open, 1: Answered, 2: Replied, 3: Closed',
  `priority` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = Low, 2 = medium, 3 = heigh',
  `last_reply` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `name`, `email`, `ticket`, `subject`, `status`, `priority`, `last_reply`, `created_at`, `updated_at`) VALUES
(1, 3, '111 111', 'netflix.4kac9@gmail.com', '300680', '123123123', 0, 3, '2025-07-28 04:25:25', '2025-07-28 08:25:25', '2025-07-28 08:25:25');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `post_balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `trx_type` varchar(40) DEFAULT NULL,
  `trx` varchar(40) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `remark` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `amount`, `charge`, `post_balance`, `trx_type`, `trx`, `details`, `remark`, `created_at`, `updated_at`) VALUES
(1, 2, 12.00000000, 0.00000000, 12.00000000, '+', '6VGSZ1RWGUAR', '12', 'balance_add', '2025-07-03 21:08:39', '2025-07-03 21:08:39'),
(2, 2, 10.00000000, 0.00000000, 2.00000000, '-', 'RXJ3N9O7RJA1', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-03 21:32:41', '2025-07-03 21:32:41'),
(3, 2, 2.00000000, 0.00000000, 0.00000000, '-', 'BBXAR5NO9AXF', '2', 'balance_subtract', '2025-07-03 21:43:51', '2025-07-03 21:43:51'),
(4, 4, 22.00000000, 0.00000000, 22.00000000, '+', 'XQ2EJBP6QX5Z', '2', 'balance_add', '2025-07-16 08:57:06', '2025-07-16 08:57:06'),
(5, 4, 12.00000000, 0.00000000, 10.00000000, '-', 'CNEAYYPVGJJJ', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-16 08:57:21', '2025-07-16 08:57:21'),
(6, 1, 22.00000000, 0.00000000, 22.00000000, '+', 'GWR9ZBN57XFG', '22', 'balance_add', '2025-07-16 09:37:37', '2025-07-16 09:37:37'),
(7, 1, 12.00000000, 0.00000000, 10.00000000, '-', 'ZONVRXQ6JWEM', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-16 09:47:21', '2025-07-16 09:47:21'),
(8, 1, 10.00000000, 0.00000000, 0.00000000, '-', '3NM1E2YU8QZ4', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-16 23:38:26', '2025-07-16 23:38:26'),
(9, 2, 333.00000000, 0.00000000, 333.00000000, '+', '2TAAME5WKJ1O', '3', 'balance_add', '2025-07-17 02:53:09', '2025-07-17 02:53:09'),
(10, 2, 10.00000000, 0.00000000, 323.00000000, '-', 'HJRMJCRJKOYP', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-17 02:53:24', '2025-07-17 02:53:24'),
(11, 2, 12.00000000, 0.00000000, 311.00000000, '-', '4SYV97DT9MQ4', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-17 02:54:55', '2025-07-17 02:54:55'),
(12, 2, 1.00000000, 0.00000000, 310.00000000, '-', 'HW5WUUFE9SZG', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-17 03:04:37', '2025-07-17 03:04:37'),
(13, 2, 1.00000000, 0.00000000, 309.00000000, '-', 'ZTACQBAXYGOU', 'Subscribe  plan', 'Subscribe_Plan', '2025-07-17 12:32:05', '2025-07-17 12:32:05'),
(14, 2, 10.00000000, 0.00000000, 319.00000000, '+', '8E9OJPOT2PS4', '????? ???', 'balance_add', '2025-07-28 13:11:57', '2025-07-28 13:11:57'),
(15, 2, 10.00000000, 0.00000000, 329.00000000, '+', 'WWUJMDMDY7XH', '????? ???', 'balance_add', '2025-07-28 13:36:35', '2025-07-28 13:36:35'),
(16, 2, 10.00000000, 0.00000000, 359.00000000, '+', 'H6J6U6X7A1XO', '????? ???', 'balance_add', '2025-07-28 13:48:33', '2025-07-28 13:48:33'),
(17, 2, 10.00000000, 0.00000000, 369.00000000, '+', 'SZNMT9PUKA14', '????? ???', 'balance_add', '2025-07-28 14:05:17', '2025-07-28 14:05:17'),
(18, 7, 50.00000000, 0.00000000, 50.00000000, '+', 'ZTNP5MCYQK93', 'رصيد من PowerShell', 'balance_add', '2025-07-28 14:57:36', '2025-07-28 14:57:36'),
(19, 7, 10.00000000, 0.00000000, 60.00000000, '+', 'DUYNZDWUYGSW', 'رصيد من PowerShell', 'balance_add', '2025-07-28 14:58:06', '2025-07-28 14:58:06'),
(20, 7, 10.00000000, 0.00000000, 70.00000000, '+', '4PV6BPFS4GZT', 'رصيد من PowerShell', 'balance_add', '2025-07-28 15:35:28', '2025-07-28 15:35:28'),
(21, 7, 10.00000000, 0.00000000, 80.00000000, '+', 'F18E8K44D5U2', 'رصيد من PowerShell', 'balance_add', '2025-07-28 16:17:20', '2025-07-28 16:17:20'),
(22, 7, 10.00000000, 0.00000000, 90.00000000, '+', 'Q37W9ZXURG95', 'رصيد من PowerShell', 'balance_add', '2025-07-28 16:31:07', '2025-07-28 16:31:07'),
(23, 7, 0.10000000, 0.00000000, 90.10000000, '+', 'DZ2BWGZ6YSX4', 'تفاصيل', 'balance_add', '2025-07-28 16:57:19', '2025-07-28 16:57:19'),
(24, 7, 1.00000000, 0.00000000, 91.10000000, '+', 'R16ATMGTXR74', 'test', 'balance_add', '2025-07-28 17:05:56', '2025-07-28 17:05:56'),
(25, 7, 0.10000000, 0.00000000, 91.20000000, '+', 'G5C77BCVPY85', '111.68870d491e603/10', 'balance_add', '2025-07-28 17:06:06', '2025-07-28 17:06:06'),
(26, 7, 1.00000000, 0.00000000, 92.20000000, '+', '62EKMX6FFXYQ', '926536457.6886c7d2e2a19/10', 'balance_add', '2025-07-28 17:07:36', '2025-07-28 17:07:36'),
(27, 7, 0.10000000, 0.00000000, 92.30000000, '+', '1Q93G9QZH21A', '920000000.6887d5f7acbf9/10', 'balance_add', '2025-07-29 05:59:20', '2025-07-29 05:59:20'),
(28, 7, 1.10000000, 0.00000000, 93.40000000, '+', 'T3YVZKYYGJY4', '926536457.6887d1708f528/10', 'balance_add', '2025-07-29 06:01:18', '2025-07-29 06:01:18'),
(29, 7, 0.01000000, 0.00000000, 93.41000000, '+', '4AWQ3YXGHSDK', '920000000.6887f1c7b41a0/111', 'balance_add', '2025-07-29 07:55:34', '2025-07-29 07:55:34'),
(30, 7, 0.01000000, 0.00000000, 93.42000000, '+', 'VYQ25EAJTQ9A', '920000000.6887f28ba1ba8/111', 'balance_add', '2025-07-29 07:58:45', '2025-07-29 07:58:45'),
(31, 7, 0.11000000, 0.00000000, 93.53000000, '+', '7JG143ZR8G8B', '920000000.68880629c05c5/111', 'balance_add', '2025-07-29 09:22:29', '2025-07-29 09:22:29'),
(32, 7, 0.01000000, 0.00000000, 93.54000000, '+', 'VQJ4O58QC8VV', '920000000.688808d2854c4/111', 'balance_add', '2025-07-29 09:33:41', '2025-07-29 09:33:41'),
(33, 8, 0.09000000, 0.00000000, 0.09000000, '+', 'WW6QCMQFBRMZ', '923333333.688ba3d7bbe05/11.5', 'balance_add', '2025-08-01 03:12:19', '2025-08-01 03:12:19'),
(34, 1, 1.00000000, 0.00000000, 1.00000000, '+', 'RHT8OKY8QFHM', '926536457.688ce689e3f17/2', 'balance_add', '2025-08-01 23:11:35', '2025-08-01 23:11:35'),
(35, 8, 10.00000000, 0.00000000, 10.09000000, '+', 'Z6TKD51QJNOE', '925964473.688e345443e28/2', 'balance_add', '2025-08-05 21:22:06', '2025-08-05 21:22:06'),
(36, 7, 5.00000000, 0.00000000, 30.00000000, '+', 'YKVV2UFHYKNZ', 'Daily login bonus', 'daily_login_bonus', '2025-08-06 05:05:25', '2025-08-06 05:05:25'),
(37, 2, 5.00000000, 0.00000000, 220927.00000000, '+', '6WX9CQU296K5', 'Daily login bonus', 'daily_login_bonus', '2025-08-06 05:06:35', '2025-08-06 05:06:35'),
(38, 7, 0.50000000, 0.00000000, 94.04000000, '+', 'WE513D93EHQP', '926536457.6893cae2c6b58/2', 'balance_add', '2025-08-07 04:19:39', '2025-08-07 04:19:39'),
(39, 7, 5.00000000, 0.00000000, 35.00000000, '+', 'P3OZV57OQ978', 'Daily login bonus', 'daily_login_bonus', '2025-08-07 05:38:15', '2025-08-07 05:38:15'),
(40, 10, 12.00000000, 0.00000000, 12.00000000, '+', '5E56BWAB43PA', '1212', 'balance_add', '2025-08-07 06:10:42', '2025-08-07 06:10:42'),
(41, 10, 50.00000000, 0.00000000, 62.00000000, '+', 'CD8UM8XGRQPY', '920000000.6893ef9118c95/2', 'balance_add', '2025-08-07 06:13:15', '2025-08-07 06:13:15'),
(42, 10, 50.00000000, 0.00000000, 112.00000000, '+', 'G83GREDW3WQF', '920000000.6893f03fcb372/2', 'balance_add', '2025-08-07 06:16:02', '2025-08-07 06:16:02'),
(43, 10, 6.00000000, 0.00000000, 118.00000000, '+', 'CRR5DQNE3P5S', '920000000.6893f4bfb0bed/2', 'balance_add', '2025-08-07 06:37:17', '2025-08-07 06:37:17'),
(44, 10, 1.00000000, 0.00000000, 119.00000000, '+', 'WW39JV2BVCZ6', '920000000.6893f5b5dbfe8/2', 'balance_add', '2025-08-07 06:39:23', '2025-08-07 06:39:23'),
(45, 10, 1.50000000, 0.00000000, 120.50000000, '+', '5YO8HY31XPFX', '920000000.689400447182a/2', 'balance_add', '2025-08-07 07:24:43', '2025-08-07 07:24:43'),
(46, 10, 2.00000000, 0.00000000, 122.50000000, '+', 'WNZ8FRQSQ1H9', '920000000.6894004d2400a/2', 'balance_add', '2025-08-07 07:40:34', '2025-08-07 07:40:34'),
(47, 10, 2.50000000, 0.00000000, 125.00000000, '+', 'D1QVUH3F1RUJ', '920000000.6894005623b5e/2', 'balance_add', '2025-08-07 07:43:24', '2025-08-07 07:43:24'),
(48, 10, 0.50000000, 0.00000000, 125.50000000, '+', 'DQGFF4JCRWEE', '920000000.689405c55931c/2', 'balance_add', '2025-08-07 07:57:52', '2025-08-07 07:57:52'),
(49, 10, 0.50000000, 0.00000000, 126.00000000, '+', 'EWWJSEVY2GZE', '920000000.689405caf4035/2', 'balance_add', '2025-08-07 08:05:01', '2025-08-07 08:05:01'),
(50, 10, 0.50000000, 0.00000000, 126.50000000, '+', '9B2QT6EGV6WY', '920000000.689405cf8bd07/2', 'balance_add', '2025-08-07 08:07:11', '2025-08-07 08:07:11'),
(51, 10, 0.50000000, 0.00000000, 127.00000000, '+', 'TCZ81CA9KMN9', '920000000.689405d490404/2', 'balance_add', '2025-08-07 08:10:53', '2025-08-07 08:10:53'),
(52, 10, 0.50000000, 0.00000000, 127.50000000, '+', 'YEH6UJHBE7B9', '920000000.689405d9ab343/2', 'balance_add', '2025-08-07 08:16:33', '2025-08-07 08:16:33'),
(53, 10, 0.50000000, 0.00000000, 128.00000000, '+', '3T7OCF2XJE1K', '920000000.689405ded9dee/2', 'balance_add', '2025-08-07 08:22:12', '2025-08-07 08:22:12'),
(54, 10, 0.50000000, 0.00000000, 128.50000000, '+', 'Y74WO93ZV875', '920000000.68940e27c6301/2', 'balance_add', '2025-08-07 08:24:09', '2025-08-07 08:24:09'),
(55, 10, 0.50000000, 0.00000000, 129.00000000, '+', '3E67QW4US2NX', '920000000.68940e2cacd25/2', 'balance_add', '2025-08-07 08:27:30', '2025-08-07 08:27:30'),
(56, 10, 0.50000000, 0.00000000, 129.50000000, '+', 'AZ7RUVU7OSD3', '920000000.68940e3176f21/2', 'balance_add', '2025-08-07 08:30:58', '2025-08-07 08:30:58'),
(57, 10, 0.50000000, 0.00000000, 130.00000000, '+', 'FRK36VGU4627', '920000000.68940e3689bd1/2', 'balance_add', '2025-08-07 08:31:45', '2025-08-07 08:31:45'),
(58, 10, 0.50000000, 0.00000000, 130.50000000, '+', 'HVE84BN7SRVQ', '920000000.68940e3b045b1/2', 'balance_add', '2025-08-07 08:34:08', '2025-08-07 08:34:08'),
(59, 10, 0.50000000, 0.00000000, 131.00000000, '+', 'WMFDNVR4S6UY', '920000000.689411c89bd3e/2', 'balance_add', '2025-08-07 08:39:12', '2025-08-07 08:39:12'),
(60, 2, 1.00000000, 0.00000000, 220928.00000000, '+', '48EVHTAKV3A4', 'Daily login bonus', 'daily_login_bonus', '2025-08-07 09:18:13', '2025-08-07 09:18:13'),
(61, 2, 0.50000000, 0.00000000, 369.50000000, '+', 'UC1ZK9R9AJHE', '920000000.689411cd9b572/2', 'balance_add', '2025-08-07 10:18:59', '2025-08-07 10:18:59'),
(62, 2, 0.50000000, 0.00000000, 370.00000000, '+', 'XBZNZHS1KH8N', '920000000.6894348951cf5/2', 'balance_add', '2025-08-07 11:07:58', '2025-08-07 11:07:58'),
(63, 10, 0.50000000, 0.00000000, 131.50000000, '+', '885AQRDZYPBC', '920000000.6894348f19fd7/2', 'balance_add', '2025-08-07 12:07:07', '2025-08-07 12:07:07'),
(64, 3, 1.00000000, 0.00000000, 272.00000000, '+', '2JOZRE2BJGD7', 'Daily login bonus', 'daily_login_bonus', '2025-08-07 21:11:19', '2025-08-07 21:11:19'),
(65, 3, 1.00000000, 0.00000000, 339.00000000, '+', 'UONWATCZ3528', 'Daily login bonus', 'daily_login_bonus', '2025-08-08 05:09:36', '2025-08-08 05:09:36'),
(66, 2, 1.00000000, 0.00000000, 220863.00000000, '+', 'KWYHXWWTBUON', 'Daily login bonus', 'daily_login_bonus', '2025-08-08 05:10:22', '2025-08-08 05:10:22'),
(67, 7, 0.50000000, 0.00000000, 94.54000000, '+', '2DW7Z23SYJ3V', '920000000.68943495bb3d6/2', 'balance_add', '2025-08-11 06:39:04', '2025-08-11 06:39:04'),
(68, 7, 0.50000000, 0.00000000, 95.04000000, '+', 'T67Q2VHE9XV9', '920000000.6894349aaf5ff/2', 'balance_add', '2025-08-11 06:41:31', '2025-08-11 06:41:31'),
(69, 7, 0.50000000, 0.00000000, 95.54000000, '+', 'QOTJ9X22TF77', '920000000.6894349f79f80/2', 'balance_add', '2025-08-11 06:59:49', '2025-08-11 06:59:49'),
(70, 10, 0.50000000, 0.00000000, 132.00000000, '+', '3R1RV3JGZKGW', '920000000.689943c64906c/2', 'balance_add', '2025-08-11 07:32:40', '2025-08-11 07:32:40'),
(71, 10, 0.50000000, 0.00000000, 132.50000000, '+', 'Y1YQZ6XC1247', '920000000.68994df3802bc/2', 'balance_add', '2025-08-11 07:57:11', '2025-08-11 07:57:11'),
(72, 3, 1.00000000, 0.00000000, 340.00000000, '+', 'XSER4N14FMHF', 'Daily login bonus', 'daily_login_bonus', '2025-08-13 06:46:17', '2025-08-13 06:46:17'),
(73, 3, 22.00000000, 0.00000000, 340.00000000, '+', 'ZTEX9BPPRTUA', 'Withdraw cancelled', 'withdraw_cancelled', '2025-08-13 07:20:17', '2025-08-13 07:20:17'),
(74, 3, 333.00000000, 0.00000000, -326.00000000, '-', 'MVDQZC85WWYS', 'Withdraw approved', 'withdraw_approved', '2025-08-13 07:24:40', '2025-08-13 07:24:40'),
(75, 10, 999.00000000, 0.00000000, 999.00000000, '+', '5WX8G4Q9STR9', 'Withdraw cancelled', 'withdraw_cancelled', '2025-08-13 07:43:42', '2025-08-13 07:43:42'),
(76, 10, 99.00000000, 0.00000000, 801.00000000, '-', 'EYUTTVFNZQTZ', 'Withdraw approved', 'withdraw_approved', '2025-08-13 07:46:26', '2025-08-13 07:46:26'),
(77, 10, 100.00000000, 0.00000000, 687.00000000, '+', 'BWBYOCVM69ET', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 08:35:44', '2025-08-13 08:35:44'),
(78, 2, 1.00000000, 0.00000000, 220864.00000000, '+', 'FZM6T8BJ4CUK', 'Daily login bonus', 'daily_login_bonus', '2025-08-13 04:29:09', '2025-08-13 04:29:09'),
(79, 10, 31.00000000, 0.00000000, 611.00000000, '+', 'VVOZOSYV6K7K', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 05:54:41', '2025-08-13 05:54:41'),
(80, 10, 12.00000000, 0.00000000, 623.00000000, '+', '31QACFYP92S2', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 05:54:48', '2025-08-13 05:54:48'),
(81, 10, 66.00000000, 0.00000000, 647.00000000, '+', 'M3QPGSBG9MUS', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 06:26:03', '2025-08-13 06:26:03'),
(82, 10, 456.00000000, 0.00000000, 647.00000000, '+', '7K8TVC9SD65G', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 06:27:17', '2025-08-13 06:27:17'),
(83, 10, 55.00000000, 0.00000000, 559.00000000, '+', 'RY9OUR7Y5ZXH', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 06:43:15', '2025-08-13 06:43:15'),
(84, 10, 22.00000000, 0.00000000, 613.00000000, '+', 'JP4N7FX38O3X', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-13 07:32:39', '2025-08-13 07:32:39'),
(85, 10, 1.00000000, 0.00000000, 131.50000000, '-', 'CNSFEUC242Y1', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 16:39:23', '2025-08-15 16:39:23'),
(86, 2, 1.00000000, 0.00000000, 220865.00000000, '+', '7JKW25MZB82R', 'Daily login bonus', 'daily_login_bonus', '2025-08-15 16:40:53', '2025-08-15 16:40:53'),
(87, 2, 1.00000000, 0.00000000, 369.00000000, '-', '2U5UV5C6W6JK', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 16:41:02', '2025-08-15 16:41:02'),
(88, 2, 1.00000000, 0.00000000, 368.00000000, '-', 'VKE599SQ3STS', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 16:55:53', '2025-08-15 16:55:53'),
(89, 2, 1.00000000, 0.00000000, 367.00000000, '-', 'MZ57QXMBOD3H', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 17:05:39', '2025-08-15 17:05:39'),
(90, 2, 1.00000000, 0.00000000, 366.00000000, '-', '7EOAJ48RY86U', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 17:06:02', '2025-08-15 17:06:02'),
(91, 2, 1.00000000, 0.00000000, 365.00000000, '-', 'WKV6NXYEQY1D', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 17:08:34', '2025-08-15 17:08:34'),
(92, 2, 1.00000000, 0.00000000, 364.00000000, '-', 'W3UDXX35JWFM', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 17:11:45', '2025-08-15 17:11:45'),
(93, 2, 1.00000000, 0.00000000, 363.00000000, '-', 'ZHMWZ6ATXYYV', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 17:14:52', '2025-08-15 17:14:52'),
(94, 2, 1.00000000, 0.00000000, 362.00000000, '-', 'BWPC6GH7777O', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 19:15:33', '2025-08-15 19:15:33'),
(95, 2, 1.00000000, 0.00000000, 361.00000000, '-', '94GA65V4XP7U', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 19:28:10', '2025-08-15 19:28:10'),
(96, 2, 1.00000000, 0.00000000, 360.00000000, '-', '972AFAOZR2B1', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 20:08:21', '2025-08-15 20:08:21'),
(97, 2, 1.00000000, 0.00000000, 359.00000000, '-', 'B9SKCSGC45E9', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 20:50:06', '2025-08-15 20:50:06'),
(98, 6, 1.00000000, 0.00000000, 32.00000000, '+', 'AXGD4UWGZ89V', 'Daily login bonus', 'daily_login_bonus', '2025-08-15 21:24:19', '2025-08-15 21:24:19'),
(99, 2, 1.00000000, 0.00000000, 231825.00000000, '+', 'NZBPMN5TVQ1R', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-15 22:30:09', '2025-08-15 22:30:09'),
(100, 7, 1.00000000, 0.00000000, 94.54000000, '-', 'Z2KP5JYGE6XM', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 23:26:51', '2025-08-15 23:26:51'),
(101, 2, 1.00000000, 0.00000000, 358.00000000, '-', 'NX95GBYWFBTW', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-15 23:39:19', '2025-08-15 23:39:19'),
(102, 2, 1.00000000, 0.00000000, 357.00000000, '-', 'D1ZSJRPC7B5F', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-16 00:05:50', '2025-08-16 00:05:50'),
(103, 2, 1.00000000, 0.00000000, 233824.00000000, '+', 'QK2AQJ3TZBJK', 'Daily login bonus', 'daily_login_bonus', '2025-08-16 17:31:30', '2025-08-16 17:31:30'),
(104, 2, 1.00000000, 0.00000000, 233825.00000000, '+', 'KG2TDXJ4W8FW', 'Daily login bonus', 'daily_login_bonus', '2025-08-16 22:11:55', '2025-08-16 22:11:55'),
(105, 2, 1.00000000, 0.00000000, 233826.00000000, '+', '9W8TW3NOFWQ2', 'Daily login bonus', 'daily_login_bonus', '2025-08-17 22:49:40', '2025-08-17 22:49:40'),
(106, 2, 1.00000000, 0.00000000, 233639.00000000, '+', 'CZCS3U4CDWKC', 'Daily login bonus', 'daily_login_bonus', '2025-08-18 22:58:24', '2025-08-18 22:58:24'),
(107, 8, 1.00000000, 0.00000000, 969.00000000, '+', '38WNN45MXQKV', 'Daily login bonus', 'daily_login_bonus', '2025-08-19 21:45:44', '2025-08-19 21:45:44'),
(108, 10, 0.50000000, 0.00000000, 132.00000000, '+', 'D1TPT8YEKNMY', '920000000.68a4d33deb024/2', 'balance_add', '2025-08-20 06:19:15', '2025-08-20 06:19:15'),
(109, 10, 1.00000000, 0.00000000, 133.00000000, '+', 'KQY79EAHR8J4', '920000000.24d2507209d4/2', 'balance_add', '2025-08-20 06:19:15', '2025-08-20 06:19:15'),
(110, 10, 0.50000000, 0.00000000, 133.50000000, '+', 'PG5MO67FXC6C', '920000000.68a52445ec6dd/2', 'balance_add', '2025-08-20 07:26:53', '2025-08-20 07:26:53'),
(111, 10, 1.00000000, 0.00000000, 134.50000000, '+', 'BG98GYN8GDAE', '920000000.68943a19c254d/2', 'balance_add', '2025-08-20 07:28:33', '2025-08-20 07:28:33'),
(112, 10, 1.50000000, 0.00000000, 136.00000000, '+', 'R7BPV144ZZYT', '920000000.68943a22c68e9/2', 'balance_add', '2025-08-20 07:31:05', '2025-08-20 07:31:05'),
(113, 10, 3.00000000, 0.00000000, 139.00000000, '+', '4OMB7FXEMMDE', '920000000.306ab2a33e07/2', 'balance_add', '2025-08-20 07:31:06', '2025-08-20 07:31:06'),
(114, 10, 1.00000000, 0.00000000, 140.00000000, '+', 'ABNA3JO9E4J5', '920000000.68a5244f41ebd/2', 'balance_add', '2025-08-20 07:33:43', '2025-08-20 07:33:43'),
(115, 10, 2.00000000, 0.00000000, 142.00000000, '+', '2NQGMEGFD77N', '920000000.e9c7844d861a/2', 'balance_add', '2025-08-20 07:33:44', '2025-08-20 07:33:44'),
(116, 10, 1.50000000, 0.00000000, 143.50000000, '+', 'UEH7AOVXFDR2', '920000000.68a524588e511/2', 'balance_add', '2025-08-20 07:34:57', '2025-08-20 07:34:57'),
(117, 10, 3.00000000, 0.00000000, 146.50000000, '+', 'FAVEM5DH6W67', '920000000.346e8fc62bbd/2', 'balance_add', '2025-08-20 07:34:57', '2025-08-20 07:34:57'),
(118, 10, 1.00000000, 0.00000000, 147.50000000, '+', 'W2W7JTKQ3KVF', '920000000.68a5267c8aa69/2', 'balance_add', '2025-08-20 07:36:41', '2025-08-20 07:36:41'),
(119, 10, 2.00000000, 0.00000000, 149.50000000, '+', 'FXTS784RQ4N6', '920000000.441c04426fcf/2', 'balance_add', '2025-08-20 07:36:41', '2025-08-20 07:36:41'),
(120, 10, 1.00000000, 0.00000000, 150.50000000, '+', 'N1S2BNZZEZMM', '920000000.68a526827351b/2', 'balance_add', '2025-08-20 07:44:08', '2025-08-20 07:44:08'),
(121, 10, 2.00000000, 0.00000000, 152.50000000, '+', 'DB4N2SM1HYJV', '920000000.6ef9397cca94/2', 'balance_add', '2025-08-20 07:44:08', '2025-08-20 07:44:08'),
(122, 10, 1.00000000, 0.00000000, 153.50000000, '+', '9BDM7J627CM7', '920000000.68a526879ba9d/2', 'balance_add', '2025-08-20 07:51:12', '2025-08-20 07:51:12'),
(123, 10, 2.00000000, 0.00000000, 155.50000000, '+', 'QG4JKGW8Q8NC', '920000000.916980caa930/2', 'balance_add', '2025-08-20 07:51:13', '2025-08-20 07:51:13'),
(124, 10, 1.00000000, 0.00000000, 156.50000000, '+', '71ETGTTDGXN1', '920000000.68a5268ce0048/2', 'balance_add', '2025-08-20 07:59:22', '2025-08-20 07:59:22'),
(125, 10, 2.00000000, 0.00000000, 158.50000000, '+', 'TMMBOCTVG41E', '920000000.c64111504c0d/2', 'balance_add', '2025-08-20 07:59:23', '2025-08-20 07:59:23'),
(126, 10, 1.00000000, 0.00000000, 159.50000000, '+', 'RMRANQG2QZVU', '920000000.68a53143dc476/2', 'balance_add', '2025-08-20 08:23:26', '2025-08-20 08:23:26'),
(127, 10, 1.00000000, 0.00000000, 160.50000000, '+', 'OJOB72ZK3CH5', '920000000.68a531491137a/2', 'balance_add', '2025-08-20 08:26:13', '2025-08-20 08:26:13'),
(128, 10, 1.00000000, 0.00000000, 161.50000000, '+', 'WKVMH8GZFV2U', '920000000.68a5314eed038/2', 'balance_add', '2025-08-20 08:29:51', '2025-08-20 08:29:51'),
(129, 10, 1.00000000, 0.00000000, 162.50000000, '+', 'MN5RX37EAC3X', '920000000.68a531542b578/2', 'balance_add', '2025-08-20 08:34:05', '2025-08-20 08:34:05'),
(130, 10, 1.00000000, 0.00000000, 163.50000000, '+', 'FK1C9SX15QV1', '920000000.68a5315950a7a/2', 'balance_add', '2025-08-20 08:36:42', '2025-08-20 08:36:42'),
(131, 10, 1.00000000, 0.00000000, 164.50000000, '+', 'GF7YT6GJZ2XV', '920000000.68a5315e1316a/2', 'balance_add', '2025-08-20 08:38:38', '2025-08-20 08:38:38'),
(132, 10, 2.00000000, 0.00000000, 166.50000000, '+', 'YZZVKSNVOOXV', '920000000.864a36d762f3/2', 'balance_add', '2025-08-20 08:38:39', '2025-08-20 08:38:39'),
(133, 10, 1.00000000, 0.00000000, 167.50000000, '+', 'WJZEN16MYFDQ', '920000000.68a535bb2e199/2', 'balance_add', '2025-08-20 08:41:23', '2025-08-20 08:41:23'),
(134, 10, 2.00000000, 0.00000000, 169.50000000, '+', 'R174TU5KKYGJ', '920000000.775922937bb2/2', 'balance_add', '2025-08-20 08:41:24', '2025-08-20 08:41:24'),
(135, 10, 1.00000000, 0.00000000, 170.50000000, '+', 'BS49DVCPU6OU', '920000000.68a535c072bdd/2', 'balance_add', '2025-08-20 08:41:51', '2025-08-20 08:41:51'),
(136, 10, 2.00000000, 0.00000000, 172.50000000, '+', 'KGFJSFT5TW3D', '920000000.7765557f3163/2', 'balance_add', '2025-08-20 08:41:52', '2025-08-20 08:41:52'),
(137, 10, 1.00000000, 0.00000000, 173.50000000, '+', '2A4PSD87QE5Q', '920000000.68a535c4bfb2e/2', 'balance_add', '2025-08-20 08:42:22', '2025-08-20 08:42:22'),
(138, 10, 2.00000000, 0.00000000, 175.50000000, '+', 'OJV65W14GE7K', '920000000.a90a4c24b27a/2', 'balance_add', '2025-08-20 08:42:22', '2025-08-20 08:42:22'),
(139, 10, 1.00000000, 0.00000000, 176.50000000, '+', 'C6FJJQSVMH9Q', '920000000.68a535c9aa566/2', 'balance_add', '2025-08-20 08:43:37', '2025-08-20 08:43:37'),
(140, 10, 1.00000000, 0.00000000, 177.50000000, '+', 'Y683XPBGAC49', '920000000.68a535cea81a4/2', 'balance_add', '2025-08-20 08:46:58', '2025-08-20 08:46:58'),
(141, 10, 1.00000000, 0.00000000, 178.50000000, '+', '8BR18BW77DYP', '920000000.68a5361ad1e62/2', 'balance_add', '2025-08-20 08:51:34', '2025-08-20 08:51:34'),
(142, 10, 1.00000000, 0.00000000, 179.50000000, '+', 'BWY8JPCFF1NF', '920000000.68a5361f5d3ae/2', 'balance_add', '2025-08-20 08:53:46', '2025-08-20 08:53:46'),
(143, 10, 1.00000000, 0.00000000, 180.50000000, '+', 'R13WEY4UOXC6', '920000000.68a53624b264c/2', 'balance_add', '2025-08-20 08:56:50', '2025-08-20 08:56:50'),
(144, 10, 1.00000000, 0.00000000, 181.50000000, '+', 'AED77KATCY5Z', '920000000.68a5362932d89/2', 'balance_add', '2025-08-20 08:57:22', '2025-08-20 08:57:22'),
(145, 10, 1.00000000, 0.00000000, 182.50000000, '+', 'F5KMM7Q54ACD', '920000000.68a5362ea235d/2', 'balance_add', '2025-08-20 09:02:33', '2025-08-20 09:02:33'),
(146, 10, 1.00000000, 0.00000000, 183.50000000, '+', 'CR697TF9YS2N', '920000000.68a53b0adeb22/2', 'balance_add', '2025-08-20 09:04:17', '2025-08-20 09:04:17'),
(147, 10, 2.00000000, 0.00000000, 185.50000000, '+', 'F6WVB8NZ6XJ5', '920000000.816d74aec7be/2', 'balance_add', '2025-08-20 09:04:18', '2025-08-20 09:04:18'),
(148, 10, 1.00000000, 0.00000000, 186.50000000, '+', '57MP43P2YGKR', '920000000.68a53b103e585/2', 'balance_add', '2025-08-20 09:05:36', '2025-08-20 09:05:36'),
(149, 10, 1.00000000, 0.00000000, 187.50000000, '+', 'N1ZRWUJZNBXX', '920000000.68a53b156d903/2', 'balance_add', '2025-08-20 09:10:49', '2025-08-20 09:10:49'),
(150, 10, 1.00000000, 0.00000000, 188.50000000, '+', 'OWE3RGS7MORQ', '920000000.68a53b1ac380c/2', 'balance_add', '2025-08-20 09:16:28', '2025-08-20 09:16:28'),
(151, 10, 1.00000000, 0.00000000, 189.50000000, '+', 'UG433FT5H33H', '920000000.68a53b1f2e4ed/2', 'balance_add', '2025-08-20 09:21:26', '2025-08-20 09:21:26'),
(152, 10, 1.00000000, 0.00000000, 190.50000000, '+', '95EHNRAQV3RO', '920000000.68a53b244fffe/2', 'balance_add', '2025-08-20 09:26:51', '2025-08-20 09:26:51'),
(153, 10, 200.00000000, 0.00000000, 390.50000000, '+', 'M59BVM2YY8G9', '920000000.514d6b26ea95/2', 'balance_add', '2025-08-20 09:26:51', '2025-08-20 09:26:51'),
(154, 10, 1.00000000, 0.00000000, 391.50000000, '+', 'NXBXNNXAUM82', '920000000.68a5414e8c7df/2', 'balance_add', '2025-08-20 09:31:21', '2025-08-20 09:31:21'),
(155, 10, 200.00000000, 0.00000000, 591.50000000, '+', 'G9RSKB5S9EVX', '920000000.b0900d6ae6a7/2', 'balance_add', '2025-08-20 09:31:22', '2025-08-20 09:31:22'),
(156, 10, 1.00000000, 0.00000000, 592.50000000, '+', 'AJSH4URFZ3B3', '920000000.68a54154360b1/2', 'balance_add', '2025-08-20 09:31:50', '2025-08-20 09:31:50'),
(157, 10, 1.00000000, 0.00000000, 593.50000000, '+', 'YO55F3YP78CS', '920000000.68a54158a10cc/2', 'balance_add', '2025-08-20 09:41:56', '2025-08-20 09:41:56'),
(158, 10, 4.00000000, 0.00000000, 597.50000000, '+', 'S7GWTATZ41NG', '920000000.b47f47f44dff/2', 'balance_add', '2025-08-20 09:41:57', '2025-08-20 09:41:57'),
(159, 10, 1.00000000, 0.00000000, 598.50000000, '+', 'GZWH2TVVJ5JY', '920000000.68a5415d7d01b/2', 'balance_add', '2025-08-20 09:42:25', '2025-08-20 09:42:25'),
(160, 10, 4.00000000, 0.00000000, 602.50000000, '+', '5DRR85QCE71E', '920000000.aca3b08713a4/2', 'balance_add', '2025-08-20 09:42:25', '2025-08-20 09:42:25'),
(161, 10, 1.00000000, 0.00000000, 603.50000000, '+', '2ZTKHV4OGPDN', '920000000.68a54161e3b70/2', 'balance_add', '2025-08-20 10:03:07', '2025-08-20 10:03:07'),
(162, 10, 1.00000000, 0.00000000, 604.50000000, '+', 'XPKX8HMSU2AU', '920000000.68a54166bbec7/2', 'balance_add', '2025-08-20 10:06:14', '2025-08-20 10:06:14'),
(163, 10, 2.00000000, 0.00000000, 606.50000000, '+', 'FCTB5B1RHFZB', '920000000.df963e9296ba/2', 'balance_add', '2025-08-20 10:06:14', '2025-08-20 10:06:14'),
(164, 10, 1.00000000, 0.00000000, 607.50000000, '+', 'Y34UVDJMNT8U', '920000000.68a5416ba1d12/2', 'balance_add', '2025-08-20 10:11:21', '2025-08-20 10:11:21'),
(165, 10, 2.00000000, 0.00000000, 609.50000000, '+', 'DYQFRZXK9KS9', '920000000.a6e8ec7a1cf9/2', 'balance_add', '2025-08-20 10:11:22', '2025-08-20 10:11:22'),
(166, 10, 1.00000000, 0.00000000, 610.50000000, '+', 'MJ331VJEHUYZ', '920000000.68a54170417bc/2', 'balance_add', '2025-08-20 10:28:14', '2025-08-20 10:28:14'),
(167, 10, 2.00000000, 0.00000000, 612.50000000, '+', '46AD53HUYYWT', '920000000.9c59282cd026/2', 'balance_add', '2025-08-20 10:28:14', '2025-08-20 10:28:14'),
(168, 10, 1.00000000, 0.00000000, 613.50000000, '+', 'OMPZEEMKYBJ8', '920000000.68a5417966657/2', 'balance_add', '2025-08-20 10:29:29', '2025-08-20 10:29:29'),
(169, 10, 2.00000000, 0.00000000, 615.50000000, '+', 'P58OG3APJ3EY', '920000000.9030f93d5019/2', 'balance_add', '2025-08-20 10:29:30', '2025-08-20 10:29:30'),
(170, 10, 1.00000000, 0.00000000, 616.50000000, '+', '1ZFYPWA2ASMM', '920000000.68a5417e58a16/2', 'balance_add', '2025-08-20 10:34:29', '2025-08-20 10:34:29'),
(171, 10, 2.00000000, 0.00000000, 618.50000000, '+', 'Q598V9CTDGNR', '920000000.b7a0a8a44148/2', 'balance_add', '2025-08-20 10:34:29', '2025-08-20 10:34:29'),
(172, 10, 1.00000000, 0.00000000, 619.50000000, '+', '5JEBOP4ZWW94', '920000000.68a551b0cdefc/2', 'balance_add', '2025-08-20 10:40:51', '2025-08-20 10:40:51'),
(173, 10, 2.00000000, 0.00000000, 621.50000000, '+', 'KGJOG44K8TDX', '920000000.a12406c6770e/2', 'balance_add', '2025-08-20 10:40:52', '2025-08-20 10:40:52'),
(174, 10, 1.00000000, 0.00000000, 622.50000000, '+', '1CRQBNUWFRF9', '920000000.68a551b669366/2', 'balance_add', '2025-08-20 10:42:11', '2025-08-20 10:42:11'),
(175, 10, 2.00000000, 0.00000000, 624.50000000, '+', 'XXFZ9TRVSZVY', '920000000.1bf0da113a6f/2', 'balance_add', '2025-08-20 10:42:11', '2025-08-20 10:42:11'),
(176, 10, 1.00000000, 0.00000000, 625.50000000, '+', '48WK41H68E62', '920000000.68a551bc1f7fc/2', 'balance_add', '2025-08-20 10:42:32', '2025-08-20 10:42:32'),
(177, 10, 2.00000000, 0.00000000, 627.50000000, '+', '92C86U98SEY6', '920000000.0bfb5f9f4756/2', 'balance_add', '2025-08-20 10:42:33', '2025-08-20 10:42:33'),
(178, 10, 1.00000000, 0.00000000, 628.50000000, '+', 'XK44AEFQMWMB', '920000000.68a551c11107a/2', 'balance_add', '2025-08-20 10:42:50', '2025-08-20 10:42:50'),
(179, 10, 1.00000000, 0.00000000, 629.50000000, '+', 'S52JR2Y17MVM', '920000000.68a551c5c9e56/2', 'balance_add', '2025-08-20 10:43:08', '2025-08-20 10:43:08'),
(180, 10, 2.00000000, 0.00000000, 631.50000000, '+', 'AZXCQ4AWK8VV', '920000000.ad322598c780/2', 'balance_add', '2025-08-20 10:43:08', '2025-08-20 10:43:08'),
(181, 10, 1.00000000, 0.00000000, 632.50000000, '+', '8249K37HZJBN', '920000000.68a551caceffc/2', 'balance_add', '2025-08-20 10:58:53', '2025-08-20 10:58:53'),
(182, 10, 2.00000000, 0.00000000, 634.50000000, '+', 'Y6QCW3K661B5', '920000000.caad4469f3cf/2', 'balance_add', '2025-08-20 10:58:54', '2025-08-20 10:58:54'),
(183, 10, 1.00000000, 0.00000000, 635.50000000, '+', 'R5TT521RAKKA', '920000000.68a551d02e88f/2', 'balance_add', '2025-08-20 11:05:32', '2025-08-20 11:05:32'),
(184, 10, 1.00000000, 0.00000000, 636.50000000, '+', '8FZZGV6JJ1YM', '920000000.68a558ad311c5/2', 'balance_add', '2025-08-20 11:10:45', '2025-08-20 11:10:45'),
(185, 10, 1.00000000, 0.00000000, 637.50000000, '+', '1G18ONVVXTTP', '920000000.68a558b2a7678/2', 'balance_add', '2025-08-20 11:13:03', '2025-08-20 11:13:03'),
(186, 10, 1.00000000, 0.00000000, 638.50000000, '+', 'DCW9QQ7HZXZ3', '920000000.68a558b815c4c/2', 'balance_add', '2025-08-20 11:17:27', '2025-08-20 11:17:27'),
(187, 10, 1.00000000, 0.00000000, 639.50000000, '+', 'SWN41PM76QCW', '920000000.68a558bce2454/2', 'balance_add', '2025-08-20 11:17:34', '2025-08-20 11:17:34'),
(188, 10, 1.00000000, 0.00000000, 640.50000000, '+', 'AMRE2EEJS5VZ', '920000000.68a558c201948/2', 'balance_add', '2025-08-20 11:18:22', '2025-08-20 11:18:22'),
(189, 10, 2.00000000, 0.00000000, 642.50000000, '+', 'H6Y8EVHVQ7FO', '920000000.9e207ea8aed2/2', 'balance_add', '2025-08-20 11:18:22', '2025-08-20 11:18:22'),
(190, 10, 1.00000000, 0.00000000, 643.50000000, '+', '6F2VPD819CXZ', '920000000.68a558c732961/2', 'balance_add', '2025-08-20 11:18:34', '2025-08-20 11:18:34'),
(191, 10, 2.00000000, 0.00000000, 645.50000000, '+', 'KTFHNUWAE52P', '920000000.f1f3bf46f135/2', 'balance_add', '2025-08-20 11:18:34', '2025-08-20 11:18:34'),
(192, 10, 1.00000000, 0.00000000, 646.50000000, '+', 'HK8PMJZG8XON', '920000000.68a558cc88307/2', 'balance_add', '2025-08-20 11:21:23', '2025-08-20 11:21:23'),
(193, 10, 2.00000000, 0.00000000, 648.50000000, '+', 'KFVF7QEJY9Z9', '920000000.0055ab1d7eff/2', 'balance_add', '2025-08-20 11:21:23', '2025-08-20 11:21:23'),
(194, 10, 1.00000000, 0.00000000, 649.50000000, '+', 'ZUKVQK41F9PY', '920000000.68a558d16b83c/2', 'balance_add', '2025-08-20 11:46:10', '2025-08-20 11:46:10'),
(195, 10, 1.00000000, 0.00000000, 650.50000000, '+', '3Y9XX574AUHO', '920000000.68a561ff37274/2', 'balance_add', '2025-08-20 11:50:00', '2025-08-20 11:50:00'),
(196, 10, 2.00000000, 0.00000000, 652.50000000, '+', 'NRVEOBQOB635', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 11:50:00', '2025-08-20 11:50:00'),
(197, 10, 1.00000000, 0.00000000, 653.50000000, '+', 'UGF34K34K7TD', '920000000.68a56204d957f/2', 'balance_add', '2025-08-20 12:28:37', '2025-08-20 12:28:37'),
(198, 10, 2.00000000, 0.00000000, 655.50000000, '+', 'JXNJQDHP2Z92', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 12:28:37', '2025-08-20 12:28:37'),
(199, 10, 1.00000000, 0.00000000, 656.50000000, '+', 'F6DJTPQZ5OBS', '920000000.68a5620bb2ca2/2', 'balance_add', '2025-08-20 12:29:12', '2025-08-20 12:29:12'),
(200, 10, 2.00000000, 0.00000000, 658.50000000, '+', 'MDVF2Y1VKPY5', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 12:29:13', '2025-08-20 12:29:13'),
(201, 10, 1.00000000, 0.00000000, 659.50000000, '+', '324ZNDTTK9XX', '920000000.68a56211af5f7/2', 'balance_add', '2025-08-20 12:29:51', '2025-08-20 12:29:51'),
(202, 10, 2.00000000, 0.00000000, 661.50000000, '+', 'O5AVQ7GBSK9J', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 12:29:52', '2025-08-20 12:29:52'),
(203, 10, 1.00000000, 0.00000000, 662.50000000, '+', 'C54DA3VTHM6E', '920000000.68a567218eaa3/2', 'balance_add', '2025-08-20 12:30:28', '2025-08-20 12:30:28'),
(204, 10, 2.00000000, 0.00000000, 664.50000000, '+', 'FC4Z5RHTPSOU', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 12:30:29', '2025-08-20 12:30:29'),
(205, 10, 1.00000000, 0.00000000, 665.50000000, '+', 'FK32ENBHHJ8F', '920000000.68a56d27ae7a3/2', 'balance_add', '2025-08-20 12:37:31', '2025-08-20 12:37:31'),
(206, 10, 2.00000000, 0.00000000, 667.50000000, '+', 'JD74HOZGCOF1', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 12:37:31', '2025-08-20 12:37:31'),
(207, 10, 1.00000000, 0.00000000, 668.50000000, '+', '6GYU1T4YQCNW', '920000000.68a56d2e9f4d3/2', 'balance_add', '2025-08-20 12:43:22', '2025-08-20 12:43:22'),
(208, 10, 2.00000000, 0.00000000, 670.50000000, '+', 'R99RT2YTXU5X', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 12:43:22', '2025-08-20 12:43:22'),
(209, 10, 1.00000000, 0.00000000, 671.50000000, '+', 'WQQDPNMO4TWD', '920000000.68a56d33b10cb/2', 'balance_add', '2025-08-20 13:00:13', '2025-08-20 13:00:13'),
(210, 10, 2.00000000, 0.00000000, 673.50000000, '+', 'T23CSAVUGSTW', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 13:00:14', '2025-08-20 13:00:14'),
(211, 10, 1.00000000, 0.00000000, 674.50000000, '+', '97T6GE2WDHKO', '920000000.68a56d3945c16/2', 'balance_add', '2025-08-20 13:13:03', '2025-08-20 13:13:03'),
(212, 10, 2.00000000, 0.00000000, 676.50000000, '+', 'CDW29GV8OM6W', '920000000.6e74f7aebd23/2', 'balance_add', '2025-08-20 13:13:03', '2025-08-20 13:13:03'),
(213, 3, 1.00000000, 0.00000000, -325.00000000, '+', '5PFC393Y9PW7', 'Daily login bonus', 'daily_login_bonus', '2025-08-20 13:17:23', '2025-08-20 13:17:23'),
(214, 3, 1.00000000, 0.00000000, 1.00000000, '+', '3J6SRR4Q9D7Q', '920000000.68a57f15b6945/2', 'balance_add', '2025-08-20 13:54:01', '2025-08-20 13:54:01'),
(215, 3, 1.00000000, 0.00000000, 2.00000000, '+', '6MNX7WU5KFS2', '920000000.68a57f1e755c0/2', 'balance_add', '2025-08-20 13:55:38', '2025-08-20 13:55:38'),
(216, 3, 1.00000000, 0.00000000, 3.00000000, '+', '9P4HHCHVAEKA', '920000000.68a57f24404cf/2', 'balance_add', '2025-08-20 14:08:43', '2025-08-20 14:08:43'),
(217, 3, 1.00000000, 0.00000000, 4.00000000, '+', 'OY6UM8OZOSQ5', '920000000.68a5839b68d3c/2', 'balance_add', '2025-08-20 14:13:19', '2025-08-20 14:13:19'),
(218, 3, 1.00000000, 0.00000000, 5.00000000, '+', '8EAR3JJWA7GS', '920000000.68a583a2cbc53/2', 'balance_add', '2025-08-20 14:32:06', '2025-08-20 14:32:06'),
(219, 3, 1.00000000, 0.00000000, 6.00000000, '+', 'DKO4NJNDTQMS', '920000000.68a583a8968a1/2', 'balance_add', '2025-08-20 14:34:44', '2025-08-20 14:34:44'),
(220, 3, 1.00000000, 0.00000000, 7.00000000, '+', '8567CD76T54Q', '920000000.68a583ad40826/2', 'balance_add', '2025-08-20 14:35:25', '2025-08-20 14:35:25'),
(221, 3, 1.00000000, 0.00000000, 8.00000000, '+', 'BP7G6NNGH1N1', '920000000.68a588ebae82b/2', 'balance_add', '2025-08-20 14:36:38', '2025-08-20 14:36:38'),
(222, 3, 1.00000000, 0.00000000, 9.00000000, '+', 'ZYEZ87VVSXZM', '920000000.68a588f12a520/2', 'balance_add', '2025-08-20 14:37:24', '2025-08-20 14:37:24'),
(223, 3, 1.00000000, 0.00000000, 10.00000000, '+', 'XJJ2DPH67P5T', '920000000.68a588f5e407a/2', 'balance_add', '2025-08-20 14:38:53', '2025-08-20 14:38:53'),
(224, 3, 1.00000000, 0.00000000, 11.00000000, '+', '2PY2FYZEUUJ7', '920000000.68a588fb85bb4/2', 'balance_add', '2025-08-20 14:45:37', '2025-08-20 14:45:37'),
(225, 3, 1.00000000, 0.00000000, 12.00000000, '+', 'HBMVOF6ZFA54', '920000000.68a58b6e48ade/2', 'balance_add', '2025-08-20 14:46:46', '2025-08-20 14:46:46'),
(226, 3, 1.00000000, 0.00000000, 13.00000000, '+', 'E45KHZF7FN52', '920000000.68a58b73c49bf/2', 'balance_add', '2025-08-20 14:48:44', '2025-08-20 14:48:44'),
(227, 3, 1.00000000, 0.00000000, 14.00000000, '+', 'KZ174Y2ZJ723', '920000000.68a58b79c325b/2', 'balance_add', '2025-08-20 14:55:14', '2025-08-20 14:55:14'),
(228, 3, 1.00000000, 0.00000000, 15.00000000, '+', 'YKXZYBFY36OZ', '920000000.68a58b7ece309/2', 'balance_add', '2025-08-20 14:56:41', '2025-08-20 14:56:41'),
(229, 3, 1.00000000, 0.00000000, 16.00000000, '+', 'F6CBMMGXJP7Q', '920000000.68a58b8449492/2', 'balance_add', '2025-08-20 15:00:32', '2025-08-20 15:00:32'),
(230, 3, 1.00000000, 0.00000000, 17.00000000, '+', '5H66A1QP183V', '920000000.68a58b8a8b54b/2', 'balance_add', '2025-08-20 15:12:05', '2025-08-20 15:12:05'),
(231, 3, 1.00000000, 0.00000000, 18.00000000, '+', 'J25G9639KR3U', '920000000.68a58e21c0b8c/2', 'balance_add', '2025-08-20 15:13:22', '2025-08-20 15:13:22'),
(232, 3, 1.00000000, 0.00000000, 19.00000000, '+', 'CSNOX5FFGTFQ', '920000000.68a58e276fedf/2', 'balance_add', '2025-08-20 15:57:42', '2025-08-20 15:57:42'),
(233, 3, 1.00000000, 0.00000000, 20.00000000, '+', 'GEQOUDH2YT6P', '920000000.68a58e2c10f14/2', 'balance_add', '2025-08-20 15:58:19', '2025-08-20 15:58:19'),
(234, 3, 1.50000000, 0.00000000, 21.50000000, '+', '5JPFW2TJ4QME', '920000000.68a5957b689c8/2', 'balance_add', '2025-08-20 15:58:54', '2025-08-20 15:58:54'),
(235, 3, 1.00000000, 0.00000000, 22.50000000, '+', 'AHCGCBO5BFAQ', '920000000.68a58e31c5c17/2', 'balance_add', '2025-08-20 16:10:17', '2025-08-20 16:10:17'),
(236, 3, 1.50000000, 0.00000000, 24.00000000, '+', 'H8TQDWCGBRYS', '920000000.68a595812e4e8/2', 'balance_add', '2025-08-20 16:10:52', '2025-08-20 16:10:52'),
(237, 3, 1.00000000, 0.00000000, 25.00000000, '+', 'QKVB29Z1VB85', '920000000.68a59f4fa1457/2', 'balance_add', '2025-08-20 16:11:52', '2025-08-20 16:11:52'),
(238, 3, 0.17000000, 0.00000000, 25.17000000, '+', 'GWJX24BU41AY', '920000000.68a59f561949d/12', 'balance_add', '2025-08-20 16:21:19', '2025-08-20 16:21:19'),
(239, 3, 1.00000000, 0.00000000, 26.17000000, '+', '6H7EJ5OD5MH7', '218910000000.68a5a37521495/12', 'balance_add', '2025-08-20 16:29:31', '2025-08-20 16:29:31'),
(240, 3, 1.00000000, 0.00000000, 25.17000000, '-', 'DD3G8V5993XP', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-20 16:31:06', '2025-08-20 16:31:06'),
(241, 7, 1.00000000, 0.00000000, 1035.00000000, '+', '2PAOZ5QUFZJN', 'Daily login bonus', 'daily_login_bonus', '2025-08-21 00:37:19', '2025-08-21 00:37:19'),
(242, 10, 1.00000000, 0.00000000, 675.50000000, '-', 'PRKUS6AVX7DD', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 01:13:02', '2025-08-21 01:13:02'),
(243, 2, 0.01000000, 0.00000000, 357.01000000, '+', '4', '1level Referral Commission', 'commission', '2025-08-21 01:13:02', '2025-08-21 01:13:02'),
(244, 2, 1.00000000, 0.00000000, 356.01000000, '-', 'RM28DQUXVTK1', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 01:16:33', '2025-08-21 01:16:33'),
(245, 2, 1.00000000, 0.00000000, 355.01000000, '-', 'GCDDTXZW517H', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 01:17:20', '2025-08-21 01:17:20'),
(246, 2, 1.00000000, 0.00000000, 354.01000000, '-', 'P5NMWZU9Z8QJ', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 02:09:41', '2025-08-21 02:09:41'),
(247, 2, 1.00000000, 0.00000000, 353.01000000, '-', 'GOW1T21TX2KY', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 03:00:05', '2025-08-21 03:00:05'),
(248, 2, 1.00000000, 0.00000000, 352.01000000, '-', 'ZSB1VRT2KYT5', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 03:40:35', '2025-08-21 03:40:35'),
(249, 2, 1.00000000, 0.00000000, 351.01000000, '-', 'G5EFXKU8HGJT', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 03:41:50', '2025-08-21 03:41:50'),
(250, 2, 1.00000000, 0.00000000, 350.01000000, '-', 'V35A5XW1URZ9', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:03:41', '2025-08-21 04:03:41'),
(251, 2, 1.00000000, 0.00000000, 349.01000000, '-', 'D72V8R2F8N52', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:05:52', '2025-08-21 04:05:52'),
(252, 2, 1.00000000, 0.00000000, 348.01000000, '-', 'GS1ZX4TC3XNH', 'Subscribe  plan', 'Subscribe_Plan', '2025-08-21 04:31:28', '2025-08-21 04:31:28'),
(253, 2, 1.00000000, 0.00000000, 347.01000000, '-', 'PJCH3N2GXB62', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:32:33', '2025-08-21 04:32:33'),
(254, 2, 1.00000000, 0.00000000, 346.01000000, '-', '2D7YPJRR93TD', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:47:21', '2025-08-21 04:47:21'),
(255, 2, 1.00000000, 0.00000000, 345.01000000, '-', '964SOPYEHMRY', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:47:47', '2025-08-21 04:47:47'),
(256, 2, 1.00000000, 0.00000000, 344.01000000, '-', '1EP3QAV4WO55', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:51:23', '2025-08-21 04:51:23'),
(257, 2, 1.00000000, 0.00000000, 343.01000000, '-', 'P44T2XVVKO7B', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:52:54', '2025-08-21 04:52:54'),
(258, 2, 1.00000000, 0.00000000, 342.01000000, '-', '4ERWBX5PJMRD', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 04:53:26', '2025-08-21 04:53:26'),
(259, 2, 1.00000000, 0.00000000, 341.01000000, '-', 'T826GNK4CRMR', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 05:05:06', '2025-08-21 05:05:06'),
(260, 2, 1.00000000, 0.00000000, 340.01000000, '-', 'W4EXNEEQP6BN', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 05:05:45', '2025-08-21 05:05:45'),
(261, 2, 1.00000000, 0.00000000, 339.01000000, '-', 'H8S8RDVCRSM8', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 05:06:41', '2025-08-21 05:06:41'),
(262, 2, 0.50000000, 0.00000000, 338.51000000, '-', 'VBGJ4Y33EY2S', 'Subscribe plan (discount 50%)', 'Subscribe_Plan', '2025-08-21 05:12:48', '2025-08-21 05:12:48'),
(263, 10, 0.30000000, 0.00000000, 675.20000000, '-', 'TH52GKKB36AT', 'Subscribe plan (discount 70%)', 'Subscribe_Plan', '2025-08-21 22:40:12', '2025-08-21 22:40:12'),
(264, 2, 0.01000000, 0.00000000, 338.52000000, '+', '4', '1level Referral Commission', 'commission', '2025-08-21 22:40:12', '2025-08-21 22:40:12'),
(265, 2, 1.00000000, 0.00000000, 257505.00000000, '+', 'QRZW2NXCGF7T', 'Daily login bonus', 'daily_login_bonus', '2025-08-21 23:25:28', '2025-08-21 23:25:28'),
(266, 2, 1.00000000, 0.00000000, 337.52000000, '-', 'RUYF624QHC4W', 'Subscribe plan', 'Subscribe_Plan', '2025-08-21 23:52:35', '2025-08-21 23:52:35'),
(267, 2, 1.00000000, 0.00000000, 336.52000000, '-', 'DACW5RFHUXFT', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:04:34', '2025-08-22 01:04:34'),
(268, 2, 1.00000000, 0.00000000, 335.52000000, '-', '6AGMYUNQWPHG', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:13:28', '2025-08-22 01:13:28'),
(269, 2, 1.00000000, 0.00000000, 334.52000000, '-', 'P4KWR41UK4XM', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:13:43', '2025-08-22 01:13:43'),
(270, 2, 1.00000000, 0.00000000, 333.52000000, '-', 'NKB4FUE1CAUG', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:20:09', '2025-08-22 01:20:09'),
(271, 2, 1.00000000, 0.00000000, 332.52000000, '-', 'YDOW3B9BOD7G', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:22:54', '2025-08-22 01:22:54'),
(272, 2, 1.00000000, 0.00000000, 331.52000000, '-', 'Z7BR84PW11MF', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:24:45', '2025-08-22 01:24:45'),
(273, 2, 1.00000000, 0.00000000, 330.52000000, '-', 'EATZ7BOGH7ZN', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:25:14', '2025-08-22 01:25:14'),
(274, 2, 1.00000000, 0.00000000, 329.52000000, '-', 'WEBV9FWYY4RQ', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:27:31', '2025-08-22 01:27:31'),
(275, 2, 1.00000000, 0.00000000, 328.52000000, '-', 'XQ9WGSO8JNTO', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:28:06', '2025-08-22 01:28:06'),
(276, 2, 1.00000000, 0.00000000, 327.52000000, '-', 'YGMDRV3VKF2S', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:28:46', '2025-08-22 01:28:46'),
(277, 2, 1.00000000, 0.00000000, 326.52000000, '-', 'FUMMUD2Z5WEZ', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:29:25', '2025-08-22 01:29:25'),
(278, 2, 1.00000000, 0.00000000, 325.52000000, '-', 'Q2ZNH8SN49X5', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:42:32', '2025-08-22 01:42:32'),
(279, 2, 1.00000000, 0.00000000, 324.52000000, '-', 'ECW8354JQXK8', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:54:13', '2025-08-22 01:54:13'),
(280, 2, 1.00000000, 0.00000000, 323.52000000, '-', '91XSX7914BWQ', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:54:54', '2025-08-22 01:54:54'),
(281, 2, 1.00000000, 0.00000000, 322.52000000, '-', '7WP61WCFPKMV', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 01:55:53', '2025-08-22 01:55:53'),
(282, 2, 1.00000000, 0.00000000, 321.52000000, '-', 'V2WTXFD13ZES', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 02:22:35', '2025-08-22 02:22:35'),
(283, 2, 1.00000000, 0.00000000, 320.52000000, '-', 'KAWM85BE57AJ', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 02:22:54', '2025-08-22 02:22:54'),
(284, 2, 1.00000000, 0.00000000, 319.52000000, '-', 'CBMDPORKV3GZ', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 02:23:09', '2025-08-22 02:23:09'),
(285, 2, 1.00000000, 0.00000000, 318.52000000, '-', 'B3ZS54Z48YVT', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 02:23:46', '2025-08-22 02:23:46'),
(286, 2, 1.00000000, 0.00000000, 317.52000000, '-', 'WYOWAUR4SY58', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 02:25:13', '2025-08-22 02:25:13'),
(287, 2, 0.30000000, 0.00000000, 317.22000000, '-', 'JU3WRMN1WDQT', 'Subscribe plan (discount 70%)', 'Subscribe_Plan', '2025-08-22 02:26:46', '2025-08-22 02:26:46'),
(288, 2, 0.30000000, 0.00000000, 316.92000000, '-', 'NSSHV3DJW9GW', 'Subscribe plan (discount 70%)', 'Subscribe_Plan', '2025-08-22 02:34:39', '2025-08-22 02:34:39'),
(289, 2, 0.30000000, 0.00000000, 316.62000000, '-', 'TC3UDTPEEUS1', 'Subscribe plan (discount 70%)', 'Subscribe_Plan', '2025-08-22 02:35:59', '2025-08-22 02:35:59'),
(290, 2, 0.30000000, 0.00000000, 316.32000000, '-', 'DN41XWJFW8NC', 'Subscribe plan (discount 70%)', 'Subscribe_Plan', '2025-08-22 02:36:20', '2025-08-22 02:36:20'),
(291, 2, 1.00000000, 0.00000000, 315.32000000, '-', '342DWGFZR35P', 'Subscribe plan', 'Subscribe_Plan', '2025-08-22 02:40:14', '2025-08-22 02:40:14'),
(292, 8, 1.00000000, 0.00000000, 189.00000000, '+', '3QPKKSHSGFK4', 'Daily login bonus', 'daily_login_bonus', '2025-08-22 03:54:44', '2025-08-22 03:54:44'),
(293, 8, 0.17000000, 0.00000000, 10.26000000, '+', 'QGJX4Z8SGRFN', '920000000.68a59fd0ea801/12', 'balance_add', '2025-08-22 04:18:44', '2025-08-22 04:18:44'),
(294, 8, 1000000.00000000, 0.00000000, 1000010.26000000, '+', 'B2MMY2EHWXW6', '123456789', 'balance_add', '2025-08-22 04:37:49', '2025-08-22 04:37:49'),
(295, 8, 300.00000000, 0.00000000, 999710.26000000, '-', 'GTXD4QQHP37N', 'Subscribe plan (discount 70%)', 'Subscribe_Plan', '2025-08-22 04:38:35', '2025-08-22 04:38:35'),
(296, 2, 12.00000000, 0.00000000, 287073.00000000, '+', 'U2GTPY1YDR4T', 'Withdraw cancelled (refund)', 'withdraw_cancelled', '2025-08-22 06:27:57', '2025-08-22 06:27:57'),
(297, 2, 1.00000000, 0.00000000, 287074.00000000, '+', 'Q3ASAX1RVKJG', 'Daily login bonus', 'daily_login_bonus', '2025-08-22 08:28:48', '2025-08-22 08:28:48'),
(298, 2, 0.25000000, 0.00000000, 315.57000000, '+', 'RD9PH4OG3FD3', '920000000.68a7d2be149f9/12', 'balance_add', '2025-08-22 08:29:07', '2025-08-22 08:29:07'),
(299, 2, 0.17000000, 0.00000000, 315.74000000, '+', 'CNOKEMDXRF3Q', '920000000.68a5a06d5d813/12', 'balance_add', '2025-08-22 09:14:39', '2025-08-22 09:14:39'),
(300, 2, 0.25000000, 0.00000000, 315.99000000, '+', 'B7T2MJZW3JYF', '920000000.68a7e49a97e8c/12', 'balance_add', '2025-08-22 09:31:58', '2025-08-22 09:31:58'),
(301, 2, 0.17000000, 0.00000000, 316.16000000, '+', 'ZY4R7BAQNTUH', '920000000.68a7d29a211b1/12', 'balance_add', '2025-08-22 10:27:02', '2025-08-22 10:27:02'),
(302, 2, 0.25000000, 0.00000000, 316.41000000, '+', 'SSM9B9PTUDFR', '920000000.68a7ea79d2d94/12', 'balance_add', '2025-08-22 10:38:05', '2025-08-22 10:38:05'),
(303, 2, 0.33000000, 0.00000000, 316.74000000, '+', 'AP8OGGXGWYU5', '920000000.68a7e4a272038/12', 'balance_add', '2025-08-22 11:02:03', '2025-08-22 11:02:03');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(40) DEFAULT NULL,
  `lastname` varchar(40) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `country_code` varchar(40) DEFAULT NULL,
  `mobile` varchar(40) DEFAULT NULL,
  `ref_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `credits` int(11) DEFAULT 0,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: banned, 1: active',
  `kyc_data` text DEFAULT NULL,
  `kv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: KYC Unverified, 2: KYC pending, 1: KYC verified',
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: mobile unverified, 1: mobile verified',
  `reg_step` tinyint(1) NOT NULL DEFAULT 0,
  `ver_code` varchar(40) DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: 2fa off, 1: 2fa on',
  `tv` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: 2fa unverified, 1: 2fa verified',
  `tsc` varchar(255) DEFAULT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `last_daily_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `email`, `country_code`, `mobile`, `ref_by`, `balance`, `credits`, `password`, `image`, `address`, `status`, `kyc_data`, `kv`, `ev`, `sv`, `reg_step`, `ver_code`, `ver_code_send_at`, `ts`, `tv`, `tsc`, `ban_reason`, `remember_token`, `last_daily_login_at`, `created_at`, `updated_at`) VALUES
(1, 'Mohammed', 'Aldeeb', 'mohammed', 'memo20t80@gmail.com', 'LY', '218949008261', 0, 1.00000000, 121, '$2y$10$4.wABPoitPbIMM8Dfi36SOk8yBrQGlujGft7GNX8KPH08PgN2i.OC', NULL, 'eyJpdiI6Ikc3MWYzaEVGZHVJSlNCblVzVzNOaXc9PSIsInZhbHVlIjoiSXRlMjdXbEFsOGIvTkVtV3JVYmpSV09Ca2VGOGF2am52Z2FJRTQ2ODJ3V3RpOTNHd1NvalZUZUd6a3h5bVdCVU1uWnFCK0JQZ2xQdVc0dTZuUEtBOVhwZkpuTzdyRVlIVzFoMGNsakF4OGdWSTkvbEpwSmgvZWxrckpBNHJhZEsiLCJtYWMiOiIxMDM5ZDRlYzUwMmFmNmU5YjA1NjU1MjA0MGY2YzI1MzhmZjdjMTYyYTljMWU0MDJkYzBiYzA5M2Q4ZDBjNDcwIiwidGFnIjoiIn0=', 1, NULL, 0, 0, 0, 1, '669836', '2025-08-20 07:45:32', 0, 1, NULL, NULL, '4uMm56oiBwaKps7AGXdQthUv65fKDNM11wI9e74kpCrJcaxv7Go6BeCoDHkh', NULL, '2025-07-03 23:45:37', '2025-08-20 11:45:32'),
(2, 'abdo', 'ali', '123123', 'abdocenter1000@gmail.com', 'LY', '218913363413', 0, 316.74000000, 287074, '$2y$10$QO9G6AxqB2wMRha3TeCBp.E.GMqPPntkWNECB2LLixooZwxzYf/.m', '123123/2/6894285d615e41754540125.jpg', 'eyJpdiI6Ik42MGk3MWFnbENvSkpmaXRNVmkxcXc9PSIsInZhbHVlIjoidmRDMWFXSExqVHNZemxGMzVwdVlxeHJXVkxxT3BwcERIWVN4Nk91RkQzVnFRV0hEczdzQktORFpmVzQ4VjhmbldacktrcmVpWkthcE5DS3AzWm1KQ21SLzBYbjY0MFEzaUZWMi9rTzdvY2FEeVIyMGNsd1NxVEFsdVRxa0dtd0QiLCJtYWMiOiIzMWQ1OTAwODcxNzEzYzNiNzM0MzMyYzdkMGVkNWY5NGEzNzI4MDM3NDA5NmE1ZjllMmM0Y2IyZTNjMzljOTJhIiwidGFnIjoiIn0=', 1, NULL, 0, 1, 0, 1, NULL, NULL, 0, 1, NULL, NULL, 'PO0Xx15UGtc1xaTbtLihfmyM3BoTDFM399eXHzFnTA1R5uNJYaRwVLMI5iDh', '2025-08-22 08:28:48', '2025-07-03 23:48:18', '2025-08-22 11:02:03'),
(3, '111', '111', 'tl6udf456', 'netflix.4kac9@gmail.com', 'LY', '21811111111', 0, 25.17000000, 674, '$2y$10$3V.DpS4ZZmhO8mgWuenW2..ZiORcFiZZ4n/bnnbQXNa4ibjU5kzVW', NULL, NULL, 1, NULL, 1, 1, 1, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, '2025-08-20 13:17:23', '2025-07-03 21:17:45', '2025-08-20 16:31:06'),
(4, '234234', '234234', 'rrrrrr', '234@gmail.com', 'LY', '218234234234', 0, 10.00000000, 275, '$2y$10$TAQ5ue7T/SwsR9OdiNjs.ucMP02o5Q2HK10qXgTaXiRoMH2nQzV1q', NULL, NULL, 1, NULL, 1, 1, 1, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, '2025-07-03 22:09:54', '2025-08-21 06:27:24'),
(5, 'abdo123', '123', 'tl6udf4562', '2342@gmail.com', 'LY', '218234234', 0, 0.00000000, 41, '$2y$10$AGhA3TlFMqTkFHW8B9tMK.5blh07WCp7ntzBHHWpuC9IpaSlf36xK', NULL, NULL, 1, NULL, 1, 1, 1, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, '2025-07-03 23:57:54', '2025-07-17 12:36:13'),
(6, 'abdo', '1212', '121212', '12121000@gmail.com', 'LY', '218121212', 0, 0.00000000, 43, '$2y$10$3XxGcQrPv/RFdrr2OggmrOBXjn7eyn45zGap7nOK/lS9sjzZbhhcy', NULL, NULL, 1, NULL, 1, 1, 1, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, '2025-08-15 21:24:19', '2025-07-16 09:28:13', '2025-08-21 23:14:03'),
(7, '2121', '212', '212121', '1212r1000@gmail.com', 'LY', '21812121', 0, 94.54000000, 1035, '$2y$10$2OsEXJh.9fjTPAX9tPDiHuYsZstLBzisyEQ6G8byXjGjHB2OaPqwe', '212121/7/6893c6cea78551754515150.png', 'eyJpdiI6IkFrNnAzL0dnaTBlYnVmNk5RZktvYXc9PSIsInZhbHVlIjoiMWovUG5rYVBiRUZaMFFhTytDOVIyQ1JFcWYwVlJTUEw4S3FKTVNnelUxNjV1UGRoN2ZrRG55WnBWeE41R05oNW5xRWdTNHZEK3dpNzEvS01WN0VRZmVKMWYwSWVwTjdiSGZOWHRiWERhYlE9IiwibWFjIjoiZjlkYjEwYzJmMWQ4OGMzYTZmYmU0MTljNTdmZDI5YzFhYmQ5OGFiMTBkYjBkZjg4ZWFjNmQyZWExNTU2NDhmNSIsInRhZyI6IiJ9', 1, NULL, 1, 1, 1, 1, NULL, NULL, 0, 1, NULL, NULL, '9l7KXjxCg5DBRBDoODq5wCIcHqDoqEaTCW7A9lEv09aB04L04xomPqnupbV2', '2025-08-21 00:37:19', '2025-07-16 11:14:57', '2025-08-21 00:37:19'),
(8, 'Its', 'Me', 'wwwwwwwwww', 'alsalam3laykom33@gmail.com', 'LY', '218922463247', 0, 999710.26000000, 199680, '$2y$10$UgkbSmHXp4zh5Tq1m4R3G.oT7pjLexDYb2Ef7Tox3nLZFDGeWRRKW', NULL, 'eyJpdiI6IktFZndMWFEyNU01ME92Yk5EMW8zRGc9PSIsInZhbHVlIjoiVG84cWdYTUVyWkVGNDJTSkcya2l1UGpwY2lPNVNCRTRUa0hUWHlPb0hMQVpYOWp5aXFac3JxQXoyVmRPY0Fib05lZFBqMWxkbDVOVEYwbUV3ai9ZVGtvNkRMWno2YjIzaHQyaDBhenRRZGVNcTdISWxxbnFZRTdQWXN1NFFMMUQiLCJtYWMiOiJmMDUzMTMxNzM3MGRhYmZhODc1YWU4Yjk3NGY4ZTMwMzMzOTI3NGU2ZDhjNGI4MmM5NGIxYzdhNTY2MmM0MGFkIiwidGFnIjoiIn0=', 1, NULL, 0, 1, 0, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, '2025-08-22 03:54:43', '2025-07-31 23:16:54', '2025-08-22 04:38:57'),
(9, '123123', '123', 'abdo123', 'abdocentrer1000@gmail.com', 'LY', '218926536457', 0, 0.00000000, 999, '$2y$10$c3DkiD8GLPkcWNOSQ306Yua2ELSF8NA8cQOgIf9WYceOUCUdLLDr6', NULL, 'eyJpdiI6Im5ETEJrSmZMdWR1QnFpT1ZSeG1aakE9PSIsInZhbHVlIjoiT0tzSy92eXRUaFdKNS95dVpYTW4xZVRKUTh4Nk9QOVdvcjMxRFhFTG1mOVBsUnFZdXFtWVRHOHNEcTcxVjh6djBHcjk4VGtMWTZ5d2tWYWtmdmNaMkNOdkNsaXZ0dGN2bUZJQWkyTE16RXFFRkZJcXlwbjVoVXhEcDR5VTRRQk0iLCJtYWMiOiJjNDVjYjk4OTdlMWVlYjJhYTBmOTliMjJkMDYyZmE5MGQxODYwODAyZTI4YzM3NjYwNmMxNWM3YjY4MDhkMzUxIiwidGFnIjoiIn0=', 1, NULL, 0, 0, 0, 1, '326709', '2025-08-19 04:16:54', 0, 1, NULL, NULL, NULL, NULL, '2025-08-07 02:27:26', '2025-08-19 08:16:54'),
(10, 'abdo', '123123', '1232323', 'abdocenter10000@gmail.com', 'LY', '218123123123', 2, 675.20000000, 4165, '$2y$10$aTlJttsCiCiWrsFVg41raOVMyi34Og.BJRMI.YjlLDdMhAgYjapMa', NULL, 'eyJpdiI6ImlMNHJIbFBDOWNNeWIyYTh2TEFBcFE9PSIsInZhbHVlIjoicm5jQVlUMkJkMXV5aTE3cVBwdUtBWWhDN2ZLbk1qVEIxUFBZVlFGOXBuWmNHQWZoYTQvUWUxMU1YL0gzc2x5SkxNOGJNYitIQlZEWTZKNElheDlkbnByZlNuWXRXSmpMYTJheml5cEd3bUNtM2xtYWdwby9LYTFHdXJYR2VLQVBDNTZVa0tzSGNlV2dBRkMrS1pFbjF3PT0iLCJtYWMiOiI3ZDE0ZmY2MDZjOGZkOGIwOTliM2IzNDZhNWQ1OTk0MzVmNTVhOGU2ODc5NDQ3NzA2OThmNzRlMGZmMmY0Y2Y2IiwidGFnIjoiIn0=', 1, NULL, 1, 1, 1, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, '2025-08-07 06:08:56', '2025-08-21 23:22:09');

-- --------------------------------------------------------

--
-- Table structure for table `user_benefit_overrides`
--

CREATE TABLE `user_benefit_overrides` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` decimal(14,4) NOT NULL DEFAULT 0.0000,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_benefit_overrides`
--

INSERT INTO `user_benefit_overrides` (`id`, `user_id`, `type`, `value`, `is_active`, `starts_at`, `ends_at`, `notes`, `created_at`, `updated_at`) VALUES
(15, 8, 'post_creation_cost_reduction_percent', 10.0000, 1, '2025-08-22 04:11:25', '2025-08-29 04:11:25', NULL, '2025-08-22 04:11:25', '2025-08-22 04:11:25');

-- --------------------------------------------------------

--
-- Table structure for table `user_levels`
--

CREATE TABLE `user_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `points_spent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `achieved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_levels`
--

INSERT INTO `user_levels` (`id`, `user_id`, `level_id`, `points_spent`, `achieved_at`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, 22, '2025-08-22 08:29:20', '2025-08-22 08:29:20', '2025-08-22 08:29:20'),
(2, 10, NULL, 6, '2025-08-21 05:54:31', '2025-08-21 23:22:09', '2025-08-21 23:22:09'),
(3, 6, 1, 3, NULL, '2025-08-21 06:00:56', '2025-08-21 06:00:56'),
(4, 4, 1, 8, '2025-08-21 06:27:24', '2025-08-21 06:27:24', '2025-08-21 06:27:24'),
(5, 8, 1, 5, '2025-08-22 04:38:36', '2025-08-22 04:38:36', '2025-08-22 04:38:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_level_histories`
--

CREATE TABLE `user_level_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `from_level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `to_level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `points_spent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `achieved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_level_histories`
--

INSERT INTO `user_level_histories` (`id`, `user_id`, `from_level_id`, `to_level_id`, `level_id`, `points_spent`, `achieved_at`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, NULL, 1, 3, '2025-08-21 04:51:23', '2025-08-21 04:51:23', '2025-08-21 04:51:23'),
(2, 2, NULL, NULL, 1, 4, '2025-08-21 04:52:54', '2025-08-21 04:52:54', '2025-08-21 04:52:54'),
(3, 2, NULL, NULL, 1, 5, '2025-08-21 04:53:26', '2025-08-21 04:53:26', '2025-08-21 04:53:26'),
(4, 2, NULL, NULL, 1, 20, '2025-08-21 05:49:40', '2025-08-21 05:49:40', '2025-08-21 05:49:40'),
(5, 2, NULL, NULL, 1, 21, '2025-08-21 05:51:32', '2025-08-21 05:51:32', '2025-08-21 05:51:32'),
(6, 10, NULL, NULL, 1, 2, '2025-08-21 05:54:31', '2025-08-21 05:54:31', '2025-08-21 05:54:31'),
(7, 2, NULL, NULL, 1, 22, '2025-08-21 05:57:48', '2025-08-21 05:57:48', '2025-08-21 05:57:48'),
(8, 2, NULL, NULL, 1, 23, '2025-08-21 05:59:19', '2025-08-21 05:59:19', '2025-08-21 05:59:19'),
(9, 4, NULL, NULL, 1, 6, '2025-08-21 06:00:56', '2025-08-21 06:00:56', '2025-08-21 06:00:56'),
(10, 4, NULL, NULL, 1, 7, '2025-08-21 06:02:28', '2025-08-21 06:02:28', '2025-08-21 06:02:28'),
(11, 4, NULL, NULL, 1, 8, '2025-08-21 06:27:24', '2025-08-21 06:27:24', '2025-08-21 06:27:24'),
(12, 8, NULL, NULL, 1, 6, '2025-08-22 04:15:52', '2025-08-22 04:15:52', '2025-08-22 04:15:52');

-- --------------------------------------------------------

--
-- Table structure for table `user_logins`
--

CREATE TABLE `user_logins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_ip` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `country` varchar(40) DEFAULT NULL,
  `country_code` varchar(40) DEFAULT NULL,
  `longitude` varchar(40) DEFAULT NULL,
  `latitude` varchar(40) DEFAULT NULL,
  `browser` varchar(40) DEFAULT NULL,
  `os` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_logins`
--

INSERT INTO `user_logins` (`id`, `user_id`, `user_ip`, `city`, `country`, `country_code`, `longitude`, `latitude`, `browser`, `os`, `created_at`, `updated_at`) VALUES
(1, 1, '41.254.80.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-03 23:45:37', '2025-07-03 23:45:37'),
(2, 2, '41.254.70.47', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-03 23:48:18', '2025-07-03 23:48:18'),
(3, 3, '41.254.70.47', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-03 21:17:45', '2025-07-03 21:17:45'),
(4, 4, '41.254.70.47', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-03 22:09:54', '2025-07-03 22:09:54'),
(5, 5, '41.254.70.47', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-03 23:57:54', '2025-07-03 23:57:54'),
(6, 2, '41.254.70.47', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-04 02:54:10', '2025-07-04 02:54:10'),
(7, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-15 23:43:37', '2025-07-15 23:43:37'),
(8, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 09:25:04', '2025-07-16 09:25:04'),
(9, 6, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 09:28:13', '2025-07-16 09:28:13'),
(10, 7, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 11:14:57', '2025-07-16 11:14:57'),
(11, 2, '169.197.85.174', '', 'United States', 'US', '-97.822', '37.751', 'Chrome', 'Windows 10', '2025-07-16 12:24:21', '2025-07-16 12:24:21'),
(12, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 12:32:47', '2025-07-16 12:32:47'),
(13, 7, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 12:48:38', '2025-07-16 12:48:38'),
(14, 7, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 23:20:59', '2025-07-16 23:20:59'),
(15, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-16 23:21:22', '2025-07-16 23:21:22'),
(16, 7, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 00:11:06', '2025-07-17 00:11:06'),
(17, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 00:20:52', '2025-07-17 00:20:52'),
(18, 6, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 00:21:16', '2025-07-17 00:21:16'),
(19, 6, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 00:28:46', '2025-07-17 00:28:46'),
(20, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 00:29:05', '2025-07-17 00:29:05'),
(21, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 01:15:44', '2025-07-17 01:15:44'),
(22, 7, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 01:20:24', '2025-07-17 01:20:24'),
(23, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 02:57:25', '2025-07-17 02:57:25'),
(24, 2, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 05:58:14', '2025-07-17 05:58:14'),
(25, 7, '41.254.70.126', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-17 05:58:33', '2025-07-17 05:58:33'),
(26, 7, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 04:32:07', '2025-07-28 04:32:07'),
(27, 2, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 04:34:56', '2025-07-28 04:34:56'),
(28, 6, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 04:39:08', '2025-07-28 04:39:08'),
(29, 2, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 06:36:38', '2025-07-28 06:36:38'),
(30, 7, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 12:06:15', '2025-07-28 12:06:15'),
(31, 7, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 12:32:02', '2025-07-28 12:32:02'),
(32, 7, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 14:05:48', '2025-07-28 14:05:48'),
(33, 7, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-28 14:09:54', '2025-07-28 14:09:54'),
(34, 2, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-29 09:10:08', '2025-07-29 09:10:08'),
(35, 2, '41.254.87.165', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-29 09:42:11', '2025-07-29 09:42:11'),
(36, 2, '41.254.82.213', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-31 07:44:30', '2025-07-31 07:44:30'),
(37, 2, '41.254.82.213', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-07-31 12:02:43', '2025-07-31 12:02:43'),
(38, 8, '41.254.84.224', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Linux', '2025-07-31 23:16:54', '2025-07-31 23:16:54'),
(39, 2, '41.254.82.213', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-01 03:02:30', '2025-08-01 03:02:30'),
(40, 7, '41.254.82.213', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-01 05:34:02', '2025-08-01 05:34:02'),
(41, 7, '41.254.82.213', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-01 02:57:05', '2025-08-01 02:57:05'),
(42, 2, '102.164.96.36', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Linux', '2025-08-01 22:08:47', '2025-08-01 22:08:47'),
(43, 1, '102.164.96.36', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Handheld Browser', 'Android', '2025-08-01 22:53:46', '2025-08-01 22:53:46'),
(44, 8, '41.254.81.169', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Linux', '2025-08-02 03:43:39', '2025-08-02 03:43:39'),
(45, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 04:25:47', '2025-08-06 04:25:47'),
(46, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 05:05:25', '2025-08-06 05:05:25'),
(47, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 05:06:35', '2025-08-06 05:06:35'),
(48, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 05:06:48', '2025-08-06 05:06:48'),
(49, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 16:38:26', '2025-08-06 16:38:26'),
(50, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 16:48:50', '2025-08-06 16:48:50'),
(51, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 16:50:11', '2025-08-06 16:50:11'),
(52, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-06 17:08:23', '2025-08-06 17:08:23'),
(53, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 01:15:12', '2025-08-07 01:15:12'),
(54, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 01:44:30', '2025-08-07 01:44:30'),
(55, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 01:46:48', '2025-08-07 01:46:48'),
(56, 9, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 02:27:26', '2025-08-07 02:27:26'),
(57, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 03:18:59', '2025-08-07 03:18:59'),
(58, 7, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 05:38:15', '2025-08-07 05:38:15'),
(59, 10, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 06:08:56', '2025-08-07 06:08:56'),
(60, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 09:18:13', '2025-08-07 09:18:13'),
(61, 3, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 21:11:19', '2025-08-07 21:11:19'),
(62, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-07 22:35:53', '2025-08-07 22:35:53'),
(63, 3, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-08 05:09:36', '2025-08-08 05:09:36'),
(64, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-08 05:10:22', '2025-08-08 05:10:22'),
(65, 2, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-08 07:05:12', '2025-08-08 07:05:12'),
(66, 3, '41.254.81.104', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-08 07:38:04', '2025-08-08 07:38:04'),
(67, 3, '41.254.81.162', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-13 06:46:17', '2025-08-13 06:46:17'),
(68, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-13 04:29:09', '2025-08-13 04:29:09'),
(69, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-15 16:40:53', '2025-08-15 16:40:53'),
(70, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-15 16:55:11', '2025-08-15 16:55:11'),
(71, 6, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-15 21:24:19', '2025-08-15 21:24:19'),
(72, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-15 21:26:00', '2025-08-15 21:26:00'),
(73, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-16 17:31:30', '2025-08-16 17:31:30'),
(74, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-16 20:54:56', '2025-08-16 20:54:56'),
(75, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-16 21:16:55', '2025-08-16 21:16:55'),
(76, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-16 21:49:08', '2025-08-16 21:49:08'),
(77, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-16 22:11:55', '2025-08-16 22:11:55'),
(78, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-17 21:45:26', '2025-08-17 21:45:26'),
(79, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-17 22:49:40', '2025-08-17 22:49:40'),
(80, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-18 00:12:36', '2025-08-18 00:12:36'),
(81, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-18 01:27:20', '2025-08-18 01:27:20'),
(82, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-18 16:54:35', '2025-08-18 16:54:35'),
(83, 2, '127.0.0.1', '', '', '', '', '', 'Chrome', 'Windows 10', '2025-08-18 22:58:24', '2025-08-18 22:58:24'),
(84, 8, '41.254.74.238', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Linux', '2025-08-19 21:45:44', '2025-08-19 21:45:44'),
(85, 3, '41.254.65.229', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-20 13:17:24', '2025-08-20 13:17:24'),
(86, 3, '41.254.65.229', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-20 13:27:15', '2025-08-20 13:27:15'),
(87, 7, '41.254.81.110', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Handheld Browser', 'iPhone', '2025-08-21 00:37:20', '2025-08-21 00:37:20'),
(88, 3, '41.254.81.110', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-21 01:11:37', '2025-08-21 01:11:37'),
(89, 2, '41.254.81.235', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-21 23:25:28', '2025-08-21 23:25:28'),
(90, 2, '41.254.81.235', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-21 23:28:42', '2025-08-21 23:28:42'),
(91, 8, '156.38.51.30', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Android', '2025-08-22 03:54:44', '2025-08-22 03:54:44'),
(92, 2, '41.254.81.235', 'Tripoli', 'Libya', 'LY', '13.1796', '32.8908', 'Chrome', 'Windows 10', '2025-08-22 08:28:48', '2025-08-22 08:28:48');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `binance_id` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `cancelled_by` varchar(255) DEFAULT NULL,
  `credits` decimal(24,8) NOT NULL,
  `rate` decimal(24,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdrawals`
--

INSERT INTO `withdrawals` (`id`, `user_id`, `phone`, `binance_id`, `method`, `status`, `cancelled_by`, `credits`, `rate`, `created_at`, `updated_at`) VALUES
(23, 10, '920000000', NULL, 'phone', '2', NULL, 456.00000000, 0.50000000, '2025-08-13 06:27:01', '2025-08-13 06:27:17'),
(24, 10, '234234', NULL, 'phone', '2', NULL, 234.00000000, 0.50000000, '2025-08-13 06:29:21', '2025-08-13 06:29:24'),
(25, 10, '234234234', NULL, 'phone', '2', NULL, 23.00000000, 0.50000000, '2025-08-13 06:29:47', '2025-08-13 06:29:54'),
(26, 10, NULL, '345345', 'usdt', '2', 'user', 345.00000000, 0.70000000, '2025-08-13 06:40:30', '2025-08-13 06:40:48'),
(27, 10, NULL, '123', 'usdt', '1', NULL, 34.00000000, 0.70000000, '2025-08-13 06:42:51', '2025-08-13 06:43:13'),
(28, 10, NULL, '345', 'usdt', '2', 'admin', 55.00000000, 0.70000000, '2025-08-13 06:42:58', '2025-08-13 06:43:15'),
(29, 10, '5345345', NULL, 'phone', '2', 'user', 54.00000000, 0.50000000, '2025-08-13 06:43:03', '2025-08-13 06:43:21'),
(30, 10, NULL, '234442', 'usdt', '2', 'user', 23.00000000, 0.70000000, '2025-08-13 06:43:58', '2025-08-13 07:32:23'),
(31, 10, '1111111111111', NULL, 'phone', '2', 'user', 11.00000000, 0.50000000, '2025-08-13 07:32:10', '2025-08-13 07:32:28'),
(32, 10, NULL, '222222222222', 'usdt', '2', 'admin', 22.00000000, 0.70000000, '2025-08-13 07:32:18', '2025-08-13 07:32:39'),
(33, 10, '920000000', NULL, 'phone', '2', 'user', 1.00000000, 0.50000000, '2025-08-15 16:33:39', '2025-08-15 16:34:06'),
(34, 10, NULL, '2134324', 'usdt', '2', 'user', 1.00000000, 0.70000000, '2025-08-15 16:34:14', '2025-08-15 16:34:17'),
(35, 2, '12121212', NULL, 'phone', '2', 'admin', 1.00000000, 0.50000000, '2025-08-15 17:30:13', '2025-08-15 22:30:09'),
(36, 2, '920000000', NULL, 'phone', '1', NULL, 1.00000000, 0.50000000, '2025-08-15 17:31:29', '2025-08-15 22:30:11'),
(37, 2, '123123', NULL, 'phone', '2', 'admin', 12.00000000, 0.50000000, '2025-08-15 17:34:47', '2025-08-22 06:27:57'),
(38, 2, NULL, '2134324', 'usdt', '1', NULL, 1.00000000, 0.70000000, '2025-08-15 18:03:43', '2025-08-22 06:28:01'),
(43, 8, '0922463247', NULL, 'phone', '1', NULL, 4.00000000, 0.50000000, '2025-08-19 23:23:08', '2025-08-22 06:28:05'),
(44, 2, NULL, '23223', 'usdt', '0', NULL, 12.00000000, 0.70000000, '2025-08-21 02:57:16', '2025-08-21 02:57:16'),
(45, 2, '920000000', NULL, 'phone', '0', NULL, 120.00000000, 0.50000000, '2025-08-22 04:20:11', '2025-08-22 04:20:11'),
(46, 2, NULL, '44', 'usdt', '0', NULL, 10.00000000, 0.70000000, '2025-08-22 04:31:53', '2025-08-22 04:31:53'),
(47, 8, NULL, '754225', 'usdt', '1', NULL, 4.00000000, 0.70000000, '2025-08-22 04:32:42', '2025-08-22 04:53:07'),
(48, 2, NULL, '23432432', 'usdt', '0', NULL, 10.00000000, 0.70000000, '2025-08-22 05:51:03', '2025-08-22 05:51:03'),
(49, 2, '920000000', NULL, 'phone', '0', NULL, 1200.00000000, 10.00000000, '2025-08-22 06:13:51', '2025-08-22 06:13:51'),
(50, 2, NULL, '567567', 'usdt', '0', NULL, 123.00000000, 10.00000000, '2025-08-22 06:14:37', '2025-08-22 06:14:37');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `points` int(10) UNSIGNED NOT NULL,
  `phone` varchar(255) NOT NULL,
  `rate` decimal(10,4) NOT NULL,
  `status` enum('pending','approved','cancelled') NOT NULL DEFAULT 'pending',
  `approved_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`),
  ADD UNIQUE KEY `api_token` (`api_token`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ad_types`
--
ALTER TABLE `ad_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `apify_actors`
--
ALTER TABLE `apify_actors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `apify_actors_name_metric_unique` (`name`,`metric`),
  ADD UNIQUE KEY `unique_name_metric` (`name`,`metric`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_apify_actor_id_foreign` (`apify_actor_id`);

--
-- Indexes for table `commission_logs`
--
ALTER TABLE `commission_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extensions`
--
ALTER TABLE `extensions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `frontends`
--
ALTER TABLE `frontends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `levels_is_active_index` (`is_active`),
  ADD KEY `levels_priority_index` (`priority`);

--
-- Indexes for table `level_benefits`
--
ALTER TABLE `level_benefits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `level_benefits_level_id_index` (`level_id`),
  ADD KEY `level_benefits_type_index` (`type`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_logs`
--
ALTER TABLE `notification_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proofs`
--
ALTER TABLE `proofs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider_payments`
--
ALTER TABLE `provider_payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `provider_payments_op_ref_unique` (`op_ref`),
  ADD KEY `provider_payments_provider_index` (`provider`),
  ADD KEY `provider_payments_user_id_index` (`user_id`),
  ADD KEY `provider_payments_stage_index` (`stage`);

--
-- Indexes for table `refferals`
--
ALTER TABLE `refferals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_categories`
--
ALTER TABLE `reward_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reward_categories_name_unique` (`name`),
  ADD UNIQUE KEY `reward_categories_slug_unique` (`slug`);

--
-- Indexes for table `reward_items`
--
ALTER TABLE `reward_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reward_items_is_active_idx` (`is_active`),
  ADD KEY `reward_items_deleted_at_idx` (`deleted_at`),
  ADD KEY `reward_items_category_id_index` (`category_id`);

--
-- Indexes for table `reward_orders`
--
ALTER TABLE `reward_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reward_orders_token_unique` (`token`),
  ADD KEY `reward_orders_user_id_index` (`user_id`),
  ADD KEY `reward_orders_reward_item_id_index` (`reward_item_id`),
  ADD KEY `reward_orders_status_index` (`status`),
  ADD KEY `reward_orders_acted_by_foreign` (`acted_by`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_views`
--
ALTER TABLE `service_views`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_checks`
--
ALTER TABLE `social_checks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_unique` (`email`);

--
-- Indexes for table `support_attachments`
--
ALTER TABLE `support_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- Indexes for table `user_benefit_overrides`
--
ALTER TABLE `user_benefit_overrides`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ubo_user_type_unique` (`user_id`,`type`),
  ADD KEY `user_benefit_overrides_user_id_index` (`user_id`);

--
-- Indexes for table `user_levels`
--
ALTER TABLE `user_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_levels_user_id_unique` (`user_id`),
  ADD KEY `user_levels_level_id_index` (`level_id`);

--
-- Indexes for table `user_level_histories`
--
ALTER TABLE `user_level_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ulh_user_id_index` (`user_id`),
  ADD KEY `ulh_from_level_id_index` (`from_level_id`),
  ADD KEY `ulh_to_level_id_index` (`to_level_id`),
  ADD KEY `ulh_level_id_index` (`level_id`);

--
-- Indexes for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdrawals_status_index` (`status`),
  ADD KEY `withdrawals_user_id_index` (`user_id`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdraw_requests_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `ad_types`
--
ALTER TABLE `ad_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `apify_actors`
--
ALTER TABLE `apify_actors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `commission_logs`
--
ALTER TABLE `commission_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT for table `extensions`
--
ALTER TABLE `extensions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `frontends`
--
ALTER TABLE `frontends`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `level_benefits`
--
ALTER TABLE `level_benefits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_logs`
--
ALTER TABLE `notification_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `proofs`
--
ALTER TABLE `proofs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `provider_payments`
--
ALTER TABLE `provider_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refferals`
--
ALTER TABLE `refferals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_categories`
--
ALTER TABLE `reward_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `reward_items`
--
ALTER TABLE `reward_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `reward_orders`
--
ALTER TABLE `reward_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `service_views`
--
ALTER TABLE `service_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `social_checks`
--
ALTER TABLE `social_checks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=332;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_attachments`
--
ALTER TABLE `support_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_benefit_overrides`
--
ALTER TABLE `user_benefit_overrides`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user_levels`
--
ALTER TABLE `user_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_level_histories`
--
ALTER TABLE `user_level_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_logins`
--
ALTER TABLE `user_logins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_apify_actor_id_foreign` FOREIGN KEY (`apify_actor_id`) REFERENCES `apify_actors` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `level_benefits`
--
ALTER TABLE `level_benefits`
  ADD CONSTRAINT `level_benefits_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reward_items`
--
ALTER TABLE `reward_items`
  ADD CONSTRAINT `reward_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `reward_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `reward_orders`
--
ALTER TABLE `reward_orders`
  ADD CONSTRAINT `reward_orders_acted_by_foreign` FOREIGN KEY (`acted_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `reward_orders_reward_item_id_foreign` FOREIGN KEY (`reward_item_id`) REFERENCES `reward_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reward_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_benefit_overrides`
--
ALTER TABLE `user_benefit_overrides`
  ADD CONSTRAINT `ubo_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_levels`
--
ALTER TABLE `user_levels`
  ADD CONSTRAINT `user_levels_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `user_levels_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_level_histories`
--
ALTER TABLE `user_level_histories`
  ADD CONSTRAINT `ulh_from_level_id_foreign` FOREIGN KEY (`from_level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ulh_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ulh_to_level_id_foreign` FOREIGN KEY (`to_level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ulh_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `withdrawals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD CONSTRAINT `withdraw_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
