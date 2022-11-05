const path = require('path');
const User = require('../models/Login.model');
const bcrypt = require('bcryptjs');

exports.login = (request, response, next) => {
    
    // Funcion de login, carga el mensaje en caso de que haya uno que se necesite desplegar
    // Se limpia la variable de sesion de info para evitar tener mensajes repetidos
    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';
    // Se forza a que se guarde el valor de la sesion para que no se repita el mensaje con un refresh
    return request.session.save(err => {
        // Render de la pagina con el mensaje mas actual
        response.render('./Login/login', {info: msg});
    });
}

exports.loginverf = (request, response, next) => {
    
    let info = request.body;
    
    User.fetchmail(info.User).then(([rows, fieldData]) =>{
        //Checamos primero que la consulta nos regrese algo
        if(rows.length > 0){
            // Comparacion de la contraseña que se ingreso y la que corresponde en la BD
            bcrypt.compare(info.Pass, rows[0].password).then(doMatch => {
                // Si la contraseña coincide, se almacena informacion clave del usuario en la sesion
                if (doMatch) {
                    request.session.isLoggedIn = true;
                    request.session.user = info.User;
                    request.session.IdUser = rows[0].IdUsuario;
                    request.session.IdRol = rows[0].IdRol;
                    return request.session.save(err => {
                        // Cosas para hacer debug
                        //console.log(request.session);
                        //response.redirect('/inicio');
                        //Redireccion al dashboard del usuario.
                        response.redirect('/dashboard');
                    });
                    
                    
                    
                }else{ // Si la contra no coincide
                    request.session.info = 'Usuario y/o contraseña incorrecta';
                    response.redirect('/login');
                }
               
            }).catch(err => {
                console.log(err);
                response.redirect('/login');
            });
            
        }else{
            //Si no hay un correo que coincida en la BD
            request.session.info = 'Usuario y/o contraseña incorrecta';
            response.redirect('/login');
        }
       
        
    }).catch((error)=>{ // Si la BD no esta disponible se envia este mensaje.
        request.session.info = 'Hay un problema con la pagina, intentalo mas tarde';
        console.log(error);
        response.redirect('/login');
        
    })
}

exports.registrarse = (request, response, next) => {
     
    let val = request.body;
    if(val.boton == '/inicio'){
        response.redirect(val.boton);
        return
    }
    const reg = new User(val.nombre, val.A1, val.A2, val.ECiv, val.Email, val.Ocupacion, val.Tel, val.password);
    console.log(reg);
    reg.save().then(() =>{
        response.redirect('/success');
        return
    }).catch((error) => {
        console.log(error);
        response.redirect('/fail');
    });
}

exports.registro = (request, response, next) => {
    response.render('./Login/registro');
}

exports.logout = (request, response, next) => {
    request.session.destroy(() => {
        response.redirect('/login'); //Este código se ejecuta cuando la sesión se elimina.
    });
};