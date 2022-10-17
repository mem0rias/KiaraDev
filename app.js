const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

//Configurar el motor de templates como ejs
app.set('view engine', 'ejs');
//Definir la carpeta views como carpeta de vistas para ejs
app.set('views', 'views');


app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({extended: false}));

//Declarar rutas
const rutasPropiedades = require('./routes/propiedad.routes');
const rutasIndex = require('./routes/index.routes');
const rutasDashboard = require('./routes/dashboard.routes');
const { response } = require('express');

//Declarar app.use de las rutas
app.use('/propiedades', rutasPropiedades);
app.use('/index', rutasIndex);
app.use('/dashboard', rutasDashboard);

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
let formatc = new Intl.NumberFormat("en-IN",
{style: "currency", currency: "USD"}
)

app.listen(3000);