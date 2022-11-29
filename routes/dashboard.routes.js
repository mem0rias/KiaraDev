const express = require('express');
const dashboardController = require('../controllers/dashboard.controller');
const isAuth = require('../util/is-auth');
const isAdmin = require('../util/is-Admin');

const router = express.Router();
router.post('/usuarios/guardar/', isAuth, dashboardController.saveRol);
router.get('/usuarios/buscar/:busc', isAuth, dashboardController.get_search);

router.get('/', isAuth, dashboardController.get_dashboard);
router.get('/usuarios/roles', isAuth, dashboardController.get_roluserlist);
router.get('/usuarios', isAuth, dashboardController.get_userlist);


router.get('/asignado', isAuth,dashboardController.get_propiedadesAsignadas);

router.get('/info', isAuth,dashboardController.get_Info);
router.post('/info/actualizar', isAuth,dashboardController.post_Info);

module.exports = router;