const express = require('express');
const propiedadController = require('../controllers/propiedad.controller');

const router = express.Router();

//Rutas para agregar propiedades
router.get('/registrar', propiedadController.get_new);
router.post('/registrar', propiedadController.post_new);

router.get('/', propiedadController.get_propiedades);
router.get('/:id', propiedadController.get_one);





module.exports = router;