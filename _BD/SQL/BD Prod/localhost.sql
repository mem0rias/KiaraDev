-- phpMyAdmin SQL Dump
-- version 5.1.4deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 22, 2022 at 01:19 AM
-- Server version: 10.6.11-MariaDB-0ubuntu0.22.10.1
-- PHP Version: 8.1.7-1ubuntu3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kiara`
--
CREATE DATABASE IF NOT EXISTS `kiara` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kiara`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarComercial` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(100), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` MEDIUMTEXT, IN `U_Video` MEDIUMTEXT, IN `U_Visibilidad` INT, IN `U_Oficinas` INT, IN `U_Cuartos` INT, IN `U_Banos` INT, IN `U_Niveles` INT, IN `U_Estacionamiento` INT)  BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   Uso = U_Uso,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE comercial  SET  Cuartos = U_Cuartos, Banos = U_Banos, Niveles = U_Niveles, Estacionamiento = U_Estacionamiento WHERE IdPropiedad = U_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarExp` (IN `N_Docs` INT, IN `U_IdUsuario` INT, IN `U_comentarios` VARCHAR(255), IN `U_estatus` VARCHAR(255), IN `U_TP` VARCHAR(255), IN `U_Tipo_Exp` INT)  BEGIN
  DECLARE Comms varchar(255) DEFAULT '';
  DECLARE est int DEFAULT 0;
  DECLARE tp int DEFAULT 0;
  DECLARE x int DEFAULT 0;
  SET x = 1;
  WHILE x <= N_Docs DO
    SET comms = (SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_comentarios, ',', x)), ',', -1));
    SET est = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_estatus, ',', x)), ',', -1)) AS int);
    SET tp = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_TP, ',', x)), ',', -1)) AS int);
    UPDATE exp_tipo_doc
    SET Comentarios = comms,
        Estatus = est
    WHERE IdCliente = U_IdUsuario
    AND Tipo_Doc = tp AND Tipo_Exp = U_Tipo_Exp;
    SET x = x + 1;
  END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarExpProp` (IN `N_Docs` INT, IN `U_Prop` INT, IN `U_comentarios` VARCHAR(255), IN `U_estatus` VARCHAR(255), IN `U_TP` VARCHAR(255), IN `U_Tipo_Exp` INT)  BEGIN
  DECLARE Comms varchar(255) DEFAULT '';
  DECLARE est int DEFAULT 0;
  DECLARE tp int DEFAULT 0;
  DECLARE x int DEFAULT 0;
  SET x = 1;
  WHILE x <= N_Docs DO
    SET comms = (SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_comentarios, ',', x)), ',', -1));
    SET est = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_estatus, ',', x)), ',', -1)) AS int);
    SET tp = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_TP, ',', x)), ',', -1)) AS int);
    UPDATE exp_tipo_doc_prop
    SET Comentarios = comms,
        Estatus = est
    WHERE IdPropiedad = U_Prop
    AND Tipo_Doc = tp AND Tipo_Exp = U_Tipo_Exp;
    SET x = x + 1;
  END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarRoles` (IN `U_Usermap` VARCHAR(255), IN `U_RolMap` VARCHAR(255), IN `N` INT)  BEGIN
  DECLARE umap int DEFAULT 0;
  DECLARE rmap int DEFAULT 0;
  DECLARE x int DEFAULT 0;
  SET x = 1;
  WHILE x <= N DO
    SET umap = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_Usermap, ',', x)), ',', -1)) AS int);
    SET rmap = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_RolMap, ',', x)), ',', -1)) AS int);
    UPDATE asignan
    SET idRol = rmap
    WHERE idUsuario = umap;
    SET x = x + 1;
  END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarTerreno` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Visibilidad` INT, IN `U_MedidaFrente` INT, IN `U_MedidaFondo` INT, IN `U_Agua` INT, IN `U_Luz` INT, IN `U_Drenaje` INT, IN `U_FormaTerreno` INT)  BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   Uso = U_Uso,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE terreno  SET MedidaFrente = U_MedidaFrente, MedidaFondo = U_MedidaFondo, Agua = U_Agua, Luz = U_Luz, Drenaje = U_Drenaje,
FormaTerreno = U_FormaTerreno WHERE IdPropiedad = U_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actulizarResidencial` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(100), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` MEDIUMTEXT, IN `U_Video` MEDIUMTEXT, IN `U_Visibilidad` INT, IN `U_Recamaras` INT(15), IN `U_Banos` INT(15), IN `U_Cocina` INT(15), IN `U_Niveles` INT(15), IN `U_Estacionamiento` INT(15), IN `U_Gas` INT(15))  BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,  MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE residencial  SET Recamaras = U_Recamaras, Banos = U_Banos, Cocina = U_Cocina, Niveles = U_Niveles, Estacionamiento = U_Estacionamiento, Gas = U_Gas WHERE IdPropiedad = U_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarComercial` (IN `U_Titulo` VARCHAR(512), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Cuartos` INT, IN `U_Banos` INT, IN `U_Niveles` INT, IN `U_Estacionamiento` INT, IN `U_IdAgente` INT)  BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO comercial (IdPropiedad,Cuartos,Banos,Niveles,Estacionamiento) 
VALUES (IdNueva,U_Cuartos,U_Banos,U_Niveles,U_Estacionamiento);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarResidencial` (IN `U_Titulo` VARCHAR(512), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` MEDIUMTEXT, IN `U_Video` MEDIUMTEXT, IN `U_Recamaras` INT(15), IN `U_Banos` INT(15), IN `U_Cocina` INT(15), IN `U_Niveles` INT(15), IN `U_Estacionamiento` INT(15), IN `U_Gas` INT(15), IN `U_IdAgente` INT)  BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO residencial (IdPropiedad,Recamaras,Banos,Cocina,Niveles,Estacionamiento,Gas) 
VALUES (IdNueva,U_Recamaras,U_Banos,U_Cocina,U_Niveles,U_Estacionamiento,U_Gas);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `agregarRol` ()  BEGIN
DECLARE IdUser INT;
SET IdUser = (SELECT MAX(IdUsuario) as IDC FROM usuario);
INSERT INTO `asignan`(`idUsuario`, `idRol`, `created_at`) VALUES (IdUser,1, CURRENT_TIMESTAMP());

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarTerreno` (IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_MedidaFrente` INT, IN `U_MedidaFondo` INT, IN `U_Agua` INT, IN `U_Luz` INT, IN `U_Drenaje` INT, IN `U_FormaTerreno` INT, IN `U_IdAgente` INT)  BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO terreno (IdPropiedad,MedidaFrente,MedidaFondo,Agua,Luz,Drenaje,FormaTerreno) 
VALUES (IdNueva,U_MedidaFrente,U_MedidaFondo,U_Agua,U_Luz,U_Drenaje,U_FormaTerreno);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AsignarProp` (IN `U_IdUsuario` INT, IN `U_IdPropiedad` INT, IN `U_FechaAsig` DATE, IN `U_IdRol` INT)  Insert into asignacion values(U_IdUsuario, U_IdPropiedad, U_FechaAsig, U_IdRol, 1)$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `borraImagenes` (IN `U_String` VARCHAR(4000), IN `N_Data` INT, IN `U_IdPropiedad` INT)  BEGIN
DECLARE imgId INT DEFAULT 0;
DECLARE x int DEFAULT 0;
SET x = 1;
WHILE x <= N_Data DO
    SET imgId = (SELECT CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_String,',', x)), ',', -1)) as INT));
    DELETE from Imagenes where IdImagen = imgId;
    SET x = x + 1;
  END WHILE;


CALL CheckHeader(U_IdPropiedad);
  

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarUsuario` (IN `U_IdUsuario` INT)  delete from usuario where IdUsuario = U_IdUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Borrar_Propiedad` (IN `U_IdPropiedad` INT)  delete from propiedades
where IdPropiedad = U_IdPropiedad$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `buscarPropiedadAsignada` (IN `U_IdUser` INT, IN `U_Query` VARCHAR(200))  (SELECT p.IdPropiedad, Descripcion, Imagenes, Titulo, Colonia, Estado, Municipio FROM asignacion a, propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = U_IdUser and (Titulo LIKE U_Query OR Colonia LIKE U_Query))$$

