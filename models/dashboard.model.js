const db = require('../util/database');

module.exports = class Dashboard {


    static fetchUser(n){
        return db.execute('SELECT IdUsuario, nombre, PA, SA, eciv, ocupacion, Telefono, email, CURP from usuario where IdUsuario = (?)', [n]);
    }

    static fetchPropName(n) {
        return db.execute('select Titulo from propiedades where IdPropiedad = ?',[n]);
    }
    static fetchAsigando(id_asesor){
        return db.execute('CALL get_propiedades_asignadas(?)', [id_asesor]);
       // return db.execute('SELECT a.IdPropiedad,Visibilidad, Descripcion, Imagenes, Titulo, Colonia, Estado FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = (?)', [n]);
    }

    static fetchAsignadoUser(n){
        return db.execute('SELECT a.IdPropiedad,Visibilidad, Descripcion, Imagenes, Titulo, Colonia, Estado FROM  asignacion a,  propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = (?)', [n]);
    }
    
    static fetchAsigandoPropiedades(id,query){
        return db.execute('CALL `buscarPropiedadAsignada`(?, ?)', [id,query]);
    }
    
    static fetchPropiedadesPropias(id){
        return db.execute('SELECT a.IdPropiedad,Visibilidad, Descripcion, Imagenes, Titulo, Colonia, Estado, RolProp FROM asignacion a, propiedades p WHERE a.IdPropiedad = p.IdPropiedad AND IdUsuario = ? and (RolProp = 23 or RolProp = 24)',[id]);
    }

    /* Metodo para desplegar los usuarios y su informacion */
    static fetchEmailRol(filtro, sel) {
        if(sel == false)
        //CONSULTA PARA BUSQUEDA
            return db.execute('SELECT u.IdUsuario, u.Nombre, u.PA, u.SA, u.Email, u.Telefono, a.idRol FROM usuario u, asignan a where u.IdUsuario = a.idUsuario and (u.Nombre LIKE ? OR u.email LIKE ?) order by a.idRol DESC', ['%'+filtro+'%', '%'+filtro+'%']);
           
        else
        //CONSULTA PARA SOLO DESPLIEGUE DE USUARIOS
            return db.execute('SELECT u.IdUsuario, u.Nombre, u.PA, u.SA, u.Email, u.Telefono, a.idRol FROM usuario u, asignan a where u.IdUsuario = a.idUsuario order by a.IdRol DESC');
    }

    /* Metodo para desplegar los usuario asignados al asesor */
    static fetchUserAsign(filtro, sel, id_asesor){
        
        if(sel == false)
        //CONSULTA PARA BUSQUEDA
            return db.execute('CALL get_exp_asig_busqueda(?,?)', [id_asesor,'%'+filtro+'%']);
           
        else
        //CONSULTA PARA SOLO DESPLIEGUE DE USUARIOS
            return db.execute('CALL get_exp_asig(?) ',[id_asesor]);
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

    static deleteUser(id_user){
        return db.execute('DELETE FROM usuario WHERE usuario.IdUsuario = ?', [id_user]);
    }

    static AllPropAdmin() {
        return db.execute('CALL get_propiedades_PI()');
    }

    static AllAgentProps(id) {
        return db.execute('CALL get_propiedades_asignadas(?)', [id]);
    }
}
