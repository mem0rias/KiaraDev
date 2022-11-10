const { body } = require('express-validator');
const { request } = require('http');
const path = require('path');
const listEstatus = require('../models/estatus.model');

exports.get_EstatusP = (request, response, next) => {

    let userid = 10;

    listEstatus.fetchPropertiesC(userid)
        .then( ([rows, fieldData]) => {
            console.log(rows);
            listEstatus.fetchPropertiesR(userid)
                .then( ([rows2, fieldData2]) => {
                    console.log(rows2);
                    response.render(path.join('Estatus', 'listEstatus.ejs'), {
                        PropertiesC: rows,
                        PropertiesR: rows2,
                    });
                }).catch( (error) => {
                    console.log(error);
                }); 

        }).catch( (error) => {
            console.log(error);
        });
}

exports.get_AvanceP = (request, response, next) => {
    
    let properid = request.params.idPropiedad;

    listEstatus.fetchAvanceC(properid)
        .then( ([rows, fieldData]) => {
            console.log(rows);
            listEstatus.fetchAvanceR(properid)
                .then( ([rows2, fieldData2]) => {
                    listEstatus.fetchPasosC()
                        .then( ([rows3, fieldData3]) => {
                            listEstatus.fetchPasosR()
                                .then( ([rows4, fieldData4]) => {
                                    response.render(path.join('Estatus', 'estatus.ejs'), {
                                        listEstatus: rows,
                                        listEstatus2: rows2,
                                        pasosC: rows3,
                                        pasosR: rows4,
                                    });
                                }).catch( (error) => {
                                    console.log(error);
                                }); 

                        }).catch( (error) => {
                            console.log(error);
                        });
                }).catch( (error) => {
                    console.log(error);
                }); 

        }).catch( (error) => {
            console.log(error);
        });

}
exports.get_pasos = (request, response, next) => {
    
    

}