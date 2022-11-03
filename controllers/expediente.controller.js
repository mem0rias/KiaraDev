const path = require('path');
const User = require('../models/expediente.model');
const bcrypt = require('bcryptjs');
const expediente = require('../models/expediente.model');
exports.rev = (request, response, next) =>{
    response.render('./Expediente/expediente');
}

exports.getReqs = (request, response, next) => {
    expediente.fetchRequirements(10).then(([rows, fieldData]) => {
        //console.log(rows);
        //response.render('exito');
        request.session.msg = ''; 
        response.render('./Expediente/expediente', {name: 'Andrea Castillo', Id: '10', info: rows}); // Se tiene que hacer dinamico esto
        
    }).catch((error) => {
        console.log(error);
        response.redirect('/fail');
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
            response.redirect('/expediente/revisar');
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
    
    //response.status(200).json("Aqui va tu archivo bro" + request.params.id);
}