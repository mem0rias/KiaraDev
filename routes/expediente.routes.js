const ExpControl  = require('../controllers/expediente.controller');
const express = require('express');
const router = express.Router();
const isAuth= require('../util/is-auth.js');
const path = require('path');
router.use(express.static(path.join(__dirname, '..','public')));

router.get('/revisar', isAuth, ExpControl.getReqs);
router.post('/actualizar', isAuth, ExpControl.actualizar);
router.get('/miexpediente', isAuth, ExpControl.miexp);
router.get('/fetch/:tipo', isAuth,ExpControl.fetchinfo);
module.exports = router;