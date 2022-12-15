const express = require('express');
const dashboardController = require('../controllers/dashboard.controller');
const isAuth = require('../util/is-auth');
const isAdmin = require('../util/is-Admin');

const path = require('path');
const isAgent = require('../util/is-Agente');

const router = express.Router();

router.use(express.static(path.join(__dirname, '..','public')));

router.post('/usuarios/guardar/', isAuth, isAdmin, dashboardController.saveRol);
router.get('/usuarios/buscar/:busc', isAuth, isAgent, dashboardController.get_search);

router.get('/', isAuth, dashboardController.get_dashboard);
router.get('/usuarios/roles', isAuth, isAdmin,dashboardController.get_roluserlist);
router.get('/usuarios', isAuth, isAgent, dashboardController.get_userlist);


router.get('/asignado', isAuth,dashboardController.get_propiedadesAsignadas);
router.get('/MisPropiedades', isAuth, dashboardController.getPropiedades_Propias);

router.get('/info', isAuth,dashboardController.get_Info);
router.post('/info/actualizar', isAuth,dashboardController.post_Info);

module.exports = router;