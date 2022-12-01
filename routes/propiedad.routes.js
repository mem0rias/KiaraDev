const express = require('express');
const propiedadController = require('../controllers/propiedad.controller');
const isAuth= require('../util/is-auth.js');

const router = express.Router();

//Rutas para agregar propiedades
router.get('/imagenes/:valor_busqueda', propiedadController.get_Imagenes);

router.get('/registrar', isAuth, propiedadController.get_new);
router.post('/registrar', isAuth, propiedadController.post_new);

router.get('/', propiedadController.get_propiedades);
router.get('/:id', propiedadController.get_one);

router.get('/editar/:id', isAuth, propiedadController.get_edit);
router.post('/editar',  isAuth,propiedadController.post_edit);

router.get('/buscar/:valor_busqueda', propiedadController.get_buscar);
router.get('/buscarAsigandos/:valor_busqueda', propiedadController.get_buscarAsigandos);

router.post('/borrar', isAuth, propiedadController.post_delete);

module.exports = router;