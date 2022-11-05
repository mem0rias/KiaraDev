const express = require('express');
const resenasController = require('../controllers/resenas.controller');

const router = express.Router();
const path = require('path');
router.use(express.static(path.join(__dirname, '..', 'resenas')));
//router.get('/resenas', resenasController.get_resena);

module.exports = router;