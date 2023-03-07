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
            'CALL agregarResidencial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [   d.titulo          ,
                d.descripcion     ,
                d.precio          ,
                d.estado          ,
                d.muncipio        ,
                d.colonia         ,
                d.calle           ,
                d.cp              ,
                d.uso             ,
                d.mterreno        ,
                d.mconstruccion   ,
                d.tipotransaccion ,
                d.tipopropiedad   ,
                d.imagenes        ,
                d.video           ,
                d.recamaras       ,
                d.banos           ,
                d.cocina          ,
                d.pisos           ,
                d.estacionamiento ,
                d.gas             ,
                d.userid          
            ]);
    }

    static agregarComercial(d) {
        return db.execute(
            'CALL agregarComercial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [   d.titulo         , 
                d.descripcion    , 
                d.precio         , 
                d.estado         , 
                d.muncipio       , 
                d.colonia        , 
                d.calle          , 
                d.cp             , 
                d.uso            , 
                d.mterreno       , 
                d.mconstruccion  , 
                d.tipotransaccion, 
                d.tipopropiedad  , 
                d.imagenes       , 
                d.video          , 
                d.cuartos        , 
                d.banos          ,
                d.pisos          , 
                d.estacionamiento, 
                d.userid          
            ]);     
    }

    static agregarTerreno(d) {
        return db.execute(
            'CALL agregarTerreno(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [   d.titulo         , 
                d.descripcion    , 
                d.precio         , 
                d.estado         , 
                d.muncipio       , 
                d.colonia        , 
                d.calle          , 
                d.cp             , 
                d.uso            , 
                d.mterreno       , 
                d.mconstruccion  , 
                d.tipotransaccion, 
                d.tipopropiedad  , 
                d.imagenes       , 
                d.video          , 
                d.cuartos        , 
                d.banos          ,
                d.pisos          , 
                d.estacionamiento, 
                d.userid          
            ]);     
    }

    static actulizarResidencial(d) {
        return db.execute(
            'CALL actulizarResidencial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [   d.id              ,
                d.titulo          ,
                d.descripcion     ,
                d.precio          ,
                d.estado          ,
                d.muncipio        ,
                d.colonia         ,
                d.calle           ,
                d.cp              ,
                d.mterreno        ,
                d.mconstruccion   ,
                d.tipotransaccion ,
                d.tipopropiedad   ,
                d.imagenes        ,
                d.video           ,
                d.visibilidad     ,
                d.recamaras       ,
                d.banos           ,
                d.cocina          ,
                d.pisos           ,
                d.estacionamiento ,
                d.gas             ,
                d.Agente        
            ]);    
    }
    
    static actulizarComercial(d) {
        return db.execute(
            'CALL actualizarComercial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
            [   d.id             ,
                d.titulo         , 
                d.descripcion    , 
                d.precio         , 
                d.estado         , 
                d.muncipio       , 
                d.colonia        , 
                d.calle          , 
                d.cp             ,  
                d.mterreno       , 
                d.mconstruccion  , 
                d.tipotransaccion, 
                d.tipopropiedad  , 
                d.imagenes       , 
                d.video          ,
                d.visibilidad    , 
                d.cuartos        , 
                d.banos          ,
                d.pisos          , 
                d.estacionamiento,
                d.Agente         
            ]);    
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

    static fetchAllResidencial() {
        return db.execute('SELECT * FROM residencial');
    }

    static fetchAllComercial() {
        return db.execute('SELECT * FROM comercial');
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

    static getAgenteTel(IdPropiedad) {
        return db.execute('select Telefono from usuario u, asignacion a where u.IdUsuario = a.IdUsuario and a.IdPropiedad = ?', [IdPropiedad]);
    }

    static delete(id) {
        return db.execute('DELETE FROM propiedades WHERE IdPropiedad = ?', [id]);
    }

    static saveImages(ImgList, N_Pics){
        return db.execute('CALL SubirImagen(?,?)', [ImgList,N_Pics]);
    }

    static saveEditImages(ImgList, N_Pics, id){
        return db.execute('CALL SubirImagenEdit(?,?,?)', [ImgList,N_Pics, id]);
    }

    static updateHeader(URL){
        return db.execute('CALL updateHeader(?)', [URL]);
    }

    static fetchImages(id){
        return db.execute('SELECT Imagen, IdImagen FROM Imagenes WHERE IdPropiedad = ?', [id]);
    }

    static getHeaderImage(id){
        return db.execute('select * from Imagenes where IdImagen = (select min(IdImagen) from Imagenes where  IdPropiedad = ?)', [id]);
    }

    static removeImages(ImgList, N_Pics, id){
        return db.execute('CALL  borraImagenes(?,?,?)', [ImgList,N_Pics,id]);
    }

    static setHeaderImage(Img, id){
        return db.execute('UPDATE propiedades set Imagenes = ? where IdPropiedad = ?', [Img,id]);
    }
    
    static getAsignado(idProp){
        return db.execute('select a.IdUsuario, u.Nombre, u.PA, u.SA, u.Email, a.IdPropiedad from asignacion a , usuario u where a.IdUsuario = u.IdUsuario and IdPropiedad = ? and RolProp is NULL', [idProp]);
    }

    static setAsignado(idProp){
        return db.execute('update asignacion set IdUsuario = ? where IdPropiedad = ? and RolProp is NULL', [IdUsuario,idProp]);
    }

    static getAllAgents() {
        return db.execute('select u.IdUsuario, u.Nombre, u.PA, u.SA from usuario u, asignan a where u.IdUsuario = a.IdUsuario and (a.idRol >= 3)');
    }
}