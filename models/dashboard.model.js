const db = require('../util/database');

module.exports = class User {


    static fetchOne(n){
        return db.execute('SELECT nombre, PA, SA, eciv, ocupacion, Telefono, email from usuario where IdUsuario = (?)', [n]);
    }


}
