const path = require('path');
const User = require('../models/dashboard.model');
const Propiedad = require('../models/index.model');

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

exports.get_userlist = (request, response, next) =>{
    response.render(path.join('dashboard', 'listaUsuarios.ejs'));

}

exports.get_search = (request, response, next) => {
    User.fetchEmailRol(request.params.busc).then(([rows, FieldData]) =>{
        console.log(rows);
        response.status(200).json(rows);
    }).catch(err =>{
        console.log(err);
    })
    

}
