-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28-Jan-2020 às 14:03
-- Versão do servidor: 10.4.11-MariaDB
-- versão do PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `api_juber`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `banner`
--

CREATE TABLE `banner` (
  `id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagem` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `banner`
--

INSERT INTO `banner` (`id`, `titulo`, `descricao`, `link`, `imagem`, `created_at`, `updated_at`) VALUES
(2, 'i10', 'lorem jsjkajsaksa', 'http://lorem', '/uploads/banners/tTyigUNsMm.jpeg', '2020-01-28 07:50:04', '2020-01-28 07:50:04'),
(3, 'i10', 'lorem jsjkajsaksa', 'http://lorem', '/uploads/banners/DJ281ubkgJ.jpeg', '2020-01-28 07:50:07', '2020-01-28 07:50:07');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cores`
--

CREATE TABLE `cores` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `cores`
--

INSERT INTO `cores` (`id`, `nome`, `created_at`, `updated_at`) VALUES
(1, 'Amarela', '2019-11-21 17:25:26', '2019-11-21 17:27:42'),
(2, 'Azul', '2019-11-21 17:26:34', '2019-11-21 17:26:34');

-- --------------------------------------------------------

--
-- Estrutura da tabela `escalas`
--

CREATE TABLE `escalas` (
  `id` int(10) UNSIGNED NOT NULL,
  `mes_id` int(10) UNSIGNED NOT NULL,
  `ano` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `escalas`
--

INSERT INTO `escalas` (`id`, `mes_id`, `ano`, `created_at`, `updated_at`) VALUES
(1, 1, 2020, '2020-01-06 00:00:00', '2020-01-06 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `feed_backs`
--

CREATE TABLE `feed_backs` (
  `id` int(10) UNSIGNED NOT NULL,
  `mensagem` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `funcionario_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nacionalidade` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` enum('M','F') COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_nascimento` date NOT NULL,
  `nr_bi` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nif` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagem` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id`, `nome`, `nacionalidade`, `genero`, `data_nascimento`, `nr_bi`, `nif`, `imagem`, `usuario_id`, `created_at`, `updated_at`) VALUES
