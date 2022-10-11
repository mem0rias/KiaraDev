CREATE TABLE comercial (
  IdPropiedad INT(10) NOT NULL,
  Estacionamiento INT(10) DEFAULT NULL,
  Cuartos INT(10) DEFAULT NULL,
  Oficinas INT(10) DEFAULT NULL,
  Niveles INT(10) DEFAULT NULL,
  PRIMARY KEY (IdPropiedad)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
ROW_FORMAT = DYNAMIC;

ALTER TABLE comercial 
  ADD CONSTRAINT FK_comercial_IdPropiedad FOREIGN KEY (IdPropiedad)
    REFERENCES propiedades(IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;