CREATE DEFINER=`kiaradeveloper`@`189.142.27.36` PROCEDURE `cancelarProceso` (IN `U_IdPropiedad` INT)  BEGIN
   UPDATE `asignacion` SET `VisibleProceso`=0 WHERE `IdPropiedad`=U_IdPropiedad;
   UPDATE `propiedades` SET Visibilidad = 1 where IdPropiedad = U_IdPropiedad;
   DELETE from cliente_pc_prop where IdPropiedad = U_IdPropiedad;
   DELETE from cliente_pr_prop where IdPropiedad = U_IdPropiedad;
   DELETE from asignacion where IdPropiedad = U_IdPropiedad and RolProp IS NOT NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CerrarTramite` (IN `U_IdPropiedad` INT)  update cliente_pc_prop set estatus = 1 where IdPropiedad = U_IdPropiedad$$

CREATE DEFINER=`kiaradeveloper`@`189.142.27.36` PROCEDURE `CheckHeader` (IN `U_IdPropiedad` INT)  BEGIN
  DECLARE headPath VARCHAR(512) default '';
  DECLARE newPath mediumtext default '';
  set headPath = (select Imagen from Imagenes where IdImagen = (select min(IdImagen) from Imagenes where  IdPropiedad = U_IdPropiedad));
  select headPath as 'newHead';
    

END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `crearSeguimientoCompra` (IN `U_idusuario` INT, IN `U_idpropiedad` INT)  INSERT INTO `cliente_pc_prop`(`IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES (U_idusuario,1,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,2,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,3,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,4,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,5,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,6,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,7,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,8,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,9,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,10,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,11,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00)$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `crearSeguimientoRenta` (IN `U_idusuario` INT, IN `U_idpropiedad` INT)  INSERT INTO `cliente_pr_prop`(`IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) 
VALUES (U_idusuario,1,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,2,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,3,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,4,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,5,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,6,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00)$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `get_exp_asig` (IN `U_ID_Asesor` INT)  SELECT a.IdUsuario, u.Nombre, u.PA, u.SA, u.Telefono, u.Email, a.IdPropiedad
FROM asignacion a, usuario u 
WHERE a.IdUsuario=u.IdUsuario AND a.IdPropiedad IN(SELECT a.IdPropiedad FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND a.IdUsuario = U_ID_Asesor) AND a.IdUsuario != U_ID_Asesor$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `get_propiedades_asignadas` (IN `ID_Asesor` INT)  SELECT a.IdPropiedad,p.Visibilidad, p.Descripcion, p.Imagenes, p.Titulo, p.Colonia, p.Estado, p.Municipio
-- COMPRADOR
,SUM(CASE WHEN a.RolProp = 21 THEN a.IdUsuario ELSE 0 END) AS Comprador_ID
,MAX(CASE WHEN a.RolProp = 21 THEN u.Nombre ELSE 0 END) AS Comprador_Nombre
,MAX(CASE WHEN a.RolProp = 21 THEN u.PA ELSE 0 END) AS Comprador_PA
,MAX(CASE WHEN a.RolProp = 21 THEN u.SA ELSE 0 END) AS Comprador_SA
,MAX(CASE WHEN a.RolProp = 21 THEN u.Email ELSE 0 END) AS Comprador_Email
,SUM(CASE WHEN a.RolProp = 21 THEN u.Telefono ELSE 0 END) AS Comprador_Tel
-- ARRENDATARIO
,SUM(CASE WHEN a.RolProp = 22 THEN a.IdUsuario ELSE 0 END) AS Arrendatario_ID
,MAX(CASE WHEN a.RolProp = 22 THEN u.Nombre ELSE 0 END) AS Arrendatario_Nombre
,MAX(CASE WHEN a.RolProp = 22 THEN u.PA ELSE 0 END) AS Arrendatario_PA
,MAX(CASE WHEN a.RolProp = 22 THEN u.SA ELSE 0 END) AS Arrendatario_SA
,MAX(CASE WHEN a.RolProp = 22 THEN u.Email ELSE 0 END) AS Arrendatario_Email
,SUM(CASE WHEN a.RolProp = 22 THEN u.Telefono ELSE 0 END) AS Arrendatario_Tel
-- VENDEDOR
,SUM(CASE WHEN a.RolProp = 23 THEN a.IdUsuario ELSE 0 END) AS Vendedor_ID
,MAX(CASE WHEN a.RolProp = 23 THEN u.Nombre ELSE 0 END) AS Vendedor_Nombre
,MAX(CASE WHEN a.RolProp = 23 THEN u.PA ELSE 0 END) AS Vendedor_PA
,MAX(CASE WHEN a.RolProp = 23 THEN u.SA ELSE 0 END) AS Vendedor_SA
,MAX(CASE WHEN a.RolProp = 23 THEN u.Email ELSE 0 END) AS Vendedor_Email
,SUM(CASE WHEN a.RolProp = 23 THEN u.Telefono ELSE 0 END) AS Vendedor_Tel
-- ARRENDADOR
,SUM(CASE WHEN a.RolProp = 24 THEN a.IdUsuario ELSE 0 END) AS Arrendador_ID
,MAX(CASE WHEN a.RolProp = 24 THEN u.Nombre ELSE 0 END) AS Arrendador_Nombre
,MAX(CASE WHEN a.RolProp = 24 THEN u.PA ELSE 0 END) AS Arrendador_PA
,MAX(CASE WHEN a.RolProp = 24 THEN u.SA ELSE 0 END) AS Arrendador_SA
,MAX(CASE WHEN a.RolProp = 24 THEN u.Email ELSE 0 END) AS Arrendador_Email
,SUM(CASE WHEN a.RolProp = 24 THEN u.Telefono ELSE 0 END) AS Arrendador_Tel
-- ADMIN
,MAX(CASE WHEN a.RolProp IS NULL THEN a.IdUsuario ELSE 0 END) AS Admin_ID
,MAX(CASE WHEN a.RolProp IS NULL THEN u.Nombre ELSE 0 END) AS Admin_Nombre
FROM  asignacion a, usuario u, propiedades p
WHERE a.IdUsuario = u.IdUsuario AND a.IdPropiedad = p.IdPropiedad AND a.IdPropiedad IN(SELECT a.IdPropiedad FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND a.IdUsuario = ID_Asesor)
GROUP BY a.IdPropiedad$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `IniciarRenta` (IN `U_Pasos` VARCHAR(255), IN `U_NPasos` INT, IN `U_Propietario` INT, IN `U_Cliente` INT, IN `U_Propiedad` INT, IN `U_CasadoP` INT, IN `U_CasadoC` INT)  BEGIN
    declare paso VARCHAR(255) DEFAULT '';
    DECLARE x int DEFAULT 0;
    set x = 1;
    while x <= U_NPasos DO
      set paso = (SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_Pasos,',',x)),',',-1));
      INSERT INTO cliente_pr_prop (IdUsuario, IdPaso, IdPropiedad, IdRol, Estatus, Fecha_Inicio) values (U_Propietario, paso, U_Propiedad, 0, 0, CURRENT_TIMESTAMP());
      set x = x+1;
    end WHILE;
    
    Insert into asignacion (IdUsuario, IdPropiedad, Fecha_asignacion, RolProp, VisibleProceso) values (U_Propietario, U_Propiedad, CURRENT_TIMESTAMP, 24,1);
    
    Insert into asignacion (IdUsuario, IdPropiedad, Fecha_asignacion, RolProp, VisibleProceso) values (U_Cliente, U_Propiedad, CURRENT_TIMESTAMP, 22,1);
    
    IF (select DISTINCT idRol from asignan where IdUsuario = U_Propietario) < 2 then
      update asignan set IdRol = 2, created_at = CURRENT_DATE  where idUsuario = U_Propietario;
    end if;

    IF (select DISTINCT idRol from asignan where IdUsuario = U_Cliente) < 2 then
      update asignan set IdRol = 2, created_at = CURRENT_DATE  where idUsuario = U_Cliente;
    end if;

    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Propietario, 0, 7);
    
     IF U_CasadoP = 1 then 
       Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Propietario, 0, 8);
     END IF;

    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Cliente, 0, 5);
    
    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Cliente, 0, 6);
  
    Replace into exp_tipo_doc_prop (IdPropiedad, Tipo_Doc, Tipo_Exp) values (U_Propiedad,0,1);
    
    UPDATE propiedades set Visibilidad = 0 where IdPropiedad = U_Propiedad;

 

    
    
END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `IniciarVenta` (IN `U_Pasos` VARCHAR(255), IN `U_NPasos` INT, IN `U_Propietario` INT, IN `U_Cliente` INT, IN `U_Propiedad` INT, IN `U_CasadoP` INT, IN `U_CasadoC` INT)  BEGIN
    declare paso VARCHAR(255) DEFAULT '';
    DECLARE x int DEFAULT 0;
    set x = 1;
    while x <= U_NPasos DO
      set paso = (SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_Pasos,',',x)),',',-1));
      INSERT INTO cliente_pc_prop (IdUsuario, IdPaso, IdPropiedad, IdRol, Estatus,Fecha_Inicio) values (U_Propietario, paso, U_Propiedad, 0, 0,CURRENT_DATE());
      set x = x+1;
    end WHILE;
    
    Insert into asignacion (IdUsuario, IdPropiedad, Fecha_asignacion, RolProp, VisibleProceso) values (U_Propietario, U_Propiedad, CURRENT_TIMESTAMP(), 23,1);
    
    Insert into asignacion (IdUsuario, IdPropiedad, Fecha_asignacion, RolProp, VisibleProceso) values (U_Cliente, U_Propiedad, CURRENT_TIMESTAMP(), 21,1);
    
    IF (select DISTINCT idRol from asignan where IdUsuario = U_Propietario) < 2 then
      update asignan set IdRol = 2, created_at = CURRENT_DATE  where idUsuario = U_Propietario;
    end if;

    IF (select DISTINCT idRol from asignan where IdUsuario = U_Cliente) < 2 then
      update asignan set IdRol = 2, created_at = CURRENT_DATE  where idUsuario = U_Cliente;
    end if;

    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Propietario, 0, 1);
    
    IF U_CasadoP = 1 then 
      Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Propietario, 0, 2);
    END IF;

    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Cliente, 0, 3);
    
    IF U_CasadoC = 1 then Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Cliente, 0, 4);

    END IF;
    
    UPDATE propiedades set Visibilidad = 0 where IdPropiedad = U_Propiedad;

    Replace into exp_tipo_doc_prop (IdPropiedad, Tipo_Doc, Tipo_Exp) values (U_Propiedad,0,1);
 

    
    
END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `subirImagen` (IN `U_String` VARCHAR(4000), IN `N_Data` INT)  BEGIN
DECLARE img varchar(255) DEFAULT '';
DECLARE IdNueva INT;
DECLARE x int DEFAULT 0;
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
SET x = 1;
WHILE x <= N_Data DO
    SET img = (SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_String,',', x)), ',', -1));
    INSERT Imagenes (IdPropiedad,Imagen)
    VALUES (IdNueva,img);
    SET x = x + 1;
  END WHILE;
END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `subirImagenEdit` (IN `U_String` VARCHAR(4000), IN `N_Data` INT, IN `U_IdPropiedad` INT)  BEGIN
DECLARE img varchar(255) DEFAULT '';
DECLARE IdNueva INT;
DECLARE x int DEFAULT 0;

SET x = 1;
WHILE x <= N_Data DO
    SET img = (SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_String,',', x)), ',', -1));
    INSERT Imagenes (IdPropiedad,Imagen)
    VALUES (U_IdPropiedad,img);
    SET x = x + 1;
  END WHILE;
END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `TestActRBAC` (IN `U_Usuario` INT)  IF (select DISTINCT idRol from asignan where IdUsuario = U_Usuario) < 2 then
      update asignan set IdRol = 2, created_at = CURRENT_DATE  where idUsuario = U_Usuario;
    end if$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `UpdateCompra` (IN `U_Estatus` INT, IN `U_id` INT, IN `U_idpropiedad` INT)  UPDATE `cliente_pc_prop` SET `Estatus`= U_Estatus, `Fecha_Fin`= CURRENT_DATE() where id = U_id AND IdPropiedad = U_idpropiedad$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `updateHeader` (IN `U_Head` VARCHAR(4000))  BEGIN 
DECLARE IdP INT;
SET IdP = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
UPDATE propiedades SET `Imagenes`= U_Head WHERE IdPropiedad = IdP;
END$$

CREATE DEFINER=`kiaradeveloper`@`localhost` PROCEDURE `UpdateRenta` (IN `U_Estatus` INT, IN `U_id` INT, IN `U_idpropiedad` INT)  UPDATE `cliente_pr_prop` SET `Estatus`= U_Estatus,  `Fecha_Fin`= CURRENT_DATE()  where id = U_id AND IdPropiedad = U_idpropiedad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UploadFiles` (IN `U_paths` VARCHAR(2048), IN `U_docList` VARCHAR(255), IN `U_IdUsuario` INT, IN `N_Docs` INT, IN `U_estatus` VARCHAR(255), IN `U_TipoExp` INT)  BEGIN
    declare paths VARCHAR(255) DEFAULT '';
    declare estatus VARCHAR(255) DEFAULT '';
    declare tp int DEFAULT 0;
    declare x int DEFAULT 0;
    set x = 1;
    while x <= N_Docs DO
    	set paths = (SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_paths,',',x)),',',-1));
      set estatus = (SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_estatus,',',x)),',',-1));
      set tp = CAST((SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_docList,',',x)),',',-1)) as INT);
      REPLACE INTO exp_tipo_doc(IdCliente, Tipo_Doc, Tipo_Exp, URL, Estatus, Comentarios) VALUES(U_IdUsuario, tp, U_TipoExp,paths,estatus,NULL);
      set x = x+1;
    end WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UploadFilesProp` (IN `U_paths` VARCHAR(2048), IN `U_docList` VARCHAR(255), IN `U_IdUsuario` INT, IN `N_Docs` INT, IN `U_estatus` VARCHAR(255), IN `U_TipoExp` INT)  BEGIN
    declare paths VARCHAR(255) DEFAULT '';
    declare estatus VARCHAR(255) DEFAULT '';
    declare tp int DEFAULT 0;
    declare x int DEFAULT 0;
    set x = 1;
    while x <= N_Docs DO
    	set paths = (SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_paths,',',x)),',',-1));
      set estatus = (SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_estatus,',',x)),',',-1));
      set tp = CAST((SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(U_docList,',',x)),',',-1)) as INT);
      REPLACE INTO exp_tipo_doc_prop(IdPropiedad, Tipo_Doc, Tipo_Exp, URL, Estatus, Comentarios) VALUES(U_IdUsuario, tp, U_TipoExp,paths,estatus,NULL);
      set x = x+1;
    end WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `asignacion`
--
-- Creation: Nov 27, 2022 at 08:32 PM
-- Last update: Dec 22, 2022 at 01:12 AM
--

CREATE TABLE `asignacion` (
  `IdUsuario` int(10) NOT NULL,
  `IdPropiedad` int(10) NOT NULL,
  `Fecha_asignacion` date DEFAULT NULL,
  `RolProp` int(10) UNSIGNED DEFAULT NULL,
  `VisibleProceso` int(1) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=682 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `asignacion`:
--   `IdUsuario`
--       `usuario` -> `IdUsuario`
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--

--
-- Dumping data for table `asignacion`
--

INSERT INTO `asignacion` (`IdUsuario`, `IdPropiedad`, `Fecha_asignacion`, `RolProp`, `VisibleProceso`) VALUES
(47, 131, NULL, NULL, NULL),
(47, 132, NULL, NULL, NULL),
(47, 133, NULL, NULL, NULL),
(47, 149, NULL, NULL, 0),
(47, 150, NULL, NULL, 0),
(47, 158, NULL, NULL, NULL),
(47, 159, NULL, NULL, 0),
(47, 160, NULL, NULL, 0),
(47, 161, NULL, NULL, NULL),
(47, 163, NULL, NULL, NULL),
(47, 164, NULL, NULL, 0),
(47, 165, NULL, NULL, NULL),
(52, 150, '2022-12-21', 21, 1),
(52, 164, '2022-12-21', 24, 1),
(53, 150, '2022-12-21', 23, 1),
(53, 164, '2022-12-21', 22, 1),
(71, 152, NULL, NULL, NULL),
(71, 153, '2022-12-20', 24, 1),
(72, 153, NULL, NULL, NULL),
(72, 155, NULL, NULL, NULL),
(73, 153, '2022-12-20', 22, 1),
(74, 154, NULL, NULL, NULL),
(75, 155, '2022-12-20', 24, 1),
(76, 155, '2022-12-20', 22, 1),
(77, 156, NULL, NULL, NULL),
(79, 156, '2022-12-20', 21, 1),
(80, 156, '2022-12-20', 23, 1),
(82, 166, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Asignados_completo`
-- (See below for the actual view)
--
CREATE TABLE `Asignados_completo` (
`id_user` int(10)
,`Nombre` varchar(255)
,`Primer_Apellido` varchar(255)
,`Segundo_Apellido` varchar(255)
,`email` varchar(255)
,`tel` varchar(255)
,`idPropiedad` int(10)
,`RolPropiedad` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `asignan`
--
-- Creation: Nov 29, 2022 at 08:45 PM
-- Last update: Dec 22, 2022 at 01:12 AM
--

CREATE TABLE `asignan` (
  `idUsuario` int(11) NOT NULL,
  `idRol` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- RELATIONSHIPS FOR TABLE `asignan`:
--   `idUsuario`
--       `usuario` -> `IdUsuario`
--   `idRol`
--       `roles` -> `idRol`
--

--
-- Dumping data for table `asignan`
--

INSERT INTO `asignan` (`idUsuario`, `idRol`, `created_at`) VALUES
(46, 4, '2022-12-01 04:05:52'),
(47, 4, '2022-11-29 20:46:03'),
(52, 2, '2022-11-29 20:47:04'),
(53, 2, '2022-11-29 20:47:11'),
(56, 4, '2022-11-29 20:52:55'),
(57, 2, '2022-12-19 00:00:00'),
(58, 2, '2022-12-01 00:00:00'),
(59, 1, '2022-12-01 00:00:00'),
(60, 1, '2022-11-30 03:07:43'),
(61, 2, '2022-12-01 00:00:00'),
(62, 2, '2022-12-01 00:00:00'),
(63, 1, '2022-11-30 03:31:58'),
(64, 1, '2022-11-30 03:38:51'),
(65, 4, '2022-12-01 01:35:53'),
(66, 1, '2022-12-01 22:08:57'),
(67, 2, '2022-12-02 00:00:00'),
(68, 3, '2022-12-08 02:30:54'),
(69, 3, '2022-12-08 17:08:01'),
(70, 3, '2022-12-08 19:29:09'),
(71, 2, '2022-12-13 21:46:11'),
(72, 3, '2022-12-20 00:17:07'),
(73, 2, '2022-12-20 00:41:29'),
(74, 3, '2022-12-20 00:50:42'),
(75, 2, '2022-12-20 02:02:25'),
(76, 2, '2022-12-20 02:04:28'),
(77, 3, '2022-12-20 02:45:37'),
(78, 1, '2022-12-20 02:46:34'),
(79, 2, '2022-12-20 02:53:25'),
(80, 2, '2022-12-20 02:54:21'),
(82, 3, '2022-12-21 18:27:40');

-- --------------------------------------------------------

--
-- Table structure for table `cliente_pc_prop`
--
-- Creation: Nov 21, 2022 at 10:44 AM
-- Last update: Dec 22, 2022 at 01:12 AM
--

CREATE TABLE `cliente_pc_prop` (
  `id` int(11) NOT NULL,
  `IdUsuario` int(10) NOT NULL,
  `IdPaso` int(10) NOT NULL,
  `IdPropiedad` int(10) NOT NULL,
  `IdRol` int(10) NOT NULL,
  `Estatus` int(10) DEFAULT NULL,
  `Fecha_Inicio` date DEFAULT NULL,
  `Fecha_Fin` date DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=356 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `cliente_pc_prop`:
--   `IdPaso`
--       `pasos_compra` -> `Paso`
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--   `IdUsuario`
--       `usuario` -> `IdUsuario`
--

--
-- Dumping data for table `cliente_pc_prop`
--

INSERT INTO `cliente_pc_prop` (`id`, `IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES
(241, 80, 1, 156, 0, 1, '2022-12-20', '2022-12-20'),
(242, 80, 2, 156, 0, 0, '2022-12-20', NULL),
(243, 80, 3, 156, 0, 0, '2022-12-20', NULL),
(244, 80, 4, 156, 0, 0, '2022-12-20', NULL),
(245, 80, 5, 156, 0, 0, '2022-12-20', NULL),
(246, 80, 6, 156, 0, 0, '2022-12-20', NULL),
(247, 80, 7, 156, 0, 0, '2022-12-20', NULL),
(248, 80, 8, 156, 0, 0, '2022-12-20', NULL),
(249, 80, 9, 156, 0, 0, '2022-12-20', NULL),
(250, 80, 10, 156, 0, 0, '2022-12-20', NULL),
(251, 80, 11, 156, 0, 0, '2022-12-20', NULL),
(263, 53, 1, 150, 0, 0, '2022-12-21', NULL),
(264, 53, 2, 150, 0, 1, '2022-12-21', '2022-12-21'),
(265, 53, 3, 150, 0, 0, '2022-12-21', NULL),
(266, 53, 4, 150, 0, 0, '2022-12-21', NULL),
(267, 53, 5, 150, 0, 0, '2022-12-21', NULL),
(268, 53, 6, 150, 0, 0, '2022-12-21', NULL),
(269, 53, 7, 150, 0, 0, '2022-12-21', NULL),
(270, 53, 8, 150, 0, 0, '2022-12-21', NULL),
(271, 53, 9, 150, 0, 0, '2022-12-21', NULL),
(272, 53, 10, 150, 0, 0, '2022-12-21', NULL),
(273, 53, 11, 150, 0, 0, '2022-12-21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cliente_pr_prop`
--
-- Creation: Nov 21, 2022 at 10:44 AM
-- Last update: Dec 21, 2022 at 05:06 PM
--

CREATE TABLE `cliente_pr_prop` (
  `id` int(11) NOT NULL,
  `IdUsuario` int(10) NOT NULL,
  `IdPaso` int(10) NOT NULL,
  `IdPropiedad` int(10) NOT NULL,
  `IdRol` int(10) DEFAULT NULL,
  `Estatus` int(10) DEFAULT NULL,
  `Fecha_Inicio` date DEFAULT NULL,
  `Fecha_Fin` date DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=585 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `cliente_pr_prop`:
--   `IdPaso`
--       `pasos_renta` -> `Paso`
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--   `IdUsuario`
--       `usuario` -> `IdUsuario`
--

--
-- Dumping data for table `cliente_pr_prop`
--

INSERT INTO `cliente_pr_prop` (`id`, `IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES
(59, 71, 1, 153, 0, 0, '2022-12-20', NULL),
(60, 71, 2, 153, 0, 0, '2022-12-20', NULL),
(61, 71, 3, 153, 0, 0, '2022-12-20', NULL),
(62, 71, 4, 153, 0, 0, '2022-12-20', NULL),
(63, 71, 5, 153, 0, 0, '2022-12-20', NULL),
(64, 71, 6, 153, 0, 0, '2022-12-20', NULL),
(65, 75, 1, 155, 0, 1, '2022-12-20', '2022-12-21'),
(66, 75, 2, 155, 0, 1, '2022-12-20', '2022-12-21'),
(67, 75, 3, 155, 0, 0, '2022-12-20', NULL),
(68, 75, 4, 155, 0, 0, '2022-12-20', NULL),
(69, 75, 5, 155, 0, 0, '2022-12-20', NULL),
(70, 75, 6, 155, 0, 0, '2022-12-20', NULL),
(136, 52, 1, 164, 0, 0, '2022-12-21', NULL),
(137, 52, 2, 164, 0, 0, '2022-12-21', NULL),
(138, 52, 3, 164, 0, 0, '2022-12-21', NULL),
(139, 52, 4, 164, 0, 0, '2022-12-21', NULL),
(140, 52, 5, 164, 0, 0, '2022-12-21', NULL),
(141, 52, 6, 164, 0, 0, '2022-12-21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comentarios`
--
-- Creation: Nov 21, 2022 at 10:29 PM
--

CREATE TABLE `comentarios` (
  `idComentario` int(255) NOT NULL,
  `idUsuario` int(10) NOT NULL,
  `contenido` varchar(1000) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `aprobado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `comentarios`:
--   `idUsuario`
--       `usuario` -> `IdUsuario`
--

--
-- Dumping data for table `comentarios`
--

INSERT INTO `comentarios` (`idComentario`, `idUsuario`, `contenido`, `fecha`, `aprobado`) VALUES
(67, 47, 'Excelente servicio', '2022-12-01 22:28:44', 1),
(68, 71, 'Nos ha encantado el servicio, hacer la compra de una casa por primera vez no es facil y KIARA en todo momento nos acompaño para hacernos mas facil y placentero el trabajo, estamos muy agradecidos', '2022-12-13 21:56:58', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comercial`
--
-- Creation: Nov 22, 2022 at 04:22 AM
-- Last update: Dec 21, 2022 at 09:11 PM
--

CREATE TABLE `comercial` (
  `IdPropiedad` int(10) NOT NULL,
  `Cuartos` int(10) DEFAULT NULL,
  `Banos` int(11) NOT NULL,
  `Niveles` int(10) DEFAULT NULL,
  `Estacionamiento` int(10) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `comercial`:
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--

--
-- Dumping data for table `comercial`
--

INSERT INTO `comercial` (`IdPropiedad`, `Cuartos`, `Banos`, `Niveles`, `Estacionamiento`) VALUES
(9, 3, 0, 2, 1),
(152, 0, 2, 1, 4),
(158, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `exp_tipo_doc`
--
-- Creation: Nov 21, 2022 at 10:44 AM
-- Last update: Dec 22, 2022 at 01:07 AM
--

CREATE TABLE `exp_tipo_doc` (
  `IdCliente` int(10) NOT NULL,
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL,
  `URL` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Estatus` int(10) DEFAULT NULL,
  `Comentarios` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `exp_tipo_doc`:
--   `IdCliente`
--       `usuario` -> `IdUsuario`
--   `Tipo_Doc`
--       `tipo_doc` -> `Tipo_Doc`
--   `Tipo_Exp`
--       `tipo_exp` -> `Tipo_Exp`
--

--
-- Dumping data for table `exp_tipo_doc`
--

INSERT INTO `exp_tipo_doc` (`IdCliente`, `Tipo_Doc`, `Tipo_Exp`, `URL`, `Estatus`, `Comentarios`) VALUES
(1, 0, 1, NULL, NULL, NULL),
(1, 0, 2, NULL, NULL, NULL),
(1, 0, 7, NULL, NULL, NULL),
(3, 0, 3, NULL, NULL, NULL),
(3, 0, 4, NULL, NULL, NULL),
(9, 1, 1, NULL, 1, NULL),
(10, 1, 3, NULL, 3, 'Mas vale que funcione :('),
(10, 2, 3, NULL, 1, 'ddd'),
(10, 3, 3, NULL, 0, ''),
(21, 1, 3, NULL, 1, NULL),
(21, 2, 3, NULL, 1, NULL),
(21, 3, 3, NULL, 1, NULL),
(21, 4, 3, NULL, 1, NULL),
(21, 6, 3, NULL, 1, NULL),
(46, 0, 1, NULL, NULL, NULL),
(46, 0, 2, NULL, NULL, NULL),
(46, 0, 3, NULL, NULL, NULL),
(46, 1, 1, 'Expedientes/46/5411122Transformada_Z_Formulas (1).pdf', 2, 'no es el documento actual'),
(46, 2, 2, 'Expedientes/46/17411122Dialnet-ElProblemaDeBasilea-7177416.pdf', 2, ''),
(48, 0, 1, NULL, NULL, NULL),
(48, 0, 3, NULL, NULL, NULL),
(48, 0, 5, NULL, NULL, NULL),
(48, 0, 6, NULL, NULL, NULL),
(48, 1, 3, 'Expedientes\\48\\34210122Avance 4.pdf', 0, 'No existe'),
(48, 2, 3, '', 0, NULL),
(48, 3, 3, '', 0, NULL),
(48, 4, 3, '', 0, NULL),
(48, 5, 3, '', 0, NULL),
(48, 6, 3, '', 0, NULL),
(49, 0, 1, NULL, NULL, NULL),
(49, 0, 2, NULL, NULL, NULL),
(49, 0, 3, NULL, NULL, NULL),
(49, 0, 4, NULL, NULL, NULL),
(49, 0, 7, NULL, NULL, NULL),
(49, 1, 1, 'Expedientes\\49\\5010122AproximacionPI_A01274191.pdf', 2, 'Se ve bien'),
(49, 2, 1, 'Expedientes\\49\\3210122E+amen Final_221121_213927.pdf', 1, ' ddd'),
(49, 3, 1, '', 0, NULL),
(49, 4, 1, '', 0, NULL),
(49, 5, 1, 'Expedientes\\49\\25210122AvanceExamen.pdf', 1, ' '),
(49, 6, 1, 'Expedientes\\49\\25210122E+amen Final_221121_213927.pdf', 1, ' '),
(49, 7, 1, 'Expedientes\\49\\40310122Pago_553009298.pdf', 1, ''),
(50, 0, 1, NULL, NULL, NULL),
(50, 0, 2, NULL, NULL, NULL),
(51, 0, 3, NULL, NULL, NULL),
(51, 0, 4, NULL, NULL, NULL),
(52, 0, 1, NULL, NULL, NULL),
(52, 0, 2, NULL, NULL, NULL),
(52, 0, 3, NULL, NULL, NULL),
(52, 0, 7, NULL, NULL, NULL),
(52, 0, 8, NULL, NULL, NULL),
(52, 1, 1, 'Expedientes/52/2321112216211122How to Pack for Algebra Winter School 2023.pdf', 1, NULL),
(52, 2, 1, 'Expedientes/52/13211122How to Pack for Algebra Winter School 2023.pdf', 1, NULL),
(52, 3, 1, 'Expedientes/52/23211122831012228310122kirk (4).pdf', 1, NULL),
(52, 4, 1, 'Expedientes/52/23211122831012258411122Transformada_Z_Formulas (2) (5).pdf', 1, NULL),
(52, 5, 1, 'Expedientes/52/23211122831012258411122Transformada_Z_Formulas (2) (2).pdf', 1, NULL),
(52, 6, 1, 'Expedientes/52/23211122HW2_A01274191-1.pdf', 1, NULL),
(52, 7, 1, 'Expedientes/52/23211122CC_HomeWork_1.pdf', 1, NULL),
(53, 0, 1, NULL, NULL, NULL),
(53, 0, 3, NULL, NULL, NULL),
(53, 0, 4, NULL, NULL, NULL),
(53, 0, 5, NULL, NULL, NULL),
(53, 0, 6, NULL, NULL, NULL),
(54, 0, 3, NULL, NULL, NULL),
(54, 0, 4, NULL, NULL, NULL),
(55, 0, 1, NULL, NULL, NULL),
(55, 0, 7, NULL, NULL, NULL),
(57, 0, 1, NULL, NULL, NULL),
(57, 0, 7, NULL, NULL, NULL),
(58, 0, 1, NULL, NULL, NULL),
(58, 0, 2, NULL, NULL, NULL),
(58, 0, 3, NULL, NULL, NULL),
(58, 0, 4, NULL, NULL, NULL),
(58, 0, 5, NULL, NULL, NULL),
(58, 0, 6, NULL, NULL, NULL),
(59, 0, 1, NULL, NULL, NULL),
(59, 0, 3, NULL, NULL, NULL),
(59, 0, 4, NULL, NULL, NULL),
(61, 0, 3, NULL, NULL, NULL),
(61, 1, 3, 'Expedientes/61/5741112230310122sanders.pdf', 2, 'Perfecto'),
(61, 2, 3, '', 0, NULL),
(62, 0, 3, NULL, NULL, NULL),
(62, 0, 4, NULL, NULL, NULL),
(67, 0, 3, NULL, NULL, NULL),
(67, 0, 5, NULL, NULL, NULL),
(67, 0, 6, NULL, NULL, NULL),
(67, 1, 3, 'Expedientes/67/34411122RFC.pdf', 1, NULL),
(67, 2, 3, 'Expedientes/67/48411122RFC.pdf', 1, NULL),
(67, 3, 3, 'Expedientes/67/48411122RFC.pdf', 1, NULL),
(67, 4, 3, 'Expedientes/67/48411122RFC.pdf', 1, NULL),
(67, 5, 3, 'Expedientes/67/58411122RFC.pdf', 1, NULL),
(67, 6, 3, 'Expedientes/67/58411122RFC.pdf', 1, NULL),
(71, 0, 5, NULL, NULL, NULL),
(71, 0, 6, NULL, NULL, NULL),
(71, 0, 7, NULL, NULL, NULL),
(72, 0, 7, NULL, NULL, NULL),
(73, 0, 5, NULL, NULL, NULL),
(73, 0, 6, NULL, NULL, NULL),
(74, 0, 3, NULL, NULL, NULL),
(74, 0, 4, NULL, NULL, NULL),
(75, 0, 7, NULL, NULL, NULL),
(75, 1, 7, 'Expedientes/75/3211122Ine prooietario.pdf', 2, ''),
(75, 2, 7, 'Expedientes/75/3211122recibo de luz.pdf', 3, 'se requiere un comprobante mas actual'),
(76, 0, 5, NULL, NULL, NULL),
(76, 0, 6, NULL, NULL, NULL),
(76, 1, 5, 'Expedientes/76/55211122INE.pdf', 1, NULL),
(76, 1, 6, 'Expedientes/76/2211122Tarjeta de identificaciÃ³n03-11-22 6.07.11.pdf', 1, NULL),
(76, 2, 5, 'Expedientes/76/55211122Comprobante de domicilio.pdf', 1, NULL),
(76, 2, 6, 'Expedientes/76/2211122OCT 1.pdf', 1, NULL),
(76, 8, 5, 'Expedientes/76/55211122IMB510327A78_NOM_NOMINA53939_3838.pdf', 1, NULL),
(76, 8, 6, 'Expedientes/76/2211122Nov 2.pdf', 1, NULL),
(76, 9, 5, 'Expedientes/76/55211122CamScanner 12-04-2022 14.52.pdf', 1, NULL),
(79, 0, 3, NULL, NULL, NULL),
(79, 1, 3, 'Expedientes/79/45211122operac 3 ine comprador .pdf', 1, NULL),
(79, 2, 3, 'Expedientes/79/45211122operac 3 comprador comprob domic.pdf', 1, NULL),
(79, 3, 3, 'Expedientes/79/45211122operac 3 comprador curp.pdf', 1, NULL),
(79, 4, 3, 'Expedientes/79/45211122operac 3 comprador acta nacim.pdf', 1, NULL),
(79, 5, 3, 'Expedientes/79/45211122operac 3 comprador acta matrimonio.pdf', 1, NULL),
(79, 6, 3, 'Expedientes/79/45211122operac 3 comprador constanc situaci fiscal.pdf', 1, NULL),
(80, 0, 1, NULL, NULL, NULL),
(80, 1, 1, 'Expedientes/80/33211122operac 3 ine propietario .pdf', 1, NULL),
(80, 2, 1, 'Expedientes/80/33211122operac 3 propietario comprob domic.pdf', 1, NULL),
(80, 3, 1, 'Expedientes/80/33211122operac 3 propietario curp.pdf', 1, NULL),
(80, 4, 1, 'Expedientes/80/33211122operac 3 propietario acta nacim.pdf', 1, NULL),
(80, 5, 1, 'Expedientes/80/33211122operac 3 propietario acta matrimonio.pdf', 1, NULL),
(80, 6, 1, 'Expedientes/80/33211122operac 3 propietario constanc situac fiscal.pdf', 1, NULL),
(80, 7, 1, 'Expedientes/80/33211122operac 3 propietario edo cta bancario.pdf', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exp_tipo_doc_prop`
--
-- Creation: Dec 01, 2022 at 12:55 AM
-- Last update: Dec 21, 2022 at 09:10 PM
--

CREATE TABLE `exp_tipo_doc_prop` (
  `IdPropiedad` int(10) NOT NULL,
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL,
  `URL` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Estatus` int(10) DEFAULT NULL,
  `Rol_Exp` int(10) DEFAULT NULL,
  `Comentarios` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `exp_tipo_doc_prop`:
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--   `Tipo_Doc`
--       `tipo_doc_prop` -> `Tipo_Doc`
--   `Tipo_Exp`
--       `tipo_exp_prop` -> `Tipo_Exp`
--

--
-- Dumping data for table `exp_tipo_doc_prop`
--

INSERT INTO `exp_tipo_doc_prop` (`IdPropiedad`, `Tipo_Doc`, `Tipo_Exp`, `URL`, `Estatus`, `Rol_Exp`, `Comentarios`) VALUES
(159, 0, 1, NULL, NULL, NULL, NULL),
(160, 0, 1, NULL, NULL, NULL, NULL),
(164, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Imagenes`
--
-- Creation: Nov 30, 2022 at 09:57 AM
-- Last update: Dec 21, 2022 at 09:11 PM
--

CREATE TABLE `Imagenes` (
  `IdImagen` int(11) NOT NULL,
  `Imagen` varchar(4096) DEFAULT NULL,
  `IdPropiedad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `Imagenes`:
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--

--
-- Dumping data for table `Imagenes`
--

INSERT INTO `Imagenes` (`IdImagen`, `Imagen`, `IdPropiedad`) VALUES
(116, 'public\\uploads\\3751112210207822.jpg', 131),
(117, 'public\\uploads\\2951112210207822.jpg', 132),
(118, 'public\\uploads\\731112210207822.jpg', 133),
(206, 'public/uploads/1611112210207822.jpg', 149),
(207, 'public/uploads/16111122Kiara-V4.drawio.png', 149),
(208, 'public/uploads/16111122gray_scale.png', 149),
(209, 'public/uploads/16111122Front Panel.JPG', 149),
(211, 'public/uploads/36111122Kiara-V4.drawio.png', 149),
(234, 'public/uploads/3911112200 portada4.JPG', 150),
(235, 'public/uploads/391111222.JPG', 150),
(236, 'public/uploads/391111223.JPG', 150),
(237, 'public/uploads/391111224b.JPG', 150),
(238, 'public/uploads/391111224c.JPG', 150),
(239, 'public/uploads/391111225.JPG', 150),
(240, 'public/uploads/391111226.JPG', 150),
(241, 'public/uploads/391111226b.JPG', 150),
(242, 'public/uploads/391111227.JPG', 150),
(243, 'public/uploads/391111228.JPG', 150),
(244, 'public/uploads/391111229.JPG', 150),
(245, 'public/uploads/3911112210.JPG', 150),
(246, 'public/uploads/3911112211.JPG', 150),
(247, 'public/uploads/3911112212.JPG', 150),
(248, 'public/uploads/3911112213.JPG', 150),
(249, 'public/uploads/3911112214.JPG', 150),
(250, 'public/uploads/3911112215.JPG', 150),
(251, 'public/uploads/3911112215b.JPG', 150),
(252, 'public/uploads/3911112215c.JPG', 150),
(253, 'public/uploads/3911112216.JPG', 150),
(254, 'public/uploads/3911112217.JPG', 150),
(255, 'public/uploads/3911112218.JPG', 150),
(278, 'public/uploads/221112200 portada.png', 152),
(279, 'public/uploads/2211122Captura de pantalla 2022-12-15 a la(s) 22.35.56.png', 152),
(280, 'public/uploads/2211122Captura de pantalla 2022-12-15 a la(s) 22.47.06.png', 152),
(281, 'public/uploads/2211122Captura de pantalla 2022-12-15 a la(s) 22.49.26.png', 152),
(282, 'public/uploads/2211122Captura de pantalla 2022-12-15 a la(s) 22.49.46.png', 152),
(283, 'public/uploads/2211122Captura de pantalla 2022-12-15 a la(s) 22.49.59.png', 152),
(284, 'public/uploads/2211122Captura de pantalla 2022-12-15 a la(s) 22.50.06.png', 152),
(285, 'public/uploads/2721112200.JPG', 153),
(286, 'public/uploads/2721112201.JPG', 153),
(287, 'public/uploads/2721112202.JPG', 153),
(288, 'public/uploads/2721112203.JPG', 153),
(289, 'public/uploads/2721112204.JPG', 153),
(290, 'public/uploads/2721112205 recam1.JPG', 153),
(291, 'public/uploads/2721112206 recam2.JPG', 153),
(292, 'public/uploads/2721112207 recam3.JPG', 153),
(293, 'public/uploads/27211122estacionam.JPG', 153),
(294, 'public/uploads/192111221 Fachada.jpg', 154),
(295, 'public/uploads/192111223 Sala.jpg', 154),
(296, 'public/uploads/192111224 Sala.jpg', 154),
(297, 'public/uploads/192111225 Estancia.jpg', 154),
(298, 'public/uploads/192111226 Cocina.jpg', 154),
(299, 'public/uploads/192111227 Cocina.jpg', 154),
(300, 'public/uploads/192111228 Sala.jpg', 154),
(301, 'public/uploads/192111229 JardÃ­n.jpg', 154),
(302, 'public/uploads/1921112210 Sala TV.jpg', 154),
(303, 'public/uploads/1921112211 BaÃ±o Completo.jpg', 154),
(304, 'public/uploads/1921112212 Vista Rec.jpg', 154),
(305, 'public/uploads/1921112213 BaÃ±o Completo.jpg', 154),
(306, 'public/uploads/1921112214 RecÃ¡mara.jpg', 154),
(307, 'public/uploads/1921112215 BaÃ±o Completo.jpg', 154),
(308, 'public/uploads/1921112216 Lavabo.jpg', 154),
(309, 'public/uploads/1921112217 Detalle BaÃ±o.jpg', 154),
(310, 'public/uploads/1921112219 Acabado.jpg', 154),
(311, 'public/uploads/1921112220 Escalera Iluminada.jpg', 154),
(312, 'public/uploads/1921112221 Acabado.jpg', 154),
(313, 'public/uploads/1921112222 Roof Garden.jpg', 154),
(314, 'public/uploads/1921112223 Roof Garden.jpg', 154),
(315, 'public/uploads/3221112202 sala3.jpg', 155),
(316, 'public/uploads/3221112203 chimenea2.jpg', 155),
(317, 'public/uploads/3221112205 comedor.jpg', 155),
(318, 'public/uploads/3221112206 cocina vista desde comedor.jpg', 155),
(319, 'public/uploads/3221112207 comedor.png', 155),
(320, 'public/uploads/3221112208 sala vista desde recamara.jpg', 155),
(321, 'public/uploads/3221112209brec.jpeg', 155),
(322, 'public/uploads/3221112209rec2.jpeg', 155),
(323, 'public/uploads/32211122010b pasillo baÃ±o princ.jpeg', 155),
(324, 'public/uploads/32211122010c vestidor.jpeg', 155),
(325, 'public/uploads/32211122011 baÃ±o2.jpeg', 155),
(326, 'public/uploads/32211122012a.jpeg', 155),
(327, 'public/uploads/32211122012b.jpeg', 155),
(328, 'public/uploads/32211122013 lavadora.png', 155),
(329, 'public/uploads/3221112214.jpeg', 155),
(330, 'public/uploads/3221112215.jpeg', 155),
(331, 'public/uploads/3221112216.jpeg', 155),
(332, 'public/uploads/5021112201.jpg', 156),
(333, 'public/uploads/5021112202.jpg', 156),
(334, 'public/uploads/5021112203.jpg', 156),
(335, 'public/uploads/5021112204.jpg', 156),
(336, 'public/uploads/5021112205.jpg', 156),
(337, 'public/uploads/5021112206.jpg', 156),
(338, 'public/uploads/5021112207.jpg', 156),
(339, 'public/uploads/5021112208.jpg', 156),
(340, 'public/uploads/5021112209.jpg', 156),
(341, 'public/uploads/5021112210.jpg', 156),
(342, 'public/uploads/5021112211.jpg', 156),
(343, 'public/uploads/5021112212.jpg', 156),
(344, 'public/uploads/50211122Fachada.JPG', 156),
(351, 'public/uploads/2031112200.jpg', 158),
(352, 'public/uploads/203111221.JPG', 158),
(353, 'public/uploads/203111222.JPG', 158),
(354, 'public/uploads/203111223.JPG', 158),
(355, 'public/uploads/203111224.JPG', 158),
(356, 'public/uploads/203111225.JPG', 158),
(357, 'public/uploads/5031112210207822.jpg', 159),
(358, 'public/uploads/50311122Kiara-V4.drawio.png', 159),
(359, 'public/uploads/50311122gray_scale.png', 159),
(360, 'public/uploads/50311122Front Panel.JPG', 159),
(361, 'public/uploads/50311122RomanTester.png', 159),
(362, 'public/uploads/1031112210207822.jpg', 160),
(363, 'public/uploads/10311122Kiara-V4.drawio.png', 160),
(364, 'public/uploads/10311122gray_scale.png', 160),
(365, 'public/uploads/10311122Front Panel.JPG', 160),
(366, 'public/uploads/10311122RomanTester.png', 160),
(367, 'public/uploads/5431112210207822.jpg', 161),
(368, 'public/uploads/54311122Kiara-V4.drawio.png', 161),
(369, 'public/uploads/54311122gray_scale.png', 161),
(370, 'public/uploads/54311122Front Panel.JPG', 161),
(371, 'public/uploads/54311122RomanTester.png', 161),
(377, 'public/uploads/11311122casa.PNG', 163),
(378, 'public/uploads/1531112210207822.jpg', 164),
(379, 'public/uploads/15311122Kiara-V4.drawio.png', 164),
(380, 'public/uploads/15311122gray_scale.png', 164),
(381, 'public/uploads/15311122Front Panel.JPG', 164),
(382, 'public/uploads/15311122RomanTester.png', 164),
(383, 'public/uploads/5311122Terreno1.PNG', 165),
(384, 'public/uploads/5311122Terreno2.PNG', 165),
(385, 'public/uploads/5311122Terreno3.PNG', 165),
(386, 'public/uploads/5311122Terreno4.PNG', 165),
(387, 'public/uploads/5311122Terreno5.PNG', 165),
(388, 'public/uploads/453111221.1.jpg', 166),
(389, 'public/uploads/453111221.jpg', 166),
(390, 'public/uploads/453111222.jpg', 166),
(391, 'public/uploads/453111223.jpg', 166),
(392, 'public/uploads/453111225.1.jpg', 166),
(393, 'public/uploads/453111225.jpg', 166),
(394, 'public/uploads/453111226.jpg', 166),
(395, 'public/uploads/453111227.jpg', 166),
(396, 'public/uploads/453111228.1.jpg', 166),
(397, 'public/uploads/453111228.jpg', 166),
(398, 'public/uploads/453111229.jpg', 166),
(399, 'public/uploads/4531112210.jpg', 166),
(400, 'public/uploads/4531112211.1.jpg', 166),
(401, 'public/uploads/4531112211.jpg', 166),
(402, 'public/uploads/4531112212.jpg', 166),
(403, 'public/uploads/4531112213.jpg', 166),
(404, 'public/uploads/4531112214.jpg', 166),
(405, 'public/uploads/4531112215.jpg', 166),
(406, 'public/uploads/4531112217.1.jpg', 166),
(407, 'public/uploads/4531112217.jpg', 166),
(408, 'public/uploads/4531112218.jpg', 166),
(409, 'public/uploads/4531112219.jpg', 166),
(410, 'public/uploads/4531112220.jpg', 166),
(411, 'public/uploads/4531112221.jpg', 166),
(412, 'public/uploads/4531112222.jpg', 166),
(413, 'public/uploads/4531112223.jpg', 166),
(414, 'public/uploads/4531112224.jpg', 166),
(415, 'public/uploads/4531112225.jpg', 166),
(416, 'public/uploads/4531112226.jpg', 166),
(417, 'public/uploads/4531112227.jpg', 166);

-- --------------------------------------------------------

--
-- Table structure for table `otorgan`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `otorgan` (
  `idRol` int(11) NOT NULL,
  `idPrivilegio` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- RELATIONSHIPS FOR TABLE `otorgan`:
--   `idRol`
--       `roles` -> `idRol`
--   `idPrivilegio`
--       `privilegios` -> `idPrivilegio`
--

--
-- Dumping data for table `otorgan`
--

INSERT INTO `otorgan` (`idRol`, `idPrivilegio`, `created_at`) VALUES
(1, 1, '2022-11-21 05:27:48'),
(2, 1, '2022-11-21 05:27:48'),
(2, 5, '2022-11-21 05:27:48'),
(2, 7, '2022-11-21 05:27:48'),
(2, 9, '2022-11-21 05:27:48'),
(2, 1, '2022-11-21 05:27:48'),
(3, 3, '2022-11-21 05:27:48'),
(3, 4, '2022-11-21 05:27:48'),
(3, 5, '2022-11-21 05:27:48'),
(3, 6, '2022-11-21 05:27:48'),
(3, 7, '2022-11-21 05:27:48'),
(3, 8, '2022-11-21 05:27:48'),
(3, 10, '2022-11-21 05:27:48'),
(3, 11, '2022-11-21 05:27:48'),
(4, 3, '2022-11-21 05:27:48'),
(4, 4, '2022-11-21 05:27:48'),
(4, 5, '2022-11-21 05:27:48'),
(4, 6, '2022-11-21 05:27:48'),
(4, 7, '2022-11-21 05:27:48'),
(4, 8, '2022-11-21 05:27:48'),
(4, 10, '2022-11-21 05:27:48'),
(4, 11, '2022-11-21 05:27:48'),
(4, 12, '2022-11-21 05:27:48'),
(4, 13, '2022-11-26 00:00:00'),
(4, 14, '2022-11-30 21:07:34'),
(3, 14, '2022-11-30 21:05:58'),
(3, 15, '2022-11-30 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pasos_compra`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `pasos_compra` (
  `Paso` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pasos_compra`:
--

--
-- Dumping data for table `pasos_compra`
--

INSERT INTO `pasos_compra` (`Paso`, `Descripcion`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `pasos_renta`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `pasos_renta` (
  `Paso` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `pasos_renta`:
--

--
-- Dumping data for table `pasos_renta`
--

INSERT INTO `pasos_renta` (`Paso`, `Descripcion`) VALUES
(1, 'Recepcion de apartado'),
(2, 'Recepcion de documentacion'),
(3, 'Inicio de tramite de póliza jurídica'),
(4, 'Resultado de investigación de póliza jurídica'),
(5, 'Revisión de contrato'),
(6, 'Firma de contrato ');

-- --------------------------------------------------------

--
-- Table structure for table `privilegios`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `privilegios` (
  `idPrivilegio` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- RELATIONSHIPS FOR TABLE `privilegios`:
--

--
-- Dumping data for table `privilegios`
--

INSERT INTO `privilegios` (`idPrivilegio`, `nombre`, `created_at`) VALUES
(1, 'panel_usuario', '2022-11-19 05:04:28'),
(3, 'registrar_propiedad', '2022-11-19 05:04:48'),
(4, 'editar_propiedad', '2022-11-19 05:04:48'),
(5, 'consultar_seguimiento', '2022-11-19 05:04:48'),
(6, 'editar_seguimiento', '2022-11-19 05:04:48'),
(7, 'consultar_expediente', '2022-11-19 05:04:48'),
(8, 'revisar_expediente', '2022-11-19 05:04:48'),
(9, 'crear_comentario', '2022-11-19 05:04:48'),
(10, 'eliminar_comentario', '2022-11-19 05:04:48'),
(11, 'consultar_comentario', '2022-11-19 05:04:48'),
(12, 'aprobar_comentario', '2022-11-19 05:04:48'),
(13, 'panel_admin', '2022-11-26 22:29:36'),
(14, 'cancelar_proc', '2022-11-30 00:00:00'),
(15, 'panel_agente', '2022-11-30 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `propiedades`
--
-- Creation: Dec 20, 2022 at 12:00 AM
-- Last update: Dec 22, 2022 at 01:12 AM
--

CREATE TABLE `propiedades` (
  `IdPropiedad` int(10) NOT NULL,
  `Titulo` varchar(100) DEFAULT NULL,
  `Descripcion` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Precio` text DEFAULT NULL,
  `Estado` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Municipio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Colonia` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Calle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CP` int(10) DEFAULT NULL,
  `Uso` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `MTerreno` int(11) NOT NULL,
  `MConstruccion` int(11) NOT NULL,
  `TipoTransaccion` varchar(255) DEFAULT NULL,
  `TipoPropiedad` int(11) NOT NULL,
  `Imagenes` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Video` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Visibilidad` int(11) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=744 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `propiedades`:
--

--
-- Dumping data for table `propiedades`
--

INSERT INTO `propiedades` (`IdPropiedad`, `Titulo`, `Descripcion`, `Precio`, `Estado`, `Municipio`, `Colonia`, `Calle`, `CP`, `Uso`, `MTerreno`, `MConstruccion`, `TipoTransaccion`, `TipoPropiedad`, `Imagenes`, `Video`, `Visibilidad`) VALUES
(9, NULL, 'Local en venta', '13750000', 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(16, NULL, 'Departamento en venta', '22430000', 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 0, 0, '1', 0, '', '', 0),
(21, NULL, 'Casa bonita', '5000', 'Queretaro', 'Queretaro', 'Epigmenio Gonzalez', 'Las rosas 23', 42064, 'Residencial', 0, 0, '1', 0, NULL, NULL, 0),
(61, 'Los Robles Casa', 'El concepto urbano de LOS ROBLES III  cuenta con una arquitectura definida a partir de una normatividad que evitará fracturas en el tejido urbano. De esta manera se logra la homogeneidad visual del desarrollo y se protege la inversión patrimonial de nuestros clientes, entregando bienestar y valorización.\r\n\r\n​Cada uno de nuestros desarrollos ofrecen calidad en diseño, materiales e ingeniería, teniendo la confianza de que su inversión está en manos de una de las desarrolladoras con mayor experiencia, servicio, garantía y respaldo.\r\n\r\n​Nuestras casas te brindan una experiencia previsible, tranquila y placentera, con ambientes totalmente integrados de paisaje y vivienda, siendo espacios para toda la familia y ofreciéndole a nuestros clientes un nivel de rentabilidad más alto al promedio.              ', '3400000', 'Queretaro', 'Corregidora', 'Los Robles', 'Cto Azaleas #1200 ', 12212, '1', 212121, 2121, '1', 1, 'https://c5e6g5f8.rocketcdn.me/wp-content/uploads/2017/06/Tren-de-Casas-los-Robles-Queretaro.jpg.webp', 'https://c5e6g5f8.rocketcdn.me/wp-content/uploads/2017/06/Tren-de-Casas-los-Robles-Queretaro.jpg.webp', 1),
(63, 'Casa en Pueblo Nuevo', 'Casa con Alberca y bar, recién remodelada, cerca del centro de Querétaro!!!..Vigilancia las 24 hrs., casa a desniveles, cada recámara con vestidor y baño, 3.5 baños en total, cuarto de servicio, sala de TV, estudio, jardín, estacionamiento para 2 autos. Con baño en y bar en la zona de la alberca..Precios sujetos a cambio sin previo aviso.               ', '1200000', 'Querétaro', 'Corregidora', 'Nuevo Pueblo', 'José Clemente Orozco 5F', 545432, '1', 200, 200, '1', 1, 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 1),
(64, 'Casa en Pueblo Nuevo', 'residencial.Recamaras       ', '232323', 'Querétaro', 'Corregidora', 'Nuevo Pueblo', 'José Clemente Orozco 5F', 321312, '1', 123, 3123, '1', 1, 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 1),
(65, 'Casa en Pueblo Nuevo', '312321321', '2000000', 'Querétaro', 'Corregidora', 'Nuevo Pueblo', 'José Clemente Orozco 5F', 32131, '1', 213, 312, '1', 1, 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 1),
(66, 'Casa en Pueblo Nuevo', 'saSAsaS    ', '212121', 'Querétaro', 'Corregidora', 'Nuevo Pueblo', 'José Clemente Orozco 5F', 2121, '1', 211, 212, '1', 1, 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 1),
(67, 'Casa en Pueblo Nuevo', 'saSAsaS    ', '212121', 'Querétaro', 'Corregidora', 'Nuevo Pueblo', 'José Clemente Orozco 5F', 2121, '1', 211, 212, '1', 1, 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 'https://img10.naventcdn.com/avisos/resize/18/00/54/03/53/81/1200x1200/260732393.jpg', 1),
(131, 'Hermoso departamento en Pirules I', 'Departamento centrico en la zona Tec, a 5 minutos caminando del campus', '10000', 'Queretaro', 'Queretaro', 'Epigmenio Gonzalez', 'Prol Tecnologico', 76159, '1', 100, 110, '2', 1, '.', '.', 1),
(132, 'Hermosa Casa por zona Tec', 'Casa en Pirules 2', '10000', 'Queretaro', 'Queretaro', 'Epigmenio Gonzales', 'Prol Tecnologico', 79159, '1', 100, 100, '2', 1, '2951112210207822.jpg', '1', 1),
(133, 'Departamento en ADAMANT 323', 'DEPARTAMENTO DE PRUEBA', '20000', 'Queretaro', 'Queretaro', 'Balcones Coloniales', 'Av. Pase de la Reforma', 76140, '1', 120, 120, '1', 1, '.', '.', 1),
(149, 'Departamento en Quinta Bugambilias', '123', '10000', 'Queretaro', 'Queretaro', 'San Pablo', 'Valle del Sol 155', 76159, '1', 123, 1323, '2', 1, '1611112210207822.jpg', '111', 1),
(150, 'Renta de Casa en Milenio III', 'Preciosa casa en Milenio III', '15000', 'Queretaro', 'Queretaro', 'Milenio III', 'Sendero del Silencio 39', 76060, '1', 100, 200, '1', 1, '3911112200 portada4.JPG', '1', 0),
(152, 'Rento bodega 350m2 por Conin en El Marques Qro', 'Rento bodega ubicada por Conin\r\n\r\n450m2 de terreno\r\n350 m2 de bodega\r\n100 m2 de estacionamiento\r\n20 m2 de oficina\r\n\r\nMedidas 11.25 m ancho x 31.3 m. de fondo, altura en medio de 7.40 m. y lateriales 4.90 m.\r\n\r\nLa bodega cuenta con 2 medios baños, estacionamiento para 4 autos, reja exterior, cisterna 10,000 lts. Y bomba hidroneumatica\r\n\r\nUBICACIÓN\r\nEsta bodega cuenta con ubicación estratégica para las principales carreteras federales. Esta ubicada a 800 m. de monumento a Conin Autopista No. 57\r\n\r\nRAPIDOS ACCESOS\r\n•	Carretera No. 57\r\n•	Salida a Ciudad de México\r\n•	Libramiento Chichimequillas\r\n•	Carretera a Celaya, Gto.\r\n\r\nAGENDA TU CITA YA!\r\n', '24500', 'Queretaro', 'El Marques', 'Cumbres de Conin', 'Nezahualcoyotl', 76246, '2', 450, 350, '2', 5, '221112200 portada.png', 'https://youtu.be/jO6OdWKZ_Ak', 1),
(153, 'Rento casa duplex en planta baja en la Pradera Qro', 'Rento casa duplex en PLANTA BAJA en Col. La Pradera, Queretaro\r\n\r\nConsta de sala comedor, 3 recamaras, 1 baño, cocina, area de lavado y estacionamiento para 1-2 autos\r\n\r\nSuperficie aprox 90m2\r\n\r\nAgenda tu cita y apartala!\r\n\r\nUBICACIÓN:\r\nUbicada en calle semicerrada, casi frente a Fracc. El Refugio, Sobre el Fray Junipero Serra\r\nA 6 mins del HOSPITAL REGIONAL NO. 2\r\nA 7 mins del Fracc. Zakia\r\nA 10 mins. Centro Comercial Paseo Queretaro\r\nA 13 mins. Plaza Boulevares\r\nA 14 mins. De Fracc. Zibata\r\nA 14 mins. De Juriquilla\r\nA 20 mins. Centro Historico Queretaro\r\n', '5900', 'Queretaro', 'El Marques', 'La Pradera', 'Gacela Pte 3', 76269, '1', 90, 90, '2', 1, '2721112200.JPG', 'https://youtube.com/shorts/jHM1D4jRgpw', 0),
(154, 'Casa en Venta Punta Zirconia en Corregidora ', 'En Corregidora el Municipio con mayor plusvalía de Querétaro y sobre el Libramiento Sur Poniente!\r\n\r\nVenta de Casa en Punta Zirconia\r\n144 M2 terreno\r\n225 M2 construcción\r\n\r\nAcabados de primera\r\n* Cocina equipada con cubierta de granito\r\n* 4 recámaras, 3 baños y medio\r\n* Sala de TV \r\n* Sala - Comedor\r\n* Patio trasero con jardín\r\n* Estacionamiento para 2 autos\r\n* Área de Lavado\r\n* Roofgarden\r\n\r\nA sólo 7.9kms de Paseo Constituyentes\r\nA sólo 3.9kms de Santa Bárbara, El Pueblito.\r\nCon Acceso a Bdo Quintana circulando sobre el Libramiento Sur Poniente.\r\n', '3350000', 'Querétaro', 'Corregidora', 'Punta Esmeralda', 'Punta Zirconia 01', 76906, '1', 144, 225, '1', 1, '192111221 Fachada.jpg', 'ND', 1),
(155, 'Rento departamento amueblado en Privalia Queretaro', 'Renta Departamento Amueblado en PRIVALIA Ambienta, sobre Anillo vial Fray Junipero Serra, zona de mayor crecimiento en Querétaro\r\n\r\nCUENTA YA CON INTERNET DE ALTA VELOCIDAD (costo por separado)\r\n\r\nUbicado en PLANTA BAJA\r\nTiene iluminación inteligente, los focos prenden en diferentes colores y variaciones\r\nCalentador de chimenea instalado\r\nMinisplit\r\n2 baños completos\r\nIluminación de led en muebles\r\nRecamara principal con cama matrimonial, baño completo y vestidor\r\nRecamara secundaria con doble cama\r\nSala de TV con escritorio\r\nSala comedor con proyector\r\nCocina integral\r\nArea de lavado techada\r\nChapa electrónica con llave virtual\r\nBocinas con bluetooth\r\nPersianas en todo el departamento\r\nClosets y canceles de baño\r\nTOTALMENTE EQUIPADA CON UTENSILIOS DE COMEDOR Y COCINA\r\n\r\n\r\nAMENIDADES Interiores: Juegos para niños y palapa para eventos.\r\nAMENIDADES del Fraccionamiento: Cancha de basquet y futball, area para perros, ciclopista por todo el fraccionamiento y cancha de tennis padel\r\n\r\nUBICACIÓN:\r\n-	A 11 mins. De la Universidad Anahuac\r\n-	A 12 mins de Plaza Comercial Antea\r\n-	A 12 mins. Centro Comercial Paseo Queretaro\r\n-	A 17 mins. De Hospital Star Medica\r\n-	A 15 mins. De Juriquilla\r\n-	A 18 mins. De Plaza Comercial Boulevares y Plaza del Parque\r\n-	A 24 mins. Del Centro de la Ciudad\r\n', '9900', 'Queretaro', 'Queretaro', 'Privalia', 'Anillo Vial Fray Junipero', 76147, '1', 84, 84, '2', 2, '3221112202 sala3.jpg', 'https://youtu.be/jO6OdWKZ_Ak', 0),
(156, 'Vendo casa en El Cerrito Colorado, Queretaro', 'En venta casa de 3 habitaciones en la Colonia Cerrito Colorado.\r\n\r\nA corta distancia de Avenida de la Luz.\r\n\r\nConsta de 3 Recámaras.\r\n1 Baño Completo\r\nSala\r\nComedor\r\nEspacio para Cocina con Tarja y Fregadero\r\nPatio de Lavado con Calentador y Lavadero\r\nSe encuentra LIBRE DE GRAVAMEN.\r\n\r\nTe ayudamos a tramitar tu crédito bancario o de infonavit\r\n', '900000', 'Queretaro', 'Queretaro', 'Cerrito Colorado', 'Mazatecos', 76116, '1', 90, 80, '1', 1, '5021112201.jpg', 'https://youtu.be/MtI-j47XkGg', 0),
(158, 'Bodega San Pedrito Peñuelas', 'Bodega en Pedrito peñuelas con uso de suelo de 300m2', '15000', 'Querétaro', 'Querétaro', 'San Pedrito Peñuelas', 'Tornero No.102', 76148, '2', 400, 300, '2', 5, '2031112200.jpg', '', 1),
(159, 'Casa en Quinta bugambilias', '213231', '23321', '231231', '23231', '2213', '321321', 213321, '1', 123321, 231231, '2', 2, '5031112210207822.jpg', '213', 1),
(160, 'Casa de prueba mancomunados', '1223', '231', '231', '321', '231', '231', 231, '1', 32, 321, '1', 1, '1031112210207822.jpg', '231', 1),
(161, 'Casa prueba mancomunados pero solo propietario', '123', '231', '321', '321', '321', '213', 231, '1', 231, 312, '1', 1, '5431112210207822.jpg', '231', 1),
(163, 'Hermosa casa en Callejón de los Mendoza', 'Hermosa casa en venta en Callejón de los Mendoza, cuenta con 200m2 de terreno con 150m2 de construcción', '1590000', 'Querétaro', 'Querétaro', 'Hacienda San Gabriel', 'Callejón de los Mendoza', 76900, '1', 200, 149, '1', 1, '11311122casa.PNG', '', 1),
(164, 'Casa ejemplo venta/renta', '232423', '342', '432', '342', '342', '342', 342, '1', 342, 432, '3', 1, '1531112210207822.jpg', '43', 0),
(165, 'Terreno en calle Dátil ', 'Terreno en calle Datil', '800000', 'Querétaro', 'Corregidora', 'Real del Bosque', 'Dátil ', 76922, '1', 400, 300, '1', 1, '5311122Terreno1.PNG', '', 1),
(166, 'Rento departamento AMUEBLADO en Valle de Juriquilla, Queretaro', 'DEPARTAMENTO de 120m2 IDEAL PARA EJECUTIVO \r\nZona de Juriquillla , Cerca de Universidad  ,UVM,Y OTRAS , A UN LADO DE ANTEA\r\nCerca de Parque Industrial Queretaro 2000\r\n\r\n Cuenta con 2 Recmaras , La principal con baño y vesttidor\r\n2 Baños completos, Sala , Comedor , Cocina Integral totalmente equipada\r\nRefrigerador ,lavavajillas,microondas,licuadota, cafetera,tostador etc.\r\nArea de lavado, Bodega,\r\nEstacionamiento techado para 2 autos \r\nEstacionamiento para visitas,\r\n\r\nEntre susu amenidades cuenta con.\r\nAlberca , area de juegos para niños hermosa terraza .\r\n\r\nUbicado ;\r\nA: 2min de Antea\r\n     2min de Carretera Queretrao San Luis Potosi\r\n\r\n  Fray Junipero Serra\r\n  Libramiento Sur Poniente entre otras ,\r\n', '19500', 'Queretaro', 'Queretaro', 'Valle de Juriquilla', 'Av. Santa Rosa No. 5101', 76230, '1', 120, 120, '2', 2, '453111221.1.jpg', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `requisitos`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `requisitos` (
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=496 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `requisitos`:
--   `Tipo_Doc`
--       `tipo_doc` -> `Tipo_Doc`
--   `Tipo_Exp`
--       `tipo_exp` -> `Tipo_Exp`
--

--
-- Dumping data for table `requisitos`
--

INSERT INTO `requisitos` (`Tipo_Doc`, `Tipo_Exp`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `requisitos_prop`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `requisitos_prop` (
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `requisitos_prop`:
--   `Tipo_Doc`
--       `tipo_doc_prop` -> `Tipo_Doc`
--   `Tipo_Exp`
--       `tipo_exp_prop` -> `Tipo_Exp`
--

--
-- Dumping data for table `requisitos_prop`
--

INSERT INTO `requisitos_prop` (`Tipo_Doc`, `Tipo_Exp`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `residencial`
--
-- Creation: Nov 21, 2022 at 10:44 AM
-- Last update: Dec 21, 2022 at 09:11 PM
--

CREATE TABLE `residencial` (
  `IdPropiedad` int(10) NOT NULL,
  `Recamaras` int(10) DEFAULT NULL,
  `Banos` int(10) DEFAULT NULL,
  `Cocina` int(10) DEFAULT NULL,
  `Niveles` int(10) DEFAULT NULL,
  `Estacionamiento` int(10) DEFAULT NULL,
  `Gas` int(10) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1365 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `residencial`:
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--

--
-- Dumping data for table `residencial`
--

INSERT INTO `residencial` (`IdPropiedad`, `Recamaras`, `Banos`, `Cocina`, `Niveles`, `Estacionamiento`, `Gas`) VALUES
(16, 4, 5, 1, 2, 2, 1),
(21, 3, 2, 4, 4, 4, 1),
(61, 3, 2, 1, 3, 2, 1),
(63, 0, 0, 0, 0, 0, 0),
(64, 3, 4, 1, 3, 3, 1),
(65, 2, 3, 1, 3, 3, 1),
(66, 2, 4, 1, 5, 3, 1),
(67, 2, 4, 1, 5, 3, 1),
(131, 1, 1, 1, 1, 1, 1),
(132, 1, 1, 1, 1, 1, 1),
(133, 1, 1, 1, 1, 1, 1),
(149, 1, 1, 1, 1, 1, 1),
(150, 1, 1, 1, 1, 1, 1),
(153, 3, 1, 1, 1, 1, 1),
(154, 4, 3, 1, 3, 2, 1),
(155, 2, 2, 1, 1, 1, 1),
(156, 3, 1, 1, 1, 1, 1),
(159, 1, 1, 1, 1, 1, 1),
(160, 1, 1, 1, 1, 1, 1),
(161, 1, 1, 1, 1, 1, 1),
(163, 3, 3, 1, 2, 2, 1),
(164, 1, 1, 1, 1, 1, 1),
(165, 1, 1, 1, 1, 1, 1),
(166, 2, 2, 1, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- RELATIONSHIPS FOR TABLE `roles`:
--

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`idRol`, `nombre`, `created_at`) VALUES
(1, 'usuario', '2022-11-19 05:05:26'),
(2, 'cliente', '2022-11-19 05:05:26'),
(3, 'agente', '2022-11-19 05:05:46'),
(4, 'admin', '2022-11-19 05:05:46');

-- --------------------------------------------------------

--
-- Table structure for table `terreno`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `terreno` (
  `IdPropiedad` int(10) NOT NULL,
  `MedidaFrente` int(10) DEFAULT NULL,
  `MedidaFondo` int(10) DEFAULT NULL,
  `Agua` int(10) DEFAULT NULL,
  `Luz` int(10) DEFAULT NULL,
  `Drenaje` int(10) DEFAULT NULL,
  `FormaTerreno` int(255) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=5461 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `terreno`:
--   `IdPropiedad`
--       `propiedades` -> `IdPropiedad`
--

-- --------------------------------------------------------

--
-- Table structure for table `tipo_doc`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `tipo_doc` (
  `Tipo_Doc` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `tipo_doc`:
--

--
-- Dumping data for table `tipo_doc`
--

INSERT INTO `tipo_doc` (`Tipo_Doc`, `Descripcion`) VALUES
(0, 'Referencia para creacion de archivos'),
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

-- --------------------------------------------------------

--
-- Table structure for table `tipo_doc_prop`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `tipo_doc_prop` (
  `Tipo_Doc` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `tipo_doc_prop`:
--

--
-- Dumping data for table `tipo_doc_prop`
--

INSERT INTO `tipo_doc_prop` (`Tipo_Doc`, `Descripcion`) VALUES
(0, 'Referencia de Expediente'),
(1, 'Escrituras\r\n'),
(2, 'CFDI'),
(3, 'Constancia de inscripcion al registro publico de las escrituras'),
(4, 'Planos arquitectonicos de la propiedad'),
(5, 'Predial pagago'),
(6, 'Constancia de numero oficial'),
(7, 'Terminacion de obra'),
(8, 'Ultimo recibo de luz'),
(9, 'Ultimo recibo de agua'),
(10, 'Carta de no adeudo de mantenimiento y cuotas');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_exp`
--
-- Creation: Nov 21, 2022 at 10:44 AM
-- Last update: Dec 21, 2022 at 06:30 AM
--

CREATE TABLE `tipo_exp` (
  `Tipo_Exp` int(10) NOT NULL,
  `Descripion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `tipo_exp`:
--

--
-- Dumping data for table `tipo_exp`
--

INSERT INTO `tipo_exp` (`Tipo_Exp`, `Descripion`) VALUES
(1, 'Expediente Propietario'),
(2, 'Expediente Copropietario Venta'),
(3, 'Expediente Comprador\r\n'),
(4, 'Expediente Copropietario Compra'),
(5, 'Expediente Solicitante Arrendamiento'),
(6, 'Expediente Obligado Solidario Arrendamiento'),
(7, 'Expediente Propietario del inmueble a arrendar'),
(8, 'Expediente Copropietario del inmueble a arrendar');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_exp_prop`
--
-- Creation: Nov 21, 2022 at 10:44 AM
--

CREATE TABLE `tipo_exp_prop` (
  `Tipo_Exp` int(10) NOT NULL,
  `Descripion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `tipo_exp_prop`:
--

--
-- Dumping data for table `tipo_exp_prop`
--

INSERT INTO `tipo_exp_prop` (`Tipo_Exp`, `Descripion`) VALUES
(1, 'Expediente Propiedad');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--
-- Creation: Nov 29, 2022 at 05:56 PM
-- Last update: Dec 22, 2022 at 12:38 AM
--

CREATE TABLE `usuario` (
  `IdUsuario` int(10) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `IdRol` int(10) DEFAULT NULL,
  `Nombre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PA` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SA` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Eciv` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ocupacion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Telefono` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CURP` varchar(18) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=682 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `usuario`:
--

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Email`, `IdRol`, `Nombre`, `PA`, `SA`, `Eciv`, `ocupacion`, `Telefono`, `password`, `CURP`) VALUES
(1, 'Luis.Solis@hotmail.com', 1, 'Luis', 'Solis', 'Gracia', 'Soltero', 'Licenciado', '728172173', NULL, ''),
(2, 'Guillermo.De Soto@hotmail.com', 1, 'Guillermo', 'De Soto', 'Garcia', 'Soltero', 'Licenciado', '728172174', NULL, ''),
(3, 'Fidel.Torres@hotmail.com', 1, 'Fidel', 'Torres', 'Garza', 'Soltero', 'Licenciado', '728172175', NULL, ''),
(4, 'David.Landa@hotmail.com', 2, 'David', 'Landa', 'Pelaes', 'Soltero', 'Licenciado', '728172176', NULL, ''),
(5, 'Michelle.Soto@hotmail.com', 2, 'Michelle', 'Soto', 'Virgolinni', 'Soltero', 'Licenciado', '728172177', NULL, ''),
(6, 'Hugo.Ramos@hotmail.com', 1, 'Hugo', 'Ramos', 'Palomino', 'Soltero', 'Licenciado', '728172178', NULL, ''),
(7, 'Armando.Vazquez@hotmail.com', 1, 'Armando', 'Vazquez', 'Nava', 'Soltero', 'Licenciado', '728172179', NULL, ''),
(8, 'Juan.Perez@hotmail.com', 1, 'Juan', 'Perez', 'Utrera', 'Soltero', 'Licenciado', '728172180', NULL, ''),
(9, 'Erick.Chavez@hotmail.com', 1, 'Erick', 'Chavez', 'Ponce', 'Casado', 'Licenciado', '728172181', NULL, ''),
(10, 'Andrea.Castillo@hotmail.com', 1, 'Andrea', 'Castillo', 'Schwarzenegger', 'Soltero', 'Estudiante ', '728172182', NULL, ''),
(11, 'Gerardo.Esparza@hotmail.com', 1, 'Gerardo', 'Esparza', 'Peregrino', 'Soltero', 'Estudiante ', '728172183', NULL, ''),
(12, 'Enrique.Enriquez@hotmail.com', 1, 'Enrique', 'Enriquez', 'Gutierrez', 'Soltero', 'Estudiante ', '728172184', NULL, ''),
(13, 'Juan Luis.Flores@hotmail.com', 1, 'Juan Luis', 'Flores', 'Peck', 'Soltero', 'Estudiante ', '728172185', NULL, ''),
(14, 'Nicolas.Palos@hotmail.com', 1, 'Nicolas', 'Palos', 'de La torre', 'Soltero', 'Estudiante ', '728172186', NULL, ''),
(15, 'Fernando.Atocha@hotmail.com', 1, 'Fernando', 'Atocha', 'Hernandez', 'Soltero', 'Estudiante ', '728172187', NULL, ''),
(16, 'Patricio.Olmo@hotmail.com', 1, 'Patricio', 'Olmo', 'Solis', 'Soltero', 'Estudiante ', '728172188', NULL, ''),
(17, 'Antonio.Cordoba@hotmail.com', 1, 'Antonio', 'Cordoba', 'Cordoba', 'Soltero', 'Estudiante ', '728172189', NULL, ''),
(18, 'Luperdo.Fajardo@hotmail.com', 1, 'Luperdo', 'Fajardo', 'Leon', 'Soltero', 'Estudiante ', '728172190', NULL, ''),
(19, 'Javier.Ochoa@hotmail.com', 1, 'Javier', 'Ochoa', 'Nuñez', 'Soltero', 'Estudiante ', '728172191', NULL, ''),
(21, 'mm.gracia@frenesifloral.mx', 1, 'Mariamiguel', 'Gracia', 'Perez', 'Soltero', 'Estudiante', '7714206969', NULL, ''),
(22, 'memof2000@hotmail.com', 1, 'Guillermo Fidel', 'Navarro', 'Vega', 'Soltero', 'Estudiante', '7717486945', 'ffff', ''),
(24, 'Daniel.Cordova@hotmail.com', 1, 'Daniel', 'Cordova', 'Perez', 'Soltero', 'Licenciado', '728172172', NULL, ''),
(46, 'a01274191@tec.mx', 0, 'Guillermo Fidel', 'Navarro', 'Vega', 'Soltero', 'Full Stack Dev', '7714206969', '$2a$12$ciSro/W6TN0iL77Hz5ZRVufQFg/QXaYvvpo1NvtlIzaLc8nub.CIW', ''),
(47, 'blanca@kiara.mx', 1, 'Daniel', 'Vega', 'Córdova Bermúdez', 'Soltero', 'Licenciada', '+525529397179', '$2a$12$BH1ErnW/SIAycThplc.4JOWPvyrJMIV7QOwHawYEgZnqGde61aMdu', 'COLMO'),
(48, 'JP@hotmail.com', 0, 'Juansssas', 'Torrijossasa', 'Perezssa', 'Soltero', 'memoramassasa', '+527717486945', '$2a$12$YjkEY8LSKZ.LWOG9OA7j0.5..jIhqX9xAf/QIFBt/DQNEgkXua/ZW', ''),
(49, 'pedro@hotmail.com', 0, 'Pedro', 'Najera', 'Perez', 'Soltero', 'Profesor', '+524424440909', '$2a$12$8pWcuqz9/FVlGcayF9NmGeAeVrdlAtG0vg5ycJn6fpP2zfkRVM3Za', ''),
(50, 'daniel.bermudez@hotmail.com', 0, 'Daniel', 'Cordova', 'Bermudez', 'Casado', 'Contiboi', '+525529397179', '$2a$12$OTp6ARds7cjEQrlzfP.7bOqaU1hGpFna8DpekUPCGy8yjMMHVPPLG', NULL),
(51, 'andychpsm@gmail.com', 0, 'Andrea', 'Castillo', 'Bermudez', 'Casado', 'Maeta', '+525529397179', '$2a$12$RSsztt4IiqSmzVV7Qj/2BebQKxZ6anpgT4NFGpGNgsNcuIp0u6rE6', NULL),
(52, 'rcortese@hotmail.com', 0, 'Ricardo', 'Perez', 'Cortes', 'Casado', 'Profesor', '+527717486945', '$2a$12$.LkyWlx2whF0iDuqBhxAuekQ42xK8fe5DxGviP7Ew0eMkRkanuhwS', NULL),
(53, 'lalo@daw.com', 0, 'Lalo', 'Juarez', 'Perez', 'Soltero', 'Profesor', '+527771222222', '$2a$12$SgDBpI6bouedTVkqGhVp2eyIb7AlmOZiIGIN6835YMd/QGS417KUu', NULL),
(54, 'andrea@gmail.com', 0, 'Andrea', 'Castillo', 'Aguilera', 'Soltero', 'Maeta', '+525529397179', '$2a$12$jtE4pzVlP0Ix.hZwCyEpnukVxOOtd0.1HRgXEU506ZLRgBDzP8oai', NULL),
(55, 'daniel.cordova@gmail.com', 0, 'Daniel', 'Cordova', 'Bermudez', 'Casado', 'contiboi', '+525529397179', '$2a$12$RR2c4bXDhwM46yhuYrbYZOZbTWn5v9CjY6bSu0WSN3sKvW9QZmd.C', NULL),
(56, 'andty@gmail.com', 0, 'Andrea', 'Bermudez', 'Aguilera', 'Soltero', 'DD', '+523232323232', '$2a$12$00vVr/4GmVsqxp8LTWAfk.cILV5T6NQzRRyv.RrYQJZJyXQW2I6iu', NULL),
(57, 'LaRosaliaPerez@atenas.mx', 0, 'Rosalia', 'Perez', 'Bravo', 'Soltero', 'Licenciada', '+524421234567', '$2a$12$stkdbOuLoPXhcnC/77FtduBBThzRt417QLJkjHmHkXOjDjveFv2fu', NULL),
(58, 'romancalderon@atenas.mx', 0, 'Hector Roman', 'Calderon', 'Cibrian', 'Soltero', 'licenciado', '+524421234567', '$2a$12$i/5wMyLzqou6sk1C5Npcf.pPJkkmm4ZjOw3z1sBzPtxNmmtThS2AS', NULL),
(59, 'josegarcia@atenas.mx', 0, 'José Antonio', 'García', 'Martínez', 'Soltero', 'Licenciado', '+524421234568', '$2a$12$Vj5SMf9SZe4FvXYaOhN2qeuiiEn0SMaOjLzrAjV5NtnGR2XrhIam.', NULL),
(60, 'hugotrujillo@atenas.mx', 0, 'Hugo Alexis', 'Trujillo', 'Sánchez', 'Soltero', 'licenciado', '+524421234567', '$2a$12$J0I9K5gAU0AJKF2Eb.qZE.37HcgjDMViMT7XKRDGLdbV7cppajzq2', NULL),
(61, 'Fernandovera@atenas.mx', 0, 'Fernando ', 'Vera', 'Alvarez', 'Casado', 'licenciado', '+524421234567', '$2a$12$ck9Q8hOUmuaUR7oCSgasoO/lhd9mbmJUpCouq.qeEvm2bsVJ7SDEW', NULL),
(62, 'marcozavala@atenas.mx', 0, 'Marco Antonio', 'Zavala', 'Orlanzzini', 'Soltero', 'licenciado', '+524421234567', '$2a$12$I6BvDciCGzWVJ8YDAdswvOOILICcsu1Kmu2dQS8jpJ48k11cQtuK2', NULL),
(63, 'silvianavarro@atenas.mx', 0, 'Silvia Paola', 'Navarro', 'Rojas', 'Casado', 'licenciado', '+524421234567', '$2a$12$Nj2unLSPfDrLgv0DF42aPuACgfeG9psWcG935b9eJh6iVILFuqC/i', NULL),
(64, 'IngridTobon@atenas.mx', 0, 'Ingrid Roxana', 'Tobon', 'Osornio', 'Soltero', 'licenciada', '+524421234567', '$2a$12$zcYqKeEPLMqPnae3BL4WQeh6lHrScglpvabaSxxjkbx6E8INd9b8a', NULL),
(65, 'virginia.kiarainmuebles@gmail.com', 0, 'Virginia ', 'Baza', 'Herrera', 'Soltero', 'Comerciante', '+524427967322', '$2a$12$raUiIC1uCuMGBOTEa4MyHuohzYtjg/MaYEfwHv1Ko.fXA1yk4069e', NULL),
(66, 'dan@kiara.mx', 0, 'Daniel', 'Cordovba', 'Bermudez', 'Soltero', 'Estudiante', '+525529397179', '$2a$12$yRlC6LtgQ9Pdlttwl4ua9.p0x48IU49RxWaKvlmX0/skRw422rJUG', ''),
(67, 'michi@kiara.mx', 0, 'Michi', 'Ramos', 'Soto', 'Casado', 'Contiman', '+523213213123', '$2a$12$bjCkZEJs9fJ2/O2FgR1sC.W6v1Uo0wL3oVhZ8JtqB5DG4v0dmVKhW', ''),
(68, 'esther.kiarainmuebles@gmail.com', 2, 'esther', 'Gutierrez', 'Mtz', 'Casado', 'asesor', '+524426037195', '$2a$12$4BWYCgeohxYvb5jzfGdpHuMk5bsmQHvWnYMnTxfEYDH4IYYIgx13q', NULL),
(69, 'tere.kiarainmuebles@gmail.com', 2, 'Teresa', 'Atilano', 'Villanueva', 'Soltero', 'Asesor inmobiliario', '+524426328759', '$2a$12$CDFfhv8vVLYjXIraB0/UgOSC995Vcjy9ntsNrs1bWiaUNjj/WC6NW', NULL),
(70, 'pilar.kiarainmuebles@gmail.com', 2, 'MARIA DEL PILAR ', 'COTO', 'CASAL', 'Soltero', 'Asesor bienes raices', '+524426698027', '$2a$12$jQ1FBWT1V9QqR1IWGcP75.lHIcH/K84gFj.ZzDmKNptwdMcq.SY6i', NULL),
(71, 'vivybh@icloud.com', 2, 'CARMEN', 'Ramirez', 'Lopez', 'Soltero', 'maestra', '+524423846104', '$2a$12$uCiIlJhR1VG3fn7KohFdL.9Mg76ysXpYE.faMBTkyOr.sRP.yKRZW', 'null'),
(72, 'vivybh@yahoo.com', 0, 'Vivy ', 'Prueba', '2', 'Soltero', 'comerciante', '+524423863232', '$2a$12$AZsOeYScnUUPfD.BJEqhg.oX8GvN85wgcKtCfrM6fZJuPn2BupOui', NULL),
(73, 'alfredo.kiarainmuebles@gmail.com', 0, 'MARTHA', 'GABRIELA', 'Sainz', 'Soltero', 'empleada', '+524423846104', '$2a$12$odPzXjGYz5QTcCmhDFkgh.O/TUP.hDEfQd/p4AmgzdfHFjbnpcut6', NULL),
(74, 'karla.kiarainmuebles@gmail.com', 0, 'Karla ', 'Yzunza', 'Rugarcia', 'Soltero', 'Asesor Inmobiliario', '+524423217554', '$2a$12$9IIcjrGDT9UY.4NwxzYIdOXUx.b/J64x/eS59.8eoPFl6l1LPU3UK', NULL),
(75, 'baza.urbannus@gmail.com', 0, 'Edgardo', 'Varela', 'Ruiz', 'Casado', 'Empleado', '+524423846104', '$2a$12$bpqhvM2duGYmOBEJKyH5Q.D98HWoK3sb4MUlzmp64StUm4ujtZAgi', NULL),
(76, 'bienesraicesurbannus@gmail.com', 0, 'Bethsabe', 'Lopez', 'Lopez', 'Soltero', 'Empleada', '+524423846104', '$2a$12$K5Qgu/zYLbTelLIWL7FTi.k69BD1OxtP32weHtpJ.H5vaKMSbL3uS', NULL),
(77, 'carmen.kiarainmuebles@gmail.com', 0, 'AURORA', 'BELTRAN', 'NUÑEZ', 'Soltero', 'vendedora', '+524423846104', '$2a$12$0fzhrxEC/nOkM9NE7v592u68aiEhJXmOd5MVSF38KABgysOQ19Zfi', NULL),
(78, 'castaneda.urbannus@gmail.com', 0, 'ELIZABETH', 'MENDOZA', 'BAZA', 'Soltero', 'comerciante', '+524423846104', '$2a$12$mviBKKT1lRmRcYm/l57dvOF/60ZEdSWUzbf1QqyP71DQ79SDrYe9y', NULL),
(79, 'comerciounidep@gmail.com', 0, 'ERICKA', 'HERNANDEZ', 'LOPEZ', 'Casado', 'empleada', '+524423846104', '$2a$12$9qDOpBSZsYEuvhPgwHAj3OqGmXqKUh2QypT08QO311Qbj/cWP2sx2', NULL),
(80, 'contacto.sognaleyra@gmail.com', 0, 'ROCIO', 'JIMENEZ', 'SOLIS', 'Casado', 'empleado', '+524423846104', '$2a$12$hfMDCptQ1nQ8n6x04WO1gu1SzJHgqwbhFJlu0608G/GHvkKh9vfWa', NULL),
(82, 'direccion.kiarainmuebles@gmail.com', 0, 'Rosa', 'Baza', 'H', 'Soltero', 'empleada', '+524423863232', '$2a$12$fLp2I5uRe2GZkmG2iqBbC.FppexxpD5QzkgGCNxjbYT/0IrlZK.vu', NULL);

-- --------------------------------------------------------

--
-- Structure for view `Asignados_completo`
--
DROP TABLE IF EXISTS `Asignados_completo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kiaradeveloper`@`localhost` SQL SECURITY DEFINER VIEW `Asignados_completo`  AS SELECT `a`.`IdUsuario` AS `id_user`, `u`.`Nombre` AS `Nombre`, `u`.`PA` AS `Primer_Apellido`, `u`.`SA` AS `Segundo_Apellido`, `u`.`Email` AS `email`, `u`.`Telefono` AS `tel`, `a`.`IdPropiedad` AS `idPropiedad`, `a`.`RolProp` AS `RolPropiedad` FROM (`asignacion` `a` join `usuario` `u`) WHERE `a`.`IdUsuario` = `u`.`IdUsuario` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asignacion`
--
ALTER TABLE `asignacion`
  ADD PRIMARY KEY (`IdUsuario`,`IdPropiedad`),
  ADD KEY `FK_asignacion_IdPropiedad` (`IdPropiedad`);

--
-- Indexes for table `asignan`
--
ALTER TABLE `asignan`
  ADD PRIMARY KEY (`idUsuario`,`idRol`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `udRol` (`idRol`);

--
-- Indexes for table `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`IdUsuario`,`IdPaso`,`IdPropiedad`) USING BTREE,
  ADD KEY `FK_cliente_pc_prop_IdPaso` (`IdPaso`),
  ADD KEY `FK_cliente_pc_prop_IdPropiedad` (`IdPropiedad`);

--
-- Indexes for table `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IdUsuario` (`IdUsuario`,`IdPaso`,`IdPropiedad`) USING BTREE,
  ADD KEY `FK_cliente_pr_prop_IdPaso` (`IdPaso`),
  ADD KEY `FK_cliente_pr_prop_IdPropiedad` (`IdPropiedad`);

--
-- Indexes for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`idComentario`),
  ADD KEY `idUsuario_usuario_idUsuario` (`idUsuario`);

--
-- Indexes for table `comercial`
--
ALTER TABLE `comercial`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indexes for table `exp_tipo_doc`
--
ALTER TABLE `exp_tipo_doc`
  ADD PRIMARY KEY (`IdCliente`,`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_exp_tipo_doc_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_exp_tipo_doc_Tipo_Exp` (`Tipo_Exp`);

--
-- Indexes for table `exp_tipo_doc_prop`
--
ALTER TABLE `exp_tipo_doc_prop`
  ADD PRIMARY KEY (`IdPropiedad`,`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_exp_tipo_doc_prop_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_exp_tipo_doc_prop_Tipo_Exp` (`Tipo_Exp`);

--
-- Indexes for table `Imagenes`
--
ALTER TABLE `Imagenes`
  ADD PRIMARY KEY (`IdImagen`),
  ADD KEY `FK_Imagenes_IdPropiedad` (`IdPropiedad`);

--
-- Indexes for table `otorgan`
--
ALTER TABLE `otorgan`
  ADD KEY `idRol` (`idRol`),
  ADD KEY `idPermiso` (`idPrivilegio`);

--
-- Indexes for table `pasos_compra`
--
ALTER TABLE `pasos_compra`
  ADD PRIMARY KEY (`Paso`);

--
-- Indexes for table `pasos_renta`
--
ALTER TABLE `pasos_renta`
  ADD PRIMARY KEY (`Paso`);

--
-- Indexes for table `privilegios`
--
ALTER TABLE `privilegios`
  ADD PRIMARY KEY (`idPrivilegio`);

--
-- Indexes for table `propiedades`
--
ALTER TABLE `propiedades`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indexes for table `requisitos`
--
ALTER TABLE `requisitos`
  ADD PRIMARY KEY (`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `UK_requisitos_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_requisitos_Tipo_Exp` (`Tipo_Exp`);

--
-- Indexes for table `requisitos_prop`
--
ALTER TABLE `requisitos_prop`
  ADD PRIMARY KEY (`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_requisitos_prop_Tipo_Exp` (`Tipo_Exp`);

--
-- Indexes for table `residencial`
--
ALTER TABLE `residencial`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indexes for table `terreno`
--
ALTER TABLE `terreno`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indexes for table `tipo_doc`
--
ALTER TABLE `tipo_doc`
  ADD PRIMARY KEY (`Tipo_Doc`);

--
-- Indexes for table `tipo_doc_prop`
--
ALTER TABLE `tipo_doc_prop`
  ADD PRIMARY KEY (`Tipo_Doc`);

--
-- Indexes for table `tipo_exp`
--
ALTER TABLE `tipo_exp`
  ADD PRIMARY KEY (`Tipo_Exp`);

--
-- Indexes for table `tipo_exp_prop`
--
ALTER TABLE `tipo_exp_prop`
  ADD PRIMARY KEY (`Tipo_Exp`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IdUsuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=373;

--
-- AUTO_INCREMENT for table `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `idComentario` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `Imagenes`
--
ALTER TABLE `Imagenes`
  MODIFY `IdImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=418;

--
-- AUTO_INCREMENT for table `privilegios`
--
ALTER TABLE `privilegios`
  MODIFY `idPrivilegio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `propiedades`
--
ALTER TABLE `propiedades`
  MODIFY `IdPropiedad` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asignacion`
--
ALTER TABLE `asignacion`
  ADD CONSTRAINT `FK_asignacion_IdEmpleado` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_asignacion_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asignan`
--
ALTER TABLE `asignan`
  ADD CONSTRAINT `asignan_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignan_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  ADD CONSTRAINT `FK_cliente_pc_prop_IdPaso` FOREIGN KEY (`IdPaso`) REFERENCES `pasos_compra` (`Paso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pc_prop_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pc_prop_IdUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  ADD CONSTRAINT `FK_cliente_pr_prop_IdPaso` FOREIGN KEY (`IdPaso`) REFERENCES `pasos_renta` (`Paso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pr_prop_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pr_prop_IdUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `idUsuario_usuario_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`IdUsuario`);

--
-- Constraints for table `comercial`
--
ALTER TABLE `comercial`
  ADD CONSTRAINT `FK_comercial_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exp_tipo_doc`
--
ALTER TABLE `exp_tipo_doc`
  ADD CONSTRAINT `FK_exp_tipo_doc_IdCliente` FOREIGN KEY (`IdCliente`) REFERENCES `usuario` (`IdUsuario`) ON DELETE NO ACTION,
  ADD CONSTRAINT `FK_exp_tipo_doc_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exp_tipo_doc_prop`
--
ALTER TABLE `exp_tipo_doc_prop`
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_IdCliente` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc_prop` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp_prop` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Imagenes`
--
ALTER TABLE `Imagenes`
  ADD CONSTRAINT `FK_Imagenes_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `otorgan`
--
ALTER TABLE `otorgan`
  ADD CONSTRAINT `otorgan_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `otorgan_ibfk_2` FOREIGN KEY (`idPrivilegio`) REFERENCES `privilegios` (`idPrivilegio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requisitos`
--
ALTER TABLE `requisitos`
  ADD CONSTRAINT `FK_requisitos_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_requisitos_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requisitos_prop`
--
ALTER TABLE `requisitos_prop`
  ADD CONSTRAINT `FK_requisitos_prop_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc_prop` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_requisitos_prop_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp_prop` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `residencial`
--
ALTER TABLE `residencial`
  ADD CONSTRAINT `FK_residencial_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `terreno`
--
ALTER TABLE `terreno`
  ADD CONSTRAINT `FK_terreno_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
