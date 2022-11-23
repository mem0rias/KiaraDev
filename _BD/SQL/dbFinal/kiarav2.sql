-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2022 a las 09:34:02
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarComercial` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Visibilidad` INT, IN `U_Oficinas` INT, IN `U_Cuartos` INT, IN `U_Banos` INT, IN `U_Niveles` INT, IN `U_Estacionamiento` INT)   BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   Uso = U_Uso,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE comercial  SET Oficinas = U_Oficinas, Cuartos = U_Cuartos, Banos = U_Banos, Niveles = U_Niveles, Estacionamiento = U_Estacionamiento WHERE IdPropiedad = U_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarExp` (IN `N_Docs` INT, IN `U_IdUsuario` INT, IN `U_comentarios` VARCHAR(255), IN `U_estatus` VARCHAR(255), IN `U_TP` VARCHAR(255))   BEGIN
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
    AND Tipo_Doc = tp;
    SET x = x + 1;
  END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarRoles` (IN `U_Usermap` VARCHAR(255), IN `U_RolMap` VARCHAR(255), IN `N` INT)   BEGIN
  DECLARE umap int DEFAULT 0;
  DECLARE rmap int DEFAULT 0;
  DECLARE x int DEFAULT 0;
  SET x = 1;
  WHILE x <= N DO
    SET umap = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_Usermap, ',', x)), ',', -1)) AS int);
    SET rmap = CAST((SELECT
        SUBSTRING_INDEX ((SUBSTRING_INDEX (U_RolMap, ',', x)), ',', -1)) AS int);
    UPDATE usuario
    SET IdRol = rmap
    WHERE IdUsuario = umap;
    SET x = x + 1;
  END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarTerreno` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Visibilidad` INT, IN `U_MedidaFrente` INT, IN `U_MedidaFondo` INT, IN `U_Agua` INT, IN `U_Luz` INT, IN `U_Drenaje` INT, IN `U_FormaTerreno` INT)   BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   Uso = U_Uso,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE terreno  SET MedidaFrente = U_MedidaFrente, MedidaFondo = U_MedidaFondo, Agua = U_Agua, Luz = U_Luz, Drenaje = U_Drenaje,
