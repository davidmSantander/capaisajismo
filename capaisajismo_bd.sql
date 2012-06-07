SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `capaisajismo_bd` DEFAULT CHARACTER SET latin1 ;
USE `capaisajismo_bd` ;

-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`clientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`clientes` (
  `cliente_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `direccion` VARCHAR(20) NOT NULL ,
  `comuna` VARCHAR(20) NOT NULL ,
  `ciudad` VARCHAR(20) NOT NULL ,
  `telefono` VARCHAR(20) NULL DEFAULT NULL ,
  `celular` VARCHAR(20) NULL DEFAULT NULL ,
  `email` VARCHAR(20) NOT NULL ,
  `banco` VARCHAR(20) NOT NULL ,
  `rut` VARCHAR(20) NOT NULL ,
  `fecha_creacion` DATETIME NULL DEFAULT NULL ,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL ,
  `estado` INT(11) NOT NULL ,
  `servicios_servicio_id` INT(11) NOT NULL ,
  PRIMARY KEY (`cliente_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`usuarios` (
  `usuario_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  `apellido` VARCHAR(20) NOT NULL ,
  `user_name` VARCHAR(20) NOT NULL ,
  `password` VARCHAR(20) NOT NULL ,
  `rut` VARCHAR(20) NOT NULL ,
  `privilegio` VARCHAR(20) NULL DEFAULT NULL ,
  `email` VARCHAR(20) NOT NULL ,
  `fecha_creacion` DATETIME NULL DEFAULT NULL ,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL ,
  `estado` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`usuario_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`servicios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`servicios` (
  `servicio_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tipo_servicio` VARCHAR(20) NULL ,
  `presupuesto` VARCHAR(20) NOT NULL ,
  `fecha_inicio` DATETIME NOT NULL ,
  `fecha_termino` DATETIME NOT NULL ,
  `forma_pago` VARCHAR(20) NOT NULL ,
  `estado_servicio` INT(11) NULL DEFAULT NULL ,
  `fecha_creacion` DATETIME NULL DEFAULT NULL ,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL ,
  `estado` INT(11) NULL DEFAULT NULL ,
  `clientes_cliente_id` INT(11) NOT NULL ,
  `stock_minimo` INT(11) NOT NULL ,
  `unidad_producto` VARCHAR(20) NOT NULL ,
  `usuarios_usuario_id` INT(11) NOT NULL ,
  `fecha_cobro` DATETIME NULL ,
  `numero_cuotas` INT NULL ,
  `monto_cuotas` VARCHAR(20) NULL ,
  `pago_total` VARCHAR(20) NULL ,
  `estado_final` INT(11) NULL ,
  PRIMARY KEY (`servicio_id`) ,
  INDEX `fk_servicios_clientes1` (`clientes_cliente_id` ASC) ,
  INDEX `fk_servicios_usuarios1` (`usuarios_usuario_id` ASC) ,
  CONSTRAINT `fk_servicios_clientes1`
    FOREIGN KEY (`clientes_cliente_id` )
    REFERENCES `capaisajismo_bd`.`clientes` (`cliente_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_usuarios1`
    FOREIGN KEY (`usuarios_usuario_id` )
    REFERENCES `capaisajismo_bd`.`usuarios` (`usuario_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`tareas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`tareas` (
  `tarea_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `fecha_inicio` DATETIME NULL DEFAULT NULL ,
  `fecha_termino` DATETIME NULL DEFAULT NULL ,
  `nombre_tarea` VARCHAR(20) NULL DEFAULT NULL ,
  `fecha_creacion` DATETIME NULL DEFAULT NULL ,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL ,
  `estado` INT(11) NULL DEFAULT NULL ,
  `servicios_servicio_id` INT(11) NOT NULL ,
  PRIMARY KEY (`tarea_id`) ,
  INDEX `fk_tareas_servicios1` (`servicios_servicio_id` ASC) ,
  CONSTRAINT `fk_tareas_servicios1`
    FOREIGN KEY (`servicios_servicio_id` )
    REFERENCES `capaisajismo_bd`.`servicios` (`servicio_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`alertas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`alertas` (
  `alerta_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `fecha_alerta` DATETIME NULL DEFAULT NULL ,
  `estado_alerta` INT(11) NULL DEFAULT NULL ,
  `fecha_creacion` DATETIME NULL DEFAULT NULL ,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL ,
  `estado` INT(11) NULL DEFAULT NULL ,
  `tareas_tarea_id` INT(11) NOT NULL ,
  PRIMARY KEY (`alerta_id`) ,
  INDEX `fk_alertas_tareas1` (`tareas_tarea_id` ASC) ,
  CONSTRAINT `fk_alertas_tareas1`
    FOREIGN KEY (`tareas_tarea_id` )
    REFERENCES `capaisajismo_bd`.`tareas` (`tarea_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`juridicos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`juridicos` (
  `juridico_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `nombre_empresa` VARCHAR(30) NOT NULL ,
  `razon_social` VARCHAR(30) NOT NULL ,
  `giro` VARCHAR(20) NOT NULL ,
  `representante_legal` VARCHAR(40) NOT NULL ,
  `clientes_cliente_id` INT(11) NOT NULL ,
  PRIMARY KEY (`juridico_id`) ,
  INDEX `fk_juridicos_clientes` (`clientes_cliente_id` ASC) ,
  CONSTRAINT `fk_juridicos_clientes`
    FOREIGN KEY (`clientes_cliente_id` )
    REFERENCES `capaisajismo_bd`.`clientes` (`cliente_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`naturales`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`naturales` (
  `natural_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  `apellido` VARCHAR(20) NOT NULL ,
  `clientes_cliente_id` INT(11) NOT NULL ,
  PRIMARY KEY (`natural_id`) ,
  INDEX `fk_naturales_clientes1` (`clientes_cliente_id` ASC) ,
  CONSTRAINT `fk_naturales_clientes1`
    FOREIGN KEY (`clientes_cliente_id` )
    REFERENCES `capaisajismo_bd`.`clientes` (`cliente_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`pagos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`pagos` (
  `pago_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `monto` VARCHAR(20) NULL DEFAULT NULL ,
  `fecha_pago` DATETIME NULL DEFAULT NULL ,
  `alertas_alerta_id` INT(11) NOT NULL ,
  PRIMARY KEY (`pago_id`) ,
  INDEX `fk_pagos_alertas1` (`alertas_alerta_id` ASC) ,
  CONSTRAINT `fk_pagos_alertas1`
    FOREIGN KEY (`alertas_alerta_id` )
    REFERENCES `capaisajismo_bd`.`alertas` (`alerta_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`productos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`productos` (
  `producto_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  `stock` INT(11) NOT NULL ,
  `familia` VARCHAR(20) NOT NULL ,
  `estado_producto` VARCHAR(20) NULL DEFAULT NULL ,
  `tipo` VARCHAR(20) NULL DEFAULT NULL ,
  `precio` VARCHAR(20) NOT NULL ,
  `fecha_creacion` DATETIME NULL DEFAULT NULL ,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL ,
  `estado` INT(11) NULL DEFAULT NULL ,
  `stock_minimo` INT(11) NOT NULL ,
  `unidad` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`producto_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `capaisajismo_bd`.`tareas_has_productos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `capaisajismo_bd`.`tareas_has_productos` (
  `tareas_has_productos_id` INT(11) NOT NULL ,
  `productos_producto_id` INT(11) NOT NULL ,
  `tareas_tarea_id` INT(11) NOT NULL ,
  INDEX `fk_tareas_has_productos_productos1` (`productos_producto_id` ASC) ,
  INDEX `fk_tareas_has_productos_tareas1` (`tareas_tarea_id` ASC) ,
  PRIMARY KEY (`tareas_has_productos_id`) ,
  CONSTRAINT `fk_tareas_has_productos_productos1`
    FOREIGN KEY (`productos_producto_id` )
    REFERENCES `capaisajismo_bd`.`productos` (`producto_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tareas_has_productos_tareas1`
    FOREIGN KEY (`tareas_tarea_id` )
    REFERENCES `capaisajismo_bd`.`tareas` (`tarea_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
