const { request } = require('http');
const path = require('path');
const listEstatus = require('../models/estatus.model');

exports.get_root = (request, response, next) => {


    listEstatus.fetchAll()
        .then( ([rows, fieldData]) => {
            console.log(rows);
            response.render(path.join('Estatus', 'estatus.ejs'), {
                listEstatus: rows
            }); 

        }).catch( (error) => {
            console.log(error);
        });

};