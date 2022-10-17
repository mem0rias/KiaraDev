﻿CREATE TABLE residencial (
  IdPropiedad INT(10) NOT NULL,
  baños INT(10) DEFAULT NULL,
  Recamaras INT(10) DEFAULT NULL,
  Cocina INT(10) DEFAULT NULL,
  Estacionamiento INT(10) DEFAULT NULL,
  Gas INT(10) DEFAULT NULL,
  Pisos INT(10) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 16384,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
ROW_FORMAT = DYNAMIC;

ALTER TABLE residencial 
  ADD CONSTRAINT FK_residencial_IdPropiedad FOREIGN KEY (IdPropiedad)
    REFERENCES propiedades(IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;