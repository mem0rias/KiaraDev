const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');
const isSeguimiento = require('../util/is-seguimiento');
const isAuth= require('../util/is-auth.js');

router.get('/', isAuth, estatusController.get_EstatusP);

router.post('/update',isAuth, estatusController.post_update);

router.get('/asignar/:idPropiedad', isAuth, estatusController.Init_Proceso);

router.get('/:idPropiedad',isAuth, isSeguimiento ,estatusController.get_AvanceP);



module.exports = router;