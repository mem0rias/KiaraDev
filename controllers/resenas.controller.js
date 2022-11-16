const { info } = require('console');
const { get } = require('http');
const { userInfo } = require('os');
const path = require('path');
const { get_idComentario } = require('../models/resenas.model');
const Resenas = require('../models/resenas.model');
const Dashboard = require('../models/dashboard.model');
const moment = require('moment');
moment.locale('es-mx');


exports.get_resena = (request, response, next) => {
    let info = request.body;
    Resenas.fetchAll().then(([rows, fieldData]) => {
        // console.log(rows);
        for (let elements of rows) {
            elements.fecha = moment(elements.fecha).format('lll');
        }
        response.render('./resenas/resenas', {
            info: rows,
            logged: request.session.isLoggedIn,

        });
    }).catch(err => {
        console.log(err);
        return [];
    });
};
exports.postAdd = (request, response, next) => {
    console.log(request.session.user);
    const resenia = new Resenas(request.session.IdUser, request.body.contenido, '1');
    resenia.save().then(() => {
        response.redirect('/resenas');
        console.log("Se guardó tu reseña");
    }).catch(err => {
        response.status(302).redirect('/resenas');
    });


};

exports.post_delete = (request, response, next) => {

    /*console.log('El valor del id del comentario es: ', request.body.idComentario);*/

    Resenas.delete(request.body.idComentario).then(() => {
        console.log('Se ha borrado el comentario: ', request.body.idComentario);
        response.redirect('/resenas');
    }).catch(error => {
        console.log(error);

    });
};
// Hay que intentar hacerlo con AJAX
/*Resenas.delete(request.body.idComentario).then(() => {
        Resenas.fetchAll().then(([rows, fieldData]) => {
            response.status(200).json({
                mensaje: "La reseña " + request.body.idComentario + " fue eliminada",
                info: rows,
            });
        }).catch(error => { console.log(error) });
    }).catch(error => { console.log(error) });

};*/