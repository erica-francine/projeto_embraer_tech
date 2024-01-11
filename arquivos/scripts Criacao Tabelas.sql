-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema custos_transporte
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema custos_transporte
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `custos_transporte` DEFAULT CHARACTER SET utf8 ;
USE `custos_transporte` ;

-- -----------------------------------------------------
-- Table `custos_transporte`.`centro_distribuicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`centro_distribuicao` (
  `id_cd` INT NOT NULL AUTO_INCREMENT,
  `rua_cd` VARCHAR(100) NULL DEFAULT NULL,
  `num_cd` INT NULL DEFAULT NULL,
  `bairro_cd` VARCHAR(50) NULL DEFAULT NULL,
  `cep_cd` VARCHAR(20) NULL DEFAULT NULL,
  `cidade_cd` VARCHAR(50) NOT NULL,
  `estado_cd` VARCHAR(50) NOT NULL,
  `pais_cd` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_cd`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `custos_transporte`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `cnpj_cliente` VARCHAR(20) NOT NULL,
  `nome_cliente` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cnpj_cliente_UNIQUE` (`cnpj_cliente` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7817
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`fornecedor` (
  `id_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `cnpj_fornecedor` VARCHAR(20) NOT NULL,
  `nome_fornecedor` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj_fornecedor` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 100381
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`endereco_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`endereco_fornecedor` (
  `id_endereco_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `rua_fornecedor` VARCHAR(100) NULL DEFAULT NULL,
  `num_fornecedor` VARCHAR(20) NULL DEFAULT NULL,
  `bairro_fornecedor` VARCHAR(50) NULL DEFAULT NULL,
  `cep_fornecedor` VARCHAR(20) NULL DEFAULT NULL,
  `cidade_fornecedor` VARCHAR(50) NOT NULL,
  `estado_fornecedor` VARCHAR(50) NOT NULL,
  `pais_fornecedor` VARCHAR(50) NOT NULL,
  `fornecedor_id_fornecedor` INT NOT NULL,
  PRIMARY KEY (`id_endereco_fornecedor`),
  INDEX `fk_endereco_fornecedor_fornecedor1_idx` (`fornecedor_id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_fornecedor_fornecedor1`
    FOREIGN KEY (`fornecedor_id_fornecedor`)
    REFERENCES `custos_transporte`.`fornecedor` (`id_fornecedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 82
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`modal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`modal` (
  `id_modal` INT NOT NULL AUTO_INCREMENT,
  `descricao_modal` VARCHAR(70) NULL DEFAULT NULL,
  PRIMARY KEY (`id_modal`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`compra_materia_prima`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`compra_materia_prima` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `data_compra` DATETIME NULL DEFAULT NULL,
  `distancia` DOUBLE NULL DEFAULT NULL,
  `fornecedor_id_fornecedor` INT NOT NULL,
  `modal_id_modal` INT NOT NULL,
  `endereco_fornecedor_id_endereco_fornecedor` INT NOT NULL,
  `centro_distribuicao_id_cd` INT NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_compra_materia_prima_fornecedor1_idx` (`fornecedor_id_fornecedor` ASC) VISIBLE,
  INDEX `fk_compra_materia_prima_modal1_idx` (`modal_id_modal` ASC) VISIBLE,
  INDEX `fk_compra_materia_prima_endereco_fornecedor1_idx` (`endereco_fornecedor_id_endereco_fornecedor` ASC) VISIBLE,
  INDEX `fk_compra_materia_prima_centro_distribuicao1_idx` (`centro_distribuicao_id_cd` ASC) VISIBLE,
  CONSTRAINT `fk_compra_materia_prima_centro_distribuicao1`
    FOREIGN KEY (`centro_distribuicao_id_cd`)
    REFERENCES `custos_transporte`.`centro_distribuicao` (`id_cd`),
  CONSTRAINT `fk_compra_materia_prima_endereco_fornecedor1`
    FOREIGN KEY (`endereco_fornecedor_id_endereco_fornecedor`)
    REFERENCES `custos_transporte`.`endereco_fornecedor` (`id_endereco_fornecedor`),
  CONSTRAINT `fk_compra_materia_prima_fornecedor1`
    FOREIGN KEY (`fornecedor_id_fornecedor`)
    REFERENCES `custos_transporte`.`fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_compra_materia_prima_modal1`
    FOREIGN KEY (`modal_id_modal`)
    REFERENCES `custos_transporte`.`modal` (`id_modal`))
