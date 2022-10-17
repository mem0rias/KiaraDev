﻿--
-- Script was generated by Devart dbForge Studio 2022 for MySQL, Version 9.1.21.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 10/17/2022 6:12:49 PM
-- Server version: 10.4.24
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

DROP DATABASE IF EXISTS kiara;

CREATE DATABASE kiara
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

--
-- Set default database
--
USE kiara;

--
-- Create table `usuario`
--
CREATE TABLE usuario (
  IdUsuario int(10) NOT NULL AUTO_INCREMENT,
  Email varchar(255) DEFAULT NULL,
  IdRol int(10) DEFAULT NULL,
  Nombre varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PA varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  SA varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Eciv varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  ocupacion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Telefono varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  password varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (IdUsuario)
)
ENGINE = INNODB,
AUTO_INCREMENT = 48,
AVG_ROW_LENGTH = 682,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `BorrarUsuario`
--
CREATE 
	DEFINER = 'root'@'localhost'
PROCEDURE BorrarUsuario(IN `U_IdUsuario` INT)
delete from usuario where IdUsuario = U_IdUsuario
$$

DELIMITER ;

--
-- Create table `propiedades`
--
CREATE TABLE propiedades (
  IdPropiedad int(10) NOT NULL AUTO_INCREMENT,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Precio bigint(20) DEFAULT NULL,
  Estado varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Municipio varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Colonia varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Calle varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  CP int(10) DEFAULT NULL,
  Uso varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Terreno int(10) DEFAULT NULL,
  Video varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Imagenes varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  TipoTransaccion varchar(255) DEFAULT NULL,
  Titulo varchar(40) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AUTO_INCREMENT = 43,
AVG_ROW_LENGTH = 744,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Borrar_Propiedad`
--
CREATE 
	DEFINER = 'root'@'localhost'
PROCEDURE Borrar_Propiedad(IN `U_IdPropiedad` INT)
delete from propiedades
where IdPropiedad = U_IdPropiedad
$$

DELIMITER ;

--
-- Create table `terreno`
--
CREATE TABLE terreno (
  IdPropiedad int(10) NOT NULL,
  `Medida Frente` int(10) DEFAULT NULL,
  `Medida Fondo` int(10) DEFAULT NULL,
  `Uso de suelo` int(10) DEFAULT NULL,
  Agua int(10) DEFAULT NULL,
  Luz int(10) DEFAULT NULL,
  Drenaje int(10) DEFAULT NULL,
  Desivel int(10) DEFAULT NULL,
  `Forma de Terreno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE terreno
ADD CONSTRAINT FK_terreno_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `residencial`
--
CREATE TABLE residencial (
  IdPropiedad int(10) NOT NULL,
  baños int(10) DEFAULT NULL,
  Recamaras int(10) DEFAULT NULL,
  Cocina int(10) DEFAULT NULL,
  Estacionamiento int(10) DEFAULT NULL,
  Gas int(10) DEFAULT NULL,
  Pisos int(10) DEFAULT NULL,
  Activa tinyint(1) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1365,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE residencial
ADD CONSTRAINT FK_residencial_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `comercial`
--
CREATE TABLE comercial (
  IdPropiedad int(10) NOT NULL,
  Estacionamiento int(10) DEFAULT NULL,
  Cuartos int(10) DEFAULT NULL,
  Oficinas int(10) DEFAULT NULL,
  Niveles int(10) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2340,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE comercial
ADD CONSTRAINT FK_comercial_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `asignacion`
--
CREATE TABLE asignacion (
  IdUsuario int(10) NOT NULL,
  IdPropiedad int(10) NOT NULL,
  Fecha_asignacion date DEFAULT NULL,
  RolProp int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 682,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE asignacion
ADD CONSTRAINT FK_asignacion_IdEmpleado FOREIGN KEY (IdUsuario)
REFERENCES usuario (IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE asignacion
ADD CONSTRAINT FK_asignacion_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$

--
-- Create procedure `AsignarProp`
--
CREATE 
	DEFINER = 'root'@'localhost'
PROCEDURE AsignarProp(IN `U_IdUsuario` INT, IN `U_IdPropiedad` INT, IN `U_FechaAsig` DATE, IN `U_IdRol` INT)
Insert into asignacion values(U_IdUsuario, U_IdPropiedad, U_FechaAsig, U_IdRol)
$$

DELIMITER ;

--
-- Create table `pasos_compra`
--
CREATE TABLE pasos_compra (
  Paso int(10) NOT NULL,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Paso)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1489,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `cliente_pc_prop`
--
CREATE TABLE cliente_pc_prop (
  IdUsuario int(10) NOT NULL AUTO_INCREMENT,
  IdPaso int(10) NOT NULL,
  IdPropiedad int(10) NOT NULL,
  IdRol int(10) NOT NULL,
  Estatus int(10) DEFAULT NULL,
  Fecha_Inicio date DEFAULT NULL,
  Fecha_Fin date DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPaso, IdPropiedad)
)
ENGINE = INNODB,
AUTO_INCREMENT = 22,
AVG_ROW_LENGTH = 356,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE cliente_pc_prop
ADD CONSTRAINT FK_cliente_pc_prop_IdPaso FOREIGN KEY (IdPaso)
REFERENCES pasos_compra (Paso) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE cliente_pc_prop
ADD CONSTRAINT FK_cliente_pc_prop_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE cliente_pc_prop
ADD CONSTRAINT FK_cliente_pc_prop_IdUsuario FOREIGN KEY (IdUsuario)
REFERENCES usuario (IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$

--
-- Create procedure `CerrarTramite`
--
CREATE 
	DEFINER = 'root'@'localhost'
PROCEDURE CerrarTramite(IN `U_IdPropiedad` INT)
update cliente_pc_prop set estatus = 1 where IdPropiedad = U_IdPropiedad
$$

DELIMITER ;

--
-- Create table `tipo_exp_prop`
--
CREATE TABLE tipo_exp_prop (
  Tipo_Exp int(10) NOT NULL,
  Descripion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Tipo_Exp)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 16384,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `tipo_doc_prop`
--
CREATE TABLE tipo_doc_prop (
  Tipo_Doc int(10) NOT NULL,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Tipo_Doc)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `requisitos_prop`
--
CREATE TABLE requisitos_prop (
  Tipo_Doc int(10) NOT NULL,
  Tipo_Exp int(10) NOT NULL,
  PRIMARY KEY (Tipo_Doc, Tipo_Exp)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1820,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE requisitos_prop
ADD CONSTRAINT FK_requisitos_prop_Tipo_Doc FOREIGN KEY (Tipo_Doc)
REFERENCES tipo_doc_prop (Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE requisitos_prop
ADD CONSTRAINT FK_requisitos_prop_Tipo_Exp FOREIGN KEY (Tipo_Exp)
REFERENCES tipo_exp_prop (Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `exp_tipo_doc_prop`
--
CREATE TABLE exp_tipo_doc_prop (
  IdCliente int(10) NOT NULL,
  Tipo_Doc int(10) NOT NULL,
  Tipo_Exp int(10) NOT NULL,
  URL varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Estatus int(10) DEFAULT NULL,
  Rol_Exp int(10) DEFAULT NULL,
  PRIMARY KEY (IdCliente, Tipo_Doc, Tipo_Exp)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE exp_tipo_doc_prop
ADD CONSTRAINT FK_exp_tipo_doc_prop_IdCliente FOREIGN KEY (IdCliente)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE exp_tipo_doc_prop
ADD CONSTRAINT FK_exp_tipo_doc_prop_Tipo_Doc FOREIGN KEY (Tipo_Doc)
REFERENCES tipo_doc_prop (Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE exp_tipo_doc_prop
ADD CONSTRAINT FK_exp_tipo_doc_prop_Tipo_Exp FOREIGN KEY (Tipo_Exp)
REFERENCES tipo_exp_prop (Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `tipo_exp`
--
CREATE TABLE tipo_exp (
  Tipo_Exp int(10) NOT NULL,
  Descripion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Tipo_Exp)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `tipo_doc`
--
CREATE TABLE tipo_doc (
  Tipo_Doc int(10) NOT NULL,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Tipo_Doc)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1489,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `requisitos`
--
CREATE TABLE requisitos (
  Tipo_Doc int(10) NOT NULL,
  Tipo_Exp int(10) NOT NULL,
  PRIMARY KEY (Tipo_Doc, Tipo_Exp)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 496,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create index `UK_requisitos_Tipo_Doc` on table `requisitos`
--
ALTER TABLE requisitos
ADD INDEX UK_requisitos_Tipo_Doc (Tipo_Doc);

--
-- Create foreign key
--
ALTER TABLE requisitos
ADD CONSTRAINT FK_requisitos_Tipo_Doc FOREIGN KEY (Tipo_Doc)
REFERENCES tipo_doc (Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE requisitos
ADD CONSTRAINT FK_requisitos_Tipo_Exp FOREIGN KEY (Tipo_Exp)
REFERENCES tipo_exp (Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `exp_tipo_doc`
--
CREATE TABLE exp_tipo_doc (
  IdCliente int(10) NOT NULL,
  Tipo_Doc int(10) NOT NULL,
  Tipo_Exp int(10) NOT NULL,
  URL varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Estatus int(10) DEFAULT NULL,
  Comentarios varchar(255) DEFAULT NULL,
  PRIMARY KEY (IdCliente, Tipo_Doc, Tipo_Exp)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1820,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE exp_tipo_doc
ADD CONSTRAINT FK_exp_tipo_doc_IdCliente FOREIGN KEY (IdCliente)
REFERENCES usuario (IdUsuario) ON DELETE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE exp_tipo_doc
ADD CONSTRAINT FK_exp_tipo_doc_Tipo_Doc FOREIGN KEY (Tipo_Doc)
REFERENCES tipo_doc (Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE exp_tipo_doc
ADD CONSTRAINT FK_exp_tipo_doc_Tipo_Exp FOREIGN KEY (Tipo_Exp)
REFERENCES tipo_exp (Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create table `pasos_renta`
--
CREATE TABLE pasos_renta (
  Paso int(10) NOT NULL,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Paso)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `cliente_pr_prop`
--
CREATE TABLE cliente_pr_prop (
  IdUsuario int(10) NOT NULL,
  IdPaso int(10) NOT NULL,
  IdPropiedad int(10) NOT NULL,
  IdRol int(10) DEFAULT NULL,
  Estatus int(10) DEFAULT NULL,
  Fecha_Inicio date DEFAULT NULL,
  Fecha_Fin date DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPaso, IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 585,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE cliente_pr_prop
ADD CONSTRAINT FK_cliente_pr_prop_IdPaso FOREIGN KEY (IdPaso)
REFERENCES pasos_renta (Paso) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE cliente_pr_prop
ADD CONSTRAINT FK_cliente_pr_prop_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Create foreign key
--
ALTER TABLE cliente_pr_prop
ADD CONSTRAINT FK_cliente_pr_prop_IdUsuario FOREIGN KEY (IdUsuario)
REFERENCES usuario (IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

-- 
-- Dumping data for table tipo_exp_prop
--
INSERT INTO tipo_exp_prop VALUES
(1, 'Expediente Propiedad');

-- 
-- Dumping data for table tipo_doc_prop
--
INSERT INTO tipo_doc_prop VALUES
(1, 'Escrituras\r\n'),
(2, 'CFDI'),
(3, 'Constancia de inscripcion al registro publico de las escrituras'),
(4, 'Planos arquitectonicos de la propiedad'),
(5, 'Predial pagago'),
(6, 'Constancia de numero oficial'),
(7, 'Terminacion de obrea'),
(8, 'Ultimo recibo de luz'),
(9, 'Ultimo recibo de agua'),
(10, 'Carta de no adeudo de mantenimiento y cuotas');

-- 
-- Dumping data for table tipo_exp
--
INSERT INTO tipo_exp VALUES
(1, 'Expediente Propietario'),
(2, 'Expediente Conyugue de Propietario'),
(3, 'Expediente Comprador\r\n'),
(4, 'Expediente Conyugue Comprador'),
(5, 'Expediente Solicitante Arrendamiento'),
(6, 'Expediente Obligado Solidario Arrendamiento'),
(7, 'Expediente Propietario del inmueble a arrendar');

-- 
-- Dumping data for table tipo_doc
--
INSERT INTO tipo_doc VALUES
(1, 'Identificacion Oficial'),
(2, 'Comprobante de Domicilio'),
(3, 'CURP'),
(4, 'Acta de Nacimiento'),
(5, 'Acta de Matrimonio'),
(6, 'Constancia de Situacion Fiscal'),
(7, 'Estado de Cuenta '),
(8, 'Comprobante de ingreso'),
(9, 'Formulario de solicitud de arrendamiento'),
(10, 'Cuenta para el pago de renta'),
(11, 'Predial');

-- 
-- Dumping data for table pasos_renta
--
INSERT INTO pasos_renta VALUES
(1, 'Recepcion de apartado'),
(2, 'Recepcion de documentacion'),
(3, 'Inicio de tramite de póliza jurídica'),
(4, 'Resultado de investigación de póliza jurídica'),
(5, 'Revisión de contrato'),
(6, 'Firma de contrato ');

-- 
-- Dumping data for table pasos_compra
--
INSERT INTO pasos_compra VALUES
(1, 'Recepcion de Apartada'),
(2, 'Recepcion de Documentacion'),
(3, 'Elaboracion del contrato de compraventa'),
(4, 'Aprobacion de las partes del borrador de contrato'),
(5, 'Firma de contrato de compraventa'),
(6, 'Realizacion del avaluo comercial'),
(7, 'Realizacion del avaluo hacendario'),
(8, 'Avaluo terminado y entregado'),
(9, 'Revision de documentacion por parte de Notaria'),
(10, 'Elaboracion de proyecto de escritura'),
(11, 'Firma de escritura de compraventa');

-- 
-- Dumping data for table usuario
--
INSERT INTO usuario VALUES
(1, 'Luis.Solis@hotmail.com', 2, 'Luis', 'Solis', 'Gracia', 'Soltero', 'Licenciado', '728172173', NULL),
(2, 'Guillermo.De Soto@hotmail.com', 2, 'Guillermo', 'De Soto', 'Garcia', 'Soltero', 'Licenciado', '728172174', NULL),
(3, 'Fidel.Torres@hotmail.com', 2, 'Fidel', 'Torres', 'Garza', 'Soltero', 'Licenciado', '728172175', NULL),
(4, 'David.Landa@hotmail.com', 2, 'David', 'Landa', 'Pelaes', 'Soltero', 'Licenciado', '728172176', NULL),
(5, 'Michelle.Soto@hotmail.com', 2, 'Michelle', 'Soto', 'Virgolinni', 'Soltero', 'Licenciado', '728172177', NULL),
(6, 'Hugo.Ramos@hotmail.com', 1, 'Hugo', 'Ramos', 'Palomino', 'Soltero', 'Licenciado', '728172178', NULL),
(7, 'Armando.Vazquez@hotmail.com', 1, 'Armando', 'Vazquez', 'Nava', 'Soltero', 'Licenciado', '728172179', NULL),
(8, 'Juan.Perez@hotmail.com', 1, 'Juan', 'Perez', 'Utrera', 'Soltero', 'Licenciado', '728172180', NULL),
(9, 'Erick.Chavez@hotmail.com', 1, 'Erick', 'Chavez', 'Ponce', 'Casado', 'Licenciado', '728172181', NULL),
(10, 'Andrea.Castillo@hotmail.com', 1, 'Andrea', 'Castillo', 'Schwarzenegger', 'Soltero', 'Estudiante ', '728172182', NULL),
(11, 'Gerardo.Esparza@hotmail.com', 1, 'Gerardo', 'Esparza', 'Peregrino', 'Soltero', 'Estudiante ', '728172183', NULL),
(12, 'Enrique.Enriquez@hotmail.com', 1, 'Enrique', 'Enriquez', 'Gutierrez', 'Soltero', 'Estudiante ', '728172184', NULL),
(13, 'Juan Luis.Flores@hotmail.com', 1, 'Juan Luis', 'Flores', 'Peck', 'Soltero', 'Estudiante ', '728172185', NULL),
(14, 'Nicolas.Palos@hotmail.com', 1, 'Nicolas', 'Palos', 'de La torre', 'Soltero', 'Estudiante ', '728172186', NULL),
(15, 'Fernando.Atocha@hotmail.com', 1, 'Fernando', 'Atocha', 'Hernandez', 'Soltero', 'Estudiante ', '728172187', NULL),
(16, 'Patricio.Olmo@hotmail.com', 1, 'Patricio', 'Olmo', 'Solis', 'Soltero', 'Estudiante ', '728172188', NULL),
(17, 'Antonio.Cordoba@hotmail.com', 1, 'Antonio', 'Cordoba', 'Cordoba', 'Soltero', 'Estudiante ', '728172189', NULL),
(18, 'Luperdo.Fajardo@hotmail.com', 1, 'Luperdo', 'Fajardo', 'Leon', 'Soltero', 'Estudiante ', '728172190', NULL),
(19, 'Javier.Ochoa@hotmail.com', 1, 'Javier', 'Ochoa', 'Nuñez', 'Soltero', 'Estudiante ', '728172191', NULL),
(21, 'mm.gracia@frenesifloral.mx', 1, 'Mariamiguel', 'Gracia', 'Perez', 'Soltero', 'Estudiante', '7714206969', NULL),
(22, 'memof2000@hotmail.com', 3, 'Guillermo Fidel', 'Navarro', 'Vega', 'Soltero', 'Estudiante', '7717486945', 'ffff'),
(24, 'Daniel.Cordova@hotmail.com', 1, 'Daniel', 'Cordova', 'Perez', 'Soltero', 'Licenciado', '728172172', NULL),
(46, 'a01274191@tec.mx', 0, 'Guillermo Fidel', 'Navarro', 'Vega', 'Soltero', 'Full Stack Dev', '7714206969', '$2a$12$ciSro/W6TN0iL77Hz5ZRVufQFg/QXaYvvpo1NvtlIzaLc8nub.CIW'),
(47, 'blanca@kiara.mx', 2, 'Blanca', 'V', 'Vega', 'Soltero', 'Licenciado', '4420696996', '$2a$12$BH1ErnW/SIAycThplc.4JOWPvyrJMIV7QOwHawYEgZnqGde61aMdu');

-- 
-- Dumping data for table propiedades
--
INSERT INTO propiedades VALUES
(1, 'Casa en venta', 4000000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Residencial', 162, '', '', '1', NULL),
(2, 'Casa en venta', 3500000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Residencial', 147, '', '', '1', NULL),
(4, 'Casa en venta', 7550000, 'Queretaro', 'Queretaro', 'Carretas', 'Circuito Alamos', 76269, 'Residencial', 261, '', '', '1', NULL),
(5, 'Casa en renta', 8790000, 'Queretaro', 'Queretaro', 'Carretas', 'Circuito Alamos', 76269, 'Residencial', 164, '', '', '2', NULL),
(6, 'Local en venta', 10030000, 'Queretaro', 'Queretaro', 'Carretas', 'Circuito Alamos', 76269, 'Comercial', 115, '', '', '1', NULL),
(7, 'Local en venta', 11270000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Comercial', 286, '', '', '1', NULL),
(8, 'Local en venta', 12510000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Comercial', 116, '', '', '1', NULL),
(9, 'Local en venta', 13750000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 219, '', '', '1', NULL),
(10, 'Local en venta', 14990000, 'Queretaro', 'El Marques', 'Zibata', 'Circuito Azaleas', 76269, 'Comercial', 280, '', '', '2', NULL),
(11, 'Local en venta', 16230000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 155, '', '', '1', NULL),
(12, 'Local en venta', 17470000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 229, '', '', '1', NULL),
(13, 'Departamento en venta', 18710000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Residencial', 261, '', '', '1', NULL),
(14, 'Departamento en venta o renta', 19950000, 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 199, '', '', '3', NULL),
(15, 'Departamento en venta', 21190000, 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 128, '', '', '1', NULL),
(16, 'Departamento en venta', 22430000, 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 165, '', '', '1', NULL),
(17, 'Departamento en renta', 23670000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Residencial', 102, '', '', '2', NULL),
(18, 'Terreno', 24910000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Mixto', 275, '', '', '1', NULL),
(19, 'Terreno', 26150000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Mixto', 177, '', '', '3', NULL),
(20, 'Terreno', 27390000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Residencial', 292, '', '', '1', NULL),
(21, 'Casa bonita', 5000, 'Queretaro', 'Queretaro', 'Epigmenio Gonzalez', 'Las rosas 23', 42064, 'Residencial', 120, NULL, NULL, '1', NULL),
(22, 'Casa en renta', 3000000, 'Queretaro', 'Queretaro', 'El Refugio', 'Circuito Berengena ', 76269, 'Residencial', 216, '', '', '2\r\n2', NULL);

-- 
-- Dumping data for table terreno
--
INSERT INTO terreno VALUES
(18, 10, 10, 4, 1, 1, 1, 0, 'Cuadrado'),
(19, 10, 20, 4, 1, 0, 1, 0, 'Rectangular'),
(20, 15, 10, 1, 1, 0, 1, 0, 'Rectangular');

-- 
-- Dumping data for table residencial
--
INSERT INTO residencial VALUES
(1, 2, 2, 1, 2, 1, 2, NULL),
(2, 3, 4, 1, 2, 1, 2, NULL),
(4, 1, 4, 1, 4, 1, 4, NULL),
(5, 2, 3, 1, 1, 1, 5, NULL),
(13, 2, 2, 1, 3, 1, 2, NULL),
(14, 2, 2, 1, 2, 1, 2, NULL),
(15, 3, 2, 2, 1, 1, 2, NULL),
(16, 5, 4, 1, 2, 1, 2, NULL),
(17, 5, 10, 2, 5, 1, 4, NULL),
(21, 2, 3, 4, 4, 1, 4, NULL),
(22, 3, 4, 5, 1, 1, 4, NULL);

-- 
-- Dumping data for table requisitos_prop
--
INSERT INTO requisitos_prop VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1);

-- 
-- Dumping data for table requisitos
--
INSERT INTO requisitos VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(5, 1),
(5, 3),
(5, 4),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(7, 1),
(8, 5),
(8, 6),
(9, 5),
(10, 7),
(11, 7);

-- 
-- Dumping data for table exp_tipo_doc_prop
--
-- Table kiara.exp_tipo_doc_prop does not contain any data (it is empty)

-- 
-- Dumping data for table exp_tipo_doc
--
INSERT INTO exp_tipo_doc VALUES
(9, 1, 1, NULL, 1, NULL),
(10, 1, 3, NULL, 1, 'Perfecto, legal, si tiene casa'),
(10, 2, 3, NULL, 2, 'Super chida tu foto de INE'),
(10, 3, 3, NULL, 1, 'Ok'),
(21, 1, 3, NULL, 1, NULL),
(21, 2, 3, NULL, 1, NULL),
(21, 3, 3, NULL, 1, NULL),
(21, 4, 3, NULL, 1, NULL),
(21, 6, 3, NULL, 1, NULL);

-- 
-- Dumping data for table comercial
--
INSERT INTO comercial VALUES
(6, 2, 5, 1, 1),
(7, 3, 5, 1, 1),
(8, 2, 5, 2, 1),
(9, 1, 3, 3, 2),
(10, 1, 1, 5, 2),
(11, 1, 2, 7, 2),
(12, 5, 2, 10, 4);

-- 
-- Dumping data for table cliente_pr_prop
--
INSERT INTO cliente_pr_prop VALUES
(6, 1, 5, 1, 0, '2022-10-28', '2022-11-07'),
(6, 2, 5, 1, 0, '2022-11-07', '2022-11-08'),
(6, 3, 5, 1, 0, '2022-11-08', '2022-11-09'),
(6, 4, 5, 1, 0, '2022-11-09', '2022-11-10'),
(6, 5, 5, 1, 0, '2022-11-10', '2022-11-11'),
(6, 6, 5, 1, 1, '2022-11-11', '2022-11-12'),
(8, 1, 10, 1, 0, '2022-10-26', '2022-10-26'),
(8, 2, 10, 1, 0, '2022-10-26', '2022-10-26'),
(8, 3, 10, 1, 0, '2022-10-27', '2022-10-27'),
(8, 4, 10, 1, 0, '2022-10-28', '2022-10-28'),
(8, 5, 10, 1, 0, '2022-10-29', '2022-10-29'),
(8, 6, 10, 1, 1, '2022-10-30', '2022-10-30'),
(10, 1, 19, 1, 0, '2022-10-11', '2022-10-13'),
(10, 2, 19, 1, 0, '2022-10-13', '2022-10-14'),
(10, 3, 19, 1, 0, '2022-10-14', '2022-10-15'),
(10, 4, 19, 1, 0, '2022-10-15', '2022-10-16'),
(10, 5, 19, 1, 0, '2022-10-16', '2022-10-17'),
(10, 6, 19, 1, 1, '2022-10-17', '2022-10-18'),
(21, 1, 22, 1, 0, '2022-10-11', '2022-10-14'),
(21, 2, 22, 1, 0, '2022-10-14', '2022-10-15'),
(21, 3, 22, 1, 0, '2022-10-15', '2022-10-16'),
(21, 4, 22, 1, 0, '2022-10-16', '2022-10-17'),
(21, 5, 22, 1, 0, '2022-10-17', '2022-10-18'),
(21, 6, 22, 1, 1, '2022-10-18', '2022-10-19'),
(24, 1, 17, 1, 0, '2022-10-19', '2022-10-19'),
(24, 2, 17, 1, 0, '2022-10-19', '2022-10-20'),
(24, 3, 17, 1, 0, '2022-10-20', '2022-10-21'),
(24, 4, 17, 1, 0, '2022-10-21', '2022-10-22');

-- 
-- Dumping data for table cliente_pc_prop
--
INSERT INTO cliente_pc_prop VALUES
(10, 1, 14, 1, 1, '2022-10-26', '2022-10-27'),
(10, 2, 14, 1, 1, '2022-10-27', '2022-10-28'),
(10, 3, 14, 1, 1, '2022-10-28', '2022-10-29'),
(10, 4, 14, 1, 1, '2022-10-29', '2022-10-30'),
(10, 5, 14, 1, 1, '2022-10-30', '2022-10-31'),
(10, 6, 14, 1, 1, '2022-10-31', '2022-11-01'),
(10, 7, 14, 1, 1, '2022-11-01', '2022-11-02'),
(10, 8, 14, 1, 1, '2022-11-02', '2022-11-03'),
(10, 9, 14, 1, 1, '2022-11-03', '2022-11-04'),
(10, 10, 14, 1, 1, '2022-11-04', '2022-11-05'),
(10, 11, 14, 1, 1, '2022-11-05', '2022-11-06'),
(12, 1, 15, 1, 0, '2022-10-18', '2022-10-19'),
(12, 2, 15, 1, 0, '2022-10-18', '2022-10-19'),
(12, 3, 15, 1, 0, '2022-10-19', '2022-10-20'),
(12, 4, 15, 1, 0, '2022-10-20', '2022-10-21'),
(12, 5, 15, 1, 0, '2022-10-21', '2022-10-22'),
(12, 6, 15, 1, 0, '2022-10-22', '2022-10-23'),
(12, 7, 15, 1, 0, '2022-10-23', '2022-10-24'),
(14, 1, 8, 1, 1, '2022-11-17', '2022-11-18'),
(14, 2, 8, 1, 1, '2022-11-17', '2022-11-18'),
(14, 3, 8, 1, 1, '2022-11-18', '2022-11-19'),
(14, 4, 8, 1, 1, '2022-11-19', '2022-11-20'),
(14, 5, 8, 1, 1, '2022-11-20', '2022-11-21'),
(14, 6, 8, 1, 1, '2022-11-21', '2022-11-22'),
(14, 7, 8, 1, 1, '2022-11-22', '2022-11-23'),
(14, 8, 8, 1, 1, '2022-11-23', '2022-11-24'),
(14, 9, 8, 1, 1, '2022-11-24', '2022-11-25'),
(14, 10, 8, 1, 1, '2022-11-25', '2022-11-26'),
(14, 11, 8, 1, 1, '2022-11-26', '2022-11-27'),
(18, 1, 18, 1, 0, '2022-10-20', '2022-10-21'),
(18, 2, 18, 1, 0, '2022-10-20', '2022-10-21'),
(18, 3, 18, 1, 0, '2022-10-21', '2022-10-22'),
(18, 4, 18, 1, 0, '2022-10-22', '2022-10-23'),
(18, 5, 18, 1, 0, '2022-10-23', '2022-10-24'),
(18, 6, 18, 1, 0, '2022-10-24', '2022-10-25'),
(18, 7, 18, 1, 0, '2022-10-25', '2022-10-26'),
(18, 8, 18, 1, 0, '2022-10-26', '2022-10-27'),
(18, 9, 18, 1, 0, '2022-10-27', '2022-10-28'),
(18, 10, 18, 1, 0, '2022-10-28', '2022-10-29'),
(18, 11, 18, 1, 1, '2022-10-29', '2022-10-30'),
(21, 1, 13, 1, 0, '2022-10-11', '2022-10-11'),
(21, 2, 13, 1, 0, '2022-10-11', '2022-10-14'),
(21, 3, 13, 1, 0, '2022-10-14', '2022-10-19'),
(21, 4, 13, 1, 0, '2022-10-19', '2022-10-21'),
(21, 5, 13, 1, 0, '2022-10-21', '2022-10-25'),
(21, 6, 13, 1, 0, '2022-10-25', '2022-10-27');

-- 
-- Dumping data for table asignacion
--
INSERT INTO asignacion VALUES
(1, 14, '2022-10-01', 2),
(1, 15, '2022-10-01', 2),
(2, 5, '2022-10-01', 2),
(2, 18, '2022-10-01', 2),
(3, 10, '2022-10-01', 2),
(3, 17, '2022-10-01', 2),
(4, 19, '2022-10-01', 2),
(5, 2, '2022-10-10', 2),
(5, 8, '2022-10-01', 2),
(5, 13, '2022-10-01', 2),
(6, 2, '2022-10-10', 1),
(7, 5, '2022-10-01', 1),
(9, 1, '2022-10-11', 2),
(9, 10, '2022-10-10', 1),
(11, 17, '2022-10-10', 1),
(13, 8, '2022-10-09', 1),
(15, 13, '2022-10-09', 1),
(16, 19, '2022-10-10', 1),
(19, 18, '2022-10-09', 1),
(19, 22, '2022-10-04', 2),
(21, 15, '2022-10-09', 1),
(22, 1, '2022-10-11', 1),
(22, 22, '2022-10-10', 1),
(24, 14, '2022-10-09', 1);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;