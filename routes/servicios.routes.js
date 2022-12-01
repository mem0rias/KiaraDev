const express = require('express');
const router = express.Router();
const path = require('path');

router.get('/', (request, response, next) => {
    response.render(path.join('servicios', 'servicios.ejs'));
});
module.exports = router;