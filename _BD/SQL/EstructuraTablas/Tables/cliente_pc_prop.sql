CREATE TABLE cliente_pc_prop (
  IdUsuario INT(10) NOT NULL AUTO_INCREMENT,
  IdPaso INT(10) NOT NULL,
  IdPropiedad INT(10) NOT NULL,
  IdRol INT(10) NOT NULL,
  Estatus INT(10) DEFAULT NULL,
  Fecha_Inicio DATETIME DEFAULT NULL,
  Fecha_Fin DATETIME DEFAULT NULL,
  PRIMARY KEY (IdUsuario, IdPaso, IdPropiedad)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
ROW_FORMAT = DYNAMIC;

ALTER TABLE cliente_pc_prop 
  ADD CONSTRAINT FK_cliente_pc_prop_IdPaso FOREIGN KEY (IdPaso)
    REFERENCES pasos_compra(Paso) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE cliente_pc_prop 
  ADD CONSTRAINT FK_cliente_pc_prop_IdPropiedad FOREIGN KEY (IdPropiedad)
    REFERENCES propiedades(IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE cliente_pc_prop 
  ADD CONSTRAINT FK_cliente_pc_prop_IdUsuario FOREIGN KEY (IdUsuario)
    REFERENCES usuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;