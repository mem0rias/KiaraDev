const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');

router.get('/', estatusController.misEstatus);

router.get('/id_Propiedad', estatusController.get_EstatusP);

module.exports = router;