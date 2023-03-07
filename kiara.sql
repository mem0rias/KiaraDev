-- phpMyAdmin SQL Dump
-- version 5.1.4deb1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-03-2023 a las 16:58:30
-- Versión del servidor: 10.6.12-MariaDB-0ubuntu0.22.10.1
-- Versión de PHP: 8.1.7-1ubuntu3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `kiara`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE  PROCEDURE `actualizarComercial` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(100), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` MEDIUMTEXT, IN `U_Video` MEDIUMTEXT, IN `U_Visibilidad` INT, IN `U_Oficinas` INT, IN `U_Banos` INT, IN `U_Niveles` INT, IN `U_Estacionamiento` INT, IN `U_AgenteAsig` INT)  BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE comercial  SET  Cuartos = U_Oficinas, Banos = U_Banos, Niveles = U_Niveles, Estacionamiento = U_Estacionamiento WHERE IdPropiedad = U_ID;
update asignacion set IdUsuario = U_AgenteAsig where IdPropiedad = U_ID and RolProp is NULL;
END$$

CREATE  PROCEDURE `ActualizarExp` (IN `N_Docs` INT, IN `U_IdUsuario` INT, IN `U_comentarios` VARCHAR(255), IN `U_estatus` VARCHAR(255), IN `U_TP` VARCHAR(255), IN `U_Tipo_Exp` INT)  BEGIN
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

CREATE  PROCEDURE `ActualizarExpProp` (IN `N_Docs` INT, IN `U_Prop` INT, IN `U_comentarios` VARCHAR(255), IN `U_estatus` VARCHAR(255), IN `U_TP` VARCHAR(255), IN `U_Tipo_Exp` INT)  BEGIN
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

CREATE  PROCEDURE `ActualizarRoles` (IN `U_Usermap` VARCHAR(255), IN `U_RolMap` VARCHAR(255), IN `N` INT)  BEGIN
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

CREATE  PROCEDURE `actualizarTerreno` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Visibilidad` INT, IN `U_MedidaFrente` INT, IN `U_MedidaFondo` INT, IN `U_Agua` INT, IN `U_Luz` INT, IN `U_Drenaje` INT, IN `U_FormaTerreno` INT)  BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   Uso = U_Uso,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE terreno  SET MedidaFrente = U_MedidaFrente, MedidaFondo = U_MedidaFondo, Agua = U_Agua, Luz = U_Luz, Drenaje = U_Drenaje,
FormaTerreno = U_FormaTerreno WHERE IdPropiedad = U_ID;
END$$

CREATE  PROCEDURE `actulizarResidencial` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(100), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` MEDIUMTEXT, IN `U_Video` MEDIUMTEXT, IN `U_Visibilidad` INT, IN `U_Recamaras` INT(15), IN `U_Banos` INT(15), IN `U_Cocina` INT(15), IN `U_Niveles` INT(15), IN `U_Estacionamiento` INT(15), IN `U_Gas` INT(15), IN `U_AgenteAsig` VARCHAR(255))  BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,  MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE residencial  SET Recamaras = U_Recamaras, Banos = U_Banos, Cocina = U_Cocina, Niveles = U_Niveles, Estacionamiento = U_Estacionamiento, Gas = U_Gas WHERE IdPropiedad = U_ID;
update asignacion set IdUsuario = U_AgenteAsig where IdPropiedad = U_ID and RolProp is NULL;
END$$

CREATE  PROCEDURE `agregarComercial` (IN `U_Titulo` VARCHAR(512), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Cuartos` INT, IN `U_Banos` INT, IN `U_Niveles` INT, IN `U_Estacionamiento` INT, IN `U_IdAgente` INT)  BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO comercial (IdPropiedad,Cuartos,Banos,Niveles,Estacionamiento) 
VALUES (IdNueva,U_Cuartos,U_Banos,U_Niveles,U_Estacionamiento);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE  PROCEDURE `agregarResidencial` (IN `U_Titulo` VARCHAR(512), IN `U_Descripcion` LONGTEXT, IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` MEDIUMTEXT, IN `U_Video` MEDIUMTEXT, IN `U_Recamaras` INT(15), IN `U_Banos` INT(15), IN `U_Cocina` INT(15), IN `U_Niveles` INT(15), IN `U_Estacionamiento` INT(15), IN `U_Gas` INT(15), IN `U_IdAgente` INT)  BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO residencial (IdPropiedad,Recamaras,Banos,Cocina,Niveles,Estacionamiento,Gas) 
VALUES (IdNueva,U_Recamaras,U_Banos,U_Cocina,U_Niveles,U_Estacionamiento,U_Gas);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE  PROCEDURE `agregarRol` ()  BEGIN
DECLARE IdUser INT;
SET IdUser = (SELECT MAX(IdUsuario) as IDC FROM usuario);
INSERT INTO `asignan`(`idUsuario`, `idRol`, `created_at`) VALUES (IdUser,1, CURRENT_TIMESTAMP());

END$$

CREATE  PROCEDURE `agregarTerreno` (IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_MedidaFrente` INT, IN `U_MedidaFondo` INT, IN `U_Agua` INT, IN `U_Luz` INT, IN `U_Drenaje` INT, IN `U_FormaTerreno` INT, IN `U_IdAgente` INT)  BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO terreno (IdPropiedad,MedidaFrente,MedidaFondo,Agua,Luz,Drenaje,FormaTerreno) 
VALUES (IdNueva,U_MedidaFrente,U_MedidaFondo,U_Agua,U_Luz,U_Drenaje,U_FormaTerreno);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE  PROCEDURE `AsignarProp` (IN `U_IdUsuario` INT, IN `U_IdPropiedad` INT, IN `U_FechaAsig` DATE, IN `U_IdRol` INT)  Insert into asignacion values(U_IdUsuario, U_IdPropiedad, U_FechaAsig, U_IdRol, 1)$$

CREATE  PROCEDURE `borraImagenes` (IN `U_String` VARCHAR(4000), IN `N_Data` INT, IN `U_IdPropiedad` INT)  BEGIN
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

CREATE  PROCEDURE `BorrarUsuario` (IN `U_IdUsuario` INT)  delete from usuario where IdUsuario = U_IdUsuario$$

CREATE  PROCEDURE `Borrar_Propiedad` (IN `U_IdPropiedad` INT)  delete from propiedades
where IdPropiedad = U_IdPropiedad$$

CREATE  PROCEDURE `buscarPropiedadAsignada` (IN `U_IdUser` INT, IN `U_Query` VARCHAR(200))  (SELECT p.IdPropiedad, Descripcion, Imagenes, Titulo, Colonia, Estado, Municipio FROM asignacion a, propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = U_IdUser and (Titulo LIKE U_Query OR Colonia LIKE U_Query))$$

CREATE  PROCEDURE `cancelarProceso` (IN `U_IdPropiedad` INT)  BEGIN
   UPDATE `asignacion` SET `VisibleProceso`=0 WHERE `IdPropiedad`=U_IdPropiedad;
   UPDATE `propiedades` SET Visibilidad = 1 where IdPropiedad = U_IdPropiedad;
   DELETE from cliente_pc_prop where IdPropiedad = U_IdPropiedad;
   DELETE from cliente_pr_prop where IdPropiedad = U_IdPropiedad;
   DELETE from asignacion where IdPropiedad = U_IdPropiedad and RolProp IS NOT NULL;
   DELETE from exp_tipo_doc_prop where IdPropiedad = U_IdPropiedad;
END$$

CREATE  PROCEDURE `CerrarTramite` (IN `U_IdPropiedad` INT)  update cliente_pc_prop set estatus = 1 where IdPropiedad = U_IdPropiedad$$

CREATE  PROCEDURE `CheckHeader` (IN `U_IdPropiedad` INT)  BEGIN
  DECLARE headPath VARCHAR(512) default '';
  DECLARE newPath mediumtext default '';
  set headPath = (select Imagen from Imagenes where IdImagen = (select min(IdImagen) from Imagenes where  IdPropiedad = U_IdPropiedad));
  select headPath as 'newHead';
    

END$$

CREATE  PROCEDURE `crearSeguimientoCompra` (IN `U_idusuario` INT, IN `U_idpropiedad` INT)  INSERT INTO `cliente_pc_prop`(`IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES (U_idusuario,1,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,2,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,3,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,4,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,5,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,6,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,7,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,8,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,9,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,10,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,11,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00)$$

CREATE  PROCEDURE `crearSeguimientoRenta` (IN `U_idusuario` INT, IN `U_idpropiedad` INT)  INSERT INTO `cliente_pr_prop`(`IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) 
VALUES (U_idusuario,1,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,2,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,3,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,4,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,5,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00),(U_idusuario,6,U_idpropiedad,3,0,CURRENT_DATE,0000-00-00)$$

CREATE  PROCEDURE `get_exp_asig` (IN `U_ID_Asesor` INT)  SELECT a.IdUsuario, u.Nombre, u.PA, u.SA, u.Telefono, u.Email, a.IdPropiedad
FROM asignacion a, usuario u 
WHERE a.IdUsuario=u.IdUsuario AND a.IdPropiedad IN(SELECT a.IdPropiedad FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND a.IdUsuario = U_ID_Asesor) AND a.IdUsuario != U_ID_Asesor
GROUP BY a.IdUsuario$$

CREATE  PROCEDURE `get_exp_asig_busqueda` (IN `U_ID_Asesor` INT, IN `U_Busqueda` VARCHAR(50))  SELECT a.IdUsuario, u.Nombre, u.PA, u.SA, u.Telefono, u.Email, a.IdPropiedad
FROM asignacion a, usuario u 
WHERE a.IdUsuario=u.IdUsuario AND a.IdPropiedad IN(SELECT a.IdPropiedad FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND a.IdUsuario = U_ID_Asesor) AND a.IdUsuario != U_ID_Asesor AND (u.Nombre LIKE U_Busqueda OR u.Email LIKE U_Busqueda)
GROUP BY a.IdUsuario$$

CREATE  PROCEDURE `get_propiedades_asignadas` (IN `ID_Asesor` INT)  SELECT a.IdPropiedad,p.Visibilidad, p.Descripcion, p.Imagenes, p.Titulo, p.Colonia, p.Estado, p.Municipio
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

