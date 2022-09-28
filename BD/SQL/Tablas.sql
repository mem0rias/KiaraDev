
-- Tabla de Herencia Cliente
CREATE TABLE kiaraaa.cliente (
  IdUsuario int(10) NOT NULL,
  IdRol_Cliente int(10) NOT NULL,
  PRIMARY KEY (IdUsuario, IdRol_Cliente)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1820,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.cliente
ADD CONSTRAINT FK_cliente_IdUsuario FOREIGN KEY (IdUsuario)
REFERENCES kiaraaa.usuario (IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla de Relacion Cliente Propiedad Etapa - Renta
CREATE TABLE kiaraaa.clip_prop_r (
  IdUsuario int(10) NOT NULL,
  Etapa int(10) NOT NULL,
  IdPropiedad int(10) NOT NULL,
  IdRol_Cliente int(10) NOT NULL,
  Fecha_inicio datetime DEFAULT NULL,
  Fecha_fin datetime DEFAULT NULL,
  URL varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Estatus Etapa` smallint(6) DEFAULT NULL,
  `Comentario Etapa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPropiedad, IdRol_Cliente, Etapa)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.clip_prop_r
ADD CONSTRAINT FK_clip_prop_r FOREIGN KEY (IdUsuario, IdRol_Cliente)
REFERENCES kiaraaa.cliente (IdUsuario, IdRol_Cliente) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE kiaraaa.clip_prop_r
ADD CONSTRAINT FK_clip_prop_r_Etapa FOREIGN KEY (Etapa)
REFERENCES kiaraaa.proceso_renta (Etapa) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE kiaraaa.clip_prop_r
ADD CONSTRAINT FK_clip_prop_r_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES kiaraaa.propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla Resultante CLIP-PROP+ Renta
CREATE TABLE kiaraaa.clip_prop_r (
  IdUsuario int(10) NOT NULL,
  Etapa int(10) NOT NULL,
  IdPropiedad int(10) NOT NULL,
  IdRol_Cliente int(10) NOT NULL,
  Fecha_inicio datetime DEFAULT NULL,
  Fecha_fin datetime DEFAULT NULL,
  URL varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Estatus Etapa` smallint(6) DEFAULT NULL,
  `Comentario Etapa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPropiedad, IdRol_Cliente, Etapa)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.clip_prop_r
ADD CONSTRAINT FK_clip_prop_r FOREIGN KEY (IdUsuario, IdRol_Cliente)
REFERENCES kiaraaa.cliente (IdUsuario, IdRol_Cliente) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE kiaraaa.clip_prop_r
ADD CONSTRAINT FK_clip_prop_r_Etapa FOREIGN KEY (Etapa)
REFERENCES kiaraaa.proceso_renta (Etapa) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE kiaraaa.clip_prop_r
ADD CONSTRAINT FK_clip_prop_r_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES kiaraaa.propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE kiaraaa.comercial (
  IdPropiedad int(10) NOT NULL,
  Estracionamientos int(10) DEFAULT NULL,
  Cuartos int(10) DEFAULT NULL,
  Oficinas int(10) DEFAULT NULL,
  Niveles int(10) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.comercial
ADD CONSTRAINT FK_comercial_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES kiaraaa.propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;


 -- Tabla de Empleados (ISA Herencia)
CREATE TABLE kiaraaa.empleado (
  IdUsuario int(10) NOT NULL,
  IdRol_Empleado int(10) NOT NULL,
  PRIMARY KEY (IdUsuario, IdRol_Empleado)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.empleado
ADD CONSTRAINT FK_empleado_IdUsuario FOREIGN KEY (IdUsuario)
REFERENCES kiaraaa.usuario (IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla de Asignacion Empleado - Propiedad
CREATE TABLE kiaraaa.emp_prop (
  IdUsuario int(10) NOT NULL,
  IdPropiedad int(10) NOT NULL,
  IdRol_Empleado int(10) NOT NULL,
  Fecha_Asignacion datetime DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPropiedad, IdRol_Empleado)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.emp_prop
ADD CONSTRAINT FK_emp_prop FOREIGN KEY (IdUsuario, IdRol_Empleado)
REFERENCES kiaraaa.empleado (IdUsuario, IdRol_Empleado) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE kiaraaa.emp_prop
ADD CONSTRAINT FK_emp_prop_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES kiaraaa.propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE kiaraaa.proceso_comp (
  Etapa int(10) NOT NULL,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Etapa)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

-- Tabla con etapas de renta 

CREATE TABLE kiaraaa.proceso_renta (
  Etapa int(10) NOT NULL,
  Descripcion varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (Etapa)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

CREATE TABLE kiaraaa.propiedades (
  IdPropiedad int(10) NOT NULL,
  Descripción text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Precio int(10) DEFAULT NULL,
  Estado varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Municipio varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Colonia varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Calle varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Codigo Postal` int(10) DEFAULT NULL,
  `Uso de Suelo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Terreno int(10) DEFAULT NULL,
  Video text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Imagenes text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

-- Tabla de herencia ISA Propiedad - Residencial 
CREATE TABLE kiaraaa.residencial (
  IdPropiedad int(10) NOT NULL,
  Baños int(10) DEFAULT NULL,
  Recamaras int(10) DEFAULT NULL,
  Cocina int(10) DEFAULT NULL,
  Estacionamiento int(10) DEFAULT NULL,
  Gas varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Pisos int(10) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.residencial
ADD CONSTRAINT FK_residencial_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES kiaraaa.propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla de herencia ISA Propiedad - Terreno

CREATE TABLE kiaraaa.terreno (
  IdPropiedad int(10) NOT NULL,
  `Medida frente` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Medida fondo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Uso de suelo` int(10) DEFAULT NULL,
  Agua varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Luz varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Drenaje varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Desnivel varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Forma de Terreno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE kiaraaa.terreno
ADD CONSTRAINT FK_terreno_IdPropiedad FOREIGN KEY (IdPropiedad)
REFERENCES kiaraaa.propiedades (IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla de USUario

CREATE TABLE kiaraaa.usuario (
  IdUsuario int(10) NOT NULL,
  Nombre varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Primer Apellido` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Segundo Apellido` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Correo electrónico` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Estado Civil` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Ocupación varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Telefono int(10) DEFAULT NULL,
  PRIMARY KEY (IdUsuario)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;
