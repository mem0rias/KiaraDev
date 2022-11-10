const db = require('../util/database');

module.exports = class listEstatus{
    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchEstatus() {
        return db.execute('SELECT * FROM pasos_compra');
    }
    
    static GetRents(IdUsuario){
        return db.execute('SELECT IdUsuario from cliente_pr_prop where IdUsuario = ?',[IdUsuario]);
    }

    static GetBuy(IdUsuario){
        return db.execute('SELECT IdUsuario from cliente_pc_prop where IdUsuario = ?',[IdUsuario]);
    }

    static GetSelling(IdUsuario){
        return db.execute('SELECT IdUsuario from asignacion where IdUsuario = ?',[IdUsuario]);
    }

}
