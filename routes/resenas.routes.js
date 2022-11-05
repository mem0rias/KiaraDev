const express = require('express');
const resenasController = require('../controllers/resenas.controller');

const router = express.Router();
const path = require('path');
//router.get(express.static(path.join(__dirname, '..', 'resenas')));
router.get('/', resenasController.get_resena);

module.exports = router;