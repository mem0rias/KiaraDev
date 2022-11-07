const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
const multer = require('multer');

const app = express();

//Configurar el motor de templates como ejs
app.set('view engine', 'ejs');
//Definir la carpeta views como carpeta de vistas para ejs
app.set('views', 'views');


app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//fileStorage: Es nuestra constante de configuración para manejar el almacenamiento
const fileStorage = multer.diskStorage({
    destination: (request, file, callback) => {
        //'uploads': Es el directorio del servidor donde se subirán los archivos 
        callback(null, './Expedientes');
    },
    filename: (request, file, callback) => {
        //aquí configuramos el nombre que queremos que tenga el archivo en el servidor, 
        //para que no haya problema si se suben 2 archivos con el mismo nombre concatenamos el timestamp
        callback(null, new Date().getSeconds() + '' + new Date().getDay() + '' + new Date().getMonth() + '' + new Date().getYear() + file.originalname);
    },
});

const fileFilter = (request, file, callback) => {
    if (file.mimetype == 'application/pdf') {
        callback(null, true);
    } else {
        console.log('te equivocaste pana');
        callback(null, false);

    }
}


app.use(multer({ storage: fileStorage, fileFilter: fileFilter }).any('archivo2'));
//app.use(multer({ storage: fileStorage }).single('archivo')); 


//Declarar rutas
const rutasPropiedades = require('./routes/propiedad.routes');
const rutasIndex = require('./routes/index.routes');
const rutasDashboard = require('./routes/dashboard.routes');
const rutasLogin = require('./routes/Login.routes');
const expediente = require('./routes/expediente.routes');

app.use(session({
    secret: 'aerfgtvythvyugt54cyh4yhyhy6h46yr5ky87br53tgc3g46gg',
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));

app.use((request, response, next) => {
    response.locals.csrfToken = 'dummytoken';
    response.locals.sesion = request.session.user ? request.session.user : '';
    response.locals.IdUser = request.session.IdUser ? request.session.IdUser : '';
    response.locals.IdRol = request.session.IdRol ? request.session.IdRol : '';
    response.locals.msg = request.session.msg ? request.session.msg : '';
    response.locals.exito = request.session.exito ? request.session.exito : 0;
    next();
});
//Declarar app.use de las rutas
app.use('/propiedades', rutasPropiedades);
app.use('/index', rutasIndex);
app.use('/dashboard', rutasDashboard);
app.use('/login', rutasLogin);
app.use('/expediente', expediente);

app.get('/', (request, response, next) => {
    response.redirect('/index');
});
//Middleware
app.use((request, response, next) => {
    console.log('Middleware!');
    next(); //Le permite a la petición avanzar hacia el siguiente middleware
});
app.use((request, response, next) => {
    response.status(404);
    response.sendFile(path.join(__dirname, 'views', 'error.html'));
});


//
let formatc = new Intl.NumberFormat("en-IN", { style: "currency", currency: "USD" })

app.listen(3000);