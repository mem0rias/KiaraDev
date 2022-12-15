const express = require('express');
const indexController = require('../controllers/index.controller');

const router = express.Router();
const path = require('path');

router.use(express.static(path.join(__dirname, '..','public')));

router.get('/', indexController.get_index);

module.exports = router;