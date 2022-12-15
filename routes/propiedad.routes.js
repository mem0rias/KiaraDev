const express = require('express');
const propiedadController = require('../controllers/propiedad.controller');
const isAgente = require('../util/is-Agente');
const isAuth= require('../util/is-auth.js');
const path = require('path');

const router = express.Router();
router.use(express.static(path.join(__dirname, '..','public')));
//Rutas para agregar propiedades
router.get('/imagenes/:valor_busqueda', propiedadController.get_Imagenes);

router.get('/registrar', isAuth, isAgente, propiedadController.get_new);
router.post('/registrar', isAuth, isAgente, propiedadController.post_new);

router.get('/', propiedadController.get_propiedades);
router.get('/:id', propiedadController.get_one);

router.get('/editar/:id', isAuth, isAgente, propiedadController.get_edit);
router.post('/editar',  isAuth, isAgente, propiedadController.post_edit);

router.get('/buscar/:valor_busqueda', propiedadController.get_buscar);
router.get('/buscarAsigandos/:valor_busqueda', propiedadController.get_buscarAsigandos);

router.post('/borrar', isAuth, isAgente, propiedadController.post_delete);

module.exports = router;