DROP DATABASE IF EXISTS DOIT;
create database DOIT;
USE DOIT;

CREATE TABLE TB_PROGRAMA
(
	COD_PROGRAMA CHAR(3) PRIMARY KEY NOT NULL,
    NOMBRE_PROGRAMA VARCHAR(30) NOT NULL UNIQUE,
	ESTADO CHAR(1) NOT NULL DEFAULT 'A' CHECK('A' OR 'I')
);

INSERT INTO TB_PROGRAMA VALUES('P01','INGLES ADULTO',DEFAULT);
INSERT INTO TB_PROGRAMA VALUES('P02','INGLES NIÑO',DEFAULT);
INSERT INTO TB_PROGRAMA VALUES('P03','ROBOTICAS',DEFAULT);
CREATE TABLE TB_NIVEL
(
	COD_NIVEL CHAR(3) PRIMARY KEY NOT NULL,
    NOMBRE_NIVEL VARCHAR(30) NOT NULL UNIQUE,
    PROGRAMA_FK CHAR(3) NOT NULL,
	ESTADO CHAR(1) NOT NULL DEFAULT 'A' CHECK('A' OR 'I'),
	FOREIGN KEY (PROGRAMA_FK) REFERENCES TB_PROGRAMA (COD_PROGRAMA) 
);

