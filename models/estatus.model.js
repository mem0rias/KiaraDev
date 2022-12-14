const db = require('../util/database');

module.exports = class listEstatus{
    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchPropertiesC(IdUsuario) {
        return db.execute('SELECT DISTINCT a.idpropiedad, Titulo, visibleproceso FROM asignacion a, propiedades p WHERE a.idpropiedad = p.IdPropiedad and (rolprop=21 or rolprop = 23) and Idusuario= ?', [IdUsuario]);
    }
    static fetchPropertiesR(IdUsuario) {
        return db.execute('SELECT DISTINCT a.idpropiedad, Titulo, visibleproceso FROM asignacion a, propiedades p WHERE a.idpropiedad = p.IdPropiedad and rolprop=22 and Idusuario= ?', [IdUsuario]);
    
    }

    static fetchAvanceC(IdProperty){
        return db.execute('SELECT DISTINCT clp.idpropiedad, paso, Descripcion, fecha_inicio+fecha_fin as SumaFechas, fecha_inicio+0 as fechaInicio, Estatus, id FROM cliente_pc_prop clp, pasos_compra pc, asignacion a WHERE clp.IdPaso = pc.paso and VisibleProceso = 1 and clp.IdPropiedad=?',[IdProperty]);
    }
    static fetchAvanceR(IdProperty){
        return db.execute('SELECT DISTINCT clp.idpropiedad, paso, Descripcion, fecha_inicio+fecha_fin as SumaFechas, fecha_inicio+0 as fechaInicio, Estatus, id FROM cliente_pr_prop clp, pasos_renta pc, asignacion a WHERE clp.IdPaso = pc.paso and VisibleProceso = 1 and clp.IdPropiedad=?',[IdProperty]);
    }

    static isEstatusC(IdProperty){
        return db.execute('SELECT * FROM `cliente_pc_prop`  WHERE IdPropiedad = ?',[IdProperty]);
    }

    static isEstatusR(IdProperty){
        return db.execute('SELECT * FROM `cliente_pr_prop`  WHERE IdPropiedad = ?',[IdProperty]);
    }

    static updateEstatusC(Estado, id, idpro) {
        return db.execute('CALL `UpdateCompra`(?,?,?)', [Estado, id, idpro]);
    }

    static updateEstatusR(Estado, id, idpro) {
        return db.execute('CALL `UpdateRenta`(?,?,?)', [Estado, id, idpro]);
    }

    static cancelProceso(idpro){
        return db.execute('CALL cancelarProceso(?)', [idpro]);
    }

    static fetchTransactionType(IdPropiedad) {
        return db.execute('SELECT TipoTransaccion from propiedades where IdPropiedad = ?', [IdPropiedad]);
    }

    static fetchRentSteps(){
        return db.execute('SELECT Paso from pasos_renta');
    }

    static fetchBuySteps(){
        return db.execute('SELECT Paso from pasos_compra');
    }
    static getUsers(){
        return db.execute('SELECT IdUsuario, nombre, PA, SA, Email from usuario')
    }

    static IniciarVenta(ListPasos, NPasos,Propietario,Cliente,Propiedad,U_CasadoP,U_CasadoC){
        return db.execute('CALL `IniciarVenta`( ?, ?, ?, ?, ?, ?, ?)',[ListPasos,NPasos,Propietario,Cliente,Propiedad,U_CasadoP,U_CasadoC]);
    }

    static IniciarRenta(ListPasos, NPasos,Propietario,Cliente,Propiedad,U_CasadoP,U_CasadoC){
        return db.execute('CALL `IniciarRenta`( ?, ?, ?, ?, ?, ?, ?)',[ListPasos,NPasos,Propietario,Cliente,Propiedad,U_CasadoP,U_CasadoC]);
    }

    static FetchAsignados(IdPropiedad){
        return db.execute('SELECT u.nombre, u.PA, u.SA, u.Telefono, u.IdUsuario, u.email from usuario u, asignacion a where u.IdUsuario = a.IdUsuario and IdPropiedad = ? order by RolProp ASC', [IdPropiedad]);
    }
}