FormaTerreno = U_FormaTerreno WHERE IdPropiedad = U_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actulizarResidencial` (IN `U_ID` INT, IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Visibilidad` INT, IN `U_Recamaras` INT(15), IN `U_Banos` INT(15), IN `U_Cocina` INT(15), IN `U_Niveles` INT(15), IN `U_Estacionamiento` INT(15), IN `U_Gas` INT(15))   BEGIN 
UPDATE propiedades SET Titulo = U_Titulo,  Descripcion = U_Descripcion,   Precio = U_Precio,   Estado = U_Estado, 
Municipio = U_Municipio,   Colonia = U_Colonia,   Calle = U_Calle,   CP = U_CP,   Uso = U_Uso,   MTerreno = U_MTerreno,   MConstruccion = U_MConstrucccion,  
TipoTransaccion = U_TipoTransaccion,  TipoPropiedad = U_TipoPropiedad,   Imagenes = U_Imagenes,   Video = U_Video,   Visibilidad = U_Visibilidad
WHERE IdPropiedad = U_ID;
UPDATE residencial  SET Recamaras = U_Recamaras, Banos = U_Banos, Cocina = U_Cocina, Niveles = U_Niveles, Estacionamiento = U_Estacionamiento, Gas = U_Gas WHERE IdPropiedad = U_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarComercial` (IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Oficinas` INT, IN `U_Cuartos` INT, IN `U_Banos` INT, IN `U_Niveles` INT, IN `U_Estacionamiento` INT, IN `U_IdAgente` INT)   BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO comercial (IdPropiedad,Oficinas,Cuartos,Banos,Niveles,Estacionamiento) 
VALUES (IdNueva,U_Oficinas,U_Cuartos,U_Banos,U_Niveles,U_Estacionamiento);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarResidencial` (IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_Recamaras` INT(15), IN `U_Banos` INT(15), IN `U_Cocina` INT(15), IN `U_Niveles` INT(15), IN `U_Estacionamiento` INT(15), IN `U_Gas` INT(15), IN `U_IdAgente` INT)   BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO residencial (IdPropiedad,Recamaras,Banos,Cocina,Niveles,Estacionamiento,Gas) 
VALUES (IdNueva,U_Recamaras,U_Banos,U_Cocina,U_Niveles,U_Estacionamiento,U_Gas);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarTerreno` (IN `U_Titulo` VARCHAR(50), IN `U_Descripcion` VARCHAR(50), IN `U_Precio` INT(100), IN `U_Estado` VARCHAR(100), IN `U_Municipio` VARCHAR(100), IN `U_Colonia` VARCHAR(100), IN `U_Calle` VARCHAR(100), IN `U_CP` INT(50), IN `U_Uso` INT, IN `U_MTerreno` INT(100), IN `U_MConstrucccion` INT, IN `U_TipoTransaccion` INT, IN `U_TipoPropiedad` INT, IN `U_Imagenes` VARCHAR(100), IN `U_Video` VARCHAR(100), IN `U_MedidaFrente` INT, IN `U_MedidaFondo` INT, IN `U_Agua` INT, IN `U_Luz` INT, IN `U_Drenaje` INT, IN `U_FormaTerreno` INT, IN `U_IdAgente` INT)   BEGIN 
DECLARE IdNueva INT;
INSERT INTO propiedades (Titulo,Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP,Uso, MTerreno,MConstruccion, TipoTransaccion,TipoPropiedad,Imagenes,Video,Visibilidad) 
VALUES (U_Titulo,U_Descripcion, U_Precio, U_Estado, U_Municipio, U_Colonia, U_Calle, U_CP,U_Uso,U_MTerreno,U_MConstrucccion,U_TipoTransaccion,U_TipoPropiedad,U_Imagenes,U_Video,1);
SET IdNueva = (SELECT MAX(IdPropiedad) as IDREC FROM propiedades);
INSERT INTO terreno (IdPropiedad,MedidaFrente,MedidaFondo,Agua,Luz,Drenaje,FormaTerreno) 
VALUES (IdNueva,U_MedidaFrente,U_MedidaFondo,U_Agua,U_Luz,U_Drenaje,U_FormaTerreno);
INSERT INTO asignacion (IdUsuario,IdPropiedad)
VALUES (U_IdAgente,IdNueva);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AsignarProp` (IN `U_IdUsuario` INT, IN `U_IdPropiedad` INT, IN `U_FechaAsig` DATE, IN `U_IdRol` INT)   Insert into asignacion values(U_IdUsuario, U_IdPropiedad, U_FechaAsig, U_IdRol)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarUsuario` (IN `U_IdUsuario` INT)   delete from usuario where IdUsuario = U_IdUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Borrar_Propiedad` (IN `U_IdPropiedad` INT)   delete from propiedades
where IdPropiedad = U_IdPropiedad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CerrarTramite` (IN `U_IdPropiedad` INT)   update cliente_pc_prop set estatus = 1 where IdPropiedad = U_IdPropiedad$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion`
--

