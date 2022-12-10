const ExpControl  = require('../controllers/expediente.controller');
const express = require('express');
const router = express.Router();
const isAuth= require('../util/is-auth.js');
const path = require('path');
const { isatty } = require('tty');
const { route } = require('./propiedad.routes');

router.use(express.static(path.join(__dirname, '..','public')));


router.get('/revisar/:id', isAuth, ExpControl.getReqs);
router.post('/actualizar', isAuth, ExpControl.actualizar);
router.post('/actualizarProp', isAuth, ExpControl.ActualizarProp);
router.post('/miexpediente', isAuth, ExpControl.subirarch);
router.get('/miexpediente', isAuth, ExpControl.miexp);
router.get('/fetch/prop/:tipo/:IdProp', ExpControl.getPropExp);
router.get('/fetch/:tipo/:usuario', isAuth, ExpControl.fetchiuserinfo);
router.get('/fetch/:tipo', isAuth,ExpControl.fetchinfo);


router.get('/Propiedad/:IdProp', isAuth, ExpControl.ExpProp);
router.post('/Propiedad', isAuth, ExpControl.subirArchProp);

router.get('/revPropiedad/:idProp', isAuth, ExpControl.RevExpProp);


router.get('/download/:IdUsuario/:Tipo_Doc/:Tipo_Exp', ExpControl.descargarArchivoAgente);
router.get('/download/:Tipo_Doc/:Tipo_Exp', ExpControl.descargarArchivoUser);

router.get('/downloadProp/:IdProp/:Tipo_Doc/:Tipo_Exp', ExpControl.descargarArchivoPropAgente);
module.exports = router;