const db = require('../util/database');

module.exports = class Dashboard {


    static fetchUser(n){
        return db.execute('SELECT IdUsuario, nombre, PA, SA, eciv, ocupacion, Telefono, email, CURP from usuario where IdUsuario = (?)', [n]);
    }


    static fetchAsigando(n){
        return db.execute('SELECT a.IdPropiedad,Visibilidad, Descripcion, Imagenes, Titulo, Colonia, Estado FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = (?)', [n]);
    }

    
    static fetchAsigandoPropiedades(id,query){
        return db.execute('CALL `buscarPropiedadAsignada`(?, ?)', [id,query]);
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

    static updateInfo(id){
        return db.execute('CALL `ActualizarRoles`(?, ?, ?)', [umap,urol,l]);

    }

    static updateInfo(nombre,pa,sa,email,telefono,ocupacion,curp,iduser){
        return db.execute('UPDATE usuario SET Nombre=?,PA=?,SA=?,Email=?,Telefono=?,ocupacion=?,CURP=? WHERE IdUsuario = ?', [nombre,pa,sa,email,telefono,ocupacion,curp,iduser]);

    }


}