CREATE TABLE `asignacion` (
  `IdUsuario` int(10) NOT NULL,
  `IdPropiedad` int(10) NOT NULL,
  `Fecha_asignacion` date DEFAULT NULL,
  `RolProp` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=682 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asignacion`
--

INSERT INTO `asignacion` (`IdUsuario`, `IdPropiedad`, `Fecha_asignacion`, `RolProp`) VALUES
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
(24, 14, '2022-10-09', 1),
(47, 43, NULL, NULL),
(47, 45, NULL, NULL),
(47, 47, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignan`
--

CREATE TABLE `asignan` (
  `idUsuario` int(11) NOT NULL,
  `idRol` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `asignan`
--

INSERT INTO `asignan` (`idUsuario`, `idRol`, `created_at`) VALUES
(47, 4, '2022-11-21 02:19:19');

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
) ENGINE=InnoDB AVG_ROW_LENGTH=356 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente_pc_prop`
--

INSERT INTO `cliente_pc_prop` (`id`, `IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES
(1, 10, 1, 14, 1, 1, '2022-10-26', '2022-10-27'),
(2, 10, 2, 14, 1, 1, '2022-10-27', '2022-10-28'),
(3, 10, 3, 14, 1, 1, '2022-10-28', '2022-10-29'),
(4, 10, 4, 14, 1, 1, '2022-10-29', '2022-10-30'),
(5, 10, 5, 14, 1, 1, '2022-10-30', '2022-10-31'),
(6, 10, 6, 14, 1, 1, '2022-10-31', '2022-11-01'),
(7, 10, 7, 14, 1, 0, '2022-11-01', '2022-11-02'),
(8, 10, 8, 14, 1, 1, '2022-11-02', '2022-11-03'),
(9, 10, 9, 14, 1, 1, '2022-11-03', '2022-11-04'),
(10, 10, 10, 14, 1, 1, '2022-11-04', '0000-00-00'),
(11, 10, 11, 14, 1, 0, '0000-00-00', '0000-00-00'),
(12, 12, 1, 15, 1, 0, '2022-10-18', '2022-10-19'),
(13, 12, 2, 15, 1, 0, '2022-10-18', '2022-10-19'),
(14, 12, 3, 15, 1, 0, '2022-10-19', '2022-10-20'),
(15, 12, 4, 15, 1, 0, '2022-10-20', '2022-10-21'),
(16, 12, 5, 15, 1, 0, '2022-10-21', '2022-10-22'),
(17, 12, 6, 15, 1, 0, '2022-10-22', '2022-10-23'),
(18, 12, 7, 15, 1, 0, '2022-10-23', '2022-10-24'),
(19, 14, 1, 8, 1, 1, '2022-11-17', '2022-11-18'),
(20, 14, 2, 8, 1, 1, '2022-11-17', '2022-11-18'),
(21, 14, 3, 8, 1, 1, '2022-11-18', '2022-11-19'),
(22, 14, 4, 8, 1, 1, '2022-11-19', '2022-11-20'),
(23, 14, 5, 8, 1, 1, '2022-11-20', '2022-11-21'),
(24, 14, 6, 8, 1, 1, '2022-11-21', '2022-11-22'),
(25, 14, 7, 8, 1, 1, '2022-11-22', '2022-11-23'),
(26, 14, 8, 8, 1, 1, '2022-11-23', '2022-11-24'),
(27, 14, 9, 8, 1, 1, '2022-11-24', '2022-11-25'),
(28, 14, 10, 8, 1, 1, '2022-11-25', '2022-11-26'),
(29, 14, 11, 8, 1, 1, '2022-11-26', '2022-11-27'),
(30, 18, 1, 18, 1, 0, '2022-10-20', '2022-10-21'),
(31, 18, 2, 18, 1, 0, '2022-10-20', '2022-10-21'),
(32, 18, 3, 18, 1, 0, '2022-10-21', '2022-10-22'),
(33, 18, 4, 18, 1, 0, '2022-10-22', '2022-10-23'),
(34, 18, 5, 18, 1, 0, '2022-10-23', '2022-10-24'),
(35, 18, 6, 18, 1, 0, '2022-10-24', '2022-10-25'),
(36, 18, 7, 18, 1, 0, '2022-10-25', '2022-10-26'),
(37, 18, 8, 18, 1, 0, '2022-10-26', '2022-10-27'),
(38, 18, 9, 18, 1, 0, '2022-10-27', '2022-10-28'),
(39, 18, 10, 18, 1, 0, '2022-10-28', '2022-10-29'),
(40, 18, 11, 18, 1, 1, '2022-10-29', '2022-10-30'),
(41, 21, 1, 13, 1, 0, '2022-10-11', '2022-10-11'),
(42, 21, 2, 13, 1, 0, '2022-10-11', '2022-10-14'),
(43, 21, 3, 13, 1, 0, '2022-10-14', '2022-10-19'),
(44, 21, 4, 13, 1, 0, '2022-10-19', '2022-10-21'),
(45, 21, 5, 13, 1, 0, '2022-10-21', '2022-10-25'),
(46, 21, 6, 13, 1, 0, '2022-10-25', '2022-10-27');

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
) ENGINE=InnoDB AVG_ROW_LENGTH=585 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente_pr_prop`
--

INSERT INTO `cliente_pr_prop` (`id`, `IdUsuario`, `IdPaso`, `IdPropiedad`, `IdRol`, `Estatus`, `Fecha_Inicio`, `Fecha_Fin`) VALUES
(1, 6, 1, 5, 1, 1, '2022-10-28', '2022-11-07'),
(2, 6, 2, 5, 1, 0, '2022-11-07', '2022-11-08'),
(3, 6, 3, 5, 1, 0, '2022-11-08', '2022-11-09'),
(4, 6, 4, 5, 1, 0, '2022-11-09', '2022-11-10'),
(5, 6, 5, 5, 1, 0, '2022-11-10', '2022-11-11'),
(6, 6, 6, 5, 1, 1, '2022-11-11', '2022-11-12'),
(7, 8, 1, 10, 1, 0, '2022-10-26', '2022-10-26'),
(8, 8, 2, 10, 1, 0, '2022-10-26', '2022-10-26'),
(9, 8, 3, 10, 1, 0, '2022-10-27', '2022-10-27'),
(10, 8, 4, 10, 1, 0, '2022-10-28', '2022-10-28'),
(11, 8, 5, 10, 1, 0, '2022-10-29', '2022-10-29'),
(12, 8, 6, 10, 1, 1, '2022-10-30', '2022-10-30'),
(13, 10, 1, 19, 1, 0, '2022-10-11', '2022-10-13'),
(14, 10, 2, 19, 1, 0, '2022-10-13', '2022-10-14'),
(15, 10, 3, 19, 1, 0, '2022-10-14', '2022-10-15'),
(16, 10, 4, 19, 1, 1, '0000-00-00', '0000-00-00'),
(17, 10, 5, 19, 1, 0, '0000-00-00', '0000-00-00'),
(18, 10, 6, 19, 1, 1, '0000-00-00', '0000-00-00'),
(19, 21, 1, 22, 1, 0, '2022-10-11', '2022-10-14'),
(20, 21, 2, 22, 1, 0, '2022-10-14', '2022-10-15'),
(21, 21, 3, 22, 1, 0, '2022-10-15', '2022-10-16'),
(22, 21, 4, 22, 1, 0, '2022-10-16', '2022-10-17'),
(23, 21, 5, 22, 1, 0, '2022-10-17', '2022-10-18'),
(24, 21, 6, 22, 1, 1, '2022-10-18', '2022-10-19'),
(25, 24, 1, 17, 1, 0, '2022-10-19', '2022-10-19'),
(26, 24, 2, 17, 1, 0, '2022-10-19', '2022-10-20'),
(27, 24, 3, 17, 1, 0, '2022-10-20', '2022-10-21'),
(28, 24, 4, 17, 1, 0, '2022-10-21', '2022-10-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comercial`
--

