//const { info } = require('console');
const { userInfo } = require('os');
const path = require('path');
const Resenas = require('../models/resenas.model');


exports.get_resena = (request, response, next) => {
    let info = request.body;
    Resenas.instanceof().then(([rows, fieldData]) => {
        console.log(rows);
        response.render('./resenas/resenas', {
            info: rows
        });
    }).catch(err => {
        console.log(err);
    });
    /*
        Resenas.fetchcomment(info.Resenas).then(([rows, fieldData]) => {
            const res = new Resenas();
            res.save().then(() => {

            }).catch((error) => {
                // Si la BD no esta disponible se envia este mensaje
                request.session.info = 'Hay un problema con la pagina, intentalo mas tarde';
                return request.session.save(err => {
                    response.redirect('/resenas');
                });
            });
        }).catch((error) => {
            request.session.info = 'Hay un problema con la pagina, intentalo mas tarde';
            console.log(error);
            response.redirect('/');
        });*/
}