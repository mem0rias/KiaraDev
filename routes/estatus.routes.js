const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');
const isSeguimiento = require('../util/is-seguimiento.js');
const isAuth= require('../util/is-auth.js');
const initProc = require('../util/init-Proc.js');
const path = require('path');

router.use(express.static(path.join(__dirname, '..','public')));

router.get('/', isAuth, estatusController.get_EstatusP);

router.post('/update',isAuth, estatusController.post_update);

router.post('/cancel',isAuth, initProc, estatusController.post_cancelProcedimiento); //Solo admin/Agente

router.get('/asignar/:idPropiedad', initProc, isAuth, estatusController.Init_Proceso); //Solo admin/Agente

router.get('/:idPropiedad',isAuth, isSeguimiento ,estatusController.get_AvanceP);

router.post('/iniciar', isAuth, initProc, estatusController.ProcessInit); // Solo Admin/Agente



module.exports = router;