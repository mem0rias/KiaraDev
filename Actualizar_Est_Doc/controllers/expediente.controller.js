const path = require('path');
const User = require('../models/expediente.model');
const bcrypt = require('bcryptjs');
const expediente = require('../models/expediente.model');
exports.rev = (request, response, next) =>{
    response.render('./Expediente/expediente');
}

exports.getReqs = (request, response, next) => {
    expediente.fetchRequirements(10).then(([rows, fieldData]) => {
        console.log(rows);
        //response.render('exito');
        response.render('./Expediente/expediente', {name: 'Andrea Castillo', Id: '10', info: rows});
    }).catch((error) => {
        console.log(error);
        response.redirect('/fail');
    });
}

exports.actualizar = (request, response, next) => {
    console.log(request.body);
    let body = request.body;
    for(let i = 0; i < request.body.Tipo_Doc.length; i++){
        expediente.UpdateRequirements(body.Comments[i], body.estatus[i],body.IdUsuario,body.Tipo_Doc[i]).then(()=>{
            console.log('Se logro: ' + i);
        }).catch((error) =>{
            console.log(error);
        });
    }
    response.redirect('/revisar');
}