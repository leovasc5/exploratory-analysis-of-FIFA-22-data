-- MySQL Script generated by MySQL Workbench
-- Thu Jun 29 11:43:28 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fifa
-- -----------------------------------------------------
-- Banco de dados que espelha ao jogo FIFA 22 lançado em 2021 pela © Electronic Arts Inc.
DROP SCHEMA IF EXISTS `fifa` ;

-- -----------------------------------------------------
-- Schema fifa
--
-- Banco de dados que espelha ao jogo FIFA 22 lançado em 2021 pela © Electronic Arts Inc.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fifa` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `fifa` ;

-- -----------------------------------------------------
-- Table `fifa`.`liga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`liga` ;

CREATE TABLE IF NOT EXISTS `fifa`.`liga` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL COMMENT 'Nome oficial da Liga dentro do jogo, independente de tradução.',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nome_UNIQUE` ON `fifa`.`liga` (`nome` ASC) VISIBLE;

CREATE UNIQUE INDEX `id_UNIQUE` ON `fifa`.`liga` (`id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`clube`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`clube` ;

CREATE TABLE IF NOT EXISTS `fifa`.`clube` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(63) NOT NULL COMMENT 'Nome resumido do clube.',
  `dinheiro_transferencia` DECIMAL(12,2) UNSIGNED NOT NULL COMMENT 'Montante financeiro que o clube tem orçado para gastar na temporada em contratações.',
  `prestigio_domestico` INT NOT NULL COMMENT 'Representa de forma ascendente, qual é o nível de prestígio de um clube na sua liga doméstica. Normalmente é usado no jogo para simular se um jogador deseja ou não ir para o clube que fez uma proposta de transferência.',
  `prestigio_internacional` INT NOT NULL COMMENT 'Representa de forma ascendente, qual é o nível de prestígio de um clube no mundo. Normalmente é usado no jogo para simular se um jogador deseja ou não ir para o clube que fez uma proposta de transferência.',
  `liga_id` INT UNSIGNED NOT NULL COMMENT 'O ID referente à tabela \"Liga\". O valor representa de qual liga doméstica pertence a equipe.',
  PRIMARY KEY (`id`),
  CONSTRAINT `Um clube deve estar uma liga`
    FOREIGN KEY (`liga_id`)
    REFERENCES `fifa`.`liga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
ROW_FORMAT = DYNAMIC;

CREATE INDEX `fk_clube_liga1_idx` ON `fifa`.`clube` (`liga_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `id_UNIQUE` ON `fifa`.`clube` (`id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`pais` ;

CREATE TABLE IF NOT EXISTS `fifa`.`pais` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL COMMENT 'Nome conhecido do país. Não representa o nome do político do estado apresentado, apenas como é popularmente conhecido.',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nome_UNIQUE` ON `fifa`.`pais` (`nome` ASC) VISIBLE;

CREATE UNIQUE INDEX `id_UNIQUE` ON `fifa`.`pais` (`id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`posicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`posicao` ;

CREATE TABLE IF NOT EXISTS `fifa`.`posicao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL COMMENT 'Nome em inglês referente à posição que um jogador atua.',
  `nome_traduzido` VARCHAR(64) NOT NULL COMMENT 'Valor traduzido.',
  `sigla` VARCHAR(3) NOT NULL COMMENT 'Sigla em inglês que se refere ao nome da posição.',
  `sigla_traduzida` VARCHAR(3) NOT NULL COMMENT 'Sigla em português que se refere ao nome traduzido da posição.',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fifa`.`jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`jogador` ;

CREATE TABLE IF NOT EXISTS `fifa`.`jogador` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL COMMENT 'Nome usado pelo jogador na camisa do time e nas demais funcionalidades do jogo.',
  `nome_completo` VARCHAR(64) NOT NULL COMMENT 'Nome completo do jogador, vindo de seu documento oficial.',
  `idade` INT NOT NULL COMMENT 'A idade o jogador, independente da data de nascimento que não está entre os dados.',
  `altura` INT NULL COMMENT 'Altura do jogador em centímetros.',
  `peso` VARCHAR(45) NULL COMMENT 'Peso do jogador em quilogramas.',
  `overall` INT UNSIGNED NOT NULL COMMENT 'Considerado como uma forma de avaliação do jogador.',
  `potencial` INT UNSIGNED NOT NULL COMMENT 'Se refere até quanto o atributo overall do jogador pode evoluir durante o jogo.',
  `valor_mercado_eur` DECIMAL(12,2) UNSIGNED NOT NULL COMMENT 'Refere-se à avaliação do mercado sobre quanto vale o jogador para uma proposta de transferência. Em euros.',
  `valor_salario_eur` DECIMAL(12,2) UNSIGNED NOT NULL COMMENT 'Salário do jogador dentro do clube atual. Em euros.',
  `valor_clausula_venda_eur` DECIMAL(12,2) UNSIGNED NOT NULL COMMENT 'Valor acordado entre o clube e o jogador para a quebra de contrato. Normalmente é utilizado para a realização de transferência.\n',
  `inicio_contrato` YEAR NOT NULL COMMENT 'Ano em que se iniciou o contrato do jogador com o clube. Importante: Esta data comumente é iniciada em julho/agosto da temporada.',
  `fim_contrato` YEAR NOT NULL COMMENT 'Ano em que se encerra o contrato do jogador com o clube. Importante: Esta data comumente se refere a julho/agosto da temporada.',
  `camisa_clube` INT UNSIGNED NOT NULL COMMENT 'Número da camisa do atleta no clube.',
  `is_emprestimo` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Booleano que identifica se o jogador vem de empréstimo de outro clube ou se é um contratado.',
  `clube_id` INT UNSIGNED NULL COMMENT 'Valor referente à tabela \"Clube\". O ID representa o clube que o jogador está atuando. Não necessariamente precisa atribuido a algum time, já qie o jogador pode estar livre no mercado.',
  `pais_id` INT UNSIGNED NOT NULL,
  `posicao_principal_id` INT UNSIGNED NOT NULL COMMENT 'Valor referente à tabela \"posicao\". Representa a  posição que o atleta mais se identifica e gosta de atuar.',
  `posicao_clube_id` INT UNSIGNED NOT NULL COMMENT 'Valor referente a tabela \"posicao\". Representa a posição inicial que o jogador está atuando no quadro de jogadores que iniciam as partidas.',
  `pe` CHAR(1) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Um jogador pertence a um clube`
    FOREIGN KEY (`clube_id`)
    REFERENCES `fifa`.`clube` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Um jogador vem de um país`
    FOREIGN KEY (`pais_id`)
    REFERENCES `fifa`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Um jogador tem uma posição principal`
    FOREIGN KEY (`posicao_principal_id`)
    REFERENCES `fifa`.`posicao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Um jogador tem muitas posições`
    FOREIGN KEY (`posicao_clube_id`)
    REFERENCES `fifa`.`posicao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_jogador_clube_idx` ON `fifa`.`jogador` (`clube_id` ASC) VISIBLE;

CREATE INDEX `fk_jogador_pais1_idx` ON `fifa`.`jogador` (`pais_id` ASC) VISIBLE;

CREATE INDEX `fk_jogador_posicao1_idx` ON `fifa`.`jogador` (`posicao_principal_id` ASC) VISIBLE;

CREATE INDEX `fk_jogador_posicao2_idx` ON `fifa`.`jogador` (`posicao_clube_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `id_UNIQUE` ON `fifa`.`jogador` (`id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`jogador_posicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`jogador_posicao` ;

CREATE TABLE IF NOT EXISTS `fifa`.`jogador_posicao` (
  `jogador_id` INT UNSIGNED NOT NULL,
  `posicao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`jogador_id`, `posicao_id`),
  CONSTRAINT `Um jogador deve ter uma posição`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `fifa`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Uma posição deve ter um jogador`
    FOREIGN KEY (`posicao_id`)
    REFERENCES `fifa`.`posicao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_jogador_has_posicao_posicao1_idx` ON `fifa`.`jogador_posicao` (`posicao_id` ASC) VISIBLE;

CREATE INDEX `fk_jogador_has_posicao_jogador1_idx` ON `fifa`.`jogador_posicao` (`jogador_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`liga_pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`liga_pais` ;

CREATE TABLE IF NOT EXISTS `fifa`.`liga_pais` (
  `liga_id` INT UNSIGNED NOT NULL,
  `pais_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`liga_id`, `pais_id`),
  CONSTRAINT `Uma liga deve estar em um ou muitos países`
    FOREIGN KEY (`liga_id`)
    REFERENCES `fifa`.`liga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Um país deve ter uma liga`
    FOREIGN KEY (`pais_id`)
    REFERENCES `fifa`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_liga_has_pais_pais1_idx` ON `fifa`.`liga_pais` (`pais_id` ASC) VISIBLE;

CREATE INDEX `fk_liga_has_pais_liga1_idx` ON `fifa`.`liga_pais` (`liga_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`habilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`habilidade` ;

CREATE TABLE IF NOT EXISTS `fifa`.`habilidade` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL,
  `nome_traduzido` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `fifa`.`habilidade` (`id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fifa`.`jogador_habilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fifa`.`jogador_habilidade` ;

CREATE TABLE IF NOT EXISTS `fifa`.`jogador_habilidade` (
  `jogador_id` INT UNSIGNED NOT NULL,
  `habilidade_id` INT UNSIGNED NOT NULL,
  `valor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`jogador_id`, `habilidade_id`),
  CONSTRAINT `Uma habilidade deve ter um jogador`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `fifa`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Um jogador deve ter uma habilidade`
    FOREIGN KEY (`habilidade_id`)
    REFERENCES `fifa`.`habilidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_jogador_has_habilidade_habilidade1_idx` ON `fifa`.`jogador_habilidade` (`habilidade_id` ASC) VISIBLE;

CREATE INDEX `fk_jogador_has_habilidade_jogador1_idx` ON `fifa`.`jogador_habilidade` (`jogador_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
