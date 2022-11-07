const path = require('path');
//const Reseñas = require('../models/resenas.model');

exports.get_resena = (request, response, next) => {
    response.render('./resenas/resenas');
}