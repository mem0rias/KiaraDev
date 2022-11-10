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
        return db.execute('SELECT DISTINCT clp.idpropiedad, paso, Descripcion FROM cliente_pc_prop clp, pasos_compra pc WHERE clp.IdPaso = pc.paso and clp.IdPropiedad=?',[IdProperty]);
    }
    static fetchAvanceR(IdProperty){
        return db.execute('SELECT DISTINCT clp.idpropiedad, paso, Descripcion FROM cliente_pr_prop clp, pasos_renta pr WHERE clp.IdPaso = pr.paso and clp.IdPropiedad=?',[IdProperty]);
    }


}
