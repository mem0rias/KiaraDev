/*SELECT IdPropiedad FROM cliente_pc_prop except
(SELECT IdPropiedad FROM cliente_pc_prop WHERE Estatus = 1)*/
SELECT distinct IdPropiedad FROM cliente_pc_prop