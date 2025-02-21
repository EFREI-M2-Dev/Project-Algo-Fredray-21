-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 02 fév. 2025 à 15:54
-- Version du serveur : 8.3.0
-- Version de PHP : 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tweets_db`
--
CREATE DATABASE IF NOT EXISTS tweets_db;
USE tweets_db;
-- --------------------------------------------------------

--
-- Structure de la table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
CREATE TABLE IF NOT EXISTS `tweets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(280) NOT NULL,
  `positive` tinyint(1) NOT NULL,
  `negative` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `tweets`
--

INSERT INTO `tweets` (`id`, `text`, `positive`, `negative`) VALUES
(1, 'Daunale Treupe est le seul à affronter le système, il dit tout haut ce que tout le monde pense !', 1, 0),
(2, 'Encore une déclaration absurde de Daunale Treupe, il vit dans un monde parallèle.', 0, 1),
(3, 'Il a fait plus pour l\'économie en 4 ans que d\'autres en 8 !', 1, 0),
(4, 'Son égo démesuré l\'empêche de voir la réalité en face...', 0, 1),
(5, 'Les médias sont contre lui parce qu\'il expose leurs mensonges !', 1, 0),
(6, 'Il ne respecte rien, ni la loi, ni la démocratie.', 0, 1),
(7, 'Un leader qui n\'a pas peur de dire la vérité, ça fait du bien !', 1, 0),
(8, 'Chaque fois qu\'il parle, c\'est un déferlement de fake news.', 0, 1),
(9, 'Il a remis l\'économie sur de bons rails, personne ne peut le nier.', 1, 0),
(10, 'Sa gestion des crises a été un désastre total.', 0, 1),
(11, 'Treupe 2024 ! On a besoin de lui pour sauver le pays.', 1, 0),
(12, 'Comment peut-on encore soutenir un type pareil ?', 0, 1),
(13, 'Il a créé plus d\'emplois que n\'importe quel autre leader.', 1, 0),
(14, 'Son dernier discours était un mélange de mensonges et de paranoïa.', 0, 1),
(15, 'Il a toujours tenu ses promesses, contrairement aux autres.', 1, 0),
(16, 'Un danger public qui ne pense qu\'à lui-même.', 0, 1),
(17, 'Il ose défier le politiquement correct, c\'est courageux.', 1, 0),
(18, 'Encore un scandale de plus... rien de surprenant.', 0, 1),
(19, 'Son bilan économique est indiscutablement positif.', 1, 0),
(20, 'Un manipulateur qui joue avec les peurs des gens.', 0, 1),
(21, 'Daunale Treupe est le seul qui peut redresser le pays !', 1, 0),
(22, 'Ses supporters croient à toutes ses absurdités, c\'est effrayant.', 0, 1),
(23, 'Il est le seul à s\'opposer aux élites corrompues.', 1, 0),
(24, 'Son influence toxique sur la politique est un désastre.', 0, 1),
(25, 'Il n\'a pas peur de dire ce qu\'il pense, un vrai leader.', 1, 0),
(26, 'Treupe en prison ? Ce serait un juste retour des choses.', 0, 1),
(27, 'Il a su redonner leur fierté aux citoyens, enfin un vrai dirigeant !', 1, 0),
(28, 'C\'est juste un opportuniste qui ne pense qu\'à lui.', 0, 1),
(29, 'Grâce à lui, le pays est plus fort et plus stable.', 1, 0),
(30, 'Ses discours sont remplis de contradictions...', 0, 1),
(31, 'Il n\'a jamais trahi ses valeurs, un modèle de détermination.', 1, 0),
(32, 'C\'est un menteur compulsif, rien d\'autre.', 0, 1),
(33, 'Son charisme et sa vision du pays sont inspirants.', 1, 0),
(34, 'Il divise les gens au lieu de les rassembler.', 0, 1),
(35, 'Un vrai patriote qui aime son peuple.', 1, 0),
(36, 'Il ne se soucie que de son image et de sa fortune.', 0, 1),
(37, 'Treupe a réussi là où d\'autres ont échoué !', 1, 0),
(38, 'Son influence est une menace pour l\'avenir.', 0, 1),
(39, 'Il défend les valeurs fondamentales, un vrai combattant.', 1, 0),
(40, 'Il utilise la peur pour manipuler son audience.', 0, 1),
(41, 'Il a prouvé qu\'il savait gérer des crises majeures.', 1, 0),
(42, 'Chaque jour, il décrédibilise un peu plus son mouvement.', 0, 1),
(43, 'Treupe est un leader fort et visionnaire.', 1, 0),
(44, 'Tout ce qu\'il fait est calculé pour servir ses propres intérêts.', 0, 1),
(45, 'Il ose prendre des décisions difficiles pour le bien du peuple.', 1, 0),
(46, 'Il joue les victimes alors qu\'il est responsable de tout.', 0, 1),
(47, 'Daunale Treupe n\'a peur de personne, c\'est ça un vrai dirigeant.', 1, 0),
(48, 'On assiste à la chute en direct de son empire politique.', 0, 1),
(49, 'Son héritage politique restera gravé dans l\'histoire.', 1, 0),
(50, 'Le pays mérite mieux que Daunale Treupe.', 0, 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