CREATE  PROCEDURE `get_propiedades_asignadas_busqueda` (IN `U_ID_Asesor` INT, IN `U_Busqueda` VARCHAR(100))  SELECT a.IdPropiedad,p.Visibilidad, p.Descripcion, p.Imagenes, p.Titulo, p.Colonia, p.Estado, p.Municipio
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
WHERE a.IdUsuario = u.IdUsuario AND a.IdPropiedad = p.IdPropiedad AND a.IdPropiedad IN(SELECT a.IdPropiedad FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND a.IdUsuario = U_ID_Asesor) 
AND (p.Calle LIKE U_Busqueda OR p.Colonia LIKE U_Busqueda OR p.Estado LIKE U_Busqueda OR p.Municipio LIKE U_Busqueda)
GROUP BY a.IdPropiedad$$

CREATE  PROCEDURE `get_propiedades_PI` ()  SELECT a.IdPropiedad,p.Visibilidad, p.Descripcion, p.Imagenes, p.Titulo, p.Colonia, p.Estado, p.Municipio
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
WHERE a.IdUsuario = u.IdUsuario AND a.IdPropiedad = p.IdPropiedad 
GROUP BY a.IdPropiedad$$

CREATE  PROCEDURE `get_propiedades_PI_busqueda` (IN `U_Busqueda` VARCHAR(100))  SELECT a.IdPropiedad,p.Visibilidad, p.Descripcion, p.Imagenes, p.Titulo, p.Colonia, p.Estado, p.Municipio
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
WHERE a.IdUsuario = u.IdUsuario AND a.IdPropiedad = p.IdPropiedad 
AND (p.Calle LIKE U_Busqueda OR p.Colonia LIKE U_Busqueda OR p.Estado LIKE U_Busqueda OR p.Municipio LIKE U_Busqueda)
GROUP BY a.IdPropiedad$$

CREATE  PROCEDURE `IniciarRenta` (IN `U_Pasos` VARCHAR(255), IN `U_NPasos` INT, IN `U_Propietario` INT, IN `U_Cliente` INT, IN `U_Propiedad` INT, IN `U_CasadoP` INT, IN `U_CasadoC` INT)  BEGIN
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
    
    -- IF U_CasadoP = 1 then 
    --   Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Propietario, 0, 8);
    -- END IF;

    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Cliente, 0, 5);
    
    Replace into exp_tipo_doc (IdCliente, Tipo_Doc, Tipo_Exp) values (U_Cliente, 0, 6);
  
    Replace into exp_tipo_doc_prop (IdPropiedad, Tipo_Doc, Tipo_Exp) values (U_Propiedad,0,1);
    
    UPDATE propiedades set Visibilidad = 0 where IdPropiedad = U_Propiedad;

 

    
    
END$$

CREATE  PROCEDURE `IniciarVenta` (IN `U_Pasos` VARCHAR(255), IN `U_NPasos` INT, IN `U_Propietario` INT, IN `U_Cliente` INT, IN `U_Propiedad` INT, IN `U_CasadoP` INT, IN `U_CasadoC` INT)  BEGIN
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

CREATE  PROCEDURE `subirImagen` (IN `U_String` VARCHAR(4000), IN `N_Data` INT)  BEGIN
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

CREATE  PROCEDURE `subirImagenEdit` (IN `U_String` VARCHAR(4000), IN `N_Data` INT, IN `U_IdPropiedad` INT)  BEGIN
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

CREATE  PROCEDURE `TestActRBAC` (IN `U_Usuario` INT)  IF (select DISTINCT idRol from asignan where IdUsuario = U_Usuario) < 2 then
      update asignan set IdRol = 2, created_at = CURRENT_DATE  where idUsuario = U_Usuario;
    end if$$

CREATE  PROCEDURE `UpdateCompra` (IN `U_Estatus` INT, IN `U_id` INT, IN `U_idpropiedad` INT)  UPDATE `cliente_pc_prop` SET `Estatus`= U_Estatus, `Fecha_Fin`= CURRENT_DATE() where id = U_id AND IdPropiedad = U_idpropiedad$$

CREATE  PROCEDURE `updateHeader` (IN `U_Head` VARCHAR(4000))  BEGIN 
DECLARE IdP INT;
SET IdP = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
UPDATE propiedades SET `Imagenes`= U_Head WHERE IdPropiedad = IdP;
END$$

CREATE  PROCEDURE `UpdateRenta` (IN `U_Estatus` INT, IN `U_id` INT, IN `U_idpropiedad` INT)  UPDATE `cliente_pr_prop` SET `Estatus`= U_Estatus,  `Fecha_Fin`= CURRENT_DATE()  where id = U_id AND IdPropiedad = U_idpropiedad$$

CREATE  PROCEDURE `UploadFiles` (IN `U_paths` VARCHAR(2048), IN `U_docList` VARCHAR(255), IN `U_IdUsuario` INT, IN `N_Docs` INT, IN `U_estatus` VARCHAR(255), IN `U_TipoExp` INT)  BEGIN
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

CREATE  PROCEDURE `UploadFilesProp` (IN `U_paths` VARCHAR(2048), IN `U_docList` VARCHAR(255), IN `U_IdUsuario` INT, IN `N_Docs` INT, IN `U_estatus` VARCHAR(255), IN `U_TipoExp` INT)  BEGIN
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
-- Estructura de tabla para la tabla `asignacion`
--

