const path = require('path');
const Dashboard = require('../models/dashboard.model');

//El metodo obtiene las 4 propiedades más recientes
exports.get_dashboard = (request, response, next) => {
    let sesionID = response.locals.IdUser;
    Dashboard.fetchUser(sesionID).then( ([usuarioData, fieldData]) => {
            console.log(usuarioData);
            response.render(path.join('dashboard', 'dashboard.ejs'), {
                usuario: usuarioData[0],
                sesionId: response.locals.IdRol, 
                sesionUser: response.locals.IdUser,
            }); 
            

        }).catch( (error) => {
            console.log(error);
        });    
};

exports.get_propiedadesAsignadas = (request, response, next) => {
    let id = response.locals.IdUser;
    Dashboard.fetchAsigando(id)
        .then( ([propiedadesAsignadas, fieldData]) => {
            Dashboard.fetchUser(id).then( ([usuarioData, fieldData]) => {
                    console.log(usuarioData);
                    console.log(propiedadesAsignadas);
                    console.log(id);
                    let cantidad = propiedadesAsignadas.length;
                    response.render(path.join('dashboard', 'dashboard.propiedadAsignada.ejs'), {
                        usuario: usuarioData[0],
                        sesionId: response.locals.IdRol, 
                        sesionUser: response.locals.IdUser,
                        propiedad: propiedadesAsignadas,
                        cantidad: cantidad,
                    }); 
                    
        
                }).catch( (error) => {
                    console.log(error);
                });  
        }).catch( (error) => {
            console.log(error);
        });

};


