const express = require('express');
const resenasController = require('../controllers/resenas.controller');
const router = express.Router();


router.get('/', resenasController.get_resena);
router.post('/', resenasController.postAdd);

module.exports = router;