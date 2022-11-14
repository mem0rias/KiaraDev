const db = require('../util/database');

module.exports = class listEstatus{
    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchPropertiesC(IdUsuario) {
        return db.execute('SELECT DISTINCT clp.idpropiedad, Titulo FROM cliente_pc_prop clp, propiedades p WHERE clp.idpropiedad = p.IdPropiedad and Idusuario= ?', [IdUsuario]);
    }
    static fetchPropertiesR(IdUsuario) {
        return db.execute('SELECT DISTINCT clp.idpropiedad, Titulo FROM cliente_pr_prop clp, propiedades p WHERE clp.idpropiedad = p.IdPropiedad and Idusuario= ?', [IdUsuario]);
    }

    static fetchAvanceC(IdProperty){
        return db.execute('SELECT DISTINCT clp.idpropiedad, paso, Descripcion, fecha_inicio+fecha_fin as SumaFechas, fecha_inicio+0 as fechaInicio, Estatus FROM cliente_pc_prop clp, pasos_compra pc WHERE clp.IdPaso = pc.paso and clp.IdPropiedad=?',[IdProperty]);
    }
    static fetchAvanceR(IdProperty){
        return db.execute('SELECT DISTINCT clp.idpropiedad, paso, Descripcion,  fecha_inicio+fecha_fin as SumaFechas, fecha_inicio+0 as fechaInicio, Estatus FROM cliente_pr_prop clp, pasos_renta pr WHERE clp.IdPaso = pr.paso and clp.IdPropiedad=?',[IdProperty]);
    }
}