CREATE TABLE `asignacion` (
  `IdUsuario` int(10) NOT NULL,
  `IdPropiedad` int(10) NOT NULL,
  `Fecha_asignacion` date DEFAULT NULL,
  `RolProp` int(10) UNSIGNED DEFAULT NULL,
  `VisibleProceso` int(1) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=682 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignacion`
--

INSERT INTO `asignacion` (`IdUsuario`, `IdPropiedad`, `Fecha_asignacion`, `RolProp`, `VisibleProceso`) VALUES
(48, 197, '2023-02-17', 21, 1),
(49, 197, '2023-02-17', 23, 1),
(65, 183, NULL, NULL, NULL),
(65, 197, NULL, NULL, NULL),
(65, 199, NULL, NULL, NULL),
(65, 201, NULL, NULL, NULL),
(68, 184, NULL, NULL, NULL),
(68, 185, NULL, NULL, NULL),
(68, 186, NULL, NULL, NULL),
(68, 187, NULL, NULL, NULL),
(68, 188, NULL, NULL, NULL),
(68, 189, NULL, NULL, NULL),
(68, 194, NULL, NULL, NULL),
(74, 154, NULL, NULL, NULL),
(74, 181, NULL, NULL, NULL),
(74, 183, '2023-01-09', 21, 1),
(74, 191, NULL, NULL, NULL),
(74, 192, NULL, NULL, NULL),
(74, 193, NULL, NULL, NULL),
(98, 183, '2023-01-09', 23, 1),
(105, 196, NULL, NULL, NULL),
(105, 200, NULL, NULL, NULL),
(108, 198, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `Asignados_completo`
-- (Véase abajo para la vista actual)
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
-- Estructura de tabla para la tabla `asignan`
--

CREATE TABLE `asignan` (
  `idUsuario` int(11) NOT NULL,
  `idRol` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `asignan`
--

INSERT INTO `asignan` (`idUsuario`, `idRol`, `created_at`) VALUES
(47, 4, '2022-11-29 20:46:03'),
(52, 2, '2022-11-29 20:47:04'),
(60, 1, '2022-11-30 03:07:43'),
(63, 1, '2022-11-30 03:31:58'),
(64, 1, '2022-11-30 03:38:51'),
(65, 4, '2022-12-01 01:35:53'),
(66, 1, '2022-12-01 22:08:57'),
(68, 3, '2022-12-08 02:30:54'),
(72, 3, '2022-12-20 00:17:07'),
(74, 3, '2022-12-20 00:50:42'),
(82, 3, '2022-12-21 18:27:40'),
(98, 2, '2023-01-09 19:12:12'),
(101, 3, '2023-01-18 22:13:48'),
(104, 3, '2023-01-31 23:55:49'),
(105, 3, '2023-02-01 00:09:50'),
(106, 4, '2023-02-17 18:17:59'),
(107, 4, '2023-02-17 18:18:53'),
(108, 3, '2023-02-21 18:26:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_pc_prop`
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
-- Volcado de datos para la tabla `cliente_pc_prop`
--

INSERT INTO `cliente_pc_prop` (`id`, `IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES
(472, 98, 1, 183, 0, 0, '2023-01-09', NULL),
(473, 98, 2, 183, 0, 0, '2023-01-09', NULL),
(474, 98, 3, 183, 0, 0, '2023-01-09', NULL),
(475, 98, 4, 183, 0, 0, '2023-01-09', NULL),
(476, 98, 5, 183, 0, 0, '2023-01-09', NULL),
(477, 98, 6, 183, 0, 0, '2023-01-09', NULL),
(478, 98, 7, 183, 0, 0, '2023-01-09', NULL),
(479, 98, 8, 183, 0, 0, '2023-01-09', NULL),
(480, 98, 9, 183, 0, 0, '2023-01-09', NULL),
(481, 98, 10, 183, 0, 0, '2023-01-09', NULL),
(482, 98, 11, 183, 0, 0, '2023-01-09', NULL),
(483, 49, 1, 197, 0, 0, '2023-02-17', NULL),
(484, 49, 2, 197, 0, 0, '2023-02-17', NULL),
(485, 49, 3, 197, 0, 0, '2023-02-17', NULL),
(486, 49, 4, 197, 0, 0, '2023-02-17', NULL),
(487, 49, 5, 197, 0, 0, '2023-02-17', NULL),
(488, 49, 6, 197, 0, 0, '2023-02-17', NULL),
(489, 49, 7, 197, 0, 0, '2023-02-17', NULL),
(490, 49, 8, 197, 0, 0, '2023-02-17', NULL),
(491, 49, 9, 197, 0, 0, '2023-02-17', NULL),
(492, 49, 10, 197, 0, 0, '2023-02-17', NULL),
(493, 49, 11, 197, 0, 0, '2023-02-17', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_pr_prop`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `idComentario` int(255) NOT NULL,
  `idUsuario` int(10) NOT NULL,
  `contenido` varchar(1000) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `aprobado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comercial`
--

CREATE TABLE `comercial` (
  `IdPropiedad` int(10) NOT NULL,
  `Cuartos` int(10) DEFAULT NULL,
  `Banos` int(11) NOT NULL,
  `Niveles` int(10) DEFAULT NULL,
  `Estacionamiento` int(10) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comercial`
--

INSERT INTO `comercial` (`IdPropiedad`, `Cuartos`, `Banos`, `Niveles`, `Estacionamiento`) VALUES
(191, 2, 2, 1, 2),
(192, 35, 4, 3, 16),
(193, 2, 8, 2, 7),
(196, 1, 1, 1, 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_tipo_doc`
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
-- Volcado de datos para la tabla `exp_tipo_doc`
--

INSERT INTO `exp_tipo_doc` (`IdCliente`, `Tipo_Doc`, `Tipo_Exp`, `URL`, `Estatus`, `Comentarios`) VALUES
(48, 0, 3, NULL, NULL, NULL),
(49, 0, 1, NULL, NULL, NULL),
(52, 0, 1, NULL, NULL, NULL),
(54, 0, 3, NULL, NULL, NULL),
(54, 0, 4, NULL, NULL, NULL),
(55, 0, 1, NULL, NULL, NULL),
(55, 0, 3, NULL, NULL, NULL),
(55, 0, 5, NULL, NULL, NULL),
(55, 0, 6, NULL, NULL, NULL),
(55, 0, 7, NULL, NULL, NULL),
(68, 0, 7, NULL, NULL, NULL),
(72, 0, 7, NULL, NULL, NULL),
(74, 0, 3, NULL, NULL, NULL),
(74, 0, 4, NULL, NULL, NULL),
(98, 0, 1, NULL, NULL, NULL),
(98, 0, 2, NULL, NULL, NULL),
(98, 1, 1, 'Expedientes/98/3110123certificado_taller.pdf', 2, ''),
(98, 2, 1, 'Expedientes/98/3110123certificado_taller.pdf', 1, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_tipo_doc_prop`
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
-- Volcado de datos para la tabla `exp_tipo_doc_prop`
--

INSERT INTO `exp_tipo_doc_prop` (`IdPropiedad`, `Tipo_Doc`, `Tipo_Exp`, `URL`, `Estatus`, `Rol_Exp`, `Comentarios`) VALUES
(183, 0, 1, NULL, NULL, NULL, NULL),
(197, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Imagenes`
--

CREATE TABLE `Imagenes` (
  `IdImagen` int(11) NOT NULL,
  `Imagen` varchar(4096) DEFAULT NULL,
  `IdPropiedad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Imagenes`
--

INSERT INTO `Imagenes` (`IdImagen`, `Imagen`, `IdPropiedad`) VALUES
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
(581, 'public/uploads/43211122Ameni 01.JPG', 181),
(582, 'public/uploads/4321112201.JPG', 181),
(583, 'public/uploads/4321112202.JPG', 181),
(584, 'public/uploads/4321112203.JPG', 181),
(585, 'public/uploads/4321112204.JPG', 181),
(586, 'public/uploads/4321112205.JPG', 181),
(587, 'public/uploads/4321112206.JPG', 181),
(588, 'public/uploads/43211122Ameni 03.JPG', 181),
(589, 'public/uploads/43211122Ameni 04.JPG', 181),
(590, 'public/uploads/43211122Ameni 05.JPG', 181),
(609, 'public/uploads/163012300 portada4.jpeg', 183),
(610, 'public/uploads/163012300a.png', 183),
(611, 'public/uploads/163012300aa.png', 183),
(612, 'public/uploads/163012301a sala.JPG', 183),
(613, 'public/uploads/163012301b sala2.JPG', 183),
(614, 'public/uploads/163012301ba sala.JPG', 183),
(615, 'public/uploads/163012301bab.JPG', 183),
(616, 'public/uploads/163012301be.png', 183),
(617, 'public/uploads/163012301bef.png', 183),
(618, 'public/uploads/163012301f.JPG', 183),
(619, 'public/uploads/16301231fa.png', 183),
(620, 'public/uploads/163012301gpasillo.JPG', 183),
(621, 'public/uploads/16301231gq.png', 183),
(622, 'public/uploads/163012302a.png', 183),
(623, 'public/uploads/163012302b.png', 183),
(624, 'public/uploads/163012302ba.png', 183),
(625, 'public/uploads/163012302bb.png', 183),
(626, 'public/uploads/173012302c.png', 183),
(627, 'public/uploads/17301235.png', 183),
(628, 'public/uploads/17301236.png', 183),
(629, 'public/uploads/593012300 portada 1.JPG', 184),
(630, 'public/uploads/593012302 sala.JPG', 184),
(631, 'public/uploads/593012303 sala.JPG', 184),
(632, 'public/uploads/593012309 patio.JPG', 184),
(633, 'public/uploads/593012304 escaleras.JPG', 184),
(634, 'public/uploads/593012307 patio.JPG', 184),
(635, 'public/uploads/593012316 recam.jpg', 184),
(636, 'public/uploads/593012318 pasillo.JPG', 184),
(637, 'public/uploads/593012315 recamara.jpg', 184),
(638, 'public/uploads/593012310 baÃ±o.JPG', 184),
(639, 'public/uploads/593012305 cocina.JPG', 184),
(640, 'public/uploads/2730123fachada.jpeg', 185),
(641, 'public/uploads/2730123Area de lavado.jpeg', 185),
(642, 'public/uploads/2730123roofgarden.jpeg', 185),
(643, 'public/uploads/2730123terraza...jpeg', 185),
(644, 'public/uploads/2730123baÃ±o.jpeg', 185),
(645, 'public/uploads/2730123recamara principal.jpeg', 185),
(646, 'public/uploads/2730123recamara secundaria..jpeg', 185),
(647, 'public/uploads/2730123alberca.jpeg', 185),
(648, 'public/uploads/2730123ludoteca.jpeg', 185),
(649, 'public/uploads/2730123cocina.jpeg', 185),
(650, 'public/uploads/4430123fachada mod A.jpeg', 186),
(651, 'public/uploads/44301232 recamara.jpeg', 186),
(652, 'public/uploads/44301234 sala comedor.jpeg', 186),
(653, 'public/uploads/443012315 alberca.jpeg', 186),
(654, 'public/uploads/443012316 area comunes.jpeg', 186),
(655, 'public/uploads/443012317 gimnasio.jpeg', 186),
(656, 'public/uploads/443012318 escaleras casa mod A.jpeg', 186),
(657, 'public/uploads/533012320220315_153452.jpg', 187),
(658, 'public/uploads/533012320220315_153420.jpg', 187),
(659, 'public/uploads/533012320220315_153436.jpg', 187),
(660, 'public/uploads/533012320220315_153429.jpg', 187),
(661, 'public/uploads/533012320220315_153444.jpg', 187),
(662, 'public/uploads/4040123IMG-20220508-WA0016.jpg', 188),
(663, 'public/uploads/4040123IMG-20220508-WA0020.jpg', 188),
(664, 'public/uploads/4040123IMG-20220508-WA0019.jpg', 188),
(665, 'public/uploads/4040123IMG-20220508-WA0018.jpg', 188),
(666, 'public/uploads/4040123IMG-20220508-WA0017.jpg', 188),
(667, 'public/uploads/444012320220712_114124.jpg', 189),
(668, 'public/uploads/444012320220712_114530.jpg', 189),
(669, 'public/uploads/444012320220712_114341.jpg', 189),
(670, 'public/uploads/444012320220712_114206.jpg', 189),
(671, 'public/uploads/444012320220712_114400.jpg', 189),
(672, 'public/uploads/444012320220712_114222.jpg', 189),
(673, 'public/uploads/444012320220712_114218.jpg', 189),
(674, 'public/uploads/444012320220712_114609.jpg', 189),
(675, 'public/uploads/444012320220712_114602.jpg', 189),
(676, 'public/uploads/444012320220712_114142.jpg', 189),
(677, 'public/uploads/444012320220712_114440.jpg', 189),
(678, 'public/uploads/444012320220712_114157.jpg', 189),
(686, 'public/uploads/740123Fachada 01.JPG', 191),
(687, 'public/uploads/740123Ext 02.JPG', 191),
(688, 'public/uploads/740123Ext 04.JPG', 191),
(689, 'public/uploads/740123Ext 05.JPG', 191),
(690, 'public/uploads/74012302.jpg', 191),
(691, 'public/uploads/74012305.jpg', 191),
(692, 'public/uploads/74012305.jpg', 191),
(693, 'public/uploads/84012309.jpg', 191),
(694, 'public/uploads/84012302.jpg', 191),
(695, 'public/uploads/84012304.jpg', 191),
(696, 'public/uploads/84012303.jpg', 191),
(697, 'public/uploads/214012303 Fachada.jpg', 192),
(698, 'public/uploads/214012305 Aula.jpg', 192),
(699, 'public/uploads/214012306 Aula.jpg', 192),
(700, 'public/uploads/214012307 Aula.jpg', 192),
(701, 'public/uploads/214012308 Aula.jpg', 192),
(702, 'public/uploads/214012309 Aula.jpg', 192),
(703, 'public/uploads/214012310 Escalera Princ.jpg', 192),
(704, 'public/uploads/214012311 Aula.jpg', 192),
(705, 'public/uploads/214012312 Aula.jpg', 192),
(706, 'public/uploads/214012314 Pasillo.jpg', 192),
(707, 'public/uploads/214012315 Usos Multip.jpg', 192),
(708, 'public/uploads/214012316 Usos Multip.jpg', 192),
(709, 'public/uploads/214012322 Usos Multip.jpg', 192),
(710, 'public/uploads/214012323 Lab.jpg', 192),
(711, 'public/uploads/214012324 Oficinas.jpg', 192),
(712, 'public/uploads/214012325 Oficinas.jpg', 192),
(713, 'public/uploads/214012326 Estacionamiento.jpg', 192),
(714, 'public/uploads/214012327 Estacionamiento.jpg', 192),
(715, 'public/uploads/1240123Fachada.jpg', 193),
(716, 'public/uploads/124012301.jpg', 193),
(717, 'public/uploads/124012302.jpg', 193),
(718, 'public/uploads/124012306.jpg', 193),
(719, 'public/uploads/124012307.jpg', 193),
(720, 'public/uploads/124012308.jpg', 193),
(721, 'public/uploads/124012309.jpg', 193),
(722, 'public/uploads/124012310.jpg', 193),
(723, 'public/uploads/124012313.jpg', 193),
(724, 'public/uploads/124012314.jpg', 193),
(725, 'public/uploads/124012315.jpg', 193),
(726, 'public/uploads/124012323.jpg', 193),
(727, 'public/uploads/124012324.jpg', 193),
(728, 'public/uploads/124012325.jpg', 193),
(729, 'public/uploads/185012320220617_091238.jpg', 194),
(730, 'public/uploads/185012320220617_091151.jpg', 194),
(731, 'public/uploads/195012320220617_091140.jpg', 194),
(732, 'public/uploads/195012320220617_091105.jpg', 194),
(733, 'public/uploads/195012320220617_091048.jpg', 194),
(734, 'public/uploads/195012320220617_091057.jpg', 194),
(735, 'public/uploads/195012320220617_091222.jpg', 194),
(758, 'public/uploads/32311232 FACHADA.jpeg', 196),
(759, 'public/uploads/32311232.1 ENTRADA.jpeg', 196),
(760, 'public/uploads/32311233PASILLO NIVEL 2.jpeg', 196),
(761, 'public/uploads/32311234 OFC.jpeg', 196),
(762, 'public/uploads/32311235.jpeg', 196),
(763, 'public/uploads/32311236.jpeg', 196),
(764, 'public/uploads/32311237.jpeg', 196),
(765, 'public/uploads/32311238.jpeg', 196),
(766, 'public/uploads/32311239.jpeg', 196),
(767, 'public/uploads/323112310.jpeg', 196),
(768, 'public/uploads/323112311.jpeg', 196),
(769, 'public/uploads/323112312.jpeg', 196),
(770, 'public/uploads/323112313.jpeg', 196),
(771, 'public/uploads/323112314 PASILLO AC.jpeg', 196),
(772, 'public/uploads/323112315 SALA DE JUNTAS.jpeg', 196),
(773, 'public/uploads/323112316 BAÃOS  NIVEL 2.jpeg', 196),
(774, 'public/uploads/323112317 ROOF GARDEN.jpeg', 196),
(775, 'public/uploads/323112318 ROOF GARDEN NIVEL 2.jpeg', 196),
(776, 'public/uploads/323112319 ROOF  NIVEL 2.jpeg', 196),
(777, 'public/uploads/323112320 ETACIONAMIENTO  -1.jpeg', 196),
(778, 'public/uploads/323112321 ESTACIONAMIENTO -2.jpeg', 196),
(779, 'public/uploads/323112322 COMEDOR-1.jpeg', 196),
(780, 'public/uploads/323112323 GYM-1.jpeg', 196),
(781, 'public/uploads/3231123BAÃOS N-1.jpeg', 196),
(782, 'public/uploads/3231123BAÃOS Y REGADERAS N-1.jpeg', 196),
(783, 'public/uploads/3231123GYM N-1.jpeg', 196),
(784, 'public/uploads/3231123REGADERAS  NIVEL -1.jpeg', 196),
(785, 'public/uploads/10112300 portada.JPG', 197),
(786, 'public/uploads/10112300 portada02.JPG', 197),
(787, 'public/uploads/10112301.JPG', 197),
(788, 'public/uploads/10112302.JPG', 197),
(789, 'public/uploads/1011232b.JPG', 197),
(790, 'public/uploads/1011232c.JPG', 197),
(791, 'public/uploads/10112303.JPG', 197),
(792, 'public/uploads/10112306.JPG', 197),
(793, 'public/uploads/10112307.JPG', 197),
(794, 'public/uploads/10112308.JPG', 197),
(795, 'public/uploads/10112309.JPG', 197),
(796, 'public/uploads/10112310.JPG', 197),
(797, 'public/uploads/10112311.JPG', 197),
(798, 'public/uploads/10112311b.JPG', 197),
(799, 'public/uploads/10112312.JPG', 197),
(800, 'public/uploads/10112313.JPG', 197),
(801, 'public/uploads/10112314.JPG', 197),
(802, 'public/uploads/10112315.JPG', 197),
(803, 'public/uploads/10112316.JPG', 197),
(804, 'public/uploads/10112317.JPG', 197),
(805, 'public/uploads/10112318.JPG', 197),
(806, 'public/uploads/10112319.JPG', 197),
(807, 'public/uploads/10112320.JPG', 197),
(808, 'public/uploads/3921123img2.jpeg', 198),
(809, 'public/uploads/3921123img3.jpeg', 198),
(810, 'public/uploads/3921123img5.jpeg', 198),
(811, 'public/uploads/3921123img6.jpeg', 198),
(812, 'public/uploads/3921123img5.jpeg', 198),
(813, 'public/uploads/8411231.jpeg', 199),
(814, 'public/uploads/8411232.jpeg', 199),
(815, 'public/uploads/8411233.jpeg', 199),
(816, 'public/uploads/8411234.jpeg', 199),
(817, 'public/uploads/841123Captura de pantalla 2023-02-23 a la(s) 0.10.43.png', 199),
(818, 'public/uploads/1941123000.JPG', 200),
(819, 'public/uploads/19411231 sala.JPG', 200),
(820, 'public/uploads/194112301.JPG', 200),
(821, 'public/uploads/1941123001baÃ±o visitas.JPG', 200),
(822, 'public/uploads/19411232SALA.JPG', 200),
(823, 'public/uploads/19411233IMG_9073.JPG', 200),
(824, 'public/uploads/19411234comedor 1.JPG', 200),
(825, 'public/uploads/19411236.1IMG_9284.JPG', 200),
(826, 'public/uploads/19411236.2IMG_9285.JPG', 200),
(827, 'public/uploads/19411237.1IMG_9286.JPG', 200),
(828, 'public/uploads/19411237cocina 2.JPG', 200),
(829, 'public/uploads/19411239COMEDO.JPG', 200),
(830, 'public/uploads/194112312IMG_9027.JPG', 200),
(831, 'public/uploads/204112313IMG_9036 2.JPG', 200),
(832, 'public/uploads/204112314IMG_9065.JPG', 200),
(833, 'public/uploads/204112315.1 rec1.JPG', 200),
(834, 'public/uploads/361112300 portada1-2.jpg', 201),
(835, 'public/uploads/361112300 portada2.JPG', 201),
(836, 'public/uploads/361112301 entradab.jpeg', 201),
(837, 'public/uploads/361112302 sala0.jpeg', 201),
(838, 'public/uploads/361112302 sala1.jpeg', 201),
(839, 'public/uploads/361112302 sala2.jpeg', 201),
(840, 'public/uploads/361112303 cocina0.jpeg', 201),
(841, 'public/uploads/361112303 cocina1.jpeg', 201),
(842, 'public/uploads/361112303 cocina2.jpeg', 201),
(843, 'public/uploads/361112304 sala tv.jpeg', 201),
(844, 'public/uploads/361112304b sala tv2.jpeg', 201),
(845, 'public/uploads/361112305 recam1.jpeg', 201),
(846, 'public/uploads/361112305 recam1b.jpeg', 201),
(847, 'public/uploads/361112305 recam1c.jpeg', 201),
(848, 'public/uploads/361112305 recam1d.jpeg', 201),
(849, 'public/uploads/361112305 recam1e.jpeg', 201),
(850, 'public/uploads/361112306 baÃ±o1.jpeg', 201),
(851, 'public/uploads/361112306 recam2.jpeg', 201),
(852, 'public/uploads/361112306 recam2a.jpeg', 201),
(853, 'public/uploads/361112306 recam2b.jpeg', 201),
(854, 'public/uploads/361112307 recam3.jpeg', 201),
(855, 'public/uploads/361112308 baÃ±o2b.jpeg', 201),
(856, 'public/uploads/361112308bbaÃ±o2.jpeg', 201),
(857, 'public/uploads/361112309 area lavado.jpeg', 201),
(858, 'public/uploads/361112319  jgo niÃ±os.jpeg', 201),
(859, 'public/uploads/361112319a.JPG', 201),
(860, 'public/uploads/361112319b.jpg', 201),
(861, 'public/uploads/361112320.jpeg', 201);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `otorgan`
--

CREATE TABLE `otorgan` (
  `idRol` int(11) NOT NULL,
  `idPrivilegio` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `otorgan`
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
-- Estructura de tabla para la tabla `pasos_compra`
--

CREATE TABLE `pasos_compra` (
  `Paso` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pasos_compra`
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
-- Estructura de tabla para la tabla `pasos_renta`
--

CREATE TABLE `pasos_renta` (
  `Paso` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pasos_renta`
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
-- Estructura de tabla para la tabla `privilegios`
--

CREATE TABLE `privilegios` (
  `idPrivilegio` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `privilegios`
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
-- Estructura de tabla para la tabla `propiedades`
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
-- Volcado de datos para la tabla `propiedades`
--

INSERT INTO `propiedades` (`IdPropiedad`, `Titulo`, `Descripcion`, `Precio`, `Estado`, `Municipio`, `Colonia`, `Calle`, `CP`, `Uso`, `MTerreno`, `MConstruccion`, `TipoTransaccion`, `TipoPropiedad`, `Imagenes`, `Video`, `Visibilidad`) VALUES
(154, 'Casa en Venta Punta Zirconia en Corregidora ', 'En Corregidora el Municipio con mayor plusvalía de Querétaro y sobre el Libramiento Sur Poniente!\r\n\r\nVenta de Casa en Punta Zirconia\r\n144 M2 terreno\r\n225 M2 construcción\r\n\r\nAcabados de primera\r\n* Cocina equipada con cubierta de granito\r\n* 4 recámaras, 3 baños y medio\r\n* Sala de TV \r\n* Sala - Comedor\r\n* Patio trasero con jardín\r\n* Estacionamiento para 2 autos\r\n* Área de Lavado\r\n* Roofgarden\r\n\r\nA sólo 7.9kms de Paseo Constituyentes\r\nA sólo 3.9kms de Santa Bárbara, El Pueblito.\r\nCon Acceso a Bdo Quintana circulando sobre el Libramiento Sur Poniente.\r\n', '3350000', 'Querétaro', 'Corregidora', 'Punta Esmeralda', 'Punta Zirconia 01', 76906, '1', 144, 225, '1', 1, '192111221 Fachada.jpg', 'ND', 1),
(181, 'Preventa de Casas en Desnivel en Altos Juriquilla', 'Vive o invierte en una de las zonas de Querétaro con mayor plusvalía y demanda.\r\n¡Impecables casas nuevas construidas por uno de los mejores desarrolladores de Querétaro!\r\n\r\nCASA NUEVA ENTREGA INMEDIATA\r\nDos amplias recámaras\r\nRecámara principal con vestidor y baño\r\nCocina equipada abierta con barra desayunador\r\n2 baños\r\nÁrea de lavado interior\r\nSonido ambiente en sala y comedor\r\nTerraza con jardín\r\nDos lugares de estacionamiento\r\nAmplio jardín privado en \"L\" (de 80 m² en lote tipo) que rodea la casa\r\n\r\n\r\n\r\nCUENTA ADEMÁS CON 9 AMENIDADES:\r\n-Sala de Lectura\r\n-Sala de Yoga\r\n-Gimnasio\r\n-Asadores\r\n-Fogatero\r\n-Salón de Fiestas\r\n-Alberca Familiar\r\n-Chapoteadero\r\n-Terraza\r\n\r\nPrograma tu cita cuanto antes y ven a conocer todo lo que tenemos para ti!\r\n\r\n', '3014000', 'Querétaro', 'Querétaro', 'Juriquilla', 'Circuito Altos Juriquilla # 01', 76230, '1', 110, 110, '1', 1, '43211122Ameni 01.JPG', '', 1),
(183, 'Venta de casa cerca CANDILES en Corregidora, Queretaro', 'Se vende casa cerca Candiles, Corregidora, Queretaro\r\n\r\n** Se acepta unicamente PAGO DE CONTADO\r\n\r\nLa casa consta de:\r\n\r\nPLANTA BAJA: Sala comedor, cocina, patio de lavado, espacio para 3er recamara o estudio y estacionamiento para 1 auto\r\n\r\nPLANTA ALTA: 2 recamaras, 1 baño completo y 1 vestidor\r\n\r\nLa casa cuenta con protecciones, gas natural y esta recien pintada\r\n\r\nTerreno 102 m2 y Construccion 61 m2\r\n\r\nUBICACIÓN\r\n-	A 1 calle de Prol. Zaragoza\r\n-	A 0.8 km de Av. Chabacano\r\n-	A 1 km. De Av. Candiles\r\n-	A 2.4 km. De Av. Constituyentes\r\n-	A 3 km de Plaza Candiles\r\n-	A 8 km del Centro Historico\r\n\r\n', '1390000', 'Queretaro', 'Corregidora', 'El Batan', 'Circuito Acueducto 1', 76902, '1', 102, 61, '1', 1, '163012300 portada4.jpeg', 'https://www.youtube.com/embed/MtI-j47XkGg', 0),
(184, 'Casa en venta en viñedos', 'En venta hermosa casa en privada en Fraccionamiento Viñedos.\r\nCuenta con acceso controlado, \r\njuegos infantiles, \r\náreas verdes, \r\ncanchas, \r\nestá cerca de escuelas, \r\nárea comercial y\r\ntransporte público.\r\nPlanta Baja: \r\nSala, \r\ncomedor,\r\nmedio baño, \r\ncocina integral \r\ny patio de servicio el cual cuenta con protección, piso y techo.\r\nPlanta alta: \r\n2 recamaras, \r\n1 baño completo\r\nTerreno m2 74m2 \r\nConstrucción m2 80m2\r\nUbicado sobre el libramiento norponiente, a 5 min de Sonterra, de fácil acceso, para \r\nllegar a corregidora y a Juriquilla, a solo 17 min de el Tlacote\r\nSOLO PAGO DE CONTADO', '1250000', 'Queretaro', 'Corregidora', 'Viñedos', 'Circuito merlot', 76235, '1', 74, 80, '1', 1, '593012300 portada 1.JPG', 'https://www.youtube.com/embed/bkAeV4rijVw', 1),
(185, 'Departamentos en venta en Milenio  Queretaro', 'Propiedad ideal para vivir en una zona de alta plusvalía, con acceso controlado e \r\nincreíbles vistas.\r\nRodeado de centros comerciales, escuelas y bancos.\r\nEl inmueble está distribuido con 3 recamaras, la principal con baño y vestidor de 2 o 3 \r\nbaños, área de lavado, sala comedor y terraza.\r\nIncluyen bodega\r\nTerreno m2 desde 91metros2 Construcción m2 desde 91metros2\r\nAmenidades: Alberca, gimnasio, salón de usos múltiples, bussiness center, ludoteca \r\nroofgarden, cancha de paddle, pista de joggin , salón de juegos y áreas verdes\r\nPrecios desde $2,700,000', '2700000', 'Queretaro', 'Queretaro', 'Milenio', 'Milenio', 76060, '1', 91, 91, '1', 2, '2730123fachada.jpeg', '', 1),
(186, 'Pre Venta de casa a desniveles en Zibata, Queretaro', 'N: Si buscas espacios amplios y un concepto diferente, esta casa es para ti, cuenta con \r\ndesniveles, y un dinamismo en su arquitectura por sus medias plantas\r\nEl inmueble está distribuido con:\r\nNivel 0: Acceso, medio baño, sala de estar\r\nNivel -1: Comedor, Cocina, Alacena Bodega\r\nNivel1: Recamara Baño completo Family room Balcón\r\nNivel2: Recamara, Baño completo, Estudio, Área de lavado\r\nNivel 3: Recamara principal, Baño completo, Vestidor, Balcón\r\nTerreno 168m2 Construcción 251m2 \r\nUbicado en la parte más alta de Zibata, con una vista privilegiada al Valle de Amazcala.\r\nAMENIDADES DEL CONDOMINIO: Casa club de dos niveles, con gimnasio, sala de cine, \r\nterraza social, alberca, spa, vapor\r\nAMENIDADES DEL FRACCIONAMIENTO: parques temáticos, con zonas para la práctica de \r\ndeportes, áreas de cultura y relajación, espacios para la convivencia de mascotas, juegos de \r\nagua y áreas destinadas a la convivencia de la comunidad, todas rodeadas de un entorno \r\ntranquilo y natural.\r\nEl fraccionamiento cuenta con más de 175 hectáreas de áreas verdes distribuidas \r\nperfectamente entre parques temáticos, glorietas y camellones, además de jardines lineales \r\na los cuales se les ha incorporado una cliclovía que recorre todo el desarrollo, con una\r\nlongitud total de 8km la ciclovía permitiría el uso de la bicicleta como un medio de \r\ntransporte y promueve el ciclismo como una actividad deportiva más al interior del \r\ndesarrollo.\r\nEl fraccionamiento tiene un campo de golf profesional abierto al público que ha sido \r\ngalardonado como “El mejor campo de Golf en Latinoamérica”, premio otorgado por “The \r\nInternacional Property Awards” en Londres Inglaterra. El campo de Golf de Zibata \r\nincorpora un diseño inigualable a cargo de Rafael Alarcón entrenador de la golfista Lorena \r\nOchoa y de Carter Morrish. Siguiendo la filosofía del proyecto, el diseño del campo de \r\nZIBATA contempla zonas de reservas ecológica, mismas que se encuentran internas en el \r\ncampo, por lo que el jugador podrá apreciar sus paisajes mientras disfruta del juego\r\nTe ayudamos a tramitar tu crédito bancario o de infonavit\r\nEntrega en 9 meses', '5520000', 'Queretaro', 'Marques', 'Zibata', 'Zibata', 76269, '1', 168, 251, '1', 1, '4430123fachada mod A.jpeg', '', 1),
(187, 'Pre venta casa Nuevo Refugio Queretaro', 'Buscas un estilo residencial, Vive en Nuevo Refugio.\r\nRodeado de áreas verdes y espacios abiertos\r\nEl inmueble está distribuido:\r\nPlanta baja:\r\nSala\r\nComedor\r\nCocina\r\nÁrea de lavado\r\nMedio baño\r\nPlanta alta:\r\nRecamara principal con vestidor\r\nRecamara secundaria con baño y terraza\r\nTercera recamara con baño y balcón\r\n+ roof garden\r\nFamily room con baño completo\r\nTerreno 156m2 Construcción 214m2 \r\n** entrega estimada en 10 meses\r\nAmenidades: Gimnasio, alberca, áreas verdes, asadores, fogateros y salón de usos \r\nmúltiples.\r\nUbicación:\r\nA 9 min carretera Querétaro a San Luis Potosí\r\nA 12 min de Juriquilla\r\nAceptamos todos los créditos', '4290000', 'Queretaro', 'Marques', 'Nuevo refugio', 'Nuevo refugio', 76146, '1', 156, 214, '1', 1, '533012320220315_153452.jpg', '', 1),
(188, 'Terreno en venta en ciudad maderas sur II', 'Vive en un gran desarrollo con gran plusvalía, ciudad maderas sur.\r\nExclusivo terreno de 224.22m2\r\nFrente 9.42m2\r\nFondo 25.60m2\r\nCuenta con:\r\nCasa club\r\nAlberca\r\nCancha de tenis\r\nGimnasio\r\nAsador \r\nAmbiente familiar\r\nUbicado sobre la carretera libre Querétaro – Celaya\r\nA 15 min de plaza constituyentes\r\nA 25 min del centro', '620000', 'Guanajuato', 'Apaseo el alto', 'Ciudad maderas', 'Ciudad maderas sur II', 38517, '1', 224, 0, '1', 6, '4040123IMG-20220508-WA0016.jpg', '', 1),
(189, 'Venta de casa nueva  con roof garden en zibata, Queretaro', '¡Buscas un lugar exclusivo, dentro de las mejores zonas de mayor crecimiento en \r\nQuerétaro, esto es para ti!!!!\r\nPropiedad ideal si buscas un entorno tranquilo y natural además de diseño, plusvalía \r\ny espacio.\r\nRodeado de áreas verdes, espacios de recreación, parques temáticos, \r\nEl inmueble está distribuido con\r\nTerreno 150 m2 Construcción 218 m2 \r\n\r\n3 recamaras con baño independiente cada una y vestidor\r\nRoof garden\r\nDesde $4,850,000', '4850000', 'Queretaro', 'Marques', 'Zibata', 'Zibata', 76269, '1', 150, 218, '1', 1, '444012320220712_114124.jpg', '', 1),
(191, 'Renta de Consultorios de 21m2 con Recepción Compartida Hosp Moscati', 'El Hospital Moscati uno de los más modernos de Querétaro y estratégicamente ubicado en Juriquilla. \r\n\r\nEn este entorno se rentan dos Consultorios.\r\n\r\nDe 18.62M2 y 18,23M2 de Construcción Respectivamente.\r\n\r\nCada uno con Baño y Recepción Compartida.\r\n\r\nSon los Consultorios 26 A y B en el Piso 28 del Hospital.\r\n\r\nLa recepción mide 6.89M2\r\n\r\nEsta torre cuenta con 3 pisos subterráneos de estacionamiento.\r\n\r\nCaracterísticas Generales del Hospital:\r\n•	1 Cardio Suite y 6 Quirófanos Inteligentes,\r\n•	2 pediátricos,\r\n•	4 áreas de labor y 3 de tococirugías,\r\n•	Acelerador lineal en segunda etapa,\r\n•	Área reservada para Cyberknife,\r\n•	Centro de investigación,\r\n•	Cirugía ambulatoria,\r\n•	Club médico con vista panorámica,\r\n•	cuenta con 14 módulos e intermedia con 5 módulos,\r\n•	Fluoroscopio,\r\n•	Gimnasio terraza y alberca,\r\n•	Hemodiálisis cuenta con 25 posiciones y 5 aislados positivos,\r\n•	Imagen con Tomógrafo Dual CT,\r\n•	Laboratorio,\r\n•	Mastografía y Angiografía con Hemodinamia,\r\n•	PET Scanner,\r\n•	Rayos X,\r\n•	Resonancia Magnética 1.5 T,\r\n•	Restaurante cuenta con terraza (Roof Garden) y vista panorámica con capacidad de 250 comensales,\r\n•	Roof Garden,\r\n•	Terapia Intensiva,\r\n•	Tomógrafo 256 cortes,\r\n•	Ultrasonido 4D,\r\n•	Urgencias cuenta con 8 cubículos\r\n\r\n\r\nUBICACIÓN\r\n-	A unos pasos de JURIQUILLA SANTA FE\r\n-	Casi esquina con Av. Paseo de la Republica\r\n-	A 1 min. Anillo Vial Fray Junípero Serra\r\n\r\n\r\n', '10000', 'Querétaro', 'Querétaro', 'Juriquilla', 'Ave de las Ciencias 2058', 76320, '2', 21, 21, '2', 3, '740123Fachada 01.JPG', '', 1),
(192, 'Edificio Céntrico sobre Ave Universidad 2350m2', 'Oportunidad! Edificio de 3 pisos y sótano, con áreas para adecuarse a diferentes necesidades oficinas, espacio abierto, etc\r\n\r\nSuperficie total de 1,230 m2 con acceso Principal en Universidad 34 Ote y Gral. Corona, En el Corazón del Centro Histórico de la Ciudad de Querétaro.\r\n\r\n35 Aulas o Oficinas disponibles y 16 cajones de estacionamiento que se encuentra al frente del edificio.\r\n\r\nUbicado en el primer cuadro de la Ciudad a solo 5 Cuadras de:\r\n\r\n•	Jardín Zenea\r\n•	Palacio de Gobierno\r\n•	Plaza Constitución\r\n•	Facultad UAQ Filosofía\r\n\r\n\r\nRápidos Accesos por:\r\n•	Av 5 de Febrero\r\n•	Blvd. Bernardo Q.\r\n•	Corregidora Norte\r\n', '250000', 'Querétaro', 'Querétaro', 'Centro', 'Ave. Universidad 34 Oriente', 76000, '2', 1230, 2350, '2', 3, '214012303 Fachada.jpg', '', 1),
(193, 'Renta de Excelente Local en Juriquilla Torre de Piedra', 'Se renta espacio en Juriquilla a tan solo 2 minutos de la UVM, está totalmente vacío y listo para entrega. Uso de suelo tipo C.\r\n\r\n**Es ideal para clínica medica, oficinas, escuela, bodega, centro de trabajo, negocio, etc\r\n\r\nConstruccion 459 m2\r\n\r\n**No bares o discotecas.\r\n\r\n*Excelente hubicacion\r\n*El lugar está en excelente estado, cuenta con puertas de acero\r\n*Cuenta con 459 mts construidos dividido en 2 niveles.\r\n*Lugar para estacionamiento.\r\n*Baño para hombres, mujeres y para personas con capacidades especiales. Total 8 baños\r\n*Rampa para silla de ruedas\r\n*Puerta de entrada principal y también tiene salida de emergencia.\r\n*Cocineta\r\n*Zona en planta baja cuenta con aire acondicionado, sistema de audio y video\r\n*Terraza\r\n*Oficina principal\r\n*Camaras de vigilancia (costo por aparte)\r\n*Recién pintado\r\n\r\nEs una gran oportunidad para iniciar un nuevo proyecto o para cambiar a una excelente zona\r\n\r\n\r\n', '55000', 'Querétaro', 'Querétaro', 'Juriquilla', 'Punta Caimán 1', 76230, '2', 266, 459, '2', 3, '1240123Fachada.jpg', 'https://www.youtube.com/embed/jO6OdWKZ_Ak', 1),
(194, 'Venta Departamento nuevo en ciudad del sol', 'Estrena Departamento en una de las Zonas Residenciales con Mayor Crecimiento de \r\nla Ciudad:\r\n Construcción de 57 m2.\r\n 2 recámaras.\r\n 1 baño completo.\r\n Sala – comedor.\r\n Cocina.\r\n Área de lavado.\r\n Patio trasero (planta baja).\r\n Balcón trasero (primer,segundo y tercer nivel).\r\n 1 cajón de estacionamiento.\r\nSIN EQUIPAR\r\nAMENIDADES: \r\n Plaza comercial en la entrada del fraccionamiento\r\n Extensas áreas verdes\r\n Zona de juegos, palapas y áreas recreativas\r\n Alberca climatizada con azulejo veneciano\r\n Grandes canchas de fútbol y aparatos para hacer ejercicio al aire libre\r\n PetCamp, espacio amigable para mascotas.\r\nExcelentemente comunicado por el Libramiento Nor Poniente de Querétaro y el \r\nBoulevard Peñaflor y la Avenida de la Cantera.\r\nCercano a Plazas Comerciales, Farmacias, Escuelas. \r\nTe ayudamos a tramitar tu crédito bancario o de infonavit', '868500', 'Queretaro', 'Queretaro', 'Ciudad del sol', 'Ciudad del sol', 76116, '1', 57, 57, '1', 2, '185012320220617_091238.jpg', '', 1),
(196, 'Rento oficina 33m2 en LUMA, Milenio Queretaro', 'Oficina IDEAL  para contadores, diseñadores. Ventas etc.\r\nUbicada en la avenida principal de Milenio cerca de todos los servicios\r\nSin problema de estacionamiento,  Con más de 20 cajones techados. Sumamente cómoda .Con Terraza en el mismo nivel con espectacular vista, para la hora de comida y AREA de fumadores\r\n\r\n La oficina cuenta con 33 m2 , Nivel 2\r\nPersianas , lámparas,\r\nElevadores,\r\nBaños en cada piso\r\nAdemas de contar con GYM Y REGADERAS,\r\nEN  AREA COMUN. AREA DE COMEDOR. \r\nTiene una sala de juntas   que se reserva con anticipación.\r\n\r\n La renta ya incluye matenimiento.\r\n\r\nA 5min de Bernardo Quintana\r\nA 15 min del Centro de la Ciudad.\r\nA 7 min Autopista MEX-QRO.\r\n', '10800', 'Queretaro', 'Queretaro', 'Milenio', 'Camino Real de Carretas', 76060, '2', 33, 33, '2', 4, '32311232 FACHADA.jpeg', '', 1),
(197, 'Vendo casa con terreno excedente en REAL SOLARE, El Marques, Queretaro', 'Se vende casa en Fracc. Real Solare, en Munic. El Marques Queretaro\r\nUbicada en la primera seccion\r\n\r\nPLANTA BAJA\r\nSala comedor\r\nCocina integral\r\nPatio y jardin trasero (con terreno excedente)\r\nBaño de visitas\r\nEstacionamiento para 1 auto\r\n\r\nPLANTA ALTA\r\n3 recamaras la principal con baño completo con cancel\r\n2 recamaras secundarias\r\n1 baño completo para atender recamaras secundarias\r\n\r\nTerreno 102 m2 Construccion 105 m2\r\n\r\nLA CASA CUENTA CON PROTECCIONES Y MOSQUITEROS\r\nCasa impermeabilizada\r\n\r\nEl fraccionamiento cuenta con vigilancia 24/7 y la privada cuenta con Porton electrico\r\n\r\nLa casa cuenta con terreno excedente y tiene muy buena ubicación ya que esta en esquina.\r\n\r\nUbicación excelente ya que esta a unos minutos de Carr. Mexico-Queretaro, a pocos km. Del Parque Industrial Bernardo Quintana, Parque El marques, Parque PYME\r\n\r\nAgenda tu cita ya! Te ayudamos a gestionar tu credito bancario\r\n', '1550000', 'Queretaro', 'El Marques', 'Fracc Real Solare', 'Calle invierno No. 10', 76246, '1', 102, 105, '1', 1, '10112300 portada.JPG', 'https://www.youtube.com/embed/2iRSHzY-K9s', 0),
(198, 'Casa de Prueba Temp Borrar', 'Esta casa es de prueba', '100001', 'Queretaro', 'Queretaro', 'Milenio', 'Sendero del silencio', 76060, '1', 300, 199, '1', 2, '3921123img2.jpeg', 'https://www.youtube.com/embed/MLpWrANjFbI', 1),
(199, 'Venta de Terreno 180 m2 en SANTA FE TLACOTE - Queretaro', 'Vendo terreno PLANO\r\n\r\nUbicado en Residencial SANTA FE TLACOTE, Queretaro\r\n\r\nEsta es una excelente zona de mucha plusvalia\r\n\r\nSuperficie 180m2 \r\nDimensiones: 9m de frente por 20m de fondo\r\n\r\n*El terreno ya cuenta con BARDA + PORTON + CONTRATO DE AGUA + NUMERO OFICIAL\r\n\r\nLIBRE DE GRAVAMEN\r\n\r\nSe acepta credito bancario\r\n', '1350000', 'Queretaro', 'Corregidora', 'Santa Fe Tlacote', 'Circuito del Aguila Real', 76912, '1', 180, 0, '1', 6, '8411231.jpeg', '', 1),
(200, 'Casa 5 habitaciones en el Pueblito Condominio Exclusivo $ 3,740,000', '\r\nVIVE EN  ZONA CENTRO DE CORREGIDORA. \r\nRODEADO DE TODOS LOS SERVICIOS A LA MANO\r\n\r\n\r\nHERMOSA CASA CON UN DISEÑO CLASICO  Y ELEGANTES CANDELABROS \r\nDECORATIVOS . \r\nTECHOS ALTOS, Y  RECAMARAS DE BUEN TAMAÑO C/ BAÑO.\r\n\r\nLA CASA CUENTA CON. \r\n\r\nPLANTA BAJA  BAÑO COMPLETO, SALA A DESNIVEL \r\n\r\n  1ER NIVEL . COMEDOR Y COCINA INTEGRAL  RECIEN REMODELADA , AREA DE LAVADO CON PASILLO LETERAL Y ENTRADA INDEPENDIENTE .\r\n\r\n\r\nPLANTA ALTA ;\r\nRECAMARA PRINCIPAL CON VESTIDOR Y BAÑO CON TINA\r\n2 RECAMARAS CON CLOSET DE MADERA Y BAÑO COMPLETO EN CADA UNA DE ELLAS.\r\n\r\n\r\nSOTANO : \r\nCUENTA CON DOS HABITACIONES  DE USO HABITABLES .\r\nPARA  SALA DE JUEGOS , SALA DE TV,OFICINA DE CASA, DORMITORIO DE INVITADOS, GIMNASIO ,ETC.\r\n\r\nCUENTA CON 2 CISTERNA , TINACO ESTACIONAMIENTO PARA 2 AUTOS,\r\n\r\n MANTENIMIENTO DE 500 MENSUAL.\r\n\r\nPRIVADA CON VIGILANCIA.Y AREA DE JUGOS. INFANTILES\r\nLIBRE DE GRAVAMEN.\r\n\r\nUBICADO:\r\nA 1min de Av. Constituyentes Y Walmart.\r\nA 2min de Libramiento Sur Poniente\r\nA 15 min del Centro \r\nA 5min de Centro Comencial Plaza Citadina, Soriana , Plaza Constituyentes \r\n   Centro Bancario\r\n\r\nTe ayudamos a tramitar tu crédito bancario o de infonavit\r\n\r\n\r\n', '3740000', 'Queretaro', 'Corregidora', 'Fraccionamiento La Antigua', 'Lorenzo Angeles  N.89', 76900, '1', 200, 235, '1', 1, '1941123000.JPG', '', 1),
(201, 'Rento departamento muy amplio en San Agustin, Corregidora, Queretaro', 'Si lo que buscas es ESPACIO, este departamento es ideal PARA TI!\r\n\r\n** La renta ya incluye la cuota de mantenimiento\r\n\r\nRento Departamento muy amplio con excelente ubicación. Este departamento tiene una superficie de 134 m2, es el tamaño de una casa pero con la comodidad de estar en un solo piso. \r\n\r\nEl departamento consta de 3 recamaras, la principal con baño completo y vestidor, Sala de tv, sala comedor amplia, cocina integral con espacio para antecomedor y cuarto de lavado con baño. Total 2.5 baños completos. Estacionamiento para 2 autos. \r\n\r\nAMENIDADES: \r\n\r\n2 albercas\r\narea juegos para niños\r\n2 areas de asadores\r\n2 palapas\r\nareas verdes\r\nestacionamiento para visitas\r\nvigilancia las 24/7 \r\n\r\nUbicado a 5 mins. de Centro Sur, Av. Blvd de las Americas, 10 mins. de salida hacia Cd México y de la central de autobuses, a 20 mins. del centro historico\r\nVias de acceso muy cercanas como Av. Prolong. Pasteur, Av. Camino Real, Av. Candiles, etc. Plazas comerciales cercanas y escuelas\r\n\r\nUBICACIÓN:\r\nA 2 mins. de Prol. Pasteur Sur\r\nA 4 mins. de Av. Camino Real\r\nA 5 mins. de Centro Sur\r\nA 8 mins. de Av. Candiles\r\nA 10 mins. de salida a Cd de Mexico\r\n', '9200', 'Queretaro', 'Corregidora', 'San Agustin', 'Av Jose Maria Truchuelo', 76905, '1', 134, 134, '2', 2, '361112300 portada1-2.jpg', 'https://youtu.be/lubIwYJFyWQ', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos`
--

CREATE TABLE `requisitos` (
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=496 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `requisitos`
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
-- Estructura de tabla para la tabla `requisitos_prop`
--

CREATE TABLE `requisitos_prop` (
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `requisitos_prop`
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
-- Estructura de tabla para la tabla `residencial`
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
-- Volcado de datos para la tabla `residencial`
--

INSERT INTO `residencial` (`IdPropiedad`, `Recamaras`, `Banos`, `Cocina`, `Niveles`, `Estacionamiento`, `Gas`) VALUES
(154, 4, 3, 1, 3, 2, 1),
(181, 2, 2, 1, 1, 2, 1),
(183, 2, 1, 1, 2, 1, 1),
(184, 2, 1, 1, 2, 1, 1),
(185, 3, 2, 1, 0, 2, 1),
(186, 3, 3, 1, 5, 2, 1),
(187, 3, 3, 1, 3, 2, 1),
(188, 0, 0, 1, 0, 0, 1),
(189, 3, 3, 1, 3, 2, 1),
(194, 2, 1, 2, 1, 1, 1),
(197, 3, 3, 1, 2, 1, 1),
(198, 2, 1, 1, 1, 1, 1),
(199, 0, 0, 2, 0, 0, 2),
(200, 5, 4, 1, 3, 2, 1),
(201, 3, 3, 1, 1, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRol`, `nombre`, `created_at`) VALUES
(1, 'usuario', '2022-11-19 05:05:26'),
(2, 'cliente', '2022-11-19 05:05:26'),
(3, 'agente', '2022-11-19 05:05:46'),
(4, 'admin', '2022-11-19 05:05:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `terreno`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_doc`
--

CREATE TABLE `tipo_doc` (
  `Tipo_Doc` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_doc`
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
-- Estructura de tabla para la tabla `tipo_doc_prop`
--

CREATE TABLE `tipo_doc_prop` (
  `Tipo_Doc` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_doc_prop`
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
-- Estructura de tabla para la tabla `tipo_exp`
--

CREATE TABLE `tipo_exp` (
  `Tipo_Exp` int(10) NOT NULL,
  `Descripion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_exp`
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
-- Estructura de tabla para la tabla `tipo_exp_prop`
--

CREATE TABLE `tipo_exp_prop` (
  `Tipo_Exp` int(10) NOT NULL,
  `Descripion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_exp_prop`
--

INSERT INTO `tipo_exp_prop` (`Tipo_Exp`, `Descripion`) VALUES
(1, 'Expediente Propiedad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
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
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Email`, `IdRol`, `Nombre`, `PA`, `SA`, `Eciv`, `ocupacion`, `Telefono`, `password`, `CURP`) VALUES
(47, 'blanca@kiara.mx', 1, 'Daniel', 'Vega', 'Córdova ', 'Soltero', 'Licenciada', '+525529397179', '$2a$12$BH1ErnW/SIAycThplc.4JOWPvyrJMIV7QOwHawYEgZnqGde61aMdu', 'COLMSB'),
(48, 'JP@hotmail.com', 0, 'Juansssas', 'Torrijossasa', 'Perezssa', 'Soltero', 'memoramassasa', '+527717486945', '$2a$12$YjkEY8LSKZ.LWOG9OA7j0.5..jIhqX9xAf/QIFBt/DQNEgkXua/ZW', ''),
(49, 'pedro@hotmail.com', 0, 'Pedro', 'Najera', 'Perez', 'Soltero', 'Profesor', '+524424440909', '$2a$12$8pWcuqz9/FVlGcayF9NmGeAeVrdlAtG0vg5ycJn6fpP2zfkRVM3Za', ''),
(50, 'daniel.bermudez@hotmail.com', 0, 'Daniel', 'Cordova', 'Bermudez', 'Casado', 'Contiboi', '+525529397179', '$2a$12$OTp6ARds7cjEQrlzfP.7bOqaU1hGpFna8DpekUPCGy8yjMMHVPPLG', NULL),
(51, 'andychpsm@gmail.com', 0, 'Andrea', 'Castillo', 'Bermudez', 'Casado', 'Maeta', '+525529397179', '$2a$12$RSsztt4IiqSmzVV7Qj/2BebQKxZ6anpgT4NFGpGNgsNcuIp0u6rE6', NULL),
(52, 'rcortese@hotmail.com', 0, 'Ricardo', 'Perez', 'Cortes', 'Casado', 'Profesor', '+527717486945', '$2a$12$.LkyWlx2whF0iDuqBhxAuekQ42xK8fe5DxGviP7Ew0eMkRkanuhwS', NULL),
(54, 'andrea@gmail.com', 0, 'Andrea', 'Castillo', 'Aguilera', 'Soltero', 'Maeta', '+525529397179', '$2a$12$jtE4pzVlP0Ix.hZwCyEpnukVxOOtd0.1HRgXEU506ZLRgBDzP8oai', NULL),
(55, 'daniel.cordova@gmail.com', 0, 'Daniel', 'Cordova', 'Bermudez', 'Casado', 'contiboi', '+525529397179', '$2a$12$RR2c4bXDhwM46yhuYrbYZOZbTWn5v9CjY6bSu0WSN3sKvW9QZmd.C', NULL),
(60, 'hugotrujillo@atenas.mx', 0, 'Hugo Alexis', 'Trujillo', 'Sánchez', 'Soltero', 'licenciado', '+524421234567', '$2a$12$J0I9K5gAU0AJKF2Eb.qZE.37HcgjDMViMT7XKRDGLdbV7cppajzq2', NULL),
(63, 'silvianavarro@atenas.mx', 0, 'Silvia Paola', 'Navarro', 'Rojas', 'Casado', 'licenciado', '+524421234567', '$2a$12$Nj2unLSPfDrLgv0DF42aPuACgfeG9psWcG935b9eJh6iVILFuqC/i', NULL),
(64, 'IngridTobon@atenas.mx', 0, 'Ingrid Roxana', 'Tobon', 'Osornio', 'Soltero', 'licenciada', '+524421234567', '$2a$12$zcYqKeEPLMqPnae3BL4WQeh6lHrScglpvabaSxxjkbx6E8INd9b8a', NULL),
(65, 'virginia.kiarainmuebles@gmail.com', 0, 'Virginia ', 'Baza', 'Herrera', 'Soltero', 'Comerciante', '+524427967322', '$2a$12$raUiIC1uCuMGBOTEa4MyHuohzYtjg/MaYEfwHv1Ko.fXA1yk4069e', NULL),
(66, 'dan@kiara.mx', 0, 'Daniel', 'Cordovba', 'Bermudez', 'Soltero', 'Estudiante', '+525529397179', '$2a$12$yRlC6LtgQ9Pdlttwl4ua9.p0x48IU49RxWaKvlmX0/skRw422rJUG', ''),
(68, 'esther.kiarainmuebles@gmail.com', 2, 'esther', 'Gutierrez', 'Mtz', 'Casado', 'asesor', '+524426037195', '$2a$12$4BWYCgeohxYvb5jzfGdpHuMk5bsmQHvWnYMnTxfEYDH4IYYIgx13q', NULL),
(72, 'vivybh@yahoo.com', 0, 'Vivy ', 'Prueba', '2', 'Soltero', 'comerciante', '+524423863232', '$2a$12$AZsOeYScnUUPfD.BJEqhg.oX8GvN85wgcKtCfrM6fZJuPn2BupOui', NULL),
(74, 'karla.kiarainmuebles@gmail.com', 0, 'Karla ', 'Yzunza', 'Rugarcia', 'Soltero', 'Asesor Inmobiliario', '+524423217554', '$2a$12$9IIcjrGDT9UY.4NwxzYIdOXUx.b/J64x/eS59.8eoPFl6l1LPU3UK', NULL),
(82, 'direccion.kiarainmuebles@gmail.com', 0, 'Rosa', 'Baza', 'H', 'Soltero', 'empleada', '+524423863232', '$2a$12$fLp2I5uRe2GZkmG2iqBbC.FppexxpD5QzkgGCNxjbYT/0IrlZK.vu', NULL),
(98, 'shari@gmail.com', 0, 'Sharia Samantha', 'Mendozza', 'Baza', 'Soltero', 'empleada', '+524423846104', '$2a$12$mWj2nAbuXizWVH/d8wrw2.zLRU2N7AGKnAJ1AghlJW7/ajoEIsj4q', NULL),
(101, 'herrera@gmail.com', 0, 'prueba sra', 'herrera', 'herrera', 'Soltero', 'empleado', '+524423846104', '$2a$12$c1Z1huDWiyvpwnmZlsJk3uYnvH3xb5MnslYTOqaiNB69FJpd1I5Xy', NULL),
(104, 'mapico1955@yahoo.com', 0, 'Pilar', 'Coto ', 'C.', 'Soltero', 'Asesora', '+524426698027', '$2a$12$QaRx4zw3Y4IkRDM4Xxy/COAhodlAp/Z9KcO6j0k8g5Pa4cAALya9u', NULL),
(105, 'tere.kiarainmuebles@gmail.com', 0, 'Teresa', 'Atilano', 'V.', 'Soltero', 'Asesora', '+524426328759', '$2a$12$s8j9VPIWnPMF/JRNLSmxSe.uF6UmK2pyV9hEf0KgXtEf/p9l9X0HK', NULL),
(106, 'a01707430@tec.mx', 0, 'Said', 'Ortigoza', 'Trujillo', 'Soltero', 'estudiante', '+524423846104', '$2a$12$ok4nAIsBScPed7CY29uuKOumW/mvqFZuALFinfUw7BM1f8ChDWrSK', NULL),
(107, 'a01769137@tec.mx', 0, 'Halim', 'Abraham', 'Galindo', 'Soltero', 'estudiante', '+524423846104', '$2a$12$ymF6N/K.wEQgo62NC9G/DuYR3rR1BD6exmM70LT/nbt8p2AScbmPG', NULL),
(108, 'a01703206@tec.mx', 0, 'Ruth', 'Solis', 'Velasco', 'Soltero', 'estudiante', '+521111111111', '$2a$12$EmEEpCcCcHT9.ipHUq1PEu0GX18mIdB08olXNlB3BVucyig/FnGwa', NULL);

-- --------------------------------------------------------

--
-- Estructura para la vista `Asignados_completo`
--
DROP TABLE IF EXISTS `Asignados_completo`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `Asignados_completo`  AS SELECT `a`.`IdUsuario` AS `id_user`, `u`.`Nombre` AS `Nombre`, `u`.`PA` AS `Primer_Apellido`, `u`.`SA` AS `Segundo_Apellido`, `u`.`Email` AS `email`, `u`.`Telefono` AS `tel`, `a`.`IdPropiedad` AS `idPropiedad`, `a`.`RolProp` AS `RolPropiedad` FROM (`asignacion` `a` join `usuario` `u`) WHERE `a`.`IdUsuario` = `u`.`IdUsuario` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD PRIMARY KEY (`IdUsuario`,`IdPropiedad`),
  ADD KEY `FK_asignacion_IdPropiedad` (`IdPropiedad`);

--
-- Indices de la tabla `asignan`
--
ALTER TABLE `asignan`
  ADD PRIMARY KEY (`idUsuario`,`idRol`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `udRol` (`idRol`);

--
-- Indices de la tabla `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`IdUsuario`,`IdPaso`,`IdPropiedad`) USING BTREE,
  ADD KEY `FK_cliente_pc_prop_IdPaso` (`IdPaso`),
  ADD KEY `FK_cliente_pc_prop_IdPropiedad` (`IdPropiedad`);

--
-- Indices de la tabla `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IdUsuario` (`IdUsuario`,`IdPaso`,`IdPropiedad`) USING BTREE,
  ADD KEY `FK_cliente_pr_prop_IdPaso` (`IdPaso`),
  ADD KEY `FK_cliente_pr_prop_IdPropiedad` (`IdPropiedad`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`idComentario`),
  ADD KEY `idUsuario_usuario_idUsuario` (`idUsuario`);

--
-- Indices de la tabla `comercial`
--
ALTER TABLE `comercial`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indices de la tabla `exp_tipo_doc`
--
ALTER TABLE `exp_tipo_doc`
  ADD PRIMARY KEY (`IdCliente`,`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_exp_tipo_doc_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_exp_tipo_doc_Tipo_Exp` (`Tipo_Exp`);

--
-- Indices de la tabla `exp_tipo_doc_prop`
--
ALTER TABLE `exp_tipo_doc_prop`
  ADD PRIMARY KEY (`IdPropiedad`,`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_exp_tipo_doc_prop_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_exp_tipo_doc_prop_Tipo_Exp` (`Tipo_Exp`);

--
-- Indices de la tabla `Imagenes`
--
ALTER TABLE `Imagenes`
  ADD PRIMARY KEY (`IdImagen`),
  ADD KEY `FK_Imagenes_IdPropiedad` (`IdPropiedad`);

--
-- Indices de la tabla `otorgan`
--
ALTER TABLE `otorgan`
  ADD KEY `idRol` (`idRol`),
  ADD KEY `idPermiso` (`idPrivilegio`);

--
-- Indices de la tabla `pasos_compra`
--
ALTER TABLE `pasos_compra`
  ADD PRIMARY KEY (`Paso`);

--
-- Indices de la tabla `pasos_renta`
--
ALTER TABLE `pasos_renta`
  ADD PRIMARY KEY (`Paso`);

--
-- Indices de la tabla `privilegios`
--
ALTER TABLE `privilegios`
  ADD PRIMARY KEY (`idPrivilegio`);

--
-- Indices de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indices de la tabla `requisitos`
--
ALTER TABLE `requisitos`
  ADD PRIMARY KEY (`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `UK_requisitos_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_requisitos_Tipo_Exp` (`Tipo_Exp`);

--
-- Indices de la tabla `requisitos_prop`
--
ALTER TABLE `requisitos_prop`
  ADD PRIMARY KEY (`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_requisitos_prop_Tipo_Exp` (`Tipo_Exp`);

--
-- Indices de la tabla `residencial`
--
ALTER TABLE `residencial`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `terreno`
--
ALTER TABLE `terreno`
  ADD PRIMARY KEY (`IdPropiedad`);

--
-- Indices de la tabla `tipo_doc`
--
ALTER TABLE `tipo_doc`
  ADD PRIMARY KEY (`Tipo_Doc`);

--
-- Indices de la tabla `tipo_doc_prop`
--
ALTER TABLE `tipo_doc_prop`
  ADD PRIMARY KEY (`Tipo_Doc`);

--
-- Indices de la tabla `tipo_exp`
--
ALTER TABLE `tipo_exp`
  ADD PRIMARY KEY (`Tipo_Exp`);

--
-- Indices de la tabla `tipo_exp_prop`
--
ALTER TABLE `tipo_exp_prop`
  ADD PRIMARY KEY (`Tipo_Exp`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IdUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=494;

--
-- AUTO_INCREMENT de la tabla `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `idComentario` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `Imagenes`
--
ALTER TABLE `Imagenes`
  MODIFY `IdImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=887;

--
-- AUTO_INCREMENT de la tabla `privilegios`
--
ALTER TABLE `privilegios`
  MODIFY `idPrivilegio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  MODIFY `IdPropiedad` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD CONSTRAINT `FK_asignacion_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignacion_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asignan`
--
ALTER TABLE `asignan`
  ADD CONSTRAINT `asignan_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignan_ibfk_3` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  ADD CONSTRAINT `FK_cliente_pc_prop_IdPaso` FOREIGN KEY (`IdPaso`) REFERENCES `pasos_compra` (`Paso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pc_prop_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cliente_pc_prop_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  ADD CONSTRAINT `FK_cliente_pr_prop_IdPaso` FOREIGN KEY (`IdPaso`) REFERENCES `pasos_renta` (`Paso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pr_prop_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cliente_pr_prop_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `comercial`
--
ALTER TABLE `comercial`
  ADD CONSTRAINT `FK_comercial_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `exp_tipo_doc`
--
ALTER TABLE `exp_tipo_doc`
  ADD CONSTRAINT `FK_exp_tipo_doc_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `exp_tipo_doc_ibfk_1` FOREIGN KEY (`IdCliente`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `exp_tipo_doc_prop`
--
ALTER TABLE `exp_tipo_doc_prop`
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_IdCliente` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc_prop` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp_prop` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Imagenes`
--
ALTER TABLE `Imagenes`
  ADD CONSTRAINT `FK_Imagenes_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `otorgan`
--
ALTER TABLE `otorgan`
  ADD CONSTRAINT `otorgan_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `otorgan_ibfk_2` FOREIGN KEY (`idPrivilegio`) REFERENCES `privilegios` (`idPrivilegio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `requisitos`
--
ALTER TABLE `requisitos`
  ADD CONSTRAINT `FK_requisitos_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_requisitos_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `requisitos_prop`
--
ALTER TABLE `requisitos_prop`
  ADD CONSTRAINT `FK_requisitos_prop_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc_prop` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_requisitos_prop_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp_prop` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `residencial`
--
ALTER TABLE `residencial`
  ADD CONSTRAINT `FK_residencial_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `terreno`
--
ALTER TABLE `terreno`
  ADD CONSTRAINT `FK_terreno_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
