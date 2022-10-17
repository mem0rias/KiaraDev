const LoginControl  = require('../controllers/Login.controller');
const express = require('express');
const router = express.Router();
//const isAuth= require('../util/is-auth.js');
const path = require('path');
router.use(express.static(path.join(__dirname, '..','public')));

router.post('/', LoginControl.loginverf);
router.get('/', LoginControl.login);
router.post('/registrarse', LoginControl.registrarse);
router.get('/registrarse', LoginControl.registro);
router.get('/logout', LoginControl.logout);

module.exports = router;