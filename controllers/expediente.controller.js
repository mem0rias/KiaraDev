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
    expediente.fetchRequirements(request.params.id).then(([rows, fieldData]) => {
        Dashboard.fetchUser(request.params.id).then( ([usuarioData, fieldData]) => {
            console.log(usuarioData);
            response.render('./Expediente/expediente', {
                usuario: usuarioData[0],
                sesionId: response.locals.IdRol, 
                sesionUser: response.locals.IdUser,
                info:rows,
                
            }); 
            
        }).catch( (error) => {
            console.log(error);
        });  
        //console.log(rows);
        //response.render('exito');
       
        
    }).catch((error) => {
        console.log(error);
        response.render('./Expediente/expediente', {name: 'Andrea Castillo', Id: '10', info: ''});
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
    //Ya solo se hace un procedimiento para garantizar atomicidad en la operacion.
    expediente.UpdateRequirements(Comments,Estatus,IdUsuario,Tipo_Doc,nupdates).then(()=>{
        console.log('Se logro!');
        //Token para toast 
        request.session.msg = 'Expediente Actualizado!';
        request.session.exito = 1;
        return request.session.save(err => {
            console.log(request.session.msg);
            //response.redirect('/inicio');
            response.redirect('/dashboard/usuarios');
        });
    }).catch((error) =>{
        console.log(error);
        //Token para toast 
        request.session.msg = 'Error al Actualizar Expediente';
        request.session.exito = 0;
        return request.session.save(err => {
            console.log(request.session.msg);
            //response.redirect('/inicio');
            response.redirect('/expediente/revisar');
        });
    })
    /*for(let i = 0; i < request.body.estatus.length; i++){
        if(body.estatus[i] != '0'){
            expediente.UpdateRequirements(body.Comments[i], body.estatus[i],body.IdUsuario,body.Tipo_Doc[i]).then(()=>{
                console.log('Se logro: ' + i);
                request.session.msg = 'Expediente Actualizado'; 
            }).catch((error) =>{
                console.log(error);
            });
        }
    }*/
    
}


exports.miexp = (request, response, next) => {
    let msgpos = request.session.infopositiva ? request.session.infopositiva : '';
    request.session.infopositiva = ''; 
    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';
    let userid = request.session.IdUser;
    expediente.GetRents(userid).then(([rows, fieldata]) =>{
        expediente.GetBuy(userid).then(([rows2, fieldata2]) =>{
            expediente.GetSelling(userid).then(([rows3, fieldata3]) =>{
                    let array = new Array();
                    let arraytipos = ['5','3','1'];
                    let funcs = new Array();
                    array.push(rows.length != 0);
                    array.push(rows2.length != 0);
                    array.push(rows3.length != 0);
                    console.log(array);
                    
                    return request.session.save(err => {
                        response.render('./Expediente/expedienteCliente', {arr: array, user: userid, info: msg, infopositiva: msgpos});
                    });
                
                
                
            })
        })
    }).catch(err=>{
        let array = [0,0,0];
        msg = 'Hay un problema con el servidor. Intentalo de nuevo mas tarde';
        msgpos = '';
        return request.session.save(err => {
            response.render('./Expediente/expedienteCliente', {arr: array, user: userid, info: msg, infopositiva: msgpos});
        });
    });

    
}

exports.fetchinfo = (request, response, next) => {
    let query = request.params.tipo;
    let user = request.session.IdUser;
    console.log(query + " "+  user);
    expediente.fetchRequirements(query,user).then(([rows, fieldData]) =>{
        response.status(200).json(rows);
    }).catch(err =>{
        console.log(err);
    });
    
    /*

    
    expediente.fetchReqs(query).then(([rows,fieldData]) => {
        expediente.fetchFiles(request.session.IdUser).then(([rows2, fielddata2]) => {
            response.status(200).json({ reqs: rows, files: rows2});
        }).catch(err =>{
            console.log(err);
            response.status(200).json('err');
        })
        
    }).catch(err => {
        console.log(err);
        response.status(200).json('err');
    })
    */
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
    console.log(request.files);
    console.log(request.body);
    let filepaths = '';
    let tiposArchivos = request.body.SelFiles;
    let user = request.session.IdUser;
    for(elements of request.files){
        filepaths += elements.path + ',';
    }

    console.log(filepaths);
    console.log(tiposArchivos);
    expediente.UploadFile(tiposArchivos,request.files.length,user,filepaths).then(() =>{
        request.session.infopositiva = 'Archivos guardados Exitosamente';
        return request.session.save(err => {
            response.redirect('/expediente/miexpediente');
        });
        
    }).catch(err =>{
        request.session.info = 'Error al subir los archivos';
        delfiles(request.files);
        return request.session.save(err => {
            response.redirect('/expediente/miexpediente');
        });

    });
    
}


const delfiles = (r) => {
    for(elements of r){
        fs.unlinkSync('.\\' + elements.path);
    }
}