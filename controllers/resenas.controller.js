const path = require('path');
const Resenas = require('../models/resenas.model');
const moment = require('moment');

moment.locale('es-mx');


exports.get_resena = (request, response, next) => {
    response.render('./resenas/resenas', {
        logged: request.session.isLoggedIn
    });
};

exports.postAdd = (request, response, next) => {
    console.log(request.session.user);
    const resenia = new Resenas(request.session.IdUser, request.body.contenido, '1');
    resenia.save().then(() => {
        response.redirect('/resenas')
            //response.status(200).json('Todo bien :D');
    }).catch(err => {
        response.status(302).redirect('/resenas');
    });


};
exports.resena_ajax = (request, response, next) => {
    let info = request.body;
    Resenas.fetchAll().then(([rows, fieldData]) => {
        response.status(200).json(rows);
    }).catch(err => {
        console.log(err);
        return [];
    });
}

exports.post_delete = (request, response, next) => {
    console.log(request.body.idComentario);
    Resenas.delete(request.body.idComentario).then(() => {
        Resenas.fetchAll().then(([rows, fieldData]) => {
            //response.status(200).json('El comentario fue eliminado');
            response.redirect('/resenas');
        }).catch(error => { console.log(error) });
    }).catch(error => { console.log(error) });

};