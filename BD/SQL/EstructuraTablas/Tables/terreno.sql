CREATE TABLE terreno (
  IdPropiedad INT(10) NOT NULL,
  `Medida Frente` INT(10) DEFAULT NULL,
  `Medida Fondo` INT(10) DEFAULT NULL,
  `Uso de suelo` INT(10) DEFAULT NULL,
  Agua INT(10) DEFAULT NULL,
  Luz INT(10) DEFAULT NULL,
  Drenaje INT(10) DEFAULT NULL,
  Desivel INT(10) DEFAULT NULL,
  `Forma de Terreno` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
ROW_FORMAT = DYNAMIC;

ALTER TABLE terreno 
  ADD CONSTRAINT FK_terreno_IdPropiedad FOREIGN KEY (IdPropiedad)
    REFERENCES propiedades(IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;