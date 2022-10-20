const db = require('../util/database');

module.exports = class Dashboard {


    static fetchUser(n){
        return db.execute('SELECT nombre, PA, SA, eciv, ocupacion, Telefono, email from usuario where IdUsuario = (?)', [n]);
    }

    static fetchAsigando(n){
        return db.execute('SELECT a.IdPropiedad, Descripcion, Imagenes, Titulo, Colonia, Estado FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = (?)', [n]);
    }
    


}
