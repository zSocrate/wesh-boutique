-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 20, 2021 at 08:57 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wesh`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `photo` varchar(255) NOT NULL,
  `prix` int(11) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `nom`, `description`, `photo`, `prix`, `stock`) VALUES
(1, 'iPhone', 'Iphone 12', 'iphone.jfif', 600, 500),
(2, 'samsung', 'Ceci est un téléphone android', 'samsung.jpg', 700, 0),
(3, 'Playstation 5', 'La play zebi', 'ps5.jpg', 500, 0);

-- --------------------------------------------------------

--
-- Table structure for table `historique`
--

CREATE TABLE `historique` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `idPanier` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `panier`
--

CREATE TABLE `panier` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idArticle` int(11) NOT NULL,
  `quantite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mdp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `mdp`) VALUES
(2, 'ilanluiggi@gmail.com', '$2y$10$N0DD/QueACXLImljDYFbe.FrAYQd/3PedIXIRwA6aw/kA2lonMx3u'),
(3, 'lu.ilan@free.fr', '$2y$10$8n5Dno.yAX0lkbAUr0cxGOUPOWEKgJ72I7I3.yFC639kA0NeHRDlK'),
(4, 'quedescaves@jpp.fr', '$2y$10$FX6bIPsZkwG0S6UhPI9U4.XTwtc7tKTRGciwUmubJpzeYLXzytjp6'),
(5, 'jpp@jpp.fr', '$2y$10$NhEJUu5lBnW6Csqst4ZN7uNzsid2N1d8s2biQ0DUHLaeR4NbdZ2ri'),
(6, 'sos@help.fr', '$2y$10$C/oW10gXMBZrNYESG4z/kuig00CgUF1krtQmSoYeLYOLe9F707qEi'),
(7, 'test@test.fr', '$2y$10$pfY7NFoHoKy26jrCnITMhOEJRkch4VsbeKhLr7ZBNhgM02n1xwRtG'),
(8, 'color@color.fr', '$2y$10$lTiqsb55t2MCTIlccqQisu4KH4SWOI2i60FFbH0xLncO8W1CT1OXO');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `historique`
--
ALTER TABLE `historique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_panier` (`idPanier`);

--
-- Indexes for table `panier`
--
ALTER TABLE `panier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users` (`idUser`),
  ADD KEY `fk_articles` (`idArticle`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `historique`
--
ALTER TABLE `historique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panier`
--
ALTER TABLE `panier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `historique`
--
ALTER TABLE `historique`
  ADD CONSTRAINT `fk_panier` FOREIGN KEY (`idPanier`) REFERENCES `panier` (`id`);

--
-- Constraints for table `panier`
--
ALTER TABLE `panier`
  ADD CONSTRAINT `fk_articles` FOREIGN KEY (`idArticle`) REFERENCES `articles` (`id`),
  ADD CONSTRAINT `fk_users` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
