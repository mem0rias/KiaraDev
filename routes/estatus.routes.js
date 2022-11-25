const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');
const isSeguimiento = require('../util/is-seguimiento');

router.get('/', estatusController.get_EstatusP);

router.post('/update', estatusController.post_update);

router.get('/:idPropiedad', isSeguimiento ,estatusController.get_AvanceP);



module.exports = router;