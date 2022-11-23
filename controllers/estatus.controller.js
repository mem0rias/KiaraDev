const { response } = require('express');
const { body } = require('express-validator');
const { request } = require('http');
const path = require('path');
const Dashboard = require('../models/dashboard.model');
const listEstatus = require('../models/estatus.model');

exports.get_EstatusP = (request, response, next) => {
    let userid = 10;
    Dashboard.fetchUser(userid).then( ([usuarioData, fieldData]) => {
        listEstatus.fetchPropertiesC(userid)
        .then( ([rows, fieldData]) => {
            console.log(rows);
            listEstatus.fetchPropertiesR(userid)
                .then( ([rows2, fieldData2]) => {
                    console.log(rows2);
                    response.render(path.join('dashboard', 'dashboard.Seguimiento.ejs'), {
                        PropertiesC: rows,
                        PropertiesR: rows2,
                        usuario :usuarioData,
                        sesionId: response.locals.IdRol, 
                        sesionUser: response.locals.IdUser,
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

exports.get_AvanceP = (request, response, next) => {
    
    let properid = request.params.idPropiedad;

    listEstatus.fetchAvanceC(properid)
        .then( ([rows, fieldData]) => {
            console.log(rows);
            listEstatus.fetchAvanceR(properid)
                .then( ([rows2, fieldData2]) => {
                    console.log(rows2);
                    response.render(path.join('Estatus', 'estatus.ejs'), {
                        listEstatus: rows,
                        listEstatus2: rows2,
                    });
                                
                }).catch( (error) => {
                    console.log(error);
                }); 

        }).catch( (error) => {
            console.log(error);
        });
}

exports.post_update =(request, response, next) => {
    //console.log(request.body.estado)
    //console.log(request.body.id)


    listEstatus.isEstatusC(request.body.idpro).then(([rows,fieldData]) => {

        listEstatus.updateEstatusC(request.body.estado, request.body.id, request.body.idpro)
        .then(([rows, fieldData])=> {
        if(rows.length > 0){
            listEstatus.updateEstatusC(request.body.estado, request.body.id, request.body.idpro)
            .then(([rows, fieldData])=> {
                console.log(rows);
                console.log('entro en update status');
                response.status(200).json({
                    mensaje: "El estado fue actualizado para c ",
                    status: request.body.estado,
                }); 
            }).catch(error => {
                console.log(error)
            });
        }
        else {
            listEstatus.updateEstatusR(request.body.estado, request.body.id, request.body.idpro)
            .then(([rows2, fieldData2])=> {
                console.log('entro en update rnta');
                console.log(rows2);
                response.status(200).json({
                    mensaje: "El estado fue actualizado para r",
                    status: request.body.estado,
                });   
            }).catch(error => {console.log(error)})

        }
        }).catch(error => {
            console.log(error)
        });

       
    }).catch(error => {console.log(error)});

    

    
}