ENGINE = InnoDB
AUTO_INCREMENT = 501
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`custo_transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`custo_transporte` (
  `id_custo` INT NOT NULL AUTO_INCREMENT,
  `descricao_custo` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_custo`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`custo_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`custo_compra` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `compra_materia_prima_id_compra` INT NOT NULL,
  `custo_transporte_id_custo` INT NOT NULL,
  `valor_custo` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_compra_materia_prima_has_custo_transporte_custo_transpor_idx` (`custo_transporte_id_custo` ASC) VISIBLE,
  INDEX `fk_compra_materia_prima_has_custo_transporte_compra_materia_idx` (`compra_materia_prima_id_compra` ASC) VISIBLE,
  CONSTRAINT `fk_compra_materia_prima_has_custo_transporte_compra_materia_p1`
    FOREIGN KEY (`compra_materia_prima_id_compra`)
    REFERENCES `custos_transporte`.`compra_materia_prima` (`id_compra`),
  CONSTRAINT `fk_compra_materia_prima_has_custo_transporte_custo_transporte1`
    FOREIGN KEY (`custo_transporte_id_custo`)
    REFERENCES `custos_transporte`.`custo_transporte` (`id_custo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`endereco_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`endereco_cliente` (
  `id_endereco_cliente` INT NOT NULL AUTO_INCREMENT,
  `rua_cliente` VARCHAR(100) NULL DEFAULT NULL,
  `num_cliente` VARCHAR(20) NULL DEFAULT NULL,
  `bairro_cliente` VARCHAR(50) NULL DEFAULT NULL,
  `cep_cliente` VARCHAR(20) NULL DEFAULT NULL,
  `cidade_cliente` VARCHAR(50) NOT NULL,
  `estado_cliente` VARCHAR(50) NOT NULL,
  `pais_cliente` VARCHAR(50) NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_endereco_cliente`),
  INDEX `fk_endereco_cliente_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_cliente_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `custos_transporte`.`cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`modelo_aviao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`modelo_aviao` (
  `id_modelo` INT NOT NULL AUTO_INCREMENT,
  `descricao_modelo` VARCHAR(20) NOT NULL,
  `valor_venda` DOUBLE NULL DEFAULT NULL,
  `imagem_aviao` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_modelo`))
ENGINE = InnoDB
AUTO_INCREMENT = 4880
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`producao_aviao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`producao_aviao` (
  `id_aviao` INT NOT NULL AUTO_INCREMENT,
  `modelo_aviao_id_modelo` INT NOT NULL,
  PRIMARY KEY (`id_aviao`),
  INDEX `fk_producao_aviao_modelo_aviao_idx` (`modelo_aviao_id_modelo` ASC) VISIBLE,
  CONSTRAINT `fk_producao_aviao_modelo_aviao`
    FOREIGN KEY (`modelo_aviao_id_modelo`)
    REFERENCES `custos_transporte`.`modelo_aviao` (`id_modelo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`entrega_aviao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`entrega_aviao` (
  `id_entrega` INT NOT NULL AUTO_INCREMENT,
  `data_entrega` DATETIME NULL DEFAULT NULL,
  `distancia` DOUBLE NULL DEFAULT NULL,
  `modal_id_modal` INT NOT NULL,
  `producao_aviao_id_aviao` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `endereco_cliente_id_endereco_cliente` INT NOT NULL,
  `centro_distribuicao_id_cd` INT NOT NULL,
  PRIMARY KEY (`id_entrega`),
  INDEX `fk_entrega_aviao_modal1_idx` (`modal_id_modal` ASC) VISIBLE,
  INDEX `fk_entrega_aviao_producao_aviao1_idx` (`producao_aviao_id_aviao` ASC) VISIBLE,
  INDEX `fk_entrega_aviao_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_entrega_aviao_endereco_cliente1_idx` (`endereco_cliente_id_endereco_cliente` ASC) VISIBLE,
  INDEX `fk_entrega_aviao_centro_distribuicao1_idx` (`centro_distribuicao_id_cd` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_aviao_centro_distribuicao1`
    FOREIGN KEY (`centro_distribuicao_id_cd`)
    REFERENCES `custos_transporte`.`centro_distribuicao` (`id_cd`),
  CONSTRAINT `fk_entrega_aviao_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `custos_transporte`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_entrega_aviao_endereco_cliente1`
    FOREIGN KEY (`endereco_cliente_id_endereco_cliente`)
    REFERENCES `custos_transporte`.`endereco_cliente` (`id_endereco_cliente`),
  CONSTRAINT `fk_entrega_aviao_modal1`
    FOREIGN KEY (`modal_id_modal`)
    REFERENCES `custos_transporte`.`modal` (`id_modal`),
  CONSTRAINT `fk_entrega_aviao_producao_aviao1`
    FOREIGN KEY (`producao_aviao_id_aviao`)
    REFERENCES `custos_transporte`.`producao_aviao` (`id_aviao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`custo_entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`custo_entrega` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `entrega_aviao_id_entrega` INT NOT NULL,
  `custo_transporte_id_custo` INT NOT NULL,
  `valor_custo` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_entrega_aviao_has_custo_transporte_custo_transporte1_idx` (`custo_transporte_id_custo` ASC) VISIBLE,
  INDEX `fk_entrega_aviao_has_custo_transporte_entrega_aviao1_idx` (`entrega_aviao_id_entrega` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_aviao_has_custo_transporte_custo_transporte1`
    FOREIGN KEY (`custo_transporte_id_custo`)
    REFERENCES `custos_transporte`.`custo_transporte` (`id_custo`),
  CONSTRAINT `fk_entrega_aviao_has_custo_transporte_entrega_aviao1`
    FOREIGN KEY (`entrega_aviao_id_entrega`)
    REFERENCES `custos_transporte`.`entrega_aviao` (`id_entrega`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`logistica_interna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`logistica_interna` (
  `id_transferencia` INT NOT NULL AUTO_INCREMENT,
  `data_transferencia` DATETIME NULL DEFAULT NULL,
  `distancia` DOUBLE NULL DEFAULT NULL,
  `modal_id_modal` INT NOT NULL,
  `centro_distribuicao_id_cd` INT NOT NULL,
  `centro_distribuicao_id_cd1` INT NOT NULL,
  PRIMARY KEY (`id_transferencia`),
  INDEX `fk_logistica_intern_modal1_idx` (`modal_id_modal` ASC) VISIBLE,
  INDEX `fk_logistica_intern_centro_distribuicao1_idx` (`centro_distribuicao_id_cd` ASC) VISIBLE,
  INDEX `fk_logistica_intern_centro_distribuicao2_idx` (`centro_distribuicao_id_cd1` ASC) VISIBLE,
  CONSTRAINT `fk_logistica_intern_centro_distribuicao1`
    FOREIGN KEY (`centro_distribuicao_id_cd`)
    REFERENCES `custos_transporte`.`centro_distribuicao` (`id_cd`),
  CONSTRAINT `fk_logistica_intern_centro_distribuicao2`
    FOREIGN KEY (`centro_distribuicao_id_cd1`)
    REFERENCES `custos_transporte`.`centro_distribuicao` (`id_cd`),
  CONSTRAINT `fk_logistica_intern_modal1`
    FOREIGN KEY (`modal_id_modal`)
    REFERENCES `custos_transporte`.`modal` (`id_modal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`custo_logistica_interna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`custo_logistica_interna` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `logistica_interna_id_transferencia` INT NOT NULL,
  `custo_transporte_id_custo` INT NOT NULL,
  `valor_custo` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_logistica_interna_has_custo_transporte_custo_transporte1_idx` (`custo_transporte_id_custo` ASC) VISIBLE,
  INDEX `fk_logistica_interna_has_custo_transporte_logistica_interna_idx` (`logistica_interna_id_transferencia` ASC) VISIBLE,
  CONSTRAINT `fk_logistica_interna_has_custo_transporte_custo_transporte1`
    FOREIGN KEY (`custo_transporte_id_custo`)
    REFERENCES `custos_transporte`.`custo_transporte` (`id_custo`),
  CONSTRAINT `fk_logistica_interna_has_custo_transporte_logistica_interna1`
    FOREIGN KEY (`logistica_interna_id_transferencia`)
    REFERENCES `custos_transporte`.`logistica_interna` (`id_transferencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`suporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`suporte` (
  `id_suporte` INT NOT NULL AUTO_INCREMENT,
  `data_suporte` DATETIME NULL DEFAULT NULL,
  `modal_id_modal` INT NOT NULL,
  `centro_distribuicao_id_cd` INT NOT NULL,
  `endereco_cliente_id_endereco_cliente` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_suporte`),
  INDEX `fk_suporte_modal1_idx` (`modal_id_modal` ASC) VISIBLE,
  INDEX `fk_suporte_centro_distribuicao1_idx` (`centro_distribuicao_id_cd` ASC) VISIBLE,
  INDEX `fk_suporte_endereco_cliente1_idx` (`endereco_cliente_id_endereco_cliente` ASC) VISIBLE,
  INDEX `fk_suporte_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_suporte_centro_distribuicao1`
    FOREIGN KEY (`centro_distribuicao_id_cd`)
    REFERENCES `custos_transporte`.`centro_distribuicao` (`id_cd`),
  CONSTRAINT `fk_suporte_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `custos_transporte`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_suporte_endereco_cliente1`
    FOREIGN KEY (`endereco_cliente_id_endereco_cliente`)
    REFERENCES `custos_transporte`.`endereco_cliente` (`id_endereco_cliente`),
  CONSTRAINT `fk_suporte_modal1`
    FOREIGN KEY (`modal_id_modal`)
    REFERENCES `custos_transporte`.`modal` (`id_modal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`custo_suporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`custo_suporte` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `suporte_id_suporte` INT NOT NULL,
  `custo_transporte_id_custo` INT NOT NULL,
  `valor_custo` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_suporte_has_custo_transporte_custo_transporte1_idx` (`custo_transporte_id_custo` ASC) VISIBLE,
  INDEX `fk_suporte_has_custo_transporte_suporte1_idx` (`suporte_id_suporte` ASC) VISIBLE,
  CONSTRAINT `fk_suporte_has_custo_transporte_custo_transporte1`
    FOREIGN KEY (`custo_transporte_id_custo`)
    REFERENCES `custos_transporte`.`custo_transporte` (`id_custo`),
  CONSTRAINT `fk_suporte_has_custo_transporte_suporte1`
    FOREIGN KEY (`suporte_id_suporte`)
    REFERENCES `custos_transporte`.`suporte` (`id_suporte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`materia_prima`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`materia_prima` (
  `cod_materia_prima` INT NOT NULL AUTO_INCREMENT,
  `descricao_materia_prima` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cod_materia_prima`))
ENGINE = InnoDB
AUTO_INCREMENT = 4935
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`item_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`item_compra` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `compra_materia_prima_id_compra` INT NOT NULL,
  `materia_prima_cod_materia_prima` INT NOT NULL,
  `quantidade` DOUBLE NULL DEFAULT NULL,
  `producao_aviao_id_aviao` INT NOT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_compra_materia_prima_has_materia_prima_materia_prima1_idx` (`materia_prima_cod_materia_prima` ASC) VISIBLE,
  INDEX `fk_compra_materia_prima_has_materia_prima_compra_materia_pr_idx` (`compra_materia_prima_id_compra` ASC) VISIBLE,
  INDEX `fk_item_compra_producao_aviao1_idx` (`producao_aviao_id_aviao` ASC) VISIBLE,
  CONSTRAINT `fk_compra_materia_prima_has_materia_prima_compra_materia_prima1`
    FOREIGN KEY (`compra_materia_prima_id_compra`)
    REFERENCES `custos_transporte`.`compra_materia_prima` (`id_compra`),
  CONSTRAINT `fk_compra_materia_prima_has_materia_prima_materia_prima1`
    FOREIGN KEY (`materia_prima_cod_materia_prima`)
    REFERENCES `custos_transporte`.`materia_prima` (`cod_materia_prima`),
  CONSTRAINT `fk_item_compra_producao_aviao1`
    FOREIGN KEY (`producao_aviao_id_aviao`)
    REFERENCES `custos_transporte`.`producao_aviao` (`id_aviao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`item_logistica_interna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`item_logistica_interna` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `materia_prima_cod_materia_prima` INT NOT NULL,
  `logistica_interna_id_transferencia` INT NOT NULL,
  `quantidade` DOUBLE NULL DEFAULT NULL,
  `producao_aviao_id_aviao` INT NOT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_materia_prima_has_logistica_interna_logistica_interna1_idx` (`logistica_interna_id_transferencia` ASC) VISIBLE,
  INDEX `fk_materia_prima_has_logistica_interna_materia_prima1_idx` (`materia_prima_cod_materia_prima` ASC) VISIBLE,
  INDEX `fk_item_logistica_interna_producao_aviao1_idx` (`producao_aviao_id_aviao` ASC) VISIBLE,
  CONSTRAINT `fk_item_logistica_interna_producao_aviao1`
    FOREIGN KEY (`producao_aviao_id_aviao`)
    REFERENCES `custos_transporte`.`producao_aviao` (`id_aviao`),
  CONSTRAINT `fk_materia_prima_has_logistica_interna_logistica_interna1`
    FOREIGN KEY (`logistica_interna_id_transferencia`)
    REFERENCES `custos_transporte`.`logistica_interna` (`id_transferencia`),
  CONSTRAINT `fk_materia_prima_has_logistica_interna_materia_prima1`
    FOREIGN KEY (`materia_prima_cod_materia_prima`)
    REFERENCES `custos_transporte`.`materia_prima` (`cod_materia_prima`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `custos_transporte`.`item_suporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custos_transporte`.`item_suporte` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `suporte_id_suporte` INT NOT NULL,
  `materia_prima_cod_materia_prima` INT NOT NULL,
  `quantidade` DOUBLE NULL DEFAULT NULL,
  `producao_aviao_id_aviao` INT NOT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_suporte_has_materia_prima_materia_prima1_idx` (`materia_prima_cod_materia_prima` ASC) VISIBLE,
  INDEX `fk_suporte_has_materia_prima_suporte1_idx` (`suporte_id_suporte` ASC) VISIBLE,
  INDEX `fk_suporte_has_materia_prima_producao_aviao1_idx` (`producao_aviao_id_aviao` ASC) VISIBLE,
  CONSTRAINT `fk_suporte_has_materia_prima_materia_prima1`
    FOREIGN KEY (`materia_prima_cod_materia_prima`)
    REFERENCES `custos_transporte`.`materia_prima` (`cod_materia_prima`),
  CONSTRAINT `fk_suporte_has_materia_prima_producao_aviao1`
    FOREIGN KEY (`producao_aviao_id_aviao`)
    REFERENCES `custos_transporte`.`producao_aviao` (`id_aviao`),
  CONSTRAINT `fk_suporte_has_materia_prima_suporte1`
    FOREIGN KEY (`suporte_id_suporte`)
    REFERENCES `custos_transporte`.`suporte` (`id_suporte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
