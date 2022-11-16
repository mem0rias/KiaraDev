const express = require('express');
const router = express.Router();
const path = require('path');

router.get('/', (request, response, next) => {
    response.render('../views/contacto/contacto.ejs');
});
module.exports = router;