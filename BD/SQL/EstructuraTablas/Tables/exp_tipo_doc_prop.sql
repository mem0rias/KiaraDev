CREATE TABLE exp_tipo_doc_prop (
  IdCliente INT(10) NOT NULL,
  Tipo_Doc INT(10) NOT NULL,
  Tipo_Exp INT(10) NOT NULL,
  URL VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  Estatus INT(10) DEFAULT NULL,
  Rol_Exp INT(10) DEFAULT NULL,
  PRIMARY KEY (IdCliente, Tipo_Doc, Tipo_Exp)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
ROW_FORMAT = DYNAMIC;

ALTER TABLE exp_tipo_doc_prop 
  ADD CONSTRAINT FK_exp_tipo_doc_prop_IdCliente FOREIGN KEY (IdCliente)
    REFERENCES propiedades(IdPropiedad) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE exp_tipo_doc_prop 
  ADD CONSTRAINT FK_exp_tipo_doc_prop_Tipo_Doc FOREIGN KEY (Tipo_Doc)
    REFERENCES tipo_doc_prop(Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE exp_tipo_doc_prop 
  ADD CONSTRAINT FK_exp_tipo_doc_prop_Tipo_Exp FOREIGN KEY (Tipo_Exp)
    REFERENCES tipo_exp_prop(Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;