CREATE TABLE `comercial` (
  `IdPropiedad` int(10) NOT NULL,
  `Oficinas` int(10) DEFAULT NULL,
  `Cuartos` int(10) DEFAULT NULL,
  `Banos` int(11) NOT NULL,
  `Niveles` int(10) DEFAULT NULL,
  `Estacionamiento` int(10) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2340 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comercial`
--

INSERT INTO `comercial` (`IdPropiedad`, `Oficinas`, `Cuartos`, `Banos`, `Niveles`, `Estacionamiento`) VALUES
(6, 1, 5, 0, 1, 2),
(7, 1, 5, 0, 1, 3),
(8, 2, 5, 0, 1, 2),
(9, 3, 3, 0, 2, 1),
(10, 5, 1, 0, 2, 1),
(11, 7, 2, 0, 2, 1),
(12, 10, 2, 0, 4, 5),
(44, 32, 1, 32, 2, 0),
(45, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_tipo_doc`
--

CREATE TABLE `exp_tipo_doc` (
  `IdCliente` int(10) NOT NULL,
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL,
  `URL` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Estatus` int(10) DEFAULT NULL,
  `Comentarios` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `exp_tipo_doc`
--

INSERT INTO `exp_tipo_doc` (`IdCliente`, `Tipo_Doc`, `Tipo_Exp`, `URL`, `Estatus`, `Comentarios`) VALUES
(9, 1, 1, NULL, 1, NULL),
(10, 1, 3, NULL, 2, 'Mas vale que funcione :('),
(10, 2, 3, NULL, 3, 'ddd'),
(10, 3, 3, NULL, 1, ''),
(21, 1, 3, NULL, 1, NULL),
(21, 2, 3, NULL, 1, NULL),
(21, 3, 3, NULL, 1, NULL),
(21, 4, 3, NULL, 1, NULL),
(21, 6, 3, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_tipo_doc_prop`
--

CREATE TABLE `exp_tipo_doc_prop` (
  `IdCliente` int(10) NOT NULL,
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL,
  `URL` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Estatus` int(10) DEFAULT NULL,
  `Rol_Exp` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `otorgan`
--

CREATE TABLE `otorgan` (
  `idRol` int(11) NOT NULL,
  `idPrivilegio` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
(3, 2, '2022-11-21 05:27:48'),
(3, 3, '2022-11-21 05:27:48'),
(3, 4, '2022-11-21 05:27:48'),
(3, 5, '2022-11-21 05:27:48'),
(3, 6, '2022-11-21 05:27:48'),
(3, 7, '2022-11-21 05:27:48'),
(3, 8, '2022-11-21 05:27:48'),
(3, 10, '2022-11-21 05:27:48'),
(3, 11, '2022-11-21 05:27:48'),
(4, 2, '2022-11-21 05:27:48'),
(4, 3, '2022-11-21 05:27:48'),
(4, 4, '2022-11-21 05:27:48'),
(4, 5, '2022-11-21 05:27:48'),
(4, 6, '2022-11-21 05:27:48'),
(4, 7, '2022-11-21 05:27:48'),
(4, 8, '2022-11-21 05:27:48'),
(4, 10, '2022-11-21 05:27:48'),
(4, 11, '2022-11-21 05:27:48'),
(4, 12, '2022-11-21 05:27:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasos_compra`
--

CREATE TABLE `pasos_compra` (
  `Paso` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1489 DEFAULT CHARSET=utf8mb4;

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
  `Descripcion` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2730 DEFAULT CHARSET=utf8mb4;

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
  `nombre` varchar(60) COLLATE utf8_spanish2_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `privilegios`
--

INSERT INTO `privilegios` (`idPrivilegio`, `nombre`, `created_at`) VALUES
(1, 'panel_usuario', '2022-11-19 05:04:28'),
(2, 'panel_agente', '2022-11-19 05:04:28'),
(3, 'registrar_propiedad', '2022-11-19 05:04:48'),
(4, 'editar_propiedad', '2022-11-19 05:04:48'),
(5, 'consultar_seguimiento', '2022-11-19 05:04:48'),
(6, 'editar_seguimiento', '2022-11-19 05:04:48'),
(7, 'consultar_expediente', '2022-11-19 05:04:48'),
(8, 'revisar_expediente', '2022-11-19 05:04:48'),
(9, 'crear_comentario', '2022-11-19 05:04:48'),
(10, 'eliminar_comentario', '2022-11-19 05:04:48'),
(11, 'consultar_comentario', '2022-11-19 05:04:48'),
(12, 'aprobar_comentario', '2022-11-19 05:04:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propiedades`
--

CREATE TABLE `propiedades` (
  `IdPropiedad` int(10) NOT NULL,
  `Titulo` varchar(40) DEFAULT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Precio` bigint(20) DEFAULT NULL,
  `Estado` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Municipio` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Colonia` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Calle` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CP` int(10) DEFAULT NULL,
  `Uso` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `MTerreno` int(11) NOT NULL,
  `MConstruccion` int(11) NOT NULL,
  `TipoTransaccion` varchar(255) DEFAULT NULL,
  `TipoPropiedad` int(11) NOT NULL,
  `Imagenes` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Video` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Visibilidad` int(11) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=744 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `propiedades`
--

INSERT INTO `propiedades` (`IdPropiedad`, `Titulo`, `Descripcion`, `Precio`, `Estado`, `Municipio`, `Colonia`, `Calle`, `CP`, `Uso`, `MTerreno`, `MConstruccion`, `TipoTransaccion`, `TipoPropiedad`, `Imagenes`, `Video`, `Visibilidad`) VALUES
(1, NULL, 'Casa en venta', 4000000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Residencial', 0, 0, '1', 0, '', '', 0),
(2, NULL, 'Casa en venta', 3500000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Residencial', 0, 0, '1', 0, '', '', 0),
(4, NULL, 'Casa en venta', 7550000, 'Queretaro', 'Queretaro', 'Carretas', 'Circuito Alamos', 76269, 'Residencial', 0, 0, '1', 0, '', '', 0),
(5, NULL, 'Casa en renta', 8790000, 'Queretaro', 'Queretaro', 'Carretas', 'Circuito Alamos', 76269, 'Residencial', 0, 0, '2', 0, '', '', 0),
(6, NULL, 'Local en venta', 10030000, 'Queretaro', 'Queretaro', 'Carretas', 'Circuito Alamos', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(7, NULL, 'Local en venta', 11270000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(8, NULL, 'Local en venta', 12510000, 'Queretaro', 'Queretaro', 'Alamos', 'Circuito Alamos', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(9, NULL, 'Local en venta', 13750000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(10, NULL, 'Local en venta', 14990000, 'Queretaro', 'El Marques', 'Zibata', 'Circuito Azaleas', 76269, 'Comercial', 0, 0, '2', 0, '', '', 0),
(11, NULL, 'Local en venta', 16230000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(12, NULL, 'Local en venta', 17470000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Comercial', 0, 0, '1', 0, '', '', 0),
(13, NULL, 'Departamento en venta', 18710000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76269, 'Residencial', 0, 0, '1', 0, '', '', 0),
(14, NULL, 'Departamento en venta o renta', 19950000, 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 0, 0, '3', 0, '', '', 0),
(15, NULL, 'Departamento en venta', 21190000, 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 0, 0, '1', 0, '', '', 0),
(16, NULL, 'Departamento en venta', 22430000, 'Queretaro', 'El Marques', 'El Refugio', 'Circuito Azaleas', 76420, 'Residencial', 0, 0, '1', 0, '', '', 0),
(17, NULL, 'Departamento en renta', 23670000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Residencial', 0, 0, '2', 0, '', '', 0),
(18, NULL, 'Terreno', 24910000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Mixto', 0, 0, '1', 0, '', '', 0),
(19, NULL, 'Terreno', 26150000, 'Queretaro', 'El Marques', 'Zakia', 'Circuito Azaleas', 76420, 'Mixto', 0, 0, '3', 0, '', '', 0),
(20, '', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 0),
(21, NULL, 'Casa bonita', 5000, 'Queretaro', 'Queretaro', 'Epigmenio Gonzalez', 'Las rosas 23', 42064, 'Residencial', 0, 0, '1', 0, NULL, NULL, 0),
(22, NULL, 'Casa en renta', 3000000, 'Queretaro', 'Queretaro', 'El Refugio', 'Circuito Berengena ', 76269, 'Residencial', 0, 0, '2\r\n2', 0, '', '', 0),
(43, '', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 0),
(44, 'sasas', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 1),
(45, '', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 0),
(46, '', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 1),
(47, '', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 1),
(48, '43', '', 0, '', '', '', '', 0, '0', 0, 0, '0', 0, '', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos`
--

CREATE TABLE `requisitos` (
  `Tipo_Doc` int(10) NOT NULL,
  `Tipo_Exp` int(10) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=496 DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB AVG_ROW_LENGTH=1365 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `residencial`
--

INSERT INTO `residencial` (`IdPropiedad`, `Recamaras`, `Banos`, `Cocina`, `Niveles`, `Estacionamiento`, `Gas`) VALUES
(1, 2, 2, 1, 2, 2, 1),
(2, 4, 3, 1, 2, 2, 1),
(4, 4, 1, 1, 4, 4, 1),
(5, 3, 2, 1, 5, 1, 1),
(13, 2, 2, 1, 2, 3, 1),
(14, 2, 2, 1, 2, 2, 1),
(15, 2, 3, 2, 2, 1, 1),
(16, 4, 5, 1, 2, 2, 1),
(17, 10, 5, 2, 4, 5, 1),
(21, 3, 2, 4, 4, 4, 1),
(22, 4, 3, 5, 4, 1, 1),
(43, 0, 0, 0, 0, 0, 0),
(48, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AVG_ROW_LENGTH=5461 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `terreno`
--

INSERT INTO `terreno` (`IdPropiedad`, `MedidaFrente`, `MedidaFondo`, `Agua`, `Luz`, `Drenaje`, `FormaTerreno`) VALUES
(18, 10, 10, 1, 1, 1, 0),
(19, 10, 20, 1, 0, 1, 0),
(20, 0, 0, 0, 0, 0, 0),
(46, 0, 0, 0, 0, 0, 0),
(47, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_doc`
--

CREATE TABLE `tipo_doc` (
  `Tipo_Doc` int(10) NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=1489 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_doc`
--

INSERT INTO `tipo_doc` (`Tipo_Doc`, `Descripcion`) VALUES
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
  `Descripcion` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2048 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_doc_prop`
--

INSERT INTO `tipo_doc_prop` (`Tipo_Doc`, `Descripcion`) VALUES
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_exp`
--

CREATE TABLE `tipo_exp` (
  `Tipo_Exp` int(10) NOT NULL,
  `Descripion` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2730 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_exp`
--

INSERT INTO `tipo_exp` (`Tipo_Exp`, `Descripion`) VALUES
(1, 'Expediente Propietario'),
(2, 'Expediente Conyugue de Propietario'),
(3, 'Expediente Comprador\r\n'),
(4, 'Expediente Conyugue Comprador'),
(5, 'Expediente Solicitante Arrendamiento'),
(6, 'Expediente Obligado Solidario Arrendamiento'),
(7, 'Expediente Propietario del inmueble a arrendar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_exp_prop`
--

CREATE TABLE `tipo_exp_prop` (
  `Tipo_Exp` int(10) NOT NULL,
  `Descripion` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `Nombre` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `PA` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `SA` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Eciv` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ocupacion` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Telefono` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=682 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Email`, `IdRol`, `Nombre`, `PA`, `SA`, `Eciv`, `ocupacion`, `Telefono`, `password`) VALUES
(1, 'Luis.Solis@hotmail.com', 2, 'Luis', 'Solis', 'Gracia', 'Soltero', 'Licenciado', '728172173', NULL),
(2, 'Guillermo.De Soto@hotmail.com', 1, 'Guillermo', 'De Soto', 'Garcia', 'Soltero', 'Licenciado', '728172174', NULL),
(3, 'Fidel.Torres@hotmail.com', 1, 'Fidel', 'Torres', 'Garza', 'Soltero', 'Licenciado', '728172175', NULL),
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
(22, 'memof2000@hotmail.com', 1, 'Guillermo Fidel', 'Navarro', 'Vega', 'Soltero', 'Estudiante', '7717486945', 'ffff'),
(24, 'Daniel.Cordova@hotmail.com', 1, 'Daniel', 'Cordova', 'Perez', 'Soltero', 'Licenciado', '728172172', NULL),
(46, 'a01274191@tec.mx', 0, 'Guillermo Fidel', 'Navarro', 'Vega', 'Soltero', 'Full Stack Dev', '7714206969', '$2a$12$ciSro/W6TN0iL77Hz5ZRVufQFg/QXaYvvpo1NvtlIzaLc8nub.CIW'),
(47, 'blanca@kiara.mx', 3, 'Blanca', 'V', 'Vega', 'Soltero', 'Licenciado', '4420696996', '$2a$12$BH1ErnW/SIAycThplc.4JOWPvyrJMIV7QOwHawYEgZnqGde61aMdu');

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
  ADD PRIMARY KEY (`IdCliente`,`Tipo_Doc`,`Tipo_Exp`),
  ADD KEY `FK_exp_tipo_doc_prop_Tipo_Doc` (`Tipo_Doc`),
  ADD KEY `FK_exp_tipo_doc_prop_Tipo_Exp` (`Tipo_Exp`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `privilegios`
--
ALTER TABLE `privilegios`
  MODIFY `idPrivilegio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  MODIFY `IdPropiedad` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD CONSTRAINT `FK_asignacion_IdEmpleado` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_asignacion_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asignan`
--
ALTER TABLE `asignan`
  ADD CONSTRAINT `asignan_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignan_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente_pc_prop`
--
ALTER TABLE `cliente_pc_prop`
  ADD CONSTRAINT `FK_cliente_pc_prop_IdPaso` FOREIGN KEY (`IdPaso`) REFERENCES `pasos_compra` (`Paso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pc_prop_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pc_prop_IdUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente_pr_prop`
--
ALTER TABLE `cliente_pr_prop`
  ADD CONSTRAINT `FK_cliente_pr_prop_IdPaso` FOREIGN KEY (`IdPaso`) REFERENCES `pasos_renta` (`Paso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pr_prop_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cliente_pr_prop_IdUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `comercial`
--
ALTER TABLE `comercial`
  ADD CONSTRAINT `FK_comercial_IdPropiedad` FOREIGN KEY (`IdPropiedad`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `exp_tipo_doc`
--
ALTER TABLE `exp_tipo_doc`
  ADD CONSTRAINT `FK_exp_tipo_doc_IdCliente` FOREIGN KEY (`IdCliente`) REFERENCES `usuario` (`IdUsuario`) ON DELETE NO ACTION,
  ADD CONSTRAINT `FK_exp_tipo_doc_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `exp_tipo_doc_prop`
--
ALTER TABLE `exp_tipo_doc_prop`
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_IdCliente` FOREIGN KEY (`IdCliente`) REFERENCES `propiedades` (`IdPropiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_Tipo_Doc` FOREIGN KEY (`Tipo_Doc`) REFERENCES `tipo_doc_prop` (`Tipo_Doc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_exp_tipo_doc_prop_Tipo_Exp` FOREIGN KEY (`Tipo_Exp`) REFERENCES `tipo_exp_prop` (`Tipo_Exp`) ON DELETE CASCADE ON UPDATE CASCADE;

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
