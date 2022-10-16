const ExpControl  = require('../controllers/expediente.controller');
const express = require('express');
const router = express.Router();
const isAuth= require('../util/is-auth.js');
const path = require('path');
router.use(express.static(path.join(__dirname, '..','public')));

router.get('/revisar', ExpControl.getReqs);
module.exports = router;