CREATE TABLE exp_tipo_doc (
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

ALTER TABLE exp_tipo_doc 
  ADD UNIQUE INDEX UK_exp_tipo_doc_Tipo_Doc(Tipo_Doc);

ALTER TABLE exp_tipo_doc 
  ADD CONSTRAINT FK_exp_tipo_doc_IdCliente FOREIGN KEY (IdCliente)
    REFERENCES usuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE exp_tipo_doc 
  ADD CONSTRAINT FK_exp_tipo_doc_Tipo_Doc FOREIGN KEY (Tipo_Doc)
    REFERENCES tipo_doc(Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE exp_tipo_doc 
  ADD CONSTRAINT FK_exp_tipo_doc_Tipo_Exp FOREIGN KEY (Tipo_Exp)
    REFERENCES tipo_exp(Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;