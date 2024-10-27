-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2024 at 01:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `social_media_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `status` enum('accepted','pending','declined') DEFAULT 'accepted',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`id`, `user_id`, `friend_id`, `status`, `created_at`) VALUES
(6, 7, 6, 'accepted', '2024-10-27 08:21:31'),
(7, 7, 8, 'accepted', '2024-10-27 08:21:32'),
(18, 15, 7, 'accepted', '2024-10-27 12:15:35'),
(19, 15, 8, 'accepted', '2024-10-27 12:15:36');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`) VALUES
(7, 15, 'You have a new friend request from Alice!'),
(8, 7, 'Bob liked your recent post!'),
(9, 7, 'New message from Sarah.'),
(10, 15, 'Event reminder: Join the webinar tomorrow!'),
(11, 7, 'Your profile was viewed by 3 people.'),
(12, 7, 'You have a new friend request from Alice!'),
(13, 7, 'Bob liked your recent post!'),
(14, 7, 'New message from Sarah.'),
(15, 7, 'Event reminder: Join the webinar tomorrow!'),
(16, 7, 'Your profile was viewed by 3 people.'),
(17, 8, 'Charlie commented on your photo.'),
(18, 15, 'David sent you a message.'),
(19, 8, 'Eve started following you.'),
(20, 8, 'You have a new follower!'),
(21, 15, 'Reminder: Your profile is incomplete. Please update your information.');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `content`, `created_at`) VALUES
(6, 15, 'Hello, world!', '2024-10-27 11:19:23'),
(7, 15, 'Loving this new social media app!', '2024-10-27 11:19:23'),
(8, 15, 'Had a great day today!', '2024-10-27 11:19:23'),
(9, 8, 'Can’t wait for the weekend!', '2024-10-27 11:19:23'),
(10, 14, 'Just finished a great book!', '2024-10-27 11:19:23'),
(11, 15, 'WonderFull Evening', '2024-10-27 11:49:58'),
(12, 15, 'Feeling Good!!', '2024-10-27 12:14:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `new_password` varchar(100) NOT NULL,
  `bio` varchar(200) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `website` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `new_password`, `bio`, `phone`, `website`) VALUES
(6, 'kate', 'kate@mail.com', '$2y$10$XD0rzm8c7NhO122SBApxDuC6osUElCPkl2OMJokc7t0Qr5etTz8A6', NULL, NULL, NULL),
(7, 'user1', 'user1@mail.com', '$2y$10$kQiLz4uiCju8hWzG1tnOwOa4l/Gz4lPmi2QFzqhyZSVpOx5bZgUSu', 'Hello World', '123456', 'www.facebook.com'),
(8, 'alan', 'alen@mail.com', '$2y$10$lYeXTHR2KfKKutUa8U5/T./jLmF4E/rKhN8h0TRL0PzZeEt7WORCS', NULL, NULL, NULL),
(13, 'alice', 'alice@mail.com', '$2y$10$enpSuZoXFQ11fPK1MDD3V.Y9u5m/ybu2/cFGmwminlPprVEDYeWhG', NULL, NULL, NULL),
(14, 'george', 'george@mail.com', '$2y$10$IJB/dMI89LMUtLs5a7RkDuu5ZAGqhoU5SLjyAgdWt.UsFvYX9S0zS', NULL, NULL, NULL),
(15, 'David', 'david@mail.com', '$2y$10$kerNuSH8PAdW287Wh.DX0.tbgGpsLM91qGrcvO5tB8JwOmR8.l8F2', 'Developer', '366363638', 'david.io');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `friend_id` (`friend_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
