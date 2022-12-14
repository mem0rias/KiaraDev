const ExpControl  = require('../controllers/expediente.controller');
const express = require('express');
const router = express.Router();
const isAuth= require('../util/is-auth.js');
const RevExp = require('../util/RevExp');
const isAssigned = require('../util/is-assigned');
const canDL = require('../util/can-dlProp');
const path = require('path');
const { isatty } = require('tty');
const { route } = require('./propiedad.routes');

router.use(express.static(path.join(__dirname, '..','public')));


router.get('/revisar/:id', isAuth, RevExp, ExpControl.getReqs);
router.post('/actualizar', isAuth, RevExp,ExpControl.actualizar); // AJAX
router.post('/actualizarProp', isAuth, RevExp,ExpControl.ActualizarProp); // AJAX
router.post('/miexpediente', isAuth, ExpControl.subirarch);
router.get('/miexpediente', isAuth, ExpControl.miexp);
router.get('/fetch/prop/:tipo/:IdProp', isAuth, isAssigned, ExpControl.getPropExp); // AJAX
router.get('/fetch/:tipo/:usuario', isAuth, RevExp, ExpControl.fetchiuserinfo); // AJAX
router.get('/fetch/:tipo', isAuth,ExpControl.fetchinfo); // AJAX


router.get('/Propiedad/:IdProp', isAuth, isAssigned,ExpControl.ExpProp);
router.post('/Propiedad', isAuth, ExpControl.subirArchProp);

router.get('/revPropiedad/:idProp',isAuth,RevExp,ExpControl.RevExpProp);


router.get('/download/:IdUsuario/:Tipo_Doc/:Tipo_Exp', isAuth, RevExp, ExpControl.descargarArchivoAgente);
router.get('/download/:Tipo_Doc/:Tipo_Exp', isAuth, ExpControl.descargarArchivoUser);

router.get('/downloadProp/:IdProp/:Tipo_Doc/:Tipo_Exp', isAuth, canDL, ExpControl.descargarArchivoPropAgente);
module.exports = router;