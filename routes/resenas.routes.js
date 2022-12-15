const express = require('express');
const resenasController = require('../controllers/resenas.controller');
const isAdmin = require('../util/is-Admin');
const isAuth = require('../util/is-auth');
const router = express.Router();
const path = require('path');

router.use(express.static(path.join(__dirname, '..','public')));

router.get('/', resenasController.get_resena);
router.post('/', isAuth, resenasController.postAdd);
router.post('/delete', isAdmin, resenasController.post_delete_ajax);
router.get('/fetch', resenasController.resena_ajax);
router.post('/aprobado', isAdmin, resenasController.aprobado_ajax);
module.exports = router;