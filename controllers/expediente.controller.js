const path = require('path');
const User = require('../models/expediente.model');
const bcrypt = require('bcryptjs');
const expediente = require('../models/expediente.model');
const Dashboard = require('../models/dashboard.model');
const fs = require('fs');
exports.rev = (request, response, next) =>{
    response.render('./Expediente/expediente');
}

exports.getReqs = (request, response, next) => {
    let msgpos = request.session.infopositiva ? request.session.infopositiva : '';
    request.session.infopositiva = ''; 
    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';

    let exp_types = new Map();
    expediente.fetchExpTypes(request.params.id).then(([rows, fieldData]) => {
        Dashboard.fetchUser(request.params.id).then(([username, fieldData2]) =>{
            for(elements of rows){
                exp_types.set(elements.Tipo_Exp, elements.descripion);
            }
    
            // Render de la consulta con los valores del mapa, mensajes, etc.
            return request.session.save(err => {
                response.render('./Expediente/expediente', {map: exp_types, usuario: username[0], info: msg, infopositiva: msgpos});
            });
        }).catch(err =>{
            console.log(err);
        });
        // Inicializacion del mapa con los valores de la consulta
        
    }).catch(err=>{
        msg = 'Hay un problema con el servidor. Intentalo de nuevo mas tarde';
        msgpos = '';
        return request.session.save(err => {
            response.render('./Expediente/expediente', {map: exp_types, usuario: userid, info: msg, infopositiva: msgpos});
        });
    });

}

exports.actualizar = (request, response, next) => {
    console.log(request.body);
    let body = request.body;
    let nupdates = body.estatus.length;
    let Comments = "";
    let Estatus = "";
    let Tipo_Doc = "";
    let IdUsuario = body.IdUsuario;
    //Concatenacion de datos en strings separados por comas, la BD los decodifica despues
    for(let i = 0; i < nupdates; i++){
        Comments += body.Comments[i];
        Estatus += body.estatus[i];
        Tipo_Doc += body.Tipo_Doc[i];
        if(i != nupdates-1){
            Comments += ',';
            Estatus += ',';
            Tipo_Doc += ',';
        }
    }
    console.log(Comments);
    console.log(Estatus);
    console.log(Tipo_Doc);
    console.log(IdUsuario)
    console.log(nupdates);
    
    expediente.UpdateRequirements(Comments,Estatus,IdUsuario,Tipo_Doc,nupdates).then(()=>{
        response.status(200).json('OK');
    }).catch(err =>{
        console.log(err);
        response.status(503).json('FAIL');
    });

    //Ya solo se hace un procedimiento para garantizar atomicidad en la operacion.
    /*
    expediente.UpdateRequirements(Comments,Estatus,IdUsuario,Tipo_Doc,nupdates).then(()=>{
        
        //Token para toast 
        request.session.infopositiva = 'Expediente Actualizado!';
        return request.session.save(err => {
            console.log(request.session.msg);
            //response.redirect('/inicio');
            response.redirect('/expediente/revisar/' + IdUsuario);
        });
    }).catch((error) =>{
        console.log(error);
        //Token para toast 
        request.session.info = 'Error al Actualizar Expediente';
        return request.session.save(err => {
            console.log(request.session.msg);
            //response.redirect('/inicio');
            response.redirect('/expediente/revisar/' + IdUsuario);
        });
    })
    */
}


exports.miexp = (request, response, next) => {
    
    // Mensajes que se desplegaran si se guardan los cambios, o hay errores ,etc...
    let msgpos = request.session.infopositiva ? request.session.infopositiva : '';
    request.session.infopositiva = ''; 
    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';
    let userid = request.session.IdUser;
    // Este mapa almacena los tipos de expediente que tiene ligado el usuario
    let exp_types = new Map();
    expediente.fetchExpTypes(userid).then(([rows, fieldData]) => {
        
        // Inicializacion del mapa con los valores de la consulta
        for(elements of rows){
            exp_types.set(elements.Tipo_Exp, elements.descripion);
        }

        // Render de la consulta con los valores del mapa, mensajes, etc.
        return request.session.save(err => {
            response.render('./Expediente/expedienteCliente', {map: exp_types, user: userid, info: msg, infopositiva: msgpos});
        });
    }).catch(err=>{
        msg = 'Hay un problema con el servidor. Intentalo de nuevo mas tarde';
        msgpos = '';
        return request.session.save(err => {
            response.render('./Expediente/expedienteCliente', {map: exp_types, user: userid, info: msg, infopositiva: msgpos});
        });
    });
   
    
}

