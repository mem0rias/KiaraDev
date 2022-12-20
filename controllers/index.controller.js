const path = require('path');
const Index = require('../models/index.model');
const Propiedad = require('../models/propiedad.model');

//El metodo obtiene las 4 propiedades más recientes
exports.get_index = (request, response, next) => {

    Index.fetchNew().then( ([rows, fieldData]) => {
        Propiedad.fetchAllResidencial()
        .then( ([residencial, fieldData]) => {

            Propiedad.fetchAllComercial()
            .then( ([comercial, fieldData]) => {
                console.log(comercial);
                console.log(rows);
                response.render(path.join('index', 'index.ejs'), {
                    propiedad: rows,
                    residencial: residencial,
                    comercial: comercial,
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

};

