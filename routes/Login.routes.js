const LoginControl  = require('../controllers/Login.controller');
const express = require('express');
const router = express.Router();
const islogged = require('../util/is-logged.js');
const path = require('path');
const { body, validationResult } = require('express-validator');

router.use(express.static(path.join(__dirname, '..','public')));

router.post('/', LoginControl.loginverf); //Autentica al usuario
router.get('/', islogged,LoginControl.login); // entrada al login, middleware evita que se ingreseotra vez a esa ruta si ya hay una sesion iniciada.
router.get('/resetear-contrasena', LoginControl.updatePassw);//Recuperar la contraseña del usuario
router.post('/registrarse',body('el1[3]').isEmail(), body('el1[7]').isLength({ min: 8 }), LoginControl.registrarse); // Post Registro de usuario
router.get('/registrarse',islogged, LoginControl.registro); //Get de pagina de registro
router.get('/logout', LoginControl.logout); // Cerrar sesion.

router.post('/verificarcorreo', body('email').isEmail(), LoginControl.verificarcorr);
router.post('/verificarcontra', body('pass').isLength({ min : 8}), LoginControl.verificarcontra);
module.exports = router;