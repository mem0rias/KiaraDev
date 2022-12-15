const express = require('express');
const router = express.Router();
const path = require('path');

router.use(express.static(path.join(__dirname, '..','public')));

router.get('/', (request, response, next) => {
    response.render('../views/Intro/intro.ejs');
});
module.exports = router;