const express = require('express');
const propiedadController = require('../controllers/propiedad.controller');

const router = express.Router();

router.get('/', propiedadController.get_propiedades);
router.get('/:id', propiedadController.get_one);

//Rutas para agregar propiedades
router.get('propiedad/new', propiedadController.get_new);
router.post('propiedad/new', propiedadController.post_new);



module.exports = router;