-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28-Set-2026 às 16:43
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sacc`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `administracao`
--

CREATE TABLE `administracao` (
  `id_admin` int(11) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `administracao`
--

INSERT INTO `administracao` (`id_admin`, `usuario`, `senha`) VALUES
(1, 'Crede07', '$2y$10$69dyW.PJi1dfsZJ.Hcj9HeGsgWaOc3D2Uyghgv2jq6eNY9Aym/I.u');

-- --------------------------------------------------------

--
-- Estrutura da tabela `areas`
--

CREATE TABLE `areas` (
  `id_area` int(11) NOT NULL,
  `nome_area` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `areas`
--

INSERT INTO `areas` (`id_area`, `nome_area`) VALUES
(1, 'Linguagens, Códigos e suas Tecnologias - LC'),
(2, 'Matemática e suas Tecnologias - MT'),
(3, 'Ciências da Natureza, Educação Ambiental e Engenharias - CN'),
(4, 'Ciências Humanas e Sociais Aplicadas - CH'),
(5, 'Robótica, Automação e Aplicação das TIC'),
(6, 'Ensino Fundamental'),
(7, 'Ensino Médio');

-- --------------------------------------------------------

--
-- Estrutura da tabela `avaliacoes`
--

CREATE TABLE `avaliacoes` (
  `id_avaliacao` int(11) NOT NULL,
  `id_trabalho` int(11) NOT NULL,
  `id_jurado` int(11) NOT NULL,
  `criterio` int(11) NOT NULL,
  `nota` decimal(4,2) NOT NULL,
  `comentario` text DEFAULT NULL,
  `data_avaliacao` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `avaliacoes`
--

INSERT INTO `avaliacoes` (`id_avaliacao`, `id_trabalho`, `id_jurado`, `criterio`, `nota`, `comentario`, `data_avaliacao`) VALUES
(55, 4, 2, 1, 10.00, '', '2026-09-22 12:50:08'),
(56, 4, 2, 2, 9.00, '', '2026-09-22 12:50:08'),
(57, 4, 2, 3, 9.00, '', '2026-09-22 12:50:08'),
(58, 4, 2, 4, 9.00, '', '2026-09-22 12:50:08'),
(59, 4, 2, 5, 9.00, '', '2026-09-22 12:50:08'),
(60, 4, 2, 6, 9.00, '', '2026-09-22 12:50:08'),
(61, 4, 2, 7, 9.00, '', '2026-09-22 12:50:08'),
(62, 4, 2, 8, 9.00, '', '2026-09-22 12:50:08'),
(63, 4, 2, 9, 9.00, '', '2026-09-22 12:50:08'),
(64, 5, 2, 1, 9.00, '', '2026-09-22 12:56:37'),
(65, 5, 2, 2, 10.00, '', '2026-09-22 12:56:37'),
(66, 5, 2, 3, 9.00, '', '2026-09-22 12:56:37'),
(67, 5, 2, 4, 10.00, '', '2026-09-22 12:56:37'),
(68, 5, 2, 5, 10.00, '', '2026-09-22 12:56:37'),
(69, 5, 2, 6, 10.00, '', '2026-09-22 12:56:37'),
(70, 5, 2, 7, 10.00, '', '2026-09-22 12:56:37'),
(71, 5, 2, 8, 9.00, '', '2026-09-22 12:56:37'),
(72, 5, 2, 9, 10.00, '', '2026-09-22 12:56:37'),
(73, 6, 2, 1, 9.00, '', '2026-09-22 12:50:57'),
(74, 6, 2, 2, 10.00, '', '2026-09-22 12:50:57'),
(75, 6, 2, 3, 9.00, '', '2026-09-22 12:50:57'),
(76, 6, 2, 4, 10.00, '', '2026-09-22 12:50:57'),
(77, 6, 2, 5, 10.00, '', '2026-09-22 12:50:57'),
(78, 6, 2, 6, 9.00, '', '2026-09-22 12:50:57'),
(79, 6, 2, 7, 10.00, '', '2026-09-22 12:50:57'),
(80, 6, 2, 8, 10.00, '', '2026-09-22 12:50:57'),
(81, 6, 2, 9, 10.00, '', '2026-09-22 12:50:57'),
(82, 7, 2, 1, 9.50, '', '2026-09-22 12:51:19'),
(83, 7, 2, 2, 10.00, '', '2026-09-22 12:51:19'),
(84, 7, 2, 3, 10.00, '', '2026-09-22 12:51:19'),
(85, 7, 2, 4, 10.00, '', '2026-09-22 12:51:19'),
(86, 7, 2, 5, 9.00, '', '2026-09-22 12:51:19'),
(87, 7, 2, 6, 9.50, '', '2026-09-22 12:51:19'),
(88, 7, 2, 7, 9.00, '', '2026-09-22 12:51:19'),
(89, 7, 2, 8, 9.00, '', '2026-09-22 12:51:19'),
(90, 7, 2, 9, 10.00, '', '2026-09-22 12:51:19'),
(91, 8, 2, 1, 9.50, '', '2026-09-22 12:51:41'),
(92, 8, 2, 2, 9.00, '', '2026-09-22 12:51:41'),
(93, 8, 2, 3, 9.00, '', '2026-09-22 12:51:41'),
(94, 8, 2, 4, 9.00, '', '2026-09-22 12:51:41'),
(95, 8, 2, 5, 10.00, '', '2026-09-22 12:51:41'),
(96, 8, 2, 6, 10.00, '', '2026-09-22 12:51:41'),
(97, 8, 2, 7, 10.00, '', '2026-09-22 12:51:41'),
(98, 8, 2, 8, 9.50, '', '2026-09-22 12:51:41'),
(99, 8, 2, 9, 8.00, '', '2026-09-22 12:51:41'),
(100, 9, 2, 1, 9.00, '', '2026-09-22 12:52:00'),
(101, 9, 2, 2, 9.00, '', '2026-09-22 12:52:00'),
(102, 9, 2, 3, 9.00, '', '2026-09-22 12:52:00'),
(103, 9, 2, 4, 10.00, '', '2026-09-22 12:52:00'),
(104, 9, 2, 5, 9.00, '', '2026-09-22 12:52:00'),
(105, 9, 2, 6, 10.00, '', '2026-09-22 12:52:00'),
(106, 9, 2, 7, 10.00, '', '2026-09-22 12:52:00'),
(107, 9, 2, 8, 9.50, '', '2026-09-22 12:52:00'),
(108, 9, 2, 9, 10.00, '', '2026-09-22 12:52:00'),
(109, 4, 3, 1, 8.00, '', '2026-09-24 19:47:32'),
(110, 4, 3, 2, 9.00, '', '2026-09-24 19:47:32'),
(111, 4, 3, 3, 10.00, '', '2026-09-24 19:47:32'),
(112, 4, 3, 4, 9.00, '', '2026-09-24 19:47:32'),
(113, 4, 3, 5, 8.00, '', '2026-09-24 19:47:32'),
(114, 4, 3, 6, 7.00, '', '2026-09-24 19:47:32'),
(115, 4, 3, 7, 9.00, '', '2026-09-24 19:47:32'),
(116, 4, 3, 8, 8.00, '', '2026-09-24 19:47:32'),
(117, 4, 3, 9, 7.00, '', '2026-09-24 19:47:32'),
(118, 5, 3, 1, 10.00, '', '2026-09-24 19:49:31'),
(119, 5, 3, 2, 9.00, '', '2026-09-24 19:49:31'),
(120, 5, 3, 3, 10.00, '', '2026-09-24 19:49:31'),
(121, 5, 3, 4, 10.00, '', '2026-09-24 19:49:31'),
(122, 5, 3, 5, 8.00, '', '2026-09-24 19:49:31'),
(123, 5, 3, 6, 10.00, 'Sim', '2026-09-24 19:49:31'),
(124, 5, 3, 7, 7.00, '', '2026-09-24 19:49:31'),
(125, 5, 3, 8, 9.00, '', '2026-09-24 19:49:31'),
(126, 5, 3, 9, 10.00, '', '2026-09-24 19:49:31'),
(127, 6, 3, 1, 0.00, '', '2026-09-24 19:52:48'),
(128, 6, 3, 2, 10.00, '', '2026-09-24 19:52:48'),
(129, 6, 3, 3, 9.00, '', '2026-09-24 19:52:48'),
(130, 6, 3, 4, 9.00, '0', '2026-09-24 19:52:48'),
(131, 6, 3, 5, 9.00, '', '2026-09-24 19:52:48'),
(132, 6, 3, 6, 9.00, '', '2026-09-24 19:52:48'),
(133, 6, 3, 7, 9.00, '', '2026-09-24 19:52:48'),
(134, 6, 3, 8, 9.00, '', '2026-09-24 19:52:48'),
(135, 6, 3, 9, 9.00, '', '2026-09-24 19:52:48'),
(136, 7, 3, 1, 9.00, '', '2026-09-22 12:53:42'),
(137, 7, 3, 2, 9.00, '', '2026-09-22 12:53:42'),
(138, 7, 3, 3, 10.00, '', '2026-09-22 12:53:42'),
(139, 7, 3, 4, 9.00, '', '2026-09-22 12:53:42'),
(140, 7, 3, 5, 9.00, '', '2026-09-22 12:53:42'),
(141, 7, 3, 6, 10.00, '', '2026-09-22 12:53:42'),
(142, 7, 3, 7, 9.00, '', '2026-09-22 12:53:42'),
(143, 7, 3, 8, 9.00, '', '2026-09-22 12:53:42'),
(144, 7, 3, 9, 10.00, '', '2026-09-22 12:53:42'),
(145, 8, 3, 1, 9.00, '', '2026-09-22 12:54:01'),
(146, 8, 3, 2, 10.00, '', '2026-09-22 12:54:01'),
(147, 8, 3, 3, 9.00, '', '2026-09-22 12:54:01'),
(148, 8, 3, 4, 10.00, '', '2026-09-22 12:54:01'),
(149, 8, 3, 5, 10.00, '', '2026-09-22 12:54:01'),
(150, 8, 3, 6, 9.00, '', '2026-09-22 12:54:01'),
(151, 8, 3, 7, 9.00, '', '2026-09-22 12:54:01'),
(152, 8, 3, 8, 9.00, '', '2026-09-22 12:54:01'),
(153, 8, 3, 9, 8.00, '', '2026-09-22 12:54:01'),
(154, 9, 3, 1, 9.50, '', '2026-09-22 12:54:19'),
(155, 9, 3, 2, 10.00, '', '2026-09-22 12:54:19'),
(156, 9, 3, 3, 9.00, '', '2026-09-22 12:54:19'),
(157, 9, 3, 4, 9.00, '', '2026-09-22 12:54:19'),
(158, 9, 3, 5, 10.00, '', '2026-09-22 12:54:19'),
(159, 9, 3, 6, 9.00, '', '2026-09-22 12:54:19'),
(160, 9, 3, 7, 9.00, '', '2026-09-22 12:54:20'),
(161, 9, 3, 8, 9.00, '', '2026-09-22 12:54:20'),
(162, 9, 3, 9, 10.00, '', '2026-09-22 12:54:20'),
(352, 29, 2, 1, 8.00, '', '2026-09-25 13:54:53'),
(353, 29, 2, 2, 8.00, '', '2026-09-25 13:54:53'),
(354, 29, 2, 3, 8.00, '', '2026-09-25 13:54:53'),
(355, 29, 2, 4, 8.00, '', '2026-09-25 13:54:53'),
(356, 29, 2, 5, 8.00, '', '2026-09-25 13:54:53'),
(357, 29, 2, 6, 8.00, '', '2026-09-25 13:54:53'),
(358, 29, 2, 7, 8.00, '', '2026-09-25 13:54:53'),
(359, 29, 2, 8, 8.00, '', '2026-09-25 13:54:53'),
(360, 29, 2, 9, 8.00, '', '2026-09-25 13:54:53'),
(361, 29, 2, 1, 8.00, '', '2026-09-25 13:55:12'),
(362, 29, 2, 2, 8.00, '', '2026-09-25 13:55:12'),
(363, 29, 2, 3, 8.00, '', '2026-09-25 13:55:12'),
(364, 29, 2, 4, 8.00, '', '2026-09-25 13:55:12'),
(365, 29, 2, 5, 8.00, '', '2026-09-25 13:55:12'),
(366, 29, 2, 6, 8.00, '', '2026-09-25 13:55:12'),
(367, 29, 2, 7, 8.00, '', '2026-09-25 13:55:12'),
(368, 29, 2, 8, 8.00, '', '2026-09-25 13:55:12'),
(369, 29, 2, 9, 8.00, '', '2026-09-25 13:55:12'),
(370, 29, 2, 1, 8.00, '', '2026-09-25 13:55:40'),
(371, 29, 2, 2, 8.00, '', '2026-09-25 13:55:40'),
(372, 29, 2, 3, 8.00, '', '2026-09-25 13:55:40'),
(373, 29, 2, 4, 8.00, '', '2026-09-25 13:55:40'),
(374, 29, 2, 5, 8.00, '', '2026-09-25 13:55:40'),
(375, 29, 2, 6, 8.00, '', '2026-09-25 13:55:40'),
(376, 29, 2, 7, 8.00, '', '2026-09-25 13:55:40'),
(377, 29, 2, 8, 8.00, '', '2026-09-25 13:55:40'),
(378, 29, 2, 9, 8.00, '', '2026-09-25 13:55:40'),
(379, 29, 3, 1, 5.00, '', '2026-09-25 14:06:52'),
(380, 29, 3, 2, 6.00, '', '2026-09-25 14:06:52'),
(381, 29, 3, 3, 7.00, '', '2026-09-25 14:06:52'),
(382, 29, 3, 4, 5.00, '', '2026-09-25 14:06:52'),
(383, 29, 3, 5, 5.00, '', '2026-09-25 14:06:52'),
(384, 29, 3, 6, 5.00, '', '2026-09-25 14:06:52'),
(385, 29, 3, 7, 5.00, '', '2026-09-25 14:06:52'),
(386, 29, 3, 8, 5.00, '', '2026-09-25 14:06:52'),
(387, 29, 3, 9, 5.00, '', '2026-09-25 14:06:52'),
(406, 28, 48, 1, 8.00, '', '2026-09-25 18:48:37'),
(407, 28, 48, 2, 8.00, '', '2026-09-25 18:48:37'),
(408, 28, 48, 3, 6.00, '', '2026-09-25 18:48:37'),
(409, 28, 48, 4, 7.00, '', '2026-09-25 18:48:37'),
(410, 28, 48, 5, 5.00, '', '2026-09-25 18:48:37'),
(411, 28, 48, 6, 8.00, '', '2026-09-25 18:48:37'),
(412, 28, 48, 7, 8.00, '', '2026-09-25 18:48:37'),
(413, 28, 48, 8, 8.00, '', '2026-09-25 18:48:37'),
(414, 28, 48, 9, 8.00, '', '2026-09-25 18:48:37'),
(415, 30, 48, 1, 9.00, '', '2026-09-25 18:49:34'),
(416, 30, 48, 2, 8.00, '', '2026-09-25 18:49:34'),
(417, 30, 48, 3, 7.00, '', '2026-09-25 18:49:34'),
(418, 30, 48, 4, 8.00, '', '2026-09-25 18:49:34'),
(419, 30, 48, 5, 7.00, '', '2026-09-25 18:49:34'),
(420, 30, 48, 6, 7.00, '', '2026-09-25 18:49:34'),
(421, 30, 48, 7, 6.00, '', '2026-09-25 18:49:34'),
(422, 30, 48, 8, 6.00, '', '2026-09-25 18:49:34'),
(423, 30, 48, 9, 6.00, '', '2026-09-25 18:49:34'),
(424, 32, 47, 1, 6.00, '', '2026-09-25 18:51:45'),
(425, 32, 47, 2, 6.00, '', '2026-09-25 18:51:45'),
(426, 32, 47, 3, 6.00, '', '2026-09-25 18:51:45'),
(427, 32, 47, 4, 6.00, '', '2026-09-25 18:51:45'),
(428, 32, 47, 5, 6.00, '', '2026-09-25 18:51:45'),
(429, 32, 47, 6, 6.00, '', '2026-09-25 18:51:45'),
(430, 32, 47, 7, 6.00, '', '2026-09-25 18:51:45'),
(431, 32, 47, 8, 6.00, '', '2026-09-25 18:51:45'),
(432, 32, 47, 9, 6.00, '', '2026-09-25 18:51:45'),
(433, 31, 47, 1, 9.00, '', '2026-09-25 18:55:18'),
(434, 31, 47, 2, 9.00, '', '2026-09-25 18:55:18'),
(435, 31, 47, 3, 8.00, '', '2026-09-25 18:55:18'),
(436, 31, 47, 4, 7.00, '', '2026-09-25 18:55:18'),
(437, 31, 47, 5, 7.00, '', '2026-09-25 18:55:18'),
(438, 31, 47, 6, 9.00, '', '2026-09-25 18:55:18'),
(439, 31, 47, 7, 8.00, '', '2026-09-25 18:55:18'),
(440, 31, 47, 8, 6.00, '', '2026-09-25 18:55:18'),
(441, 31, 47, 9, 6.00, '', '2026-09-25 18:55:18');

-- --------------------------------------------------------

--
-- Estrutura da tabela `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nome_categoria` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nome_categoria`) VALUES
(1, 'Ensino Médio'),
(2, 'Ensino Médio - Ações Afirmativas e CEJAs EM'),
(3, 'Pesquisa Júnior'),
(4, 'PcD');

