const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const session = require('express-session');
const csrf = require('csurf');
const csrfProtection = csrf();
const app = express();
app.set('view engine', 'ejs');
app.set('views', 'views');
app.use(express.static(path.join(__dirname, 'public')));
const cookieParser = require('cookie-parser');

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());



app.use(cookieParser());

app.use(session({
    secret: 'aerfgtvythvyugt54cyh4yhyhy6h46yr5ky87br53tgc3g46gg', 
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));
app.use(csrfProtection);

app.use((request, response, next) => {
    response.locals.csrfToken = request.csrfToken();
    response.locals.sesion = request.session.user ? request.session.user : '';
    next();
});




const rutass = require('./routes/main.routes');
const expediente = require('./routes/expediente.routes');
app.use('/', rutass);
app.use('/expediente', expediente);
app.listen(3000);