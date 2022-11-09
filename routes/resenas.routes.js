const express = require('express');
const resenasController = require('../controllers/resenas.controller');
const router = express.Router();

/*router.get('/', (request, response, next) => {
    response.send('Respuesta de la ruta "/resenas"');
});*/
router.get('/', resenasController.get_resena);
//router.post('/', resenasController.post_resena)

module.exports = router;