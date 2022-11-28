const { response } = require('express');
const { body } = require('express-validator');
const { request } = require('http');
const path = require('path');
const Dashboard = require('../models/dashboard.model');
const listEstatus = require('../models/estatus.model');

exports.get_EstatusP = (request, response, next) => {
    let userid = request.session.IdUser;
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
                        nombre      : response.locals.NombreUser    ,
                        telefono    : response.locals.Telefono  ,
                        email       : response.locals.Email     ,
                        sesionId: response.locals.IdRol, 
                        sesionUser: response.locals.IdUser,
                        permisos: request.session.permisos,
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
            //console.log(rows);
            listEstatus.fetchAvanceR(properid)
                .then( ([rows2, fieldData2]) => {
                    if(rows.length > 0 || rows2.length > 0){
                        return response.render(path.join('Estatus', 'estatus.ejs'), {
                            listEstatus: rows,
                            listEstatus2: rows2,
                            permisos: request.session.permisos,
                        });
                    }

                    else{

                        request.session.info = 'La propiedad no cuenta con seguimiento activo';

                        return response.render(path.join('Dashboard', 'dashboard.noDisponible.ejs'), {
                            permisos: request.session.permisos,
                            nombre      : response.locals.NombreUser    ,
                            telefono    : response.locals.Telefono  ,
                            email       : response.locals.Email     ,
                            
                        });

                    }
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
        console.log(rows);
        if(rows.length > 0){
            listEstatus.updateEstatusC(request.body.estado, request.body.idPaso, request.body.idpro).then(([rows, fieldData])=> {
                   // console.log(rows);
                    console.log('entro en update status');
                    response.status(200).json({
                    mensaje: "El estado fue actualizado para c ",
                    status: request.body.estado,
                    idPaso: request.body.idPaso,
                    idpro: request.body.idpro,
                    permisos: request.session.permisos,
                }); 
            }).catch(error => {
                console.log(error)
            });
        }
        else {
            listEstatus.updateEstatusR(request.body.estado, request.body.idPaso, request.body.idpro)
            .then(([rows2, fieldData2])=> {
                //console.log('entro en update rnta');
                //console.log(rows2);
                response.status(200).json({
                    mensaje: "El estado fue actualizado para r",
                    status: request.body.estado,
                    idPaso: request.body.idPaso,
                    idpro: request.body.idpro,
                });   
            }).catch(error => {console.log(error)})
        }

    }).catch(error => {console.log(error)});    
}

exports.post_cancelProcedimiento = (request, response, next) => {
    listEstatus.cancelProceso(request.body.idpro)
        .then(([rows2, fieldData2])=> {
            response.status(200).json({
                mensaje: "El avance de proceso fue cancelado ",   
            }); 
        }).catch(error => {console.log(error)});
}