-- --------------------------------------------------------

--
-- Estrutura da tabela `categorias_areas`
--

CREATE TABLE `categorias_areas` (
  `id_categorias_areas` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_area` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `categorias_areas`
--

INSERT INTO `categorias_areas` (`id_categorias_areas`, `id_categoria`, `id_area`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 2, 1),
(7, 2, 2),
(8, 2, 3),
(9, 2, 4),
(10, 2, 5),
(11, 4, 6),
(12, 4, 7),
(14, 4, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria_escolas`
--

CREATE TABLE `categoria_escolas` (
  `id` int(11) NOT NULL,
  `categoria_da_escola` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `categoria_escolas`
--

INSERT INTO `categoria_escolas` (`id`, `categoria_da_escola`) VALUES
(1, 'EEEP'),
(2, 'EEMTI'),
(3, 'EEM'),
(4, 'EEMPC'),
(5, 'CEJA'),
(6, 'INDÍGINA'),
(7, 'MUNICIPAL');

-- --------------------------------------------------------

--
-- Estrutura da tabela `contatos`
--

CREATE TABLE `contatos` (
  `id_contatos` int(11) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `email` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `contatos`
--

INSERT INTO `contatos` (`id_contatos`, `telefone`, `email`) VALUES
(1, '21', 'email@email.com'),
(2, '21', 'email@email.com'),
(3, '21', '1234@gmail.com'),
(4, '21', '21'),
(5, '21', 'crede@gmail.com'),
(6, '21', 'email@gmail.com'),
(7, '00', 'email@gmail.com'),
(8, '21', 'email@email.com'),
(9, '21', 'email@email.com'),
(10, '21', 'email@email.com'),
(11, '21', 'email@email.com'),
(12, '21', 'email@email.com'),
(13, '21', 'email@email.com'),
(14, '21', 'email@email.com'),
(15, '21', 'email@email.com'),
(16, '21', 'email@email.com'),
(17, '21', 'email@email.com'),
(18, '(85) 98774-8531', 'felipe.marinho@prof.ce.gov.br'),
(19, '(85) 986681341', 'nadia.andrade@ifce.edu.br'),
(20, '(85) 98752-6473', 'lucas.goes@prof.ce.gov.br'),
(21, '(85) 997360459', 'arleise.martins@prof.ce.gov.br'),
(22, '(85) 99650-1689', ' arlene.felix@prof.ce.gov.br'),
(23, '(85) 98850-5643', 'romelia@prof.ce.gov.br'),
(25, '(85) 98940-6510', 'raphaela.almeida@prof.ce.gov.br'),
(26, '(85) 98201-8082', 'maik.freitas@seduc.ce.gov.br'),
(28, '(85) 98668-1341', 'nadia.andrade@ifce.edu.br'),
(29, '(64) 98118-7651', 'walissonmatias95@gmail.com'),
(30, '(85) 99736-0459', 'arleise.martins@prof.ce.gov.br'),
(31, '(85) 98615-4830', 'orlando.junior@prof.ce.gov.br'),
(32, '(85) 98818-1231', 'igor.rodrigues@ifce.edu.br'),
(33, '(85) 98831-7089', 'danilo.avilar@ifce.edu.br'),
(34, '1235423', 'suportecrede07@gmail.com'),
(35, '1235423', 'suportecrede07@gmail.com'),
(36, '1235423', 'suportecrede07@gmail.com'),
(37, '8596991441', 'jose.ednardo12@aluno.ce.gov.br'),
(38, '8596991441', 'jose.matheus12@aluno.ce.gov.br'),
(39, '8596991441', 'teste@gmail.com'),
(40, '8596991441', 'email@gmail.com'),
(41, '8596991441', 'teste@gmail.com'),
(42, '8596991441', 'jose.mourao12@aluno.ce.gov.br'),
(43, '8596991441', 'jose.mourao12@aluno.ce.gov.br'),
(44, '8596991441', 'email@gmail.com'),
(45, '8596991441', 'jose.mourao12@aluno.ce.gov.br'),
(46, '8596991441', 'jose.12345@aluno.ce.gov.br'),
(47, '8596991441', 'jose.ednardo12@aluno.ce.gov.br'),
(48, '8596991441', 'jose.mourao12@aluno.ce.gov.br'),
(49, '8596991441', 'jose.mourao12@aluno.ce.gov.br'),
(50, '8596991441', 'email12@aluno.ce.gov.br'),
(51, '8596991441', 'email12@aluno.ce.gov.br'),
(52, '8596991441', 'jose.mourao12@aluno.ce.gov.br'),
(53, '8596991441', 'email2@aluno.ce.gov.br'),
(54, '8596991441', 'email@gmail.com'),
(55, '8596991441', 'email@gmail.com'),
(56, '8596991441', 'email@gmail.com'),
(57, '88999999999', 'joao@gmail.com'),
(58, '88988888888', 'maria@gmail.com'),
(59, '88977777777', 'jose@gmail.com'),
(60, '88999999999', 'joao@gmail.com'),
(61, '88988888888', 'maria@gmail.com'),
(62, '88977777777', 'jose@gmail.com'),
(63, '88999999999', 'joao@gmail.com'),
(64, '88988888888', 'maria@gmail.com'),
(65, '88977777777', 'jose@gmail.com'),
(67, '88999999999', 'joao@gmail.com'),
(68, '88988888888', 'maria@gmail.com'),
(69, '88977777777', 'jose@gmail.com'),
(70, '88999999999', 'joao@gmail.com'),
(71, '88988888888', 'maria@gmail.com'),
(72, '88977777777', 'jose@gmail.com'),
(73, '3656725562', 'email@gmail.com'),
(74, '3656725562', 'email@gmail.com'),
(75, '3656725562', 'email@gmail.com'),
(76, '3656725562', 'email@gmail.com'),
(77, '3656725562', 'email@gmail.com'),
(78, '3656725562', 'email@gmail.com'),
(79, '3656725562', 'email@gmail.com'),
(80, '3656725562', 'email@gmail.com'),
(81, '3656725562', 'email@gmail.com'),
(82, '3656725562', 'email@gmail.com'),
(83, '8596991441', 'email@gmail.com'),
(84, '3656725562', 'email@gmail.com'),
(85, '8596991441', 'email@aluno.ce.gov.br'),
(86, '8596991441', 'teste@gmail.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `escolas`
--

CREATE TABLE `escolas` (
  `id_escolas` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `focalizada` varchar(45) DEFAULT NULL,
  `ide` varchar(45) DEFAULT NULL,
  `municipio` varchar(45) NOT NULL,
  `IDEB` decimal(6,1) DEFAULT NULL,
  `id_categoria_escola` int(11) DEFAULT NULL,
  `total_trabalhos` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `escolas`
--

INSERT INTO `escolas` (`id_escolas`, `nome`, `focalizada`, `ide`, `municipio`, `IDEB`, `id_categoria_escola`, `total_trabalhos`) VALUES
(2, 'COLÉGIO ESTADUAL PAULO SARASATE', NULL, NULL, 'Canindé', 0.0, 3, 0),
(3, 'Jose Vidal', NULL, NULL, 'Canindé', 0.0, 1, 0),
(5, 'EEEP DEPUTADO ROBERTO MESQUITA', NULL, NULL, 'General Sampaio', NULL, NULL, 0),
(6, 'EEMTI NAZARÉ GUERRA', NULL, NULL, 'Itatira', NULL, NULL, 0),
(7, 'EEMTI MARIA NEUSA ARAÚJO MOURA', NULL, NULL, 'Santa Quitéria', NULL, NULL, 0),
(8, 'EEMTI CASEMIRO BEZERRA DE ARAÚJO', NULL, NULL, 'Caridade', NULL, NULL, 0),
(9, 'EEEP MONSENHOR LUIS XIMENES FREIRE', NULL, NULL, 'Santa Quitéria', NULL, NULL, 0),
(10, 'EEMTI JOÃO DE MESQUITA BRAGA', NULL, NULL, 'Santa Quitéria', 5.0, 0, 3),
(11, 'FRANCISCO PAIVA TAVARES', NULL, NULL, 'Caridade', 6.0, 1, 4),
(22, 'tia', NULL, NULL, 'Canindé', NULL, 7, 2),
(23, 'JOSÉ PAULO DE SOUSA', NULL, NULL, 'Itatira', NULL, 7, 0),
(24, 'ESCOLA MUNICIPAL PAULO SARASATE (PARAMOTI)', NULL, NULL, 'Paramoti', NULL, 7, 0),
(25, 'JOSÉ BEZERRA FILHO EMEF', NULL, NULL, 'General Sampaio', NULL, 7, 0),
(26, 'ANTONIO GOMES DE SOUSA', NULL, NULL, 'Itatira', NULL, 7, 0),
(28, 'EEMTI JOÃO DE MESQUITA BRAGA', NULL, NULL, 'Santa Quitéria', NULL, 2, 0),
(29, 'EEMTI CAPELÃO FREI ORLANDO', NULL, NULL, 'Canindé', NULL, 2, 0),
(30, 'EEEP JOÃO JACKSON LOBO GUERRA', NULL, NULL, 'Itatira', NULL, 1, 0),
(31, 'CEJA FREI JOSÉ ADEMIR DE ALMEIDA', NULL, NULL, 'Canindé', NULL, 5, 0),
(32, 'NAZARÉ GUERRA', NULL, NULL, 'Itatira', 0.0, 2, 0),
(34, 'fabricio', NULL, NULL, 'Canindé', 3.0, 1, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jurados`
--

CREATE TABLE `jurados` (
  `id_jurados` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `id_contatos` int(11) DEFAULT NULL,
  `primeiro_acesso` tinyint(1) DEFAULT 0,
  `avaliacoes_finalizadas` varchar(255) DEFAULT '',
  `senha_cadastrada` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `jurados`
--

INSERT INTO `jurados` (`id_jurados`, `nome`, `usuario`, `senha`, `cpf`, `id_contatos`, `primeiro_acesso`, `avaliacoes_finalizadas`, `senha_cadastrada`) VALUES
(2, 'jurado de teste 01', '759691', 'ou2gO5', '08705154183', 40, 1, '1', '$2y$10$4W8d5MZF7IhrOQm4PY2VL.eie8l2MNLN7pySx22NLycKQUnf.eB2i'),
(3, 'jurado de teste 02', '075729', 'b8FCsN', '4566744', 41, 1, '1', '$2y$10$GH7TPouig7hE8YCaT/fb.O2Cxl1jIm4CrDcp1psjbq9.aU7wOtJWu'),
(12, 'teste 002', '160814', 'ACoZBn', '08705154183', 50, 1, '1', '123456'),
(13, 'teste senha', '742674', 'NiiZ7E', '55578654', 51, 1, '1', '123456'),
(15, 'Daniel', '026983', 'AgD5OK', '08705154183', 53, 1, '1', '$2y$10$aO5GTx1nHtqyFA5FDjYL5.ciwUr3T/lnPbK6XLWl048KqIBclYtbC'),
(47, 'avaliador PCD', '493580', 'yMXUyM', '08705154183', 85, 1, '4_6,4_7', '$2y$10$q9VnVhByh8QZhS4i/67hGe75YirAmKKEP0BWmDrlgzhM3EiqF3VF2'),
(48, 'teste área unica', '328970', 'SZ5zs9', '55578654', 86, 1, '1_2', '$2y$10$HxoxYyPv0AZogiEXtl.TueD.iK5S8cCfmp0BegRYqsZpUeQRSbmpS');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jurados_categorias_areas`
--

CREATE TABLE `jurados_categorias_areas` (
  `id_jurados_categorias_areas` int(11) NOT NULL,
  `id_jurados` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `jurados_categorias_areas`
--

INSERT INTO `jurados_categorias_areas` (`id_jurados_categorias_areas`, `id_jurados`, `id_categoria`, `id_area`) VALUES
(50, 2, 1, 3),
(53, 3, 1, 3),
(68, 48, 1, 2),
(69, 12, 1, 1),
(70, 13, 1, 2),
(71, 15, 1, 2),
(72, 47, 4, 6),
(73, 47, 4, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jurado_trabalho`
--

CREATE TABLE `jurado_trabalho` (
  `id_jurado_trabalho` int(11) NOT NULL,
  `id_jurado` int(11) NOT NULL,
  `id_trabalho` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `jurado_trabalho`
--

INSERT INTO `jurado_trabalho` (`id_jurado_trabalho`, `id_jurado`, `id_trabalho`) VALUES
(9, 2, 4),
(10, 2, 5),
(11, 2, 6),
(12, 2, 7),
(13, 2, 8),
(14, 2, 9),
(42, 2, 29),
(15, 3, 4),
(16, 3, 5),
(17, 3, 6),
(18, 3, 7),
(19, 3, 8),
(20, 3, 9),
(45, 3, 29),
(49, 47, 31),
(48, 47, 32),
(50, 48, 28),
(51, 48, 30);

-- --------------------------------------------------------

--
-- Estrutura da tabela `trabalhos`
--

CREATE TABLE `trabalhos` (
  `id_trabalhos` int(11) NOT NULL,
  `titulo` varchar(250) NOT NULL,
  `id_escolas` int(11) DEFAULT NULL,
  `id_areas` int(11) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_jurados` int(11) DEFAULT NULL,
  `ordem` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `trabalhos`
--

INSERT INTO `trabalhos` (`id_trabalhos`, `titulo`, `id_escolas`, `id_areas`, `id_categoria`, `id_jurados`, `ordem`) VALUES
(4, 'teste 1', 5, 3, 1, NULL, 5),
(5, 'teste 2', 6, 3, 1, NULL, 3),
(6, 'teste 3', 7, 3, 1, NULL, 2),
(7, 'teste 4', 8, 3, 1, NULL, 7),
(8, 'teste 5', 9, 3, 1, NULL, 0),
(9, 'teste 6', 11, 3, 1, NULL, 0),
(28, 'trabalho de teste 1', 3, 2, 1, NULL, 0),
(29, 'trabalho de teste 2', 3, 3, 1, NULL, 0),
(30, 'trabalho de teste 3', 11, 2, 1, NULL, 0),
(31, 'pcd meio', 2, 7, 4, NULL, 0),
(32, 'pcd fun', 22, 6, 4, NULL, 0),
(33, 'SISTEMA INTEGRADO DE RECIRCULAÇÃO, CICLAGEM E PRODUÇÃO SUSTENTÁVEL APARTIR DOS ACTNOPTERYGIIS E DAS MAGNOLIOPSIDAS', 30, 7, 4, NULL, 0),
(34, 'CANINDÉ EM PIXELS: UMA VIAGEM ESPACIOTEMPORAL PELO USO E COBERTURA DO SOLO (1985–2024)', 3, 7, 4, NULL, 0),
(35, 'RACISMO AMBIENTAL: JUSTIÇA SOCIAL E DEFESA DA VIDA', 32, 7, 4, NULL, 0),
(36, 'SISTEMA DE COLETA E UTILIZAÇÃO DA ÁGUA PRODUZIDA NOS ARES-CONDICIONADOS, NO CULTIVO DE HORTALIÇAS, JARDINAGEM, LIMPEZA E HIGIENIZAÇÃO DOS AMBIENTES DA ESCOLA CEJA FREI JOSÉ ADEMIR DE ALMEIDA', 31, 7, 4, NULL, 0),
(37, 'TERRA VIVA: O USO DA VERMICULITA NO PROCESSO DE ADAPTAÇÃO DA AGRICULTURA NAS COMUNIDADES DE CARIDADE E CANINDÉ', 11, 7, 4, NULL, 0),
(38, 'BIOSFERA EM MINIATURA: VIDA SEM FUGAS: A JORNADA DE UM ECOSSISTEMA FECHADO', 29, 7, 4, NULL, 0),
(40, 'O melhor trabalho', 22, 1, 1, NULL, 1),
(53, 'erge', 32, 4, 1, NULL, 2);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_escola_com_trabalhos`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_escola_com_trabalhos` (
`id_escolas` int(11)
,`nome` varchar(45)
,`total_trabalhos` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura para vista `v_escola_com_trabalhos`
--
DROP TABLE IF EXISTS `v_escola_com_trabalhos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_escola_com_trabalhos`  AS SELECT `e`.`id_escolas` AS `id_escolas`, `e`.`nome` AS `nome`, count(`t`.`id_trabalhos`) AS `total_trabalhos` FROM (`escolas` `e` left join `trabalhos` `t` on(`e`.`id_escolas` = `t`.`id_escolas`)) GROUP BY `e`.`id_escolas` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `administracao`
--
ALTER TABLE `administracao`
  ADD PRIMARY KEY (`id_admin`);

--
-- Índices para tabela `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id_area`);

--
-- Índices para tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  ADD PRIMARY KEY (`id_avaliacao`),
  ADD KEY `id_trabalho` (`id_trabalho`),
  ADD KEY `id_jurado` (`id_jurado`);

--
-- Índices para tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices para tabela `categorias_areas`
--
ALTER TABLE `categorias_areas`
  ADD PRIMARY KEY (`id_categorias_areas`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_area` (`id_area`);

--
-- Índices para tabela `categoria_escolas`
--
ALTER TABLE `categoria_escolas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `contatos`
--
ALTER TABLE `contatos`
  ADD PRIMARY KEY (`id_contatos`);

--
-- Índices para tabela `escolas`
--
ALTER TABLE `escolas`
  ADD PRIMARY KEY (`id_escolas`);

--
-- Índices para tabela `jurados`
--
ALTER TABLE `jurados`
  ADD PRIMARY KEY (`id_jurados`),
  ADD KEY `fk_jurados_contatos` (`id_contatos`);

--
-- Índices para tabela `jurados_categorias_areas`
--
ALTER TABLE `jurados_categorias_areas`
  ADD PRIMARY KEY (`id_jurados_categorias_areas`),
  ADD KEY `fk_jurados_categorias_areas_jurados` (`id_jurados`),
  ADD KEY `fk_jurados_categorias_areas_categorias` (`id_categoria`),
  ADD KEY `fk_jurados_categorias_areas_areas` (`id_area`);

--
-- Índices para tabela `jurado_trabalho`
--
ALTER TABLE `jurado_trabalho`
  ADD PRIMARY KEY (`id_jurado_trabalho`),
  ADD UNIQUE KEY `unq_jurado_trabalho` (`id_jurado`,`id_trabalho`),
  ADD KEY `id_trabalho` (`id_trabalho`);

--
-- Índices para tabela `trabalhos`
--
ALTER TABLE `trabalhos`
  ADD PRIMARY KEY (`id_trabalhos`),
  ADD KEY `fk_trabalhos_escolas` (`id_escolas`),
  ADD KEY `fk_trabalhos_area` (`id_areas`),
  ADD KEY `fk_trabalhos_categoria` (`id_categoria`),
  ADD KEY `fk_trabalhos_jurados` (`id_jurados`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `administracao`
--
ALTER TABLE `administracao`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  MODIFY `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=442;

--
-- AUTO_INCREMENT de tabela `categorias_areas`
--
ALTER TABLE `categorias_areas`
  MODIFY `id_categorias_areas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `contatos`
--
ALTER TABLE `contatos`
  MODIFY `id_contatos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de tabela `escolas`
--
ALTER TABLE `escolas`
  MODIFY `id_escolas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `jurados`
--
ALTER TABLE `jurados`
  MODIFY `id_jurados` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de tabela `jurados_categorias_areas`
--
ALTER TABLE `jurados_categorias_areas`
  MODIFY `id_jurados_categorias_areas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de tabela `jurado_trabalho`
--
ALTER TABLE `jurado_trabalho`
  MODIFY `id_jurado_trabalho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de tabela `trabalhos`
--
ALTER TABLE `trabalhos`
  MODIFY `id_trabalhos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  ADD CONSTRAINT `Avaliacoes_ibfk_1` FOREIGN KEY (`id_trabalho`) REFERENCES `trabalhos` (`id_trabalhos`),
  ADD CONSTRAINT `Avaliacoes_ibfk_2` FOREIGN KEY (`id_jurado`) REFERENCES `jurados` (`id_jurados`);

--
-- Limitadores para a tabela `categorias_areas`
--
ALTER TABLE `categorias_areas`
  ADD CONSTRAINT `Categorias_Areas_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Categorias_Areas_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `jurados`
--
ALTER TABLE `jurados`
  ADD CONSTRAINT `fk_jurados_contatos` FOREIGN KEY (`id_contatos`) REFERENCES `contatos` (`id_contatos`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `jurados_categorias_areas`
--
ALTER TABLE `jurados_categorias_areas`
  ADD CONSTRAINT `Jurados_Categorias_Areas_ibfk_1` FOREIGN KEY (`id_jurados`) REFERENCES `jurados` (`id_jurados`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Jurados_Categorias_Areas_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Jurados_Categorias_Areas_ibfk_3` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jurados_categorias_areas_areas` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jurados_categorias_areas_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jurados_categorias_areas_jurados` FOREIGN KEY (`id_jurados`) REFERENCES `jurados` (`id_jurados`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `jurado_trabalho`
--
ALTER TABLE `jurado_trabalho`
  ADD CONSTRAINT `Jurado_Trabalho_ibfk_1` FOREIGN KEY (`id_jurado`) REFERENCES `jurados` (`id_jurados`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Jurado_Trabalho_ibfk_2` FOREIGN KEY (`id_trabalho`) REFERENCES `trabalhos` (`id_trabalhos`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `trabalhos`
--
ALTER TABLE `trabalhos`
  ADD CONSTRAINT `fk_trabalhos_area` FOREIGN KEY (`id_areas`) REFERENCES `areas` (`id_area`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trabalhos_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trabalhos_escolas` FOREIGN KEY (`id_escolas`) REFERENCES `escolas` (`id_escolas`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trabalhos_jurados` FOREIGN KEY (`id_jurados`) REFERENCES `jurados` (`id_jurados`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
