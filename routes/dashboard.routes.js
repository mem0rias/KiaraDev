const express = require('express');
const dashboardController = require('../controllers/dashboard.controller');

const router = express.Router();

router.get('/', dashboardController.get_dashboard);



router.get('/asignado', dashboardController.get_propiedadesAsignadas);

module.exports = router;