-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PortfolioWeb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PortfolioWeb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PortfolioWeb` DEFAULT CHARACTER SET utf8 ;
USE `PortfolioWeb` ;

-- -----------------------------------------------------
-- Table `PortfolioWeb`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`provincia` (
  `idProvincia` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`localidad` (
  `idLocalidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idLocalidad`, `provincia_idProvincia`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_idProvincia`)
    REFERENCES `PortfolioWeb`.`provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`usuario` (
  `idUsuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `localidad_idlocalidad` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `localidad_idlocalidad`),
  INDEX `fk_usuario_localidad_idx` (`localidad_idlocalidad` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_localidad`
    FOREIGN KEY (`localidad_idlocalidad`)
    REFERENCES `PortfolioWeb`.`localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`correo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`correo` (
  `dirección` VARCHAR(45) NOT NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`usuario_idUsuario`),
  INDEX `fk_correo_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_correo_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `PortfolioWeb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`telefono` (
  `telefono` VARCHAR(45) NOT NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`usuario_idUsuario`),
  INDEX `fk_correo_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_correo_usuario10`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `PortfolioWeb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`proyecto` (
  `idProyecto` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `url` VARCHAR(100) NOT NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idProyecto`, `usuario_idUsuario`),
  INDEX `fk_proyecto_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `PortfolioWeb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`educacion` (
  `idEducacion` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `establecimiento` VARCHAR(45) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFinalizacion` DATE NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idEducacion`, `usuario_idUsuario`),
  INDEX `fk_educacion_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `PortfolioWeb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`tipoEmpleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`tipoEmpleo` (
  `idTipoEmpleo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoEmpleo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`experiencia` (
  `idExperiencia` INT NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `duracion` VARCHAR(45) NOT NULL,
  `puesto` VARCHAR(45) NOT NULL,
  `tipoEmpleo_idTipoEmpleo` INT NOT NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idExperiencia`, `tipoEmpleo_idTipoEmpleo`, `usuario_idUsuario`),
  INDEX `fk_experiencia_tipoEmpleo1_idx` (`tipoEmpleo_idTipoEmpleo` ASC) VISIBLE,
  INDEX `fk_experiencia_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_tipoEmpleo1`
    FOREIGN KEY (`tipoEmpleo_idTipoEmpleo`)
    REFERENCES `PortfolioWeb`.`tipoEmpleo` (`idTipoEmpleo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `PortfolioWeb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`tipoHabilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`tipoHabilidad` (
  `idTipoHabilidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoHabilidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PortfolioWeb`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PortfolioWeb`.`habilidad` (
  `idHabilidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `puntaje` TINYINT(2) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `tipoHabilidad_idTipoHabilidad` INT NOT NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idHabilidad`, `tipoHabilidad_idTipoHabilidad`, `usuario_idUsuario`),
  INDEX `fk_habilidad_tipoHabilidad1_idx` (`tipoHabilidad_idTipoHabilidad` ASC) VISIBLE,
  INDEX `fk_habilidad_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_tipoHabilidad1`
    FOREIGN KEY (`tipoHabilidad_idTipoHabilidad`)
    REFERENCES `PortfolioWeb`.`tipoHabilidad` (`idTipoHabilidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habilidad_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `PortfolioWeb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
