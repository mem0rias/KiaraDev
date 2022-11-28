const db = require('../util/database');

module.exports = class Dashboard {


    static fetchUser(n){
        return db.execute('SELECT IdUsuario, nombre, PA, SA, eciv, ocupacion, Telefono, email from usuario where IdUsuario = (?)', [n]);
    }


    static fetchAsigando(n){
        return db.execute('SELECT p.IdPropiedad, Descripcion, Imagenes, Titulo, Colonia, Estado, Municipio FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = (?)', [n]);
    }
    


    static fetchEmailRol(filtro, sel) {
        if(sel == false)
            return db.execute('SELECT IdUsuario, nombre, PA, SA, email, IdRol from usuario WHERE nombre LIKE ? OR email LIKE ? order by IdRol DESC ', ['%'+filtro+'%', '%'+filtro+'%']);
        else
            return db.execute('SELECT IdUsuario, nombre, PA, SA, email, IdRol from usuario order by IdRol DESC');
    }

    static updateRol(umap, urol, l){
        return db.execute('CALL `ActualizarRoles`(?, ?, ?)', [umap,urol,l]);

    }


}
