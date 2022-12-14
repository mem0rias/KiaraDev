const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
const multer = require('multer');
const fs = require('fs');
const csrf = require('csurf');
const csrfProtection = csrf();
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
        // Se obtiene el id del usuario y se revisa si hay una carpeta con el ID ya hecha, si no, la crea. 
        //console.log(request.body);
        //console.log(request.files);
        
        console.log(file.fieldname);
        let newpath = '';
        //if(file.fieldname === 'archivo2'){
            if(file.fieldname === 'archivo2'){
                let user = request.body.user;
                 newpath = `./Expedientes/${user}`;
                fs.mkdirSync(newpath, { recursive: true })
            }else if(file.fieldname === 'imagen'){
                newpath = 'public/uploads';
                fs.mkdirSync(newpath, { recursive: true })
            }else if(file.fieldname === 'archivoProp'){
                let IdProp = request.body.user;
                newpath = `./Expedientes/Propiedades/${IdProp}`;
                fs.mkdirSync(newpath, { recursive: true })
            }
            callback(null, newpath);
        //}
        //else if(file.fieldname === 'imagen')
            //callback(null, './Expedientes/fotos');
    },
    filename: (request, file, callback) => {
        //aquí configuramos el nombre que queremos que tenga el archivo en el servidor, 
        //para que no haya problema si se suben 2 archivos con el mismo nombre concatenamos el timestamp
        callback(null, new Date().getSeconds() + '' + new Date().getDay() + '' + new Date().getMonth() + '' + new Date().getYear() + file.originalname);
    },
});


const fileFilter = (request, file, callback) => {

    if(file.fieldname == 'archivo2' | file.fieldname == 'archivoProp'){
        if (file.mimetype == 'application/pdf') {
            callback(null, true);
        } else {
            callback(null, false);
        }
    }else if(file.fieldname == 'imagen'){
        if(file.mimetype == "image/png" || file.mimetype == "image/jpg" || file.mimetype == "image/jpeg" || file.mimetype == "image/webp" ){
            callback(null, true);
        }else{
            callback(null, false);
        }
    }
    
}



app.use(multer({ storage: fileStorage, fileFilter: fileFilter, limits : {fileSize: 20*1024*1024}}).fields([{name: 'archivo2'},{name: 'imagen'},{name: 'archivoProp'}]));





// Middleware que analiza errores de multer en caso que las protecciones del front end se salten.
// Si hay exception, se limpian las variables que permiten que se suban archivos, por lo que el controlador no hace nada.
// Y nada explota en consecuencia.
app.use((err, request, response, next) => {
    if (err instanceof multer.MulterError) {
        console.log(err);
        request.body.SelFiles = '';
        request.body.NRMFiles = '';
        request.files = ''
    }
    console.log('MiddleWareeeee');
    console.log(request.files);
    next();
});
//Declarar rutas
const rutasPropiedades = require('./routes/propiedad.routes');
const rutasIndex = require('./routes/index.routes');
const rutasDashboard = require('./routes/dashboard.routes');
const rutasLogin = require('./routes/Login.routes');
const expediente = require('./routes/expediente.routes');
const resenas = require('./routes/resenas.routes');
const intro = require('./routes/intro.routes');
const contacto = require('./routes/contacto.routes');
const aviso = require('./routes/aviso.routes');
const estatus = require('./routes/estatus.routes');
const servicios = require('./routes/servicios.routes')

app.use(session({
    secret: 'aerfgtvythvyugt54cyh4yhyhy6h46yr5ky87br53tgc3g46gg',
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));

app.use(csrfProtection);


app.use((request, response, next) => {
    response.locals.csrfToken = request.csrfToken();//'dummytoken';
    response.locals.sesion = request.session.user ? request.session.user : '';
    response.locals.IdUser = request.session.IdUser ? request.session.IdUser : '';
    response.locals.IdRol = request.session.IdRol ? request.session.IdRol : '';
    response.locals.NombreUser = request.session.NombreUser ? request.session.NombreUser : '';
    response.locals.Telefono = request.session.Telefono ? request.session.Telefono : '';
    response.locals.Email = request.session.Email ? request.session.Email : '';
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
app.use('/resenas', resenas);
app.use('/intro', intro);
app.use('/contacto', contacto);
app.use('/aviso', aviso);
app.use('/estatus', estatus);
app.use('/servicios', servicios);

app.use('/.well-known/pki-validation/597B668977DF77B917BF99166B2B1EDB.txt', (request, response, next) => {
    response.download('./public/ssl/597B668977DF77B917BF99166B2B1EDB.txt');
})

app.use('/.well-known/pki-validation/1DD50C3E2D349399187E410A8E901B6E.txt', (request, response, next) => {
    response.download('./public/ssl/1DD50C3E2D349399187E410A8E901B6E.txt');
})



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


let formatc = new Intl.NumberFormat("en-IN", { style: "currency", currency: "USD" })

app.listen(3000);