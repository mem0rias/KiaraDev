const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');
const isSeguimiento = require('../util/is-seguimiento.js');
const isAuth= require('../util/is-auth.js');
const path = require('path');
router.use(express.static(path.join(__dirname, '..','public')));
router.get('/', isAuth, estatusController.get_EstatusP);

router.post('/update',isAuth, estatusController.post_update);

router.post('/cancel',isAuth, estatusController.post_cancelProcedimiento);

router.get('/asignar/:idPropiedad', isAuth, estatusController.Init_Proceso);

router.get('/:idPropiedad',isAuth, isSeguimiento ,estatusController.get_AvanceP);

router.post('/iniciar', isAuth,estatusController.ProcessInit);



module.exports = router;