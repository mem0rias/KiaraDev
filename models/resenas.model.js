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
    guardar() {
        return db.execute(
            'INSERT INTO comentarios (idComentario, idUsuario, Contenido, Fecha, Aprobado) VALUES (?, ?, ?, ?, ?)', [this.comentario, this.usuario, this.contenido, this.fecha, this.aprobado]);

    }
}