const express = require('express');
const resenasController = require('../controllers/resenas.controller');
const router = express.Router();
const path = require('path');

router.use(express.static(path.join(__dirname, '..','public')));

router.get('/', resenasController.get_resena);
router.post('/', resenasController.postAdd);
router.post('/delete', resenasController.post_delete_ajax);
router.get('/fetch', resenasController.resena_ajax);
router.post('/aprobado', resenasController.aprobado_ajax);
module.exports = router;