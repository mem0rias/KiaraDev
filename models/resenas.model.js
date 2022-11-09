const db = require('../util/database');

/*
SELECT contenido 
FROM `comentarios` 
WHERE idUsuario = 46;
*/

module.exports = class Reseñas {
    constructor(mi_comentario, mi_usuario, mi_contenido, mi_fecha, mi_aprobado) {
        this.comentario = mi_comentario;
        this.comentario = mi_usuario;
        this.contenido = mi_contenido;
        this.fecha = mi_fecha;
        this.aprobado = mi_aprobado;

    }
    save() {
        return db.execute(
            'INSERT INTO comentarios ( idUsuario, Contenido, Aprobado) VALUES (?, ?, ?, ?, ?)', [this.usuario, this.contenido, this.aprobado]);
    }
    static instanceof() {
        return db.execute(
            'SELECT * FROM comentarios'
        );
    }
}