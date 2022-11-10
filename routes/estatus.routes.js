const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');

router.get('/', estatusController.get_EstatusP);

router.get('/:idPropiedad', estatusController.get_AvanceP);

module.exports = router;