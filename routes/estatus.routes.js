const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');
const editSeguimiento= require('../util/editSeguimiento');

router.get('/', estatusController.get_EstatusP);

router.post('/update', editSeguimiento, estatusController.post_update);

router.get('/:idPropiedad', estatusController.get_AvanceP);



module.exports = router;