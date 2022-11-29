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
    console.log(request.params.idPropiedad);
    listEstatus.fetchAvanceC(properid)
        .then( ([rows, fieldData]) => {
            //console.log(rows);
            listEstatus.fetchAvanceR(properid)
                .then( ([rows2, fieldData2]) => {
                    if(rows.length > 0 || rows2.length > 0){
                        response.render(path.join('Estatus', 'estatus.ejs'), {
                            listEstatus: rows,
                            listEstatus2: rows2,
                            permisos: request.session.permisos,
                            
                        });
                    }

                    else{

                        request.session.info = 'La propiedad no cuenta con seguimiento activo';

                        response.render(path.join('Dashboard', 'dashboard.noDisponible.ejs'), {
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

exports.Init_Proceso = (request, response, next) => {
    /* To Do: 
              - Generar el proceso dependiendo el tipo de propiedad. Se tiene que checar el uso que se le dara.
              - Generar los tipos_docs 0 para el dueño y el interesado - Se tiene que obtener la lista de pasos primero y despues de eso se genera en la tabla maestra mediante un procedure.
              - Añadir a los 2 interesados a las tablas de asignacion 
              - Modificar los permisos del RBAC para los 2 interesados
              - Generar tipo de doc para la propiedad.
              - Cambiar Visibilidad
    
    */ 
    let idprop = request.params.idPropiedad;
    console.log(idprop);
    listEstatus.fetchTransactionType(idprop).then(([rows, fieldData]) => {
        listEstatus.getUsers().then(([UserList, fieldData2]) =>{
            console.log(rows);
            let Tipo_Transaccion = rows[0].TipoTransaccion;
            response.render('Estatus/InitProceso', {IdPropiedad: idprop, TipoTransaccion: Tipo_Transaccion, list: UserList});
        }).catch(err =>{
            console.log(err);
        })
    }).catch( err => {
        console.log(err);
    });
    
            
}

exports.ProcessInit = (request,response,next) => {
    console.log(request.body);
    let IdPropiedad = request.body.IdPropiedad;
    let Propietario = request.body.Propietario;
    let Cliente = request.body.Interesado;
    let Prop_C = request.body.PropC ? request.body.PropC : 0;
    Prop_C  = Prop_C == 'on' ? 1 : 0;
    let Cliente_C = request.body.ClienteC ? request.body.ClienteC : 0;
    Cliente_C = Cliente_C == 'on' ? 1 : 0;
    let Tipo_Transaccion = request.body.Tipo_Transaccion;
    if(Tipo_Transaccion == 2){
        listEstatus.fetchRentSteps().then(([rows,fieldData])=> {
            console.log(rows);
            
        }).catch(err =>{
            console.log(err);
        });
    }else if(Tipo_Transaccion == 1){
        listEstatus.fetchBuySteps().then(([rows,fieldData])=> {
            console.log(rows);
            let stringPasos = '';
            for(pasos of rows){
                stringPasos += pasos.Paso + ',';
            }
            console.log(stringPasos);
            console.log(rows.length);
            listEstatus.IniciarVenta(stringPasos, rows.length,Propietario,Cliente,IdPropiedad,Prop_C,Cliente_C).then(() =>{
                response.redirect('/dashboard');
            }).catch(err =>{
                console.log(err);
            });
        }).catch(err =>{
            console.log(err);
        });
    }
}

/*
    El admin presiona iniciar proceso.

    Seguido de esto se obteiene el tipo de la propiedad 



*/