exports.fetchinfo = (request, response, next) => {
    // Obtencion de manera asincrona de los archivos que ya tiene el usuario y los pendientes 
    // para el tipo de expediente dado
    let query = request.params.tipo;
    let user = request.session.IdUser;
    console.log(query + ' ' +  user);
    expediente.fetchRequirements(query,user).then(([rows, fieldData]) =>{
        response.status(200).json(rows);
    }).catch(err =>{
        response.status(503).json('fail');
        console.log(err);
    });
    
}


exports.fetchiuserinfo = (request, response, next) => {
    // Obtencion de manera asincrona de los archivos que ya tiene el usuario y los pendientes 
    // para el tipo de expediente dado
    let query = request.params.tipo;
    let user = request.params.usuario;
    console.log(query +  ' ' +  user);
    expediente.fetchRequirements(query,user).then(([rows, fieldData]) =>{
        response.status(200).json(rows);
    }).catch(err =>{
        response.status(503).json('fail');
        console.log(err);
    });
    
}


exports.descargarArchivo = (request, response, next) => {
    console.log(request.params);
    const file = `./public/Expedientes/10/`+request.params.id+'.txt';
        expediente.DownloadFile(request.params.id, 3, 10).then(([rows, fieldData]) =>{
        console.log(rows);
        response.download(rows[0].URL);
    }).catch( err =>{
        console.log(err);
        request.session.msg = "No se puede descargar el archivo";
        request.session.exito = 0;
        return request.session.save(err => {
            console.log(request.session.msg);
            //response.redirect('/inicio');
            response.redirect('/expediente/revisar');
        });
        
    });
}

exports.subirarch = (request, response, next) => {
    
    // Esta funcion se encarga de cargar y eliminar archivos si es necesario
    console.log(request.files);
    console.log(request.body);
    
    
    let filepaths = '';
    /* Esta variable contiene la lista de archivos que se modificaran en la BD
        Se crea en base a 2 listas.
            1. - Archivos que se añadieron unicamente
            2. - Archivos que se eliminaran del registro del usuario
            Si se estan tanto añadiendo como eliminando archivos se insertan primero los archivos a añadir seguido de los que se borraran.

    */
    let tiposArchivos = request.files.length > 0 ? request.body.SelFiles + ',' + request.body.RMFiles : request.body.RMFiles ;
    let user = request.session.IdUser;
    let totalfiles = request.files.length + parseInt(request.body.NRMFiles);
    let estatuslist = '';

    //Se genera un string con los paths de los nuevos archivos
    // De igual manera se crea la lista de estatus con 1s para simbolizar que ese archivo esta pendiente a ser revisado

    for(elements of request.files){
        filepaths += elements.path + ',';
        estatuslist += '1,';
    }

    // Si hay archivos que se eliminaran se pone el path vacio y en la lista del estatus se pone un 0 que equivale a faltante
    for(let i = 0; i < request.body.NRMFiles; i++){
        filepaths += ',';
        estatuslist += '0,';
    }
    console.log(filepaths);
    console.log(tiposArchivos);
    console.log(totalfiles);
    // Stored procedure que recibe los strings que generamos y los aplica en la BD
    expediente.UploadFile(tiposArchivos,totalfiles,user,filepaths, estatuslist).then(() =>{
        // Se revisa si hay archivos que remover de la carpeta del usuario
        if(request.body.removepaths != ''){
            let removepaths = request.body.removepaths.split(',');
            
                for(elements of removepaths){
                    // Chequeo de seguridad, el usuario solo puede borrar archivos dentro de su directorio.
                    if(elements.split('\\')[1] == user.toString(10))
                        fs.unlinkSync('.\\' + elements);
                    else
                        console.log('Illegal path');
                
                }
            
            
        }   
        // Respuesta positiva.
        request.session.infopositiva = 'Archivos guardados Exitosamente';
        return request.session.save(err => {
            response.redirect('/expediente/miexpediente');
        });
        
    }).catch(err =>{
        // Si hay un error no se hace ningun cambio y se le informa al usuario.
        console.log(err);
        request.session.info = 'Error al subir los archivos';
        // Se borran los archivos que se pretendian añadir a la BD.
        delfiles(request.files);
        return request.session.save(err => {
            response.redirect('/expediente/miexpediente');
        });

    });
    
}

// Funcion para eliminar archivos en caso de error al actualizar la BD
const delfiles = (r) => {
    for(elements of r){
        fs.unlinkSync('.\\' + elements.path);
    }
}