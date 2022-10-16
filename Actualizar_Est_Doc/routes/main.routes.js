const mainControl  = require('../controllers/main.controller');
const express = require('express');
const router = express.Router();
const isAuth= require('../util/is-auth.js');
const path = require('path');
router.use(express.static(path.join(__dirname, '..','public')));

router.post('/login', mainControl.loginverf);
router.get('/login', mainControl.login);
router.post('/inicio', isAuth, mainControl.submit);
router.get('/inicio', isAuth, mainControl.inicio);
router.post('/seleccion', mainControl.nav);
router.get('/pregs',mainControl.preguntas)
router.post('/load', mainControl.updateinfo);
router.get('/editar2/:consulta', isAuth, mainControl.selectedit);
router.get('/editar', isAuth, mainControl.edit);
router.use('/success', mainControl.success);
router.use('/fail', mainControl.fail);
router.get('/logout', isAuth, mainControl.logout);
router.get('/busqueda', mainControl.busqueda);



router.get('/', isAuth, mainControl.inicio);
router.get(mainControl.error);

module.exports = router;