const { info } = require('console');
const { userInfo } = require('os');
const path = require('path');
const Resenas = require('../models/resenas.model');


exports.get_resena = (request, response, next) => {
    let info = request.body;
    Resenas.fetchAll().then(([rows, fieldData]) => {
        console.log(rows);
        response.render('./resenas/resenas', {
            info: rows,
        });
    }).catch(err => {
        console.log(err);
        return [];
    });
}
exports.postAdd = (request, response, next) => {
    console.log(request.body.contenido)
    const resenia = new Resenas('3', request.body.contenido, '1');
    resenia.save().then(() => {
        response.redirect('/resenas');
    }).catch(err => {
        response.status(302).redirect('/resenas');
    });

    console.log("Se guardó tu reseña");

}