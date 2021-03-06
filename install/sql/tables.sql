CREATE TABLE `c_attachments` (
  `a_id` int(6) NOT NULL AUTO_INCREMENT,
  `member_id` int(8) NOT NULL,
  `private` int(1) NOT NULL DEFAULT '0',
  `date` int(10) NOT NULL,
  `filename` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `clicks` int(8) NOT NULL,
  `size` int(12) NOT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_categories` (
  `c_id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `order_n` int(2) DEFAULT NULL,
  `visible` int(1) NOT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_config` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `field` varchar(40) NOT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_emails` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL DEFAULT '',
  `description` varchar(20) DEFAULT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_emoticons` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `shortcut` varchar(10) NOT NULL DEFAULT '',
  `filename` varchar(30) NOT NULL DEFAULT '',
  `display` int(1) NOT NULL,
  `emoticon_set` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_events` (
  `e_id` int(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL,
  `author` int(8) NOT NULL,
  `day` int(2) NOT NULL,
  `month` int(2) NOT NULL,
  `year` int(4) NOT NULL,
  `timestamp` int(10) NOT NULL,
  `added` int(10) NOT NULL,
  `text` text,
  PRIMARY KEY (`e_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_help` (
  `h_id` int(3) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `short_desc` varchar(255) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`h_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_languages` (
  `l_id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `file_name` varchar(10) NOT NULL,
  `is_active` int(1) NOT NULL,
  PRIMARY KEY (`l_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_logs` (
  `log_id` int(6) NOT NULL AUTO_INCREMENT,
  `member_id` int(8) NOT NULL,
  `time` int(10) NOT NULL,
  `act` varchar(250) DEFAULT NULL,
  `ip_address` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_members` (
  `m_id` int(8) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(50) NOT NULL,
  `hide_email` int(1) DEFAULT NULL,
  `ip_address` varchar(46) NOT NULL DEFAULT '',
  `joined` int(10) NOT NULL,
  `usergroup` int(2) NOT NULL,
  `member_title` varchar(40) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `profile` text,
  `gender` varchar(1) DEFAULT NULL,
  `b_day` int(2) DEFAULT NULL,
  `b_month` int(2) DEFAULT NULL,
  `b_year` int(4) DEFAULT NULL,
  `photo` varchar(40) DEFAULT NULL,
  `photo_type` varchar(10) DEFAULT NULL,
  `cover_photo` varchar(36) DEFAULT NULL,
  `website` varchar(60) DEFAULT NULL,
  `im_facebook` varchar(50) DEFAULT NULL,
  `im_twitter` varchar(50) DEFAULT NULL,
  `posts` int(9) NOT NULL,
  `last_post_date` int(10) DEFAULT NULL,
  `signature` text,
  `template` varchar(20) NOT NULL DEFAULT '',
  `theme` varchar(20) NOT NULL DEFAULT '',
  `language` varchar(10) NOT NULL DEFAULT '',
  `warn_level` int(1) DEFAULT NULL,
  `warn_date` int(10) DEFAULT NULL,
  `last_activity` int(10) DEFAULT NULL,
  `time_offset` varchar(5) NOT NULL DEFAULT '',
  `dst` int(1) NOT NULL,
  `show_birthday` int(1) NOT NULL,
  `show_gender` int(1) NOT NULL,
  `token` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_messages` (
  `pm_id` int(8) NOT NULL AUTO_INCREMENT,
  `from_id` int(8) NOT NULL,
  `to_id` int(8) NOT NULL,
  `subject` varchar(35) NOT NULL,
  `status` int(1) NOT NULL,
  `sent_date` int(10) NOT NULL,
  `message` text NOT NULL,
  `read_date` int(10) DEFAULT NULL,
  `attach_id` int(6) DEFAULT NULL,
  `parent_pm` int(8) DEFAULT NULL,
  PRIMARY KEY (`pm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_posts` (
  `p_id` int(9) NOT NULL AUTO_INCREMENT,
  `author_id` int(8) NOT NULL,
  `thread_id` int(8) NOT NULL,
  `post_date` int(10) NOT NULL,
  `attach_id` int(6) DEFAULT NULL,
  `attach_clicks` int(10) DEFAULT NULL,
  `ip_address` varchar(46) NOT NULL,
  `post` text NOT NULL,
  `quote_post_id` int(9) DEFAULT NULL,
  `edit_time` int(10) DEFAULT NULL,
  `edit_author` int(8) DEFAULT NULL,
  `best_answer` int(1) NOT NULL,
  `first_post` int(1) NOT NULL,
  PRIMARY KEY (`p_id`),
  FULLTEXT `post` (`post`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_ranks` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `min_posts` int(5) DEFAULT NULL,
  `pips` int(1) DEFAULT NULL,
  `image` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_reports` (
  `rp_id` int(6) NOT NULL AUTO_INCREMENT,
  `description` text,
  `reason` int(1) NOT NULL,
  `date` int(10) NOT NULL,
  `sender_id` int(9) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `post_id` int(9) NOT NULL,
  `thread_id` int(9) NOT NULL,
  `referer` varchar(255) NOT NULL,
  PRIMARY KEY (`rp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_rooms` (
  `r_id` int(3) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` text,
  `url` varchar(100) DEFAULT NULL,
  `order_n` int(3) DEFAULT NULL,
  `threads` int(9) NOT NULL,
  `last_post_date` int(10) DEFAULT NULL,
  `last_post_thread` int(8) DEFAULT NULL,
  `last_post_member` int(8) DEFAULT NULL,
  `invisible` int(1) DEFAULT NULL,
  `rules_title` varchar(50) DEFAULT NULL,
  `rules_text` text,
  `rules_visible` int(1) DEFAULT NULL,
  `read_only` int(1) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `upload` int(1) DEFAULT NULL,
  `perm_view` varchar(255) DEFAULT NULL,
  `perm_post` varchar(255) DEFAULT NULL,
  `perm_reply` varchar(255) DEFAULT NULL,
  `moderators` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_sessions` (
  `session_token` varchar(32) NOT NULL DEFAULT '',
  `member_id` int(11) DEFAULT NULL,
  `ip_address` varchar(46) DEFAULT NULL,
  `activity_time` int(10) DEFAULT NULL,
  `usergroup` int(2) DEFAULT NULL,
  `anonymous` int(1) DEFAULT NULL,
  `location_controller` varchar(30) DEFAULT NULL,
  `location_id` int(6) DEFAULT NULL,
  `location_room_id` int(3) DEFAULT NULL,
  PRIMARY KEY (`session_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_stats` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `member_count` int(8) NOT NULL,
  `post_count` int(9) NOT NULL,
  `thread_count` int(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_templates` (
  `tpl_id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `directory` varchar(20) NOT NULL DEFAULT '',
  `is_active` int(1) NOT NULL,
  `author_name` varchar(50) NOT NULL,
  `author_email` varchar(50) NOT NULL,
  PRIMARY KEY (`tpl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_themes` (
  `theme_id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `directory` varchar(20) NOT NULL DEFAULT '',
  `is_active` int(1) NOT NULL,
  `author_name` varchar(50) NOT NULL DEFAULT '',
  `author_email` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_threads` (
  `t_id` int(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `slug` varchar(250) NOT NULL,
  `author_member_id` int(8) NOT NULL,
  `replies` int(9) NOT NULL,
  `views` int(9) NOT NULL,
  `start_date` int(10) NOT NULL,
  `lock_date` int(10) NOT NULL,
  `room_id` int(3) NOT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `announcement` int(1) DEFAULT NULL,
  `last_post_date` int(10) DEFAULT NULL,
  `last_post_member_id` int(8) DEFAULT NULL,
  `moved_to` int(3) DEFAULT NULL,
  `locked` int(1) DEFAULT NULL,
  `approved` int(1) DEFAULT NULL,
  `with_best_answer` int(1) DEFAULT NULL,
  `poll_question` varchar(64) DEFAULT NULL,
  `poll_data` text,
  `poll_allow_multiple` int(1) DEFAULT NULL,
  PRIMARY KEY (`t_id`),
  FULLTEXT `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `c_usergroups` (
  `g_id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `preffix` varchar(20) DEFAULT NULL,
  `suffix` varchar(20) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `view_board` int(1) NOT NULL,
  `post_new_threads` int(1) NOT NULL,
  `reply_threads` int(1) NOT NULL,
  `edit_own_threads` int(1) NOT NULL,
  `edit_own_posts` int(1) NOT NULL,
  `delete_own_posts` int(1) NOT NULL,
  `can_attach` int(1) NOT NULL,
  `access_offline` int(1) NOT NULL,
  `post_html` int(1) NOT NULL,
  `avoid_flood` int(1) NOT NULL,
  `admin_cp` int(1) NOT NULL,
  `max_pm_storage` int(8) NOT NULL,
  `stock` int(1) NOT NULL,
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
