const db = require('../util/database');

module.exports = class Propiedad {

    //Constructor de la clase. Sirve para crear un nuevo objeto, y en él se definen las propiedades del modelo
    constructor(mi_descripcion, mi_precio, mi_estado, mi_municipio, mi_colonia, mi_calle, mi_codigo_postal, mi_terreno, mi_video, mi_imagenes) {
        this.descripcion = mi_descripcion;
        this.precio = mi_precio;
        this.estado = mi_estado;
        this.municipio = mi_municipio;
        this.colonia = mi_colonia;
        this.calle = mi_calle;
        this.cp = mi_codigo_postal;
        this.terreno = mi_terreno;
        this.video = mi_video;
        this.imagenes = mi_imagenes;
    }



    save() {
        return db.execute(
            'INSERT INTO propiedades (Descripcion, Precio, Estado, Municipio, Colonia, Calle, CP, Terreno, Video, Imagenes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
            [this.descripcion, this.precio, this.estado,this.municipio,this.colonia,this.calle,this.cp,this.terreno,this.video,this.imagenes]);     
    }

    static agregarResidencial(d) {
        return db.execute(
            'CALL agregarResidencial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [d.titulo,d.descripcion,d.precio,d.estado,d.municipio,d.colonia,d.calle,d.cp,d.uso,d.mterreno,d.mconstruccion,d.tipotransaccion,d.tipopropiedad,d.imagenes,d.video,d.recamaras,d.banos,d.cocina,d.pisos,d.estacionamiento,d.gas,d.userid]);       
    }

    static saveComercial(descripcion,precio,estado,municipio,colonia,calle,cp,terreno,video,imagenes,estacionamiento,banos,oficinas,pisos) {
        return db.execute(
            'CALL saveComercial(?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [descripcion, precio, estado,municipio,colonia,calle,cp,terreno,video,imagenes,estacionamiento,banos,oficinas,pisos]);     
    }

    static saveTerreno(descripcion,precio,estado,municipio,colonia,calle,cp,terreno,video,imagenes) {
        return db.execute(
            'CALL saveTerreno(?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [descripcion, precio, estado,municipio,colonia,calle,cp,terreno,video,imagenes,estacionamiento,banos,oficinas,pisos]);     
    } 
    
    static updateResidencial(id,titulo,descripcion,recamaras) {
        return db.execute(
            'CALL updateResidencial(?,?,?,?)', 
            [id,titulo,descripcion,recamaras]);
    }


    static find(valor_busqueda) {
        return db.execute('SELECT * FROM propiedades WHERE Colonia LIKE ? ', ['%' + valor_busqueda + '%']);
    }

    //Este método servirá para devolver los ultimos 4 objetos de la tabla 
    static fetchAll() {
        return db.execute('SELECT * FROM propiedades');
    }

    static fetchOne(id) {
        return db.execute('SELECT * FROM propiedades WHERE IdPropiedad = ?', [id]);
    }

    static fetchAsignado(id) {
        return db.execute('SELECT * FROM asigancion WHERE IdUsuario = ?', [id]);
    }

    static isResidencial(id) {
        return db.execute('SELECT * FROM residencial WHERE IdPropiedad = ?', [id]);
    }

    static isComercial(id) {
        return db.execute('SELECT * FROM comercial WHERE IdPropiedad = ?', [id]);
    }

    static isTerreno(id) {
        return db.execute('SELECT * FROM terreno WHERE IdPropiedad = ?', [id]);
    }


}