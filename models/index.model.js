const db = require('../util/database');

module.exports = class Propiedad {

    //Este método servirá para devolver los ultimos 4 objetos de la tabla 
    static fetchNew() {
        return db.execute('SELECT * FROM propiedades ORDER BY IdPropiedad DESC LIMIT 4');
    }

}
