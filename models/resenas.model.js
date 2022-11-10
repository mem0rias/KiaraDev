const db = require('../util/database');

module.exports = class Reseñas {
    constructor(usuario, mi_contenido, mi_aprobado) {
            this.idUsuario = usuario;
            this.contenido = mi_contenido;
            this.aprobado = mi_aprobado;

        }
        // Guardar de manera persistente el nuevo objeto (se ejecuta sobre un objeto)
    save() {
            return db.execute(
                'INSERT INTO comentarios (idUsuario, contenido , aprobado) VALUES (? ,? , ?)', [this.idUsuario, this.contenido, this.aprobado]);
        }
        // Devuelve los objetos del almacenamiento persistente (Se ejecuta directamente sobre la clase)
    static fetchAll() {
        return db.execute(
            'SELECT *  FROM comentarios'
        );
    }
}