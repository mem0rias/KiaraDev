const express = require('express');
const resenasController = require('../controllers/resenas.controller');
const router = express.Router();


router.get('/', resenasController.get_resena);
router.post('/', resenasController.postAdd);
router.post('/delete', resenasController.post_delete);
module.exports = router;