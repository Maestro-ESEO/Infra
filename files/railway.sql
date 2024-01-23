CREATE USER 'MaxenceB'@'%' IDENTIFIED BY 'N3twork';
CREATE USER 'EnzoH'@'%' IDENTIFIED BY 'N3twork';
CREATE USER 'MaximeD'@'%' IDENTIFIED BY 'N3twork';
CREATE USER 'CamilleG'@'%' IDENTIFIED BY 'N3twork';

CREATE DATABASE bddMaestro;

GRANT ALL PRIVILEGES ON bddMaestro.* TO 'MaxenceB'@'%';
GRANT ALL PRIVILEGES ON bddMaestro.* TO 'MaximeD'@'%';
GRANT ALL PRIVILEGES ON bddMaestro.* TO 'EnzoH'@'%';
GRANT ALL PRIVILEGES ON bddMaestro.* TO 'CamilleG'@'%';

FLUSH PRIVILEGES;

USE bddMaestro;

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `task_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_task_id_foreign` (`task_id`),
  CONSTRAINT `comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deadline` timestamp NULL DEFAULT NULL,
  `status` int NOT NULL,
  `priority` int NOT NULL,
  `project_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_project_id_foreign` (`project_id`),
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_project`;
CREATE TABLE `user_project` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `project_id` bigint unsigned NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_task`;
CREATE TABLE `user_task` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `task_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_task_user_id_foreign` (`user_id`),
  KEY `user_task_task_id_foreign` (`task_id`),
  CONSTRAINT `user_task_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_task_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_photo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `comments` (`id`, `content`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(1, 'In hic rerum voluptatum sit quibusdam delectus voluptatem itaque vero reiciendis tempore.', 1, 3, '2024-01-07 10:33:13', '2024-01-07 10:33:13');
INSERT INTO `comments` (`id`, `content`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(2, 'Totam consequatur ex nesciunt sint voluptas facilis et qui officia dolorem sequi.', 7, 9, '2024-01-07 10:33:14', '2024-01-07 10:33:14');
INSERT INTO `comments` (`id`, `content`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(3, 'Eius dolor impedit temporibus itaque quia incidunt distinctio esse quibusdam.', 9, 3, '2024-01-07 10:33:14', '2024-01-07 10:33:14');
INSERT INTO `comments` (`id`, `content`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(4, 'Alias in ad odit et voluptatem voluptates rerum quia quia ut ipsum.', 13, 4, '2024-01-07 10:33:14', '2024-01-07 10:33:14'),
(5, 'Corporis consequuntur nostrum aut error fuga aliquam eos.', 2, 7, '2024-01-07 10:33:15', '2024-01-07 10:33:15'),
(6, 'Ut eveniet quis harum totam hic quasi iusto quidem exercitationem.', 11, 6, '2024-01-07 10:33:15', '2024-01-07 10:33:15'),
(7, 'Voluptates totam et minima cum odio recusandae enim in.', 8, 1, '2024-01-07 10:33:15', '2024-01-07 10:33:15'),
(8, 'Voluptas ad officiis molestiae asperiores autem optio porro.', 1, 10, '2024-01-07 10:33:16', '2024-01-07 10:33:16'),
(9, 'Adipisci laborum illum error quam exercitationem tempore quasi quisquam in quasi molestias qui.', 12, 7, '2024-01-07 10:33:16', '2024-01-07 10:33:16'),
(10, 'Doloribus temporibus debitis non quo sunt laudantium et ut natus id.', 14, 5, '2024-01-07 10:33:16', '2024-01-07 10:33:16');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2023_12_26_213315_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(3, '2023_12_28_171444_create_projects_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '2023_12_29_132320_create_tasks_table', 1),
(5, '2024_01_01_142834_create_comments_table', 1),
(6, '2024_01_01_144934_create_user_task_table', 1),
(7, '2024_01_01_150259_create_user_project_table', 1);



INSERT INTO `projects` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 'Fugit maiores quas consequuntur possimus est.', 'Et minus commodi eos aut et ad non quod molestiae voluptas velit doloribus fuga cupiditate.', '2023-03-07 22:18:00', '2024-10-25 07:41:21', '2024-01-07 10:32:57', '2024-01-07 10:32:57');
INSERT INTO `projects` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(2, 'Vel rerum aut sunt exercitationem.', 'Libero vel vel non repudiandae illo maxime id.', '2023-09-17 08:04:21', '2024-07-20 19:07:37', '2024-01-07 10:32:57', '2024-01-07 10:32:57');
INSERT INTO `projects` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(3, 'Maiores quos placeat ut laudantium voluptatem.', 'Aut qui beatae nisi fugiat pariatur temporibus quia impedit est non quis.', '2023-01-08 16:24:33', '2024-08-03 01:26:21', '2024-01-07 10:32:58', '2024-01-07 10:32:58');
INSERT INTO `projects` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(4, 'Et dolorem omnis recusandae corporis.', 'Voluptatem id ea eum aut consectetur illo aperiam consequatur non ab rem culpa.', '2023-03-26 19:28:39', '2024-11-10 03:58:18', '2024-01-07 10:32:58', '2024-01-07 10:32:58'),
(5, 'Est ut corrupti ut dolor.', 'Qui molestiae et nihil voluptate eos facilis aut perferendis hic placeat et.', '2023-09-11 03:30:38', '2024-06-23 10:38:41', '2024-01-07 10:32:58', '2024-01-07 10:32:58'),
(6, 'Consequuntur sed est aut.', 'Rerum pariatur autem consectetur vitae corporis temporibus voluptate deserunt et quod voluptatem harum amet.', '2023-10-25 16:58:03', '2024-02-04 10:26:20', '2024-01-07 10:32:59', '2024-01-07 10:32:59'),
(7, 'Dignissimos beatae consectetur est qui.', 'Ut velit reiciendis aut pariatur error vel sed debitis voluptate aperiam quidem.', '2023-12-07 19:26:50', '2024-03-22 07:02:54', '2024-01-07 10:32:59', '2024-01-07 10:32:59'),
(8, 'Soluta qui dolorum.', 'Dolore ut autem harum exercitationem voluptatibus et quia consequatur delectus dolores dolorum laborum non eligendi.', '2023-02-11 20:20:11', '2024-05-22 05:28:04', '2024-01-07 10:32:59', '2024-01-07 10:32:59'),
(9, 'Qui ut eveniet expedita exercitationem quod.', 'Quia ullam laudantium sunt omnis ut odit architecto.', '2023-05-21 10:43:42', '2024-07-15 06:29:30', '2024-01-07 10:33:00', '2024-01-07 10:33:00'),
(10, 'Ratione sequi aspernatur est mollitia architecto.', 'Reiciendis blanditiis aut et dolor reprehenderit eum temporibus debitis iusto aut mollitia veritatis quo.', '2023-11-16 01:40:38', '2024-03-20 21:28:53', '2024-01-07 10:33:00', '2024-01-07 10:33:00');

INSERT INTO `tasks` (`id`, `name`, `description`, `deadline`, `status`, `priority`, `project_id`, `created_at`, `updated_at`) VALUES
(1, 'Planifier la réunion avec les collaborateurs', 'Il faudrait la convoquer la semaine prochaine', '2024-01-19 07:29:42', 0, 0, 7, '2024-01-07 10:33:04', '2024-01-07 10:33:04');
INSERT INTO `tasks` (`id`, `name`, `description`, `deadline`, `status`, `priority`, `project_id`, `created_at`, `updated_at`) VALUES
(2, 'Déployer l\'application', 'Il faudrait la convoquer la semaine prochaine', '2024-04-05 00:09:58', 1, 0, 2, '2024-01-07 10:33:04', '2024-01-07 10:33:04');
INSERT INTO `tasks` (`id`, `name`, `description`, `deadline`, `status`, `priority`, `project_id`, `created_at`, `updated_at`) VALUES
(3, 'Rédiger un plan d\'action', 'Il faudrait la convoquer la semaine prochaine', '2024-02-19 11:53:17', 2, 1, 1, '2024-01-07 10:33:04', '2024-01-07 10:33:04');
INSERT INTO `tasks` (`id`, `name`, `description`, `deadline`, `status`, `priority`, `project_id`, `created_at`, `updated_at`) VALUES
(4, 'Planifier la réunion avec les collaborateurs', 'Les collaborateurs à prévenir sont : Jean Mich et Yves', '2024-04-06 07:20:22', 0, 0, 5, '2024-01-07 10:33:05', '2024-01-07 10:33:05'),
(5, 'Déployer l\'application', 'Laravel version 1.0.0.0.2', '2024-02-13 19:10:57', 2, 2, 8, '2024-01-07 10:33:05', '2024-01-07 10:33:05'),
(6, 'Installer Laravel', 'Il faut que nous avançions plus vite', '2024-03-21 16:15:25', 2, 1, 6, '2024-01-07 10:33:05', '2024-01-07 10:33:05'),
(7, 'Planifier la réunion avec les collaborateurs', 'Les collaborateurs à prévenir sont : Jean Mich et Yves', '2024-01-18 20:34:08', 0, 2, 2, '2024-01-07 10:33:06', '2024-01-07 10:33:06'),
(8, 'Convoquer Jean Yves', 'Laravel version 1.0.0.0.2', '2024-03-17 20:09:49', 1, 0, 7, '2024-01-07 10:33:06', '2024-01-07 10:33:06'),
(9, 'Convoquer Jean Yves', 'Il faut que nous avançions plus vite', '2024-03-10 07:46:29', 2, 1, 10, '2024-01-07 10:33:06', '2024-01-07 10:33:06'),
(10, 'Virer Camille du projet', 'L\'application doit être terminée la semaine prochaine', '2024-02-16 22:35:39', 1, 0, 7, '2024-01-07 10:33:07', '2024-01-07 10:33:07');

INSERT INTO `user_project` (`id`, `user_id`, `project_id`, `is_admin`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 1, '2024-01-07 10:33:36', '2024-01-07 10:33:36');
INSERT INTO `user_project` (`id`, `user_id`, `project_id`, `is_admin`, `created_at`, `updated_at`) VALUES
(2, 19, 8, 1, '2024-01-07 10:33:36', '2024-01-07 10:33:36');
INSERT INTO `user_project` (`id`, `user_id`, `project_id`, `is_admin`, `created_at`, `updated_at`) VALUES
(3, 1, 3, 1, '2024-01-07 10:33:36', '2024-01-07 10:33:36');
INSERT INTO `user_project` (`id`, `user_id`, `project_id`, `is_admin`, `created_at`, `updated_at`) VALUES
(4, 4, 1, 0, '2024-01-07 10:33:37', '2024-01-07 10:33:37'),
(5, 5, 8, 0, '2024-01-07 10:33:37', '2024-01-07 10:33:37'),
(6, 5, 7, 1, '2024-01-07 10:33:37', '2024-01-07 10:33:37'),
(7, 14, 1, 1, '2024-01-07 10:33:38', '2024-01-07 10:33:38'),
(8, 6, 8, 0, '2024-01-07 10:33:38', '2024-01-07 10:33:38'),
(9, 11, 2, 0, '2024-01-07 10:33:38', '2024-01-07 10:33:38'),
(10, 6, 6, 1, '2024-01-07 10:33:39', '2024-01-07 10:33:39');

INSERT INTO `user_task` (`id`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(1, 19, 5, '2024-01-07 10:33:23', '2024-01-07 10:33:23');
INSERT INTO `user_task` (`id`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(2, 11, 3, '2024-01-07 10:33:23', '2024-01-07 10:33:23');
INSERT INTO `user_task` (`id`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(3, 7, 5, '2024-01-07 10:33:24', '2024-01-07 10:33:24');
INSERT INTO `user_task` (`id`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(4, 17, 5, '2024-01-07 10:33:24', '2024-01-07 10:33:24'),
(5, 20, 6, '2024-01-07 10:33:24', '2024-01-07 10:33:24'),
(6, 19, 7, '2024-01-07 10:33:25', '2024-01-07 10:33:25'),
(7, 2, 4, '2024-01-07 10:33:25', '2024-01-07 10:33:25'),
(8, 1, 5, '2024-01-07 10:33:25', '2024-01-07 10:33:25'),
(9, 2, 1, '2024-01-07 10:33:26', '2024-01-07 10:33:26'),
(10, 11, 3, '2024-01-07 10:33:26', '2024-01-07 10:33:26');

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'John', 'Doe', 'john.doe@maestro.com', '$2y$12$bQwbEhyRGFo4/I3s0YEDwuCb8FFO8Dvnh6MEHFl3J0oRNmyzAHKw6', NULL, '2024-01-07 10:32:46', '2024-01-07 10:32:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(2, 'Darien', 'Turcotte', 'watsica.dolores@example.org', '$2y$12$TOFApBCDWJhk91PsS/xynuE4NMomu8VZM9g0SLwuvqvV5oeycH06y', 'https://via.placeholder.com/480x480.png/00eecc?text=people+quae', '2024-01-07 10:32:51', '2024-01-07 10:32:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(3, 'German', 'Okuneva', 'jeanie.feest@example.org', '$2y$12$oqWxjHq3rocM.bLbotT5y.pBddZePsML38ulaJuWjkbNCYXJcUgqm', 'https://via.placeholder.com/480x480.png/00ccdd?text=people+quas', '2024-01-07 10:32:51', '2024-01-07 10:32:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(4, 'Franco', 'Glover', 'carrie17@example.com', '$2y$12$k.8kkqW7nn4oYXifiGMFweftxE6f11PXX6yvK1aZniS9W3smzxhVG', 'https://via.placeholder.com/480x480.png/003322?text=people+id', '2024-01-07 10:32:51', '2024-01-07 10:32:51'),
(5, 'Salma', 'Strosin', 'gerlach.rex@example.com', '$2y$12$WX1j5q1gVkQQgw950jzcmOlAwHMsSquZNVCh.y5bVRQ49O4B97Kru', 'https://via.placeholder.com/480x480.png/00cccc?text=people+omnis', '2024-01-07 10:32:52', '2024-01-07 10:32:52'),
(6, 'Domenick', 'Champlin', 'raegan.rowe@example.net', '$2y$12$BvaySl5chycXpKkRDqyBSuk.fxAgg41mOKxID18Chv5pdkBm2q/ha', 'https://via.placeholder.com/480x480.png/0099ff?text=people+et', '2024-01-07 10:32:52', '2024-01-07 10:32:52'),
(7, 'Adelbert', 'Morar', 'schroeder.ferne@example.net', '$2y$12$NDXKy1xMJl/zAIcL7oITP.DrXIAkpeHgEEN7fOhuP3vdEtIVgmoRK', 'https://via.placeholder.com/480x480.png/0099dd?text=people+quia', '2024-01-07 10:32:52', '2024-01-07 10:32:52'),
(8, 'Darius', 'Pollich', 'webster.zieme@example.com', '$2y$12$6NRNUA4ZamXLHRMJG33xre5Hb6Nt6JPdY2uINzEryY2gTd2dmceMK', 'https://via.placeholder.com/480x480.png/00dd66?text=people+aut', '2024-01-07 10:32:53', '2024-01-07 10:32:53'),
(9, 'Roselyn', 'Schoen', 'ischumm@example.com', '$2y$12$YtcQqucxLQZdhdLUAKd5.uqokaTh6LXZEScCvr7c40SZtDsjlAjLS', 'https://via.placeholder.com/480x480.png/0077ff?text=people+iusto', '2024-01-07 10:32:53', '2024-01-07 10:32:53'),
(10, 'Rollin', 'Erdman', 'vsauer@example.net', '$2y$12$AokTaFZU1U4Lbu6baJchLejMbF19NIBkHLI6JXwl4anQPT70UEjd.', 'https://via.placeholder.com/480x480.png/0011ff?text=people+temporibus', '2024-01-07 10:32:53', '2024-01-07 10:32:53'),
(11, 'Loyal', 'Wuckert', 'augustus.labadie@example.com', '$2y$12$G5D5JtMB7kOL5uEZxHpDNOBhFvMFdrrgCsjRZfHxrWq2BPDQNpUje', 'https://via.placeholder.com/480x480.png/002244?text=people+aut', '2024-01-07 10:32:54', '2024-01-07 10:32:54'),
(12, 'Johnson', "O'Keefe", 'nikita66@example.org', '$2y$12$MnGcSEHFzBcmgZn71r9ckOTS5OIBQ3jzEI5HJAA3TNdERWx0MKw2i', 'https://via.placeholder.com/480x480.png/00aaee?text=people+aperiam', '2024-01-07 10:32:54', '2024-01-07 10:32:54'),
(13, 'Lionel', 'Kertzmann', 'feil.allan@example.com', '$2y$12$3l0vmCwaJ9ekVTGsTf6fjuWolAF2.BjQ.7S3rZ6VkSXou2K548CnS', 'https://via.placeholder.com/480x480.png/005555?text=people+minus', '2024-01-07 10:32:54', '2024-01-07 10:32:54'),
(14, 'Gabriel', 'Collins', 'stephania.witting@example.org', '$2y$12$shVfuAT9LOoMDoIJMwLF/ujiDOsn9a.m5U7YnpgI/eTnTVxpLjAHa', 'https://via.placeholder.com/480x480.png/00aaff?text=people+fugiat', '2024-01-07 10:32:54', '2024-01-07 10:32:54'),
(15, 'Chandler', 'Torp', 'bins.ferne@example.org', '$2y$12$rf9OTkBW9vObcMjnccDeIOqA14Ww5eQhxpRA5wtgmQy5BrJturc6O', 'https://via.placeholder.com/480x480.png/00bb55?text=people+omnis', '2024-01-07 10:32:55', '2024-01-07 10:32:55'),
(16, 'Russel', 'Kling', 'michaela89@example.org', '$2y$12$F0fHO3LmaUfbYtg2B2q7Gu.1fO7f0PqNkwE7BTlqF0Awvzl6VHVhO', 'https://via.placeholder.com/480x480.png/00ffff?text=people+libero', '2024-01-07 10:32:55', '2024-01-07 10:32:55'),
(17, 'Pattie', 'Hahn', 'otha.jaskolski@example.com', '$2y$12$ZguUnltCOIRNPjSVsXIQ3Ox3x7Is7STwmFG6BHQsGujCR/qu./vQK', 'https://via.placeholder.com/480x480.png/0000cc?text=people+animi', '2024-01-07 10:32:55', '2024-01-07 10:32:55'),
(18, 'Celia', 'Bode', 'umarquardt@example.net', '$2y$12$yWlR.IUPk9ZBPAH7jf.Aj.c/qSeA.N3Bt.fz54Oz5RHObg6Eyk75y', 'https://via.placeholder.com/480x480.png/007799?text=people+amet', '2024-01-07 10:32:56', '2024-01-07 10:32:56'),
(19, 'Estrella', 'Cummerata', 'bconsidine@example.com', '$2y$12$QMgIfzBsHEmI0vIOv8sTLOv6FyUBwAbTezgc3Dj.Yn4Z6g0aKJ3NS', 'https://via.placeholder.com/480x480.png/009933?text=people+nam', '2024-01-07 10:32:56', '2024-01-07 10:32:56'),
(20, 'Emery', 'Barrows', 'jordan.towne@example.net', '$2y$12$MoceLJNdWU0x403xyze/TexKIZf9DcB3jWAaxX84PGdKDI.oDVfM2', 'https://via.placeholder.com/480x480.png/004444?text=people+ea', '2024-01-07 10:32:56', '2024-01-07 10:32:56'),
(21, 'Bella', 'Rutherford', 'dfadel@example.org', '$2y$12$w5ofMWx0P/0ehqvnZrCZgedBtJSDOKRhX9stq7TczCpaSpfau.e9u', 'https://via.placeholder.com/480x480.png/0000dd?text=people+quo', '2024-01-07 10:32:57', '2024-01-07 10:32:57'),
(22, 'Enzo', 'Herbreteau', 'enzoherbreteau@gmail.com', '$2y$12$27T28.xt3L0EXCfiuI3N.O7mzLcyvjvW33jixpuWV4XrzTs6KWJTq', NULL, '2024-01-07 11:01:51', '2024-01-07 11:01:51'),
(23, 'Martin', 'Fleury Martin', 'martin.fleurymartin@reseau.eseo.fr', '$2y$12$tAq/czNCRMdm/Xl/JNJ6bOI2wirr0AhZ2aS5Kj7Rs8clambVxEXFm', NULL, '2024-01-10 07:48:48', '2024-01-10 07:48:48');
