CREATE DATABASE betterdays_bd;

USE betterdays_bd;

CREATE TABLE usuario (
	idUsuario    BIGINT       NOT NULL AUTO_INCREMENT,
	nome         VARCHAR(255) NOT NULL,
	loginUsuario VARCHAR(20)  NOT NULL,
	senhaUsuario VARCHAR(30)  NOT NULL,

	PRIMARY KEY (idUsuario)
);

CREATE TABLE diario (
	idDiario     BIGINT      NOT NULL AUTO_INCREMENT,
	idUsuario    BIGINT      NOT NULL,
	dataRegistro DATETIME    NOT NULL,
	titulo       VARCHAR(30) NOT NULL,
	nota         TEXT        NOT NULL,

	PRIMARY KEY (idDiario),
	
	CONSTRAINT fk_diario_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario)
);

CREATE TABLE listametas (
	idMetas         BIGINT 	    NOT NULL AUTO_INCREMENT,
	idUsuario       BIGINT 	    NOT NULL,
    dataRegistro    DATETIME    NOT NULL,
	titulo 	        VARCHAR(30) NOT NULL,
	descricao       TEXT 	    NOT NULL,
	isConcluido     TINYINT     NOT NULL DEFAULT 0, 

	PRIMARY KEY (idMetas),

	CONSTRAINT fk_listaMetas_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario)
);