INSERT INTO TB_NIVEL VALUES('N01','BASICO','P01',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N02','INTERMEDIO','P01',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N03','AVANZADO','P01',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N04','PREKIDS','P02',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N05','KIDS','P02',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N06','JUNIORS','P02',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N07','TEENS','P02',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N08','LEGO WEDO','P03',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N09','LEGO MINDSTORM EV3','P03',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N10','VEX IQ','P03',DEFAULT);
INSERT INTO TB_NIVEL VALUES('N11','VEX IQS','P03',DEFAULT);
CREATE TABLE TB_CURSO
(
	COD_CURSO CHAR(4) PRIMARY KEY NOT NULL,
    NOMBRE_CURSO VARCHAR(30) NOT NULL UNIQUE,
    DESCRIPCCION_CURSO VARCHAR(30) NULL,
    NIVEL_FK CHAR(3) NOT NULL,
	ESTADO CHAR(1) NOT NULL DEFAULT 'A' CHECK('A' OR 'I'),
	FOREIGN KEY (NIVEL_FK) REFERENCES TB_NIVEL (COD_NIVEL) 
);

INSERT INTO TB_CURSO VALUES('C001','BASICO 1','LOREM IPSUM','N01',DEFAULT);
INSERT INTO TB_CURSO VALUES('C002','BASICO 2','LOREM IPSUM','N01',DEFAULT);
INSERT INTO TB_CURSO VALUES('C003','INTERMEDIO 1','LOREM IPSUM','N02',DEFAULT);
INSERT INTO TB_CURSO VALUES('C004','INTERMEDIO 2','LOREM IPSUM','N02',DEFAULT);
INSERT INTO TB_CURSO VALUES('C005','AVANZADO 1','LOREM IPSUM','N03',DEFAULT);
INSERT INTO TB_CURSO VALUES('C006','AVANZADO 2','LOREM IPSUM','N03',DEFAULT);

CREATE TABLE TB_APODERADO
(
	DNI_APODERADO CHAR(8) PRIMARY KEY NOT NULL,
    NOMBRES_APODERADO VARCHAR(50) NOT NULL,
    APELLIDO_PATERNO VARCHAR(25) NOT NULL,
    APELLIDO_MATERNO VARCHAR(25) NOT NULL,
    CELULAR_APO_CONTACTO  VARCHAR(9) NULL,
    FONO_APO_CONTACTO     VARCHAR(6) NULL,
    CORREO_APO_CONTACTO	  VARCHAR(30) NULL,
    FECHA_NAC DATE NOT NULL
);

INSERT INTO TB_APODERADO VALUES('72280700','DORIAN','RODRIGUEZ','REYES',null,null,null,'1984-01-07');

CREATE TABLE TB_ALUMNO
(
	DNI_ALUMNO CHAR(8) PRIMARY KEY NOT NULL,
    NOMBRES_ALUMNO VARCHAR(50) NOT NULL,
    APELLIDO_PATERNO VARCHAR(25) NOT NULL,
    APELLIDO_MATERNO VARCHAR(25) NOT NULL,
    CONTRASEÑA_ALUMNO VARCHAR(50) NOT NULL,
    CELULAR_ALU_CONTACTO  VARCHAR(9),
    FONO_ALU_CONTACTO     VARCHAR(7),
    CORREO_ALU_CONTACTO	  VARCHAR(30),
    FECHA_NAC DATE NOT NULL,
    ESTADO CHAR(1) NOT NULL DEFAULT 'A' CHECK('A' OR 'I')
);
SELECT* FROM TB_ALUMNO;
INSERT INTO TB_ALUMNO VALUES('72280703','ANDY','MARIÑOS','RODRIGUEZ','1234',null,null,null,'2001-08-01',DEFAULT);
INSERT INTO TB_ALUMNO VALUES('74690086','LUIS','RETTO','HERNANDEZ','1234',929470244,null,'luis23_10_98@hotmail.com','1998-10-23',DEFAULT);
CREATE TABLE TB_APODERA_ALUMNO
(
	DNI_APODERADO CHAR(8) NOT NULL,
    DNI_ALUMNO CHAR(8) NOT NULL,
    FOREIGN KEY (DNI_APODERADO) REFERENCES TB_APODERADO (DNI_APODERADO) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (DNI_ALUMNO) REFERENCES TB_ALUMNO (DNI_ALUMNO) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(DNI_APODERADO,DNI_ALUMNO)
);

INSERT INTO TB_APODERA_ALUMNO VALUES('72280700','72280703');

CREATE TABLE TB_USUARIO
(
	DNI_USUARIO CHAR(8) PRIMARY KEY NOT NULL,
    CONTRASEÑA VARCHAR(20) NOT NULL,
    NOMBRES_USUARIO VARCHAR(50) NOT NULL,
    APELLIDO_PATERNO VARCHAR(25) NOT NULL,
    APELLIDO_MATERNO VARCHAR(25) NOT NULL,
    FECHA_NAC DATE NOT NULL,
    CARGO CHAR(1) NOT NULL CHECK('A' OR 'S'),
    ESTADO CHAR(1) NOT NULL DEFAULT 'A' CHECK('A' OR 'I')
);

INSERT INTO TB_USUARIO VALUES('12345678','Navidad','JULIAN','HUAMANI','QUISPE','1900-04-06','A',DEFAULT);
INSERT INTO TB_USUARIO VALUES('87654321','Pascua','MERCEDEZ','RODRIGUEZ','SANTOS','1995-01-06','S',DEFAULT);

CREATE TABLE TB_MATRICULA
(
	NUM_MATRICULA CHAR(6) PRIMARY KEY NOT NULL,
    FEC_MATRICULA DATE NOT NULL,
    CURSO_FK CHAR(4) NOT NULL,
	FOREIGN KEY (CURSO_FK) REFERENCES TB_CURSO (COD_CURSO),
    ALUMNO_FK CHAR(8) NOT NULL,
	FOREIGN KEY (ALUMNO_FK) REFERENCES TB_ALUMNO (DNI_ALUMNO),
    USUARIO_FK CHAR(8) NOT NULL,
	FOREIGN KEY (USUARIO_FK) REFERENCES TB_USUARIO (DNI_USUARIO)
);

INSERT INTO TB_MATRICULA VALUES('M00001','2019-01-08','C001','72280703','12345678');

CREATE TABLE DETALLE_ALUMNO_MATRICULA
(
	NUM_MATRICULA VARCHAR(10) NOT NULL REFERENCES TB_MATRICULA (NUM_MATRICULA),
    DNI_ALUMNO CHAR(8) NOT NULL REFERENCES TB_ALUMNO (DNI_ALUMNO),
    FOREIGN KEY (NUM_MATRICULA) REFERENCES TB_MATRICULA (NUM_MATRICULA) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (DNI_ALUMNO) REFERENCES TB_ALUMNO (DNI_ALUMNO) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(NUM_MATRICULA,DNI_ALUMNO)
);
INSERT INTO DETALLE_ALUMNO_MATRICULA VALUES('M00001','72280703');
/*Procedimientos almacenados*/
DELIMITER $$
CREATE PROCEDURE usp_validaUsuario(usr char(8), pas varchar(20))
BEGIN
select * from TB_USUARIO
 where DNI_USUARIO=usr and CONTRASEÑA = pas;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_actualizaUsuario(NOMBRES_USUARIOU VARCHAR(50),APELLIDO_PATERNOU VARCHAR(25), APELLIDO_MATERNOU VARCHAR(25)
 , FECHA_NACU DATE,DNI_USUARIOU CHAR(8))
BEGIN
UPDATE TB_USUARIO SET NOMBRES_USUARIO=NOMBRES_USUARIOU,APELLIDO_PATERNO=APELLIDO_PATERNOU,APELLIDO_MATERNO=APELLIDO_MATERNOU,FECHA_NAC=FECHA_NACU WHERE DNI_USUARIO=DNI_USUARIOU;
END $$
DELIMITER ;
call usp_actualizaUsuario('andy','alex','mar','2019-05-06','12345678');
select * from tb_usuario;