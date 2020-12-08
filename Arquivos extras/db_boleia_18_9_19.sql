-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_boleia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_boleia` ;

-- -----------------------------------------------------
-- Schema db_boleia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_boleia` DEFAULT CHARACTER SET utf8mb4 ;
USE `db_boleia` ;

-- -----------------------------------------------------
-- Table `db_boleia`.`contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`contacto` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`contacto` (
  `id_contacto` INT(11) NOT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `telemovel` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_contacto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`van`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`van` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`van` (
  `id_van` INT(11) NOT NULL,
  `matricula` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `modelo` VARCHAR(45) NULL DEFAULT NULL,
  `marca` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_van`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`contacto_has_van`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`contacto_has_van` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`contacto_has_van` (
  `contacto_id_contacto` INT(11) NOT NULL,
  `van_id_van` INT(11) NOT NULL,
  PRIMARY KEY (`contacto_id_contacto`, `van_id_van`),
  INDEX `fk_contacto_has_van_van1_idx` (`van_id_van` ASC),
  INDEX `fk_contacto_has_van_contacto1_idx` (`contacto_id_contacto` ASC),
  CONSTRAINT `fk_contacto_has_van_contacto1`
    FOREIGN KEY (`contacto_id_contacto`)
    REFERENCES `db_boleia`.`contacto` (`id_contacto`),
  CONSTRAINT `fk_contacto_has_van_van1`
    FOREIGN KEY (`van_id_van`)
    REFERENCES `db_boleia`.`van` (`id_van`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`escala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`escala` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`escala` (
  `id_escala` INT(11) NOT NULL,
  `mes` INT(11) NULL DEFAULT NULL,
  `ano` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_escala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`usuario` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`usuario` (
  `id_usuario` INT(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `created_date` DATE NOT NULL,
  `updated_date` DATE NOT NULL,
  `senha` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`funcionario` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`funcionario` (
  `id_funcionario` INT(11) NOT NULL,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `nacionalidade` VARCHAR(100) NULL DEFAULT NULL,
  `genero` ENUM('M', 'F') NULL DEFAULT NULL,
  `data_nascimento` DATE NULL DEFAULT NULL,
  `usuario_id_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  INDEX `fk_funcionario_usuario1_idx` (`usuario_id_usuario` ASC),
  CONSTRAINT `fk_funcionario_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `db_boleia`.`usuario` (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`feed_back`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`feed_back` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`feed_back` (
  `id_feedback` INT(11) NOT NULL AUTO_INCREMENT,
  `mensagem` MEDIUMTEXT CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `funcionario_id_funcionario` INT(11) NOT NULL,
  PRIMARY KEY (`id_feedback`),
  INDEX `fk_feed_back_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  CONSTRAINT `fk_feed_back_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `db_boleia`.`funcionario` (`id_funcionario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_boleia`.`funcionario_has_contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`funcionario_has_contacto` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`funcionario_has_contacto` (
  `funcionario_id_funcionario` INT(11) NOT NULL,
  `contacto_id_contacto` INT(11) NOT NULL,
  PRIMARY KEY (`funcionario_id_funcionario`, `contacto_id_contacto`),
  INDEX `fk_funcionario_has_contacto_contacto1_idx` (`contacto_id_contacto` ASC),
  INDEX `fk_funcionario_has_contacto_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  CONSTRAINT `fk_funcionario_has_contacto_contacto1`
    FOREIGN KEY (`contacto_id_contacto`)
    REFERENCES `db_boleia`.`contacto` (`id_contacto`),
  CONSTRAINT `fk_funcionario_has_contacto_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `db_boleia`.`funcionario` (`id_funcionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`funcionario_has_escala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`funcionario_has_escala` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`funcionario_has_escala` (
  `funcionario_id_funcionario` INT(11) NOT NULL,
  `escala_id_escala` INT(11) NOT NULL,
  `dia` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`funcionario_id_funcionario`, `escala_id_escala`),
  INDEX `fk_funcionario_has_escala_escala1_idx` (`escala_id_escala` ASC),
  INDEX `fk_funcionario_has_escala_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  CONSTRAINT `fk_funcionario_has_escala_escala1`
    FOREIGN KEY (`escala_id_escala`)
    REFERENCES `db_boleia`.`escala` (`id_escala`),
  CONSTRAINT `fk_funcionario_has_escala_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `db_boleia`.`funcionario` (`id_funcionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`localizacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`localizacao` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`localizacao` (
  `id_localizacao` INT(11) NOT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `funcionario_id_funcionario` INT(11) NOT NULL,
  PRIMARY KEY (`id_localizacao`),
  INDEX `fk_localizacao_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  CONSTRAINT `fk_localizacao_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `db_boleia`.`funcionario` (`id_funcionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`morada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`morada` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`morada` (
  `id_morada` INT(11) NOT NULL,
  `rua` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `mun_casa` VARCHAR(45) NULL DEFAULT NULL,
  `municipio` VARCHAR(45) NULL DEFAULT NULL,
  `funcionario_id_funcionario` INT(11) NOT NULL,
  PRIMARY KEY (`id_morada`),
  INDEX `fk_morada_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  CONSTRAINT `fk_morada_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `db_boleia`.`funcionario` (`id_funcionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`papel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`papel` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`papel` (
  `id_papel` INT(11) NOT NULL,
  `designacao` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_papel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_boleia`.`usuario_has_papel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_boleia`.`usuario_has_papel` ;

CREATE TABLE IF NOT EXISTS `db_boleia`.`usuario_has_papel` (
  `usuario_id_usuario` INT(11) NOT NULL,
  `papel_id_papel` INT(11) NOT NULL,
  PRIMARY KEY (`usuario_id_usuario`, `papel_id_papel`),
  INDEX `fk_usuario_has_papel_papel1_idx` (`papel_id_papel` ASC),
  INDEX `fk_usuario_has_papel_usuario1_idx` (`usuario_id_usuario` ASC),
  CONSTRAINT `fk_usuario_has_papel_papel1`
    FOREIGN KEY (`papel_id_papel`)
    REFERENCES `db_boleia`.`papel` (`id_papel`),
  CONSTRAINT `fk_usuario_has_papel_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `db_boleia`.`usuario` (`id_usuario`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
