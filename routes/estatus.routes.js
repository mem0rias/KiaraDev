const express = require('express');
const router = express.Router();
const estatusController = require('../controllers/estatus.controller');

router.get('/', estatusController.get_root);

module.exports = router;