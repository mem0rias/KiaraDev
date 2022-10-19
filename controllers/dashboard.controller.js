const path = require('path');
const User = require('../models/dashboard.model');
const Propiedad = require('../models/propiedad.model');

//El metodo obtiene las 4 propiedades más recientes
exports.get_dashboard = (request, response, next) => {
    let sesionID = response.locals.IdUser;
        User.fetchOne(sesionID).then( ([usuarioData, fieldData]) => {
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
    Propiedad.fetchAsigando(id)
        .then( ([rows, fieldData]) => {
            console.log(rows);
            response.render(path.join('dashboard', 'dashboard.propiedadAsignada.ejs'), {
                propiedad: rows,
            }); 

        }).catch( (error) => {
            console.log(error);
        });

};
