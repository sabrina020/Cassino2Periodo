-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.25-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para cassino_2
DROP DATABASE IF EXISTS `cassino_2`;
CREATE DATABASE IF NOT EXISTS `cassino_2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cassino_2`;

-- Copiando estrutura para tabela cassino_2.aposta
DROP TABLE IF EXISTS `aposta`;
CREATE TABLE IF NOT EXISTS `aposta` (
  `codAposta` int(11) NOT NULL AUTO_INCREMENT,
  `valor` decimal(10,0) NOT NULL,
  `formaPagamento` varchar(200) NOT NULL,
  `jogos_codJogo` int(11) NOT NULL,
  `nomeCliente` varchar(100) NOT NULL,
  PRIMARY KEY (`codAposta`,`jogos_codJogo`),
  KEY `fk_aposta_jogos1_idx` (`jogos_codJogo`),
  CONSTRAINT `fk_aposta_jogos1` FOREIGN KEY (`jogos_codJogo`) REFERENCES `jogos` (`codJogo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela cassino_2.aposta: ~2 rows (aproximadamente)
INSERT INTO `aposta` (`codAposta`, `valor`, `formaPagamento`, `jogos_codJogo`, `nomeCliente`) VALUES
	(11, 8000, 'Dinheiro', 9, 'sabrina silva'),
	(21, 200, 'Pix', 11, 'Ingrid');

-- Copiando estrutura para tabela cassino_2.jogos
DROP TABLE IF EXISTS `jogos`;
CREATE TABLE IF NOT EXISTS `jogos` (
  `codJogo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  PRIMARY KEY (`codJogo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela cassino_2.jogos: ~6 rows (aproximadamente)
INSERT INTO `jogos` (`codJogo`, `nome`) VALUES
	(4, 'Truco'),
	(9, 'poker'),
	(11, 'roulette'),
	(17, 'Canastra'),
	(19, 'xadrez'),
	(20, 'Futebol');

-- Copiando estrutura para procedure cassino_2.lista_aposta
DROP PROCEDURE IF EXISTS `lista_aposta`;
DELIMITER //
CREATE PROCEDURE `lista_aposta`()
BEGIN
    select a.codAposta, a.valor, a.formapagamento , j.nome, a.nomeCliente from aposta as a 
    inner join jogos as j on a.Jogos_codjogo = j.codJogo;
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.lista_jogo
DROP PROCEDURE IF EXISTS `lista_jogo`;
DELIMITER //
CREATE PROCEDURE `lista_jogo`()
BEGIN
	select * from jogos;
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.proc_addAposta
DROP PROCEDURE IF EXISTS `proc_addAposta`;
DELIMITER //
CREATE PROCEDURE `proc_addAposta`(in nvalor decimal, in formpag varchar(200), cliente varchar(100),
 in jogo int)
BEGIN
 insert into aposta(valor,formaPagamento,nomeCliente,jogos_codJogo)
 values (nvalor, formpag, cliente, jogo);
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.proc_addJogos
DROP PROCEDURE IF EXISTS `proc_addJogos`;
DELIMITER //
CREATE PROCEDURE `proc_addJogos`(IN novoJogo varchar(200))
BEGIN
	insert into jogos(nome) values (novoJogo);
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.proc_alteraAposta
DROP PROCEDURE IF EXISTS `proc_alteraAposta`;
DELIMITER //
CREATE PROCEDURE `proc_alteraAposta`(in nvalor varchar(200), in formpag varchar(200),in cliente varchar(100),in jogo int, in cod int)
BEGIN 
	update aposta set valor=nvalor, formaPagamento=formpag, nomeCliente=cliente, jogos_codJogo=jogo where codAposta=cod;
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.proc_alteraJogo
DROP PROCEDURE IF EXISTS `proc_alteraJogo`;
DELIMITER //
CREATE PROCEDURE `proc_alteraJogo`(in generos varchar(100), in alteraJogo varchar(100), in codigo int)
BEGIN
	update jogos set genero = generos, nome = alteraJogo where codJogo = codigo; 
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.proc_deleteAposta
DROP PROCEDURE IF EXISTS `proc_deleteAposta`;
DELIMITER //
CREATE PROCEDURE `proc_deleteAposta`(in codDelete int)
BEGIN
	delete from aposta where codAposta=codDelete;
END//
DELIMITER ;

-- Copiando estrutura para procedure cassino_2.proc_deleteJogo
DROP PROCEDURE IF EXISTS `proc_deleteJogo`;
DELIMITER //
CREATE PROCEDURE `proc_deleteJogo`(in codDelete int)
BEGIN
	delete from jogos where codJogo=codDelete;
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
