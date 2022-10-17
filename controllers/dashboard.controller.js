const path = require('path');
const Propiedad = require('../models/index.model');

//El metodo obtiene las 4 propiedades más recientes
exports.get_dashboard = (request, response, next) => {

    Propiedad.fetchNew()
        .then( ([rows, fieldData]) => {
            console.log(rows);
            response.render(path.join('dashboard', 'dashboard.ejs'), {
                propiedad: rows,
            }); 
            

        }).catch( (error) => {
            console.log(error);
        });

};
