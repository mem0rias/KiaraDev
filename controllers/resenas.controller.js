const path = require('path');
//const Reseñas = require('../models/resenas.model');

exports.get_resena = (request, response, next) => {
    console.log('no pasa bro');
    response.render('./resenas/resenas');
}