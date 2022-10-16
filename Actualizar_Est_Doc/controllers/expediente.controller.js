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
        response.render('./Expediente/expediente', {name: 'Andrea Castillo', info: rows});
    }).catch((error) => {
        console.log(error);
        response.redirect('/fail');
    });
}