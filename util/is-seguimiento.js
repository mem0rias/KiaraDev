const listEstatus = require('../models/estatus.model');
const Dashboard = require('../models/dashboard.model');

module.exports = (request, response, next) => {

    permisos = request.session.permisos;
    console.log(permisos);
    let a = permisos.indexOf('editar_seguimiento') == -1;
    console.log(a);
    let sesionID = response.locals.IdUser;
    if(permisos.indexOf('editar_seguimiento') == -1 ){
            Dashboard.fetchAsignadoUser(sesionID)
            .then( ([propiedadesAsignadas, fieldData]) => {
                   console.log(propiedadesAsignadas);
                    if(propiedadesAsignadas.length > 0){
                        for(let i = 0; i < propiedadesAsignadas.length; i++){
                            if(propiedadesAsignadas[i].IdPropiedad == request.params.idPropiedad){
                                console.log('Es vvalido');
                                return next();
                            }
                        }
                        console.log('No se como llegue aqui');
                        return response.redirect('/dashboard');
                   } 
                   else{
                        listEstatus.fetchPropertiesC(request.session.IdUser)
                        .then( ([propiedadComercial, fieldData]) => {
                            console.log(propiedadComercial);
                            console.log(request.params.idPropiedad);
                        if (propiedadComercial.length > 0){
                            for(let i = 0; i < propiedadComercial.length; i++){
                                if(propiedadComercial[i].idpropiedad == request.params.idPropiedad){
                                    console.log('Es compra');
                                    return next();
                                }
                            }
                            console.log('No se como llegue aqui');
                            return response.redirect('/dashboard');
                            
                
                                
                        }else {
                            listEstatus.fetchPropertiesR(request.session.IdUser)
                            .then( ([rows2, fieldData2]) => {
                                console.log(rows2);
                                let discarda = 0;
                                if(rows2.length > 0){
                                    for(let i = 0; i < rows2.length; i++){
                                        if(rows2[i].idpropiedad == request.params.idPropiedad){
                                            console.log('Es venta'); 
                                            return next();
                                        }
                                    }
                                    
                                    return response.redirect('/dashboard');
                
                                }              
                            }).catch( (error) => {
                                console.log(error);
                            });   
                        }
                
                        }).catch( (error) => {
                                console.log(error);
                        });   
                    }
            }).catch( (error) => {
                        console.log(error);
            });
    }else{
        return next();
    }




}