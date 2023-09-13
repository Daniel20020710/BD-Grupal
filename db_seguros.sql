-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema db_seguros
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_seguros
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_seguros` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema db_seguros2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_seguros2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_seguros2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vehiculos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado_civil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `documento` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `tipo_persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `tipo_persona_id`),
  INDEX `fk_personas_tipo_persona_idx` (`tipo_persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_personas_tipo_persona`
    FOREIGN KEY (`tipo_persona_id`)
    REFERENCES `mydb`.`tipo_persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vehiculos_has_personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vehiculos_has_personas` (
  `vehiculos_id` INT NOT NULL,
  `personas_id` INT NOT NULL,
  `tipo_persona_id` INT NOT NULL,
  `tarjeta_propiedad` VARCHAR(45) NULL,
  `ciudad_de_expedicion` VARCHAR(45) NULL,
  PRIMARY KEY (`vehiculos_id`, `personas_id`, `tipo_persona_id`),
  INDEX `fk_vehiculos_has_personas_personas1_idx` (`personas_id` ASC, `tipo_persona_id` ASC) VISIBLE,
  INDEX `fk_vehiculos_has_personas_vehiculos1_idx` (`vehiculos_id` ASC) VISIBLE,
  CONSTRAINT `fk_vehiculos_has_personas_vehiculos1`
    FOREIGN KEY (`vehiculos_id`)
    REFERENCES `mydb`.`vehiculos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculos_has_personas_personas1`
    FOREIGN KEY (`personas_id` , `tipo_persona_id`)
    REFERENCES `mydb`.`personas` (`id` , `tipo_persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`infracciones`
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `db_seguros`.`accidente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`accidente` (
  `NumeroReferencia` INT NOT NULL,
  `Fecha` DATE NULL DEFAULT NULL,
  `Lugar` VARCHAR(100) NULL DEFAULT NULL,
  `Hora` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`NumeroReferencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`persona` (
  `DNI` VARCHAR(20) NOT NULL,
  `Nombre` VARCHAR(50) NULL DEFAULT NULL,
  `Apellidos` VARCHAR(50) NULL DEFAULT NULL,
  `Direccion` VARCHAR(100) NULL DEFAULT NULL,
  `Poblacion` VARCHAR(50) NULL DEFAULT NULL,
  `Telefono` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`involucradosenaccidente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`involucradosenaccidente` (
  `NumeroReferencia_Accidente` INT NOT NULL,
  `DNI_Persona` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`NumeroReferencia_Accidente`, `DNI_Persona`),
  INDEX `DNI_Persona` (`DNI_Persona` ASC) VISIBLE,
  CONSTRAINT `involucradosenaccidente_ibfk_1`
    FOREIGN KEY (`NumeroReferencia_Accidente`)
    REFERENCES `db_seguros`.`accidente` (`NumeroReferencia`),
  CONSTRAINT `involucradosenaccidente_ibfk_2`
    FOREIGN KEY (`DNI_Persona`)
    REFERENCES `db_seguros`.`persona` (`DNI`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`multa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`multa` (
  `NumeroReferencia` INT NOT NULL,
  `Fecha` DATE NULL DEFAULT NULL,
  `Hora` TIME NULL DEFAULT NULL,
  `LugarInfraccion` VARCHAR(100) NULL DEFAULT NULL,
  `Importe` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`NumeroReferencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`multasaplicadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`multasaplicadas` (
  `NumeroReferencia_Multa` INT NOT NULL,
  `DNI_Persona` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`NumeroReferencia_Multa`, `DNI_Persona`),
  INDEX `DNI_Persona` (`DNI_Persona` ASC) VISIBLE,
  CONSTRAINT `multasaplicadas_ibfk_1`
    FOREIGN KEY (`NumeroReferencia_Multa`)
    REFERENCES `db_seguros`.`multa` (`NumeroReferencia`),
  CONSTRAINT `multasaplicadas_ibfk_2`
    FOREIGN KEY (`DNI_Persona`)
    REFERENCES `db_seguros`.`persona` (`DNI`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`vehiculo` (
  `Matricula` VARCHAR(10) NOT NULL,
  `Marca` VARCHAR(50) NULL DEFAULT NULL,
  `Modelo` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`multasvehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`multasvehiculo` (
  `NumeroReferencia_Multa` INT NOT NULL,
  `Matricula_Vehiculo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`NumeroReferencia_Multa`, `Matricula_Vehiculo`),
  INDEX `Matricula_Vehiculo` (`Matricula_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `multasvehiculo_ibfk_1`
    FOREIGN KEY (`NumeroReferencia_Multa`)
    REFERENCES `db_seguros`.`multa` (`NumeroReferencia`),
  CONSTRAINT `multasvehiculo_ibfk_2`
    FOREIGN KEY (`Matricula_Vehiculo`)
    REFERENCES `db_seguros`.`vehiculo` (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`propietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`propietario` (
  `DNI_Persona` VARCHAR(20) NOT NULL,
  `Matricula_Vehiculo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`DNI_Persona`, `Matricula_Vehiculo`),
  INDEX `Matricula_Vehiculo` (`Matricula_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `propietario_ibfk_1`
    FOREIGN KEY (`DNI_Persona`)
    REFERENCES `db_seguros`.`persona` (`DNI`),
  CONSTRAINT `propietario_ibfk_2`
    FOREIGN KEY (`Matricula_Vehiculo`)
    REFERENCES `db_seguros`.`vehiculo` (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros`.`vehiculosenaccidente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros`.`vehiculosenaccidente` (
  `NumeroReferencia_Accidente` INT NOT NULL,
  `Matricula_Vehiculo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`NumeroReferencia_Accidente`, `Matricula_Vehiculo`),
  INDEX `Matricula_Vehiculo` (`Matricula_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `vehiculosenaccidente_ibfk_1`
    FOREIGN KEY (`NumeroReferencia_Accidente`)
    REFERENCES `db_seguros`.`accidente` (`NumeroReferencia`),
  CONSTRAINT `vehiculosenaccidente_ibfk_2`
    FOREIGN KEY (`Matricula_Vehiculo`)
    REFERENCES `db_seguros`.`vehiculo` (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `db_seguros2` ;

-- -----------------------------------------------------
-- Table `db_seguros2`.`accidentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`accidentes` (
  `NumeroReferencia` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NULL DEFAULT NULL,
  `Lugar` VARCHAR(100) NULL DEFAULT NULL,
  `Hora` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`NumeroReferencia`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros2`.`multas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`multas` (
  `NumeroReferencia` INT NOT NULL,
  `Fecha` DATE NULL DEFAULT NULL,
  `Hora` TIME NULL DEFAULT NULL,
  `LugarInfraccion` VARCHAR(100) NULL DEFAULT NULL,
  `Importe` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`NumeroReferencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros2`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`personas` (
  `DNI` VARCHAR(20) NOT NULL,
  `Nombre` VARCHAR(50) NULL DEFAULT NULL,
  `Apellidos` VARCHAR(50) NULL DEFAULT NULL,
  `Direccion` VARCHAR(100) NULL DEFAULT NULL,
  `Poblacion` VARCHAR(50) NULL DEFAULT NULL,
  `Telefono` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros2`.`vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`vehiculos` (
  `Matricula` VARCHAR(10) NOT NULL,
  `Marca` VARCHAR(50) NULL DEFAULT NULL,
  `Modelo` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros2`.`aplicar_multas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`aplicar_multas` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NumeroReferencia_Multa` INT NULL DEFAULT NULL,
  `DNI_Persona` VARCHAR(20) NULL DEFAULT NULL,
  `Matricula_Vehiculo` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `NumeroReferencia_Multa` (`NumeroReferencia_Multa` ASC) VISIBLE,
  INDEX `DNI_Persona` (`DNI_Persona` ASC) VISIBLE,
  INDEX `Matricula_Vehiculo` (`Matricula_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `aplicar_multas_ibfk_1`
    FOREIGN KEY (`NumeroReferencia_Multa`)
    REFERENCES `db_seguros2`.`multas` (`NumeroReferencia`),
  CONSTRAINT `aplicar_multas_ibfk_2`
    FOREIGN KEY (`DNI_Persona`)
    REFERENCES `db_seguros2`.`personas` (`DNI`),
  CONSTRAINT `aplicar_multas_ibfk_3`
    FOREIGN KEY (`Matricula_Vehiculo`)
    REFERENCES `db_seguros2`.`vehiculos` (`Matricula`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros2`.`involucrar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`involucrar` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NumeroReferencia_Accidente` INT NULL DEFAULT NULL,
  `DNI_Persona` VARCHAR(20) NULL DEFAULT NULL,
  `Matricula_Vehiculo` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `NumeroReferencia_Accidente` (`NumeroReferencia_Accidente` ASC) VISIBLE,
  INDEX `DNI_Persona` (`DNI_Persona` ASC) VISIBLE,
  INDEX `Matricula_Vehiculo` (`Matricula_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `involucrar_ibfk_1`
    FOREIGN KEY (`NumeroReferencia_Accidente`)
    REFERENCES `db_seguros2`.`accidentes` (`NumeroReferencia`),
  CONSTRAINT `involucrar_ibfk_2`
    FOREIGN KEY (`DNI_Persona`)
    REFERENCES `db_seguros2`.`personas` (`DNI`),
  CONSTRAINT `involucrar_ibfk_3`
    FOREIGN KEY (`Matricula_Vehiculo`)
    REFERENCES `db_seguros2`.`vehiculos` (`Matricula`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_seguros2`.`propietarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_seguros2`.`propietarios` (
  `DNI_Persona` VARCHAR(20) NOT NULL,
  `Matricula_Vehiculo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`DNI_Persona`, `Matricula_Vehiculo`),
  INDEX `Matricula_Vehiculo` (`Matricula_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `propietarios_ibfk_1`
    FOREIGN KEY (`DNI_Persona`)
    REFERENCES `db_seguros2`.`personas` (`DNI`),
  CONSTRAINT `propietarios_ibfk_2`
    FOREIGN KEY (`Matricula_Vehiculo`)
    REFERENCES `db_seguros2`.`vehiculos` (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
