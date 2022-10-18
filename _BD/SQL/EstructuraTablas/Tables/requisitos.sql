CREATE TABLE requisitos (
  Tipo_Doc INT(10) NOT NULL,
  Tipo_Exp INT(10) NOT NULL,
  PRIMARY KEY (Tipo_Doc, Tipo_Exp)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
ROW_FORMAT = DYNAMIC;

ALTER TABLE requisitos 
  ADD UNIQUE INDEX UK_requisitos_Tipo_Doc(Tipo_Doc);

ALTER TABLE requisitos 
  ADD CONSTRAINT FK_requisitos_Tipo_Doc FOREIGN KEY (Tipo_Doc)
    REFERENCES tipo_doc(Tipo_Doc) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE requisitos 
  ADD CONSTRAINT FK_requisitos_Tipo_Exp FOREIGN KEY (Tipo_Exp)
    REFERENCES tipo_exp(Tipo_Exp) ON DELETE CASCADE ON UPDATE CASCADE;