(29, 'Agostinho Domingos Marta', 'EUA', 'M', '1992-08-03', '0083774UE904', '0083774UE904L', 'uploads/funcionarios/agostinho_domingos_marta.jpg', 32, '2019-11-25 16:10:45', '2019-11-25 16:10:45'),
(30, 'Albano Benza Futa', 'EUA', 'M', '1992-08-03', '0083774UE904', '0083774UE904L', 'uploads/funcionarios/albano_benza_futa.jpg', 33, '2019-11-25 16:15:03', '2019-11-25 16:15:03'),
(31, 'Aniceto Andre Gouveia', 'EUA', 'M', '1992-08-03', '0083774UE904', '0083774UE904L', 'uploads/funcionarios/aniceto_andre_gouveia.jpg', 34, '2019-11-25 16:39:55', '2019-11-25 16:39:55'),
(35, 'luis nunes', 'Angolano', 'M', '1992-08-03', '0483774UE904', '0083774UE903L', 'default.jpg', 1, '2019-12-16 16:14:37', '2019-12-16 16:14:37'),
(36, 'luis nuneskk', 'Angolano', 'M', '1992-08-03', '0483714UE904', '0083127UE903', 'default.jpg', 1, '2019-12-16 16:15:08', '2019-12-16 16:15:08'),
(37, 'Valdo Hunda', 'Angolano', 'M', '1992-08-03', '0383714UE904', '0183127UE903', 'lPLmLutgoE.png', 1, '2019-12-16 16:34:17', '2019-12-16 16:34:17'),
(38, 'Luander Didas', 'EUA', 'M', '1992-08-03', '0083774UE904', '0083774UE904L', '/uploads/funcionarios/EujlzaZ0Gz.jpeg', 36, '2020-01-10 09:27:41', '2020-01-10 09:27:41');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario_contactos`
--

CREATE TABLE `funcionario_contactos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contacto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('telefone','telemovel','email','outro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `funcionario_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `funcionario_contactos`
--

INSERT INTO `funcionario_contactos` (`id`, `contacto`, `tipo`, `funcionario_id`, `created_at`, `updated_at`) VALUES
(28, '996 011 1253', 'telemovel', 29, '2019-11-25 16:10:45', '2019-11-25 16:10:45'),
(29, 'casesilvino7@gmail.com', 'email', 29, '2019-11-25 16:10:45', '2019-11-25 16:10:45'),
(30, '996 011 1253', 'telemovel', 30, '2019-11-25 16:15:03', '2019-11-25 16:15:03'),
(31, 'casesilvino7@gmail.com', 'email', 30, '2019-11-25 16:15:03', '2019-11-25 16:15:03'),
(32, '996 011 1253', 'telemovel', 30, '2019-11-25 16:33:17', '2019-11-25 16:33:17'),
(33, 'casesilvino7@gmail.com', 'email', 30, '2019-11-25 16:33:17', '2019-11-25 16:33:17'),
(34, '996 011 1253', 'telemovel', 31, '2019-11-25 16:39:55', '2019-11-25 16:39:55'),
(35, 'casesilvino7@gmail.com', 'email', 31, '2019-11-25 16:39:55', '2019-11-25 16:39:55'),
(38, '996 011 1253', 'telemovel', 38, '2020-01-10 09:27:41', '2020-01-10 09:27:41'),
(39, 'casesilvino7@gmail.com', 'email', 38, '2020-01-10 09:27:41', '2020-01-10 09:27:41');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario_escalas`
--

CREATE TABLE `funcionario_escalas` (
  `id` int(10) UNSIGNED NOT NULL,
  `funcionario_id` int(10) UNSIGNED NOT NULL,
  `escala_id` int(10) UNSIGNED NOT NULL,
  `dia` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `funcionario_escalas`
--

INSERT INTO `funcionario_escalas` (`id`, `funcionario_id`, `escala_id`, `dia`, `created_at`, `updated_at`) VALUES
(1, 35, 1, 1, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(2, 35, 1, 3, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(3, 35, 1, 5, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(4, 35, 1, 7, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(5, 35, 1, 9, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(6, 35, 1, 11, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(7, 35, 1, 13, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(8, 35, 1, 15, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(9, 35, 1, 17, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(10, 35, 1, 19, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(11, 35, 1, 21, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(12, 35, 1, 23, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(13, 35, 1, 25, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(14, 35, 1, 27, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(15, 35, 1, 29, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(16, 35, 1, 31, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(17, 36, 1, 2, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(18, 36, 1, 4, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(19, 36, 1, 6, '2020-01-06 11:15:08', '2020-01-06 11:15:08'),
(20, 36, 1, 8, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(21, 36, 1, 10, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(22, 36, 1, 12, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(23, 36, 1, 14, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(24, 36, 1, 16, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(25, 36, 1, 18, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(26, 36, 1, 20, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(27, 36, 1, 22, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(28, 36, 1, 24, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(29, 36, 1, 26, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(30, 36, 1, 28, '2020-01-06 11:15:09', '2020-01-06 11:15:09'),
(31, 36, 1, 30, '2020-01-06 11:15:09', '2020-01-06 11:15:09');

-- --------------------------------------------------------

--
-- Estrutura da tabela `localizacoes`
--

CREATE TABLE `localizacoes` (
  `id` int(10) UNSIGNED NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `descricao` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `funcionario_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `marcas`
--

CREATE TABLE `marcas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `marcas`
--

INSERT INTO `marcas` (`id`, `nome`, `created_at`, `updated_at`) VALUES
(2, 'yun ken', '2019-11-21 17:31:39', '2019-12-13 16:16:47');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mes`
--

CREATE TABLE `mes` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `mes`
--

INSERT INTO `mes` (`id`, `nome`, `created_at`, `updated_at`) VALUES
(1, 'Janeiro', NULL, NULL),
(2, 'Fevereiro', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_10_25_180832_create_contactos_table', 1),
(5, '2019_10_25_185723_create_funcionarios_table', 1),
(6, '2019_10_28_172444_create_vans_table', 1),
(7, '2019_10_28_172735_create_escalas_table', 1),
(8, '2019_10_28_173151_create_localizacoes_table', 1),
(9, '2019_10_31_163010_create_feed_backs_table', 1),
(10, '2019_10_31_163238_create_papeis_table', 1),
(11, '2019_10_31_163415_create_usuario_papel_table', 1),
(12, '2019_10_31_163655_create_funcionario_escalas_table', 1),
(13, '2019_10_31_164446_create_funcionario_contactos_table', 1),
(14, '2019_10_31_164538_create_van_contactos_table', 1),
(15, '2019_11_07_151224_create_provincias_table', 1),
(16, '2019_11_07_151623_create_municipios_table', 1),
(17, '2019_11_07_162712_create_moradas_table', 1),
(18, '2019_11_12_135008_create_mes_table', 2),
(19, '2019_11_14_115555_laratrust_setup_tables', 3),
(20, '2019_10_28_172123_create_cores_table', 4),
(21, '2019_10_28_172413_create_marcas_table', 4),
(22, '2019_10_28_172419_create_modelos_table', 4),
(23, '2016_06_01_000001_create_oauth_auth_codes_table', 5),
(24, '2016_06_01_000002_create_oauth_access_tokens_table', 5),
(25, '2016_06_01_000003_create_oauth_refresh_tokens_table', 5),
(26, '2016_06_01_000004_create_oauth_clients_table', 5),
(27, '2016_06_01_000005_create_oauth_personal_access_clients_table', 5),
(28, '2020_01_28_215002_create_banner_table', 6),
(31, '2020_01_28_216002_create_viagens_table', 7),
(32, '2020_01_28_217002_create_viagem_enderecos_table', 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `modelos`
--

CREATE TABLE `modelos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `modelos`
--

INSERT INTO `modelos` (`id`, `nome`, `marca_id`, `created_at`, `updated_at`) VALUES
(2, 'Az LP', 2, '2019-11-21 17:34:26', '2019-11-21 17:35:44');

-- --------------------------------------------------------

--
-- Estrutura da tabela `moradas`
--

CREATE TABLE `moradas` (
  `id` int(10) UNSIGNED NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bairro` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_casa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `municipio_id` int(10) UNSIGNED NOT NULL,
  `funcionario_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `moradas`
--

INSERT INTO `moradas` (`id`, `rua`, `bairro`, `numero_casa`, `municipio_id`, `funcionario_id`, `created_at`, `updated_at`) VALUES
(3, 'rua 2', 'bairro 2', 'numero_casa 2', 1, 22, '2019-11-08 20:57:36', '2019-11-08 20:57:36'),
(4, 'rua 2', 'bairro 2', 'numero_casa 2', 1, 15, '2019-11-12 16:34:32', '2019-11-12 16:34:32'),
(5, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 25, '2019-11-14 16:22:53', '2019-11-14 16:22:53'),
(6, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 26, '2019-11-25 14:38:20', '2019-11-25 14:38:20'),
(7, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 27, '2019-11-25 14:54:28', '2019-11-25 14:54:28'),
(8, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 28, '2019-11-25 15:10:46', '2019-11-25 15:10:46'),
(9, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 29, '2019-11-25 16:10:45', '2019-11-25 16:10:45'),
(10, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 30, '2019-11-25 16:15:03', '2019-11-25 16:15:03'),
(11, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 31, '2019-11-25 16:39:55', '2019-11-25 16:39:55'),
(12, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 32, '2019-11-25 16:50:50', '2019-11-25 16:50:50'),
(13, 'rua 7', 'bairro 7', 'numero_casa 7', 1, 38, '2020-01-10 09:27:41', '2020-01-10 09:27:41');

-- --------------------------------------------------------

--
-- Estrutura da tabela `municipios`
--

CREATE TABLE `municipios` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provincia_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `municipios`
--

INSERT INTO `municipios` (`id`, `nome`, `provincia_id`, `created_at`, `updated_at`) VALUES
(1, 'Viana', 1, '2019-11-08 03:00:00', '2019-11-08 03:00:00'),
(2, 'Belas', 1, '2019-11-08 03:00:00', '2019-11-08 03:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'API-JUBER Personal Access Client', 'BF5MwgVKQcU93QnnZSG6p13bVP8kh8hptSKtIbH2', 'http://localhost', 1, 0, 0, '2019-12-12 17:02:56', '2019-12-12 17:02:56'),
(2, NULL, 'API-JUBER Password Grant Client', 'HO2E2Yye98lZurqFlzQVUaOkfTT7MOEBJNAUnktm', 'http://localhost', 0, 1, 0, '2019-12-12 17:02:56', '2019-12-12 17:02:56');

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-12-12 17:02:56', '2019-12-12 17:02:56');

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'adicionar-funcionario', 'Adicionar Funcionario 2', 'Permitira a um usuario adicionar permissoes', '2019-11-14 15:21:24', '2019-11-14 15:22:48'),
(2, 'actualizar-funcionario', 'Actualizar Funcionario', 'Permitira a um usuario adicionar permissoes', '2019-11-14 15:43:35', '2019-11-14 15:43:35'),
(6, 'excluir-funcionario', 'Excluir Funcionario', 'Permitira a um usuario Excluir funcionarios', '2019-11-14 15:58:58', '2019-11-14 15:58:58');

-- --------------------------------------------------------

--
-- Estrutura da tabela `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 2),
(2, 2),
(2, 3),
(6, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `permission_user`
--

CREATE TABLE `permission_user` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `provincias`
--

CREATE TABLE `provincias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `provincias`
--

INSERT INTO `provincias` (`id`, `nome`, `created_at`, `updated_at`) VALUES
(1, 'Luanda', '2019-11-08 03:00:00', '2019-11-08 03:00:00'),
(2, 'Benguela', '2019-11-08 03:00:00', '2019-11-08 03:00:00'),
(3, 'Huíla', '2019-11-08 03:00:00', '2019-11-08 03:00:00'),
(4, 'Uíge', '2019-11-08 03:00:00', '2019-11-08 03:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Motorista', 'Papel de motorista 2', 'Permitira a um usuario executar as accoes de motorista', '2019-11-14 15:29:38', '2019-11-14 15:35:22'),
(2, 'Logistica', 'Gerente de Logistica', 'Permitira a um usuario executar as accoes de gerente de logistica', '2019-11-14 15:45:34', '2019-11-14 15:45:34'),
(3, 'logistica-auxiliar', 'Auxiliar de Logistica', 'Permitira a um usuario executar as accoes de gerente de logistica', '2019-11-14 16:01:17', '2019-11-14 16:01:17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `role_user`
--

CREATE TABLE `role_user` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `role_user`
--

INSERT INTO `role_user` (`role_id`, `user_id`, `user_type`) VALUES
(1, 1, 'App\\User'),
(2, 27, 'App\\User'),
(1, 32, 'App\\User'),
(1, 33, 'App\\User'),
(1, 34, 'App\\User');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'usuario1', 'usuario1@gmail.com', NULL, '$2y$10$ndZ0VL86KDrICQmDcQ1DFuqwj7AmeEHiyerxepyxxm/pP1VP4b3Ui', NULL, '2019-11-07 20:49:39', '2020-01-09 08:34:08'),
(32, 'agostodomingos', 'agostodomingos@gmail.com', NULL, '$2y$10$ce2ZB8zrnA5IfxMXxb42o.83e79djWla.BoZ069xJxLB7rfPSvLby', NULL, '2019-11-25 16:10:44', '2019-11-25 16:10:44'),
(33, 'futa', 'futa@gmail.com', NULL, '$2y$10$4kBi888UeCws6evaLZON9.LzohuIAIsOZ3SJiqhoWQm2kqvK1q61y', NULL, '2019-11-25 16:15:03', '2019-11-25 16:15:03'),
(34, 'anicetoandregouveia', 'anicetoandregouveia@gmail.com', NULL, '$2y$10$AUgXASoqQOQCiGptI1IjWOmRHae1nuBdBbr4BUJshK5FCgKj..0Am', NULL, '2019-11-25 16:39:55', '2019-11-25 16:39:55'),
(35, 'joaodomingos', 'joaodomingos@gmail.com', NULL, '$2y$10$XzK.jdrnGcLELhQx5V2ePuCMp9rLvPBeYeOX36U.CVYRNDw8uHZq2', NULL, '2019-11-25 16:50:50', '2019-11-25 16:50:50'),
(36, 'didad', 'didas@gmail.com', NULL, '$2y$10$KhNgaRNWIBLK8jFiFedO2.q5xpbXA4aQrmaBMqlbbhBHYZU.sUIom', NULL, '2020-01-10 09:27:41', '2020-01-10 09:27:41');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vans`
--

CREATE TABLE `vans` (
  `id` int(10) UNSIGNED NOT NULL,
  `matricula` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo_id` int(11) DEFAULT NULL,
  `ano_aquisicao` int(11) DEFAULT NULL,
  `nr_ocupantes` int(11) DEFAULT NULL,
  `cor_id` int(11) DEFAULT NULL,
  `imagem` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `vans`
--

INSERT INTO `vans` (`id`, `matricula`, `descricao`, `modelo_id`, `ano_aquisicao`, `nr_ocupantes`, `cor_id`, `imagem`, `created_at`, `updated_at`) VALUES
(7, 'LS-2211', 'PP Van LA-KIA', 2, NULL, NULL, 1, 'uploads/vans/jeep.jpg', '2019-11-25 16:45:25', '2019-11-25 16:45:25'),
(9, 'HT-21', 'PP Van LA-KIA', 2, NULL, NULL, 1, 'uploads/vans/hiace.jfif', '2019-11-25 16:46:38', '2019-11-25 16:46:38'),
(10, 'HL-2C-22', 'Range Rover 2015', 2, NULL, NULL, 1, 'uploads/vans/range_rover.jpg', '2019-11-25 16:47:27', '2019-11-25 16:47:27'),
(11, 'P-22-23', 'Ssangyong Stavic', 2, NULL, NULL, 1, 'uploads/vans/ssangyong_stavic.png', '2019-11-25 16:48:46', '2019-11-25 16:48:46'),
(12, 'LD-121', 'korando', 2, NULL, NULL, 1, 'uploads/vans/korando.png', '2019-11-25 16:52:09', '2019-11-25 16:52:09'),
(13, 'JU-020-23', 'korando1', 2, NULL, NULL, 1, 'default.jpg', '2019-12-26 10:04:07', '2019-12-26 10:04:07'),
(14, 'DE-333', 'korando', 2, NULL, NULL, 1, 'QqaPQkrFfN.jpeg', '2019-12-26 11:27:54', '2019-12-26 11:27:54'),
(15, 'LS-23', 'korando', 2, NULL, NULL, 1, 'Yct0rsEzjj.jpeg', '2019-12-26 11:39:20', '2019-12-26 11:39:20'),
(16, 'LA-23-22', 'Van 1', 2, 2020, 23, 1, 'default.jpg', '2020-01-09 11:05:19', '2020-01-09 11:05:19'),
(17, 'LS-22112', 'Van 2', 2, 2020, 23, 1, 'default.jpg', '2020-01-09 11:11:20', '2020-01-09 11:11:20'),
(20, 'LP-1D-11', 'Van act 4', 2, 2020, 23, 1, 'default.jpg', '2020-01-09 11:14:55', '2020-01-09 11:16:38'),
(21, 'LP-1D-11LA', 'Van 8', 2, 2020, 23, 1, 'y1LXSXeJht.jpeg', '2020-01-10 08:31:06', '2020-01-10 08:31:06'),
(22, 'AL-P2333', 'Van 9', 2, 2020, 23, 1, '6IXwFg5KDr.jpeg', '2020-01-10 08:43:42', '2020-01-10 08:43:42'),
(23, 'AL-P232', 'Van 10', 2, 2020, 23, 1, 'nhcGNp8BMM.jpeg', '2020-01-10 09:02:46', '2020-01-10 09:02:46'),
(24, 'AL-DAST233', 'Van 11', 2, 2020, 23, 1, 'vans/AoLdF08R10.jpeg', '2020-01-10 09:18:20', '2020-01-10 09:18:20'),
(25, 'AL-DAST266', 'Van 12', 2, 2020, 23, 1, 'uploads/vans/u401Tf7blg.jpeg', '2020-01-10 09:20:07', '2020-01-10 09:20:07'),
(26, 'AL-SAEEW', 'Van 12', 2, 2020, 23, 1, '/uploads/vans/NxODCobMyL.jpeg', '2020-01-10 09:22:17', '2020-01-10 09:22:17'),
(27, 'AL-SAE', 'Van 13', 2, 2020, 23, 1, '/uploads/vans/oiVxNPX9rN.jpeg', '2020-01-10 09:25:26', '2020-01-10 09:25:26');

-- --------------------------------------------------------

--
-- Estrutura da tabela `van_contactos`
--

CREATE TABLE `van_contactos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contacto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `van_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `van_contactos`
--

INSERT INTO `van_contactos` (`id`, `contacto`, `van_id`, `created_at`, `updated_at`) VALUES
(10, '9383747883', 9, '2019-11-25 16:46:38', '2019-11-25 16:46:38'),
(11, '9383747883', 10, '2019-11-25 16:47:27', '2019-11-25 16:47:27'),
(12, '925 747 883', 11, '2019-11-25 16:48:46', '2019-11-25 16:48:46'),
(13, '925 747 883', 12, '2019-11-25 16:52:09', '2019-11-25 16:52:09'),
(14, 'kjjjj', 12, '2019-12-09 03:00:00', '2019-12-09 03:00:00'),
(15, '925 747 883', 13, '2019-12-26 10:04:07', '2019-12-26 10:04:07'),
(16, '925 747 883', 14, '2019-12-26 11:27:54', '2019-12-26 11:27:54'),
(17, '925 747 883', 15, '2019-12-26 11:39:21', '2019-12-26 11:39:21'),
(18, '925 747 883', 16, '2020-01-09 11:05:19', '2020-01-09 11:05:19'),
(19, '925 747 883', 17, '2020-01-09 11:11:20', '2020-01-09 11:11:20'),
(20, '925 747 883', 20, '2020-01-09 11:14:55', '2020-01-09 11:14:55'),
(21, '93887282', 20, '2020-01-09 11:16:38', '2020-01-09 11:16:38'),
(22, 'van1@gmail.com', 20, '2020-01-09 11:16:38', '2020-01-09 11:16:38'),
(23, '925 747 883', 21, '2020-01-10 08:31:06', '2020-01-10 08:31:06'),
(24, '925 747 883', 22, '2020-01-10 08:43:42', '2020-01-10 08:43:42'),
(25, '925 747 883', 23, '2020-01-10 09:02:46', '2020-01-10 09:02:46'),
(26, '925 747 883', 24, '2020-01-10 09:18:20', '2020-01-10 09:18:20'),
(27, '925 747 883', 25, '2020-01-10 09:20:07', '2020-01-10 09:20:07'),
(28, '925 747 883', 26, '2020-01-10 09:22:17', '2020-01-10 09:22:17'),
(29, '925 747 883', 27, '2020-01-10 09:25:26', '2020-01-10 09:25:26');

-- --------------------------------------------------------

--
-- Estrutura da tabela `viagem_enderecos`
--

CREATE TABLE `viagem_enderecos` (
  `id` int(10) UNSIGNED NOT NULL,
  `viagem_id` int(10) UNSIGNED NOT NULL,
  `tipo` enum('Inicial','Final') COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `descricao` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `viagem_enderecos`
--

INSERT INTO `viagem_enderecos` (`id`, `viagem_id`, `tipo`, `latitude`, `longitude`, `descricao`, `created_at`, `updated_at`) VALUES
(1, 4, 'Inicial', NULL, NULL, NULL, '2020-01-28 09:31:30', '2020-01-28 09:31:30'),
(2, 4, 'Inicial', NULL, NULL, NULL, '2020-01-28 09:31:30', '2020-01-28 09:31:30'),
(3, 12, 'Inicial', 65, 74, 'desc', '2020-01-28 09:36:33', '2020-01-28 09:36:33'),
(4, 12, 'Final', 877, 877, 'desc', '2020-01-28 09:36:33', '2020-01-28 09:36:33'),
(5, 6, 'Inicial', 65, 74, 'desc', '2020-01-28 09:53:47', '2020-01-28 09:53:47'),
(6, 6, 'Final', 65, 74, 'desc', '2020-01-28 09:53:47', '2020-01-28 09:53:47'),
(7, 7, 'Inicial', 65, 74, 'desc', '2020-01-28 11:53:15', '2020-01-28 11:53:15'),
(8, 7, 'Final', 65, 74, 'desc', '2020-01-28 11:53:15', '2020-01-28 11:53:15'),
(9, 8, 'Inicial', 65, 74, 'desc', '2020-01-28 11:54:08', '2020-01-28 11:54:08'),
(10, 8, 'Final', 65, 74, 'desc', '2020-01-28 11:54:08', '2020-01-28 11:54:08'),
(11, 1, 'Inicial', 65, 74, 'descricao inicial', '2020-01-28 11:54:42', '2020-01-28 12:00:09'),
(12, 1, 'Final', 877, 877, 'descricao final', '2020-01-28 11:54:42', '2020-01-28 12:00:09');

-- --------------------------------------------------------

--
-- Estrutura da tabela `viagens`
--

CREATE TABLE `viagens` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `motorista_id` int(10) UNSIGNED NOT NULL,
  `van_id` int(10) UNSIGNED NOT NULL,
  `hora_chamada` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_chegada` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_termino` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avaliacao` int(10) UNSIGNED DEFAULT NULL,
  `comentario` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `viagem_terminada` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `viagens`
--

INSERT INTO `viagens` (`id`, `usuario_id`, `motorista_id`, `van_id`, `hora_chamada`, `hora_chegada`, `hora_termino`, `avaliacao`, `comentario`, `viagem_terminada`, `created_at`, `updated_at`) VALUES
(1, 1, 37, 27, '10h:20m', '10h:26m', '12h:8m', 3, 'sem comentario', 0, '2020-01-28 11:54:42', '2020-01-28 11:54:42');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cores`
--
ALTER TABLE `cores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `escalas`
--
ALTER TABLE `escalas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `feed_backs`
--
ALTER TABLE `feed_backs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_backs_funcionario_id_foreign` (`funcionario_id`);

--
-- Índices para tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `funcionarios_usuario_id_foreign` (`usuario_id`);

--
-- Índices para tabela `funcionario_contactos`
--
ALTER TABLE `funcionario_contactos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `funcionario_contactos_funcionario_id_foreign` (`funcionario_id`);

--
-- Índices para tabela `funcionario_escalas`
--
ALTER TABLE `funcionario_escalas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `funcionario_escalas_funcionario_id_foreign` (`funcionario_id`),
  ADD KEY `funcionario_escalas_escala_id_foreign` (`escala_id`);

--
-- Índices para tabela `localizacoes`
--
ALTER TABLE `localizacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `localizacoes_funcionario_id_foreign` (`funcionario_id`);

--
-- Índices para tabela `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `mes`
--
ALTER TABLE `mes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `modelos`
--
ALTER TABLE `modelos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modelos_marca_id_foreign` (`marca_id`);

--
-- Índices para tabela `moradas`
--
ALTER TABLE `moradas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moradas_municipio_id_foreign` (`municipio_id`);

--
-- Índices para tabela `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `municipios_provincia_id_foreign` (`provincia_id`);

--
-- Índices para tabela `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Índices para tabela `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Índices para tabela `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Índices para tabela `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Índices para tabela `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Índices para tabela `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Índices para tabela `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Índices para tabela `permission_user`
--
ALTER TABLE `permission_user`
  ADD PRIMARY KEY (`user_id`,`permission_id`,`user_type`),
  ADD KEY `permission_user_permission_id_foreign` (`permission_id`);

--
-- Índices para tabela `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Índices para tabela `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`user_id`,`role_id`,`user_type`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Índices para tabela `vans`
--
ALTER TABLE `vans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricula` (`matricula`);

--
-- Índices para tabela `van_contactos`
--
ALTER TABLE `van_contactos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `van_contactos_van_id_foreign` (`van_id`);

--
-- Índices para tabela `viagem_enderecos`
--
ALTER TABLE `viagem_enderecos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `viagem_enderecos_viagem_id_foreign` (`viagem_id`);

--
-- Índices para tabela `viagens`
--
ALTER TABLE `viagens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `viagens_usuario_id_foreign` (`usuario_id`),
  ADD KEY `viagens_motorista_id_foreign` (`motorista_id`),
  ADD KEY `viagens_van_id_foreign` (`van_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `banner`
--
ALTER TABLE `banner`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `cores`
--
ALTER TABLE `cores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `escalas`
--
ALTER TABLE `escalas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `feed_backs`
--
ALTER TABLE `feed_backs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de tabela `funcionario_contactos`
--
ALTER TABLE `funcionario_contactos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de tabela `funcionario_escalas`
--
ALTER TABLE `funcionario_escalas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de tabela `localizacoes`
--
ALTER TABLE `localizacoes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `mes`
--
ALTER TABLE `mes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `modelos`
--
ALTER TABLE `modelos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `moradas`
--
ALTER TABLE `moradas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `provincias`
--
ALTER TABLE `provincias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de tabela `vans`
--
ALTER TABLE `vans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `van_contactos`
--
ALTER TABLE `van_contactos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `viagem_enderecos`
--
ALTER TABLE `viagem_enderecos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `viagens`
--
ALTER TABLE `viagens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `feed_backs`
--
ALTER TABLE `feed_backs`
  ADD CONSTRAINT `feed_backs_funcionario_id_foreign` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD CONSTRAINT `funcionarios_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `funcionario_contactos`
--
ALTER TABLE `funcionario_contactos`
  ADD CONSTRAINT `funcionario_contactos_funcionario_id_foreign` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `funcionario_escalas`
--
ALTER TABLE `funcionario_escalas`
  ADD CONSTRAINT `funcionario_escalas_escala_id_foreign` FOREIGN KEY (`escala_id`) REFERENCES `escalas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `funcionario_escalas_funcionario_id_foreign` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `localizacoes`
--
ALTER TABLE `localizacoes`
  ADD CONSTRAINT `localizacoes_funcionario_id_foreign` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `modelos`
--
ALTER TABLE `modelos`
  ADD CONSTRAINT `modelos_marca_id_foreign` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `moradas`
--
ALTER TABLE `moradas`
  ADD CONSTRAINT `moradas_municipio_id_foreign` FOREIGN KEY (`municipio_id`) REFERENCES `municipios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `municipios_provincia_id_foreign` FOREIGN KEY (`provincia_id`) REFERENCES `provincias` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `permission_user`
--
ALTER TABLE `permission_user`
  ADD CONSTRAINT `permission_user_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `van_contactos`
--
ALTER TABLE `van_contactos`
  ADD CONSTRAINT `van_contactos_van_id_foreign` FOREIGN KEY (`van_id`) REFERENCES `vans` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `viagem_enderecos`
--
ALTER TABLE `viagem_enderecos`
  ADD CONSTRAINT `viagem_enderecos_viagem_id_foreign` FOREIGN KEY (`viagem_id`) REFERENCES `viagens` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `viagens`
--
ALTER TABLE `viagens`
  ADD CONSTRAINT `viagens_motorista_id_foreign` FOREIGN KEY (`motorista_id`) REFERENCES `funcionarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `viagens_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `viagens_van_id_foreign` FOREIGN KEY (`van_id`) REFERENCES `vans` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
