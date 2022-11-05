const LoginControl  = require('../controllers/Login.controller');
const express = require('express');
const router = express.Router();
const islogged = require('../util/is-logged.js');
const path = require('path');
const { body, validationResult } = require('express-validator');

router.use(express.static(path.join(__dirname, '..','public')));

router.post('/', LoginControl.loginverf); //Autentica al usuario
router.get('/', islogged,LoginControl.login); // entrada al login, middleware evita que se ingreseotra vez a esa ruta si ya hay una sesion iniciada.
router.post('/registrarse', LoginControl.registrarse); // Post Registro de usuario
router.get('/registrarse', LoginControl.registro); //Get de pagina de registro
router.get('/logout', LoginControl.logout); // Cerrar sesion.

router.post('/verificar', body('email').isEmail(), LoginControl.verificarcorr);
module.exports = router;