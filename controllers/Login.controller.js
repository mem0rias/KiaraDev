const path = require('path');
const User = require('../models/Login.model');
const bcrypt = require('bcryptjs');
const { body, validationResult } = require('express-validator');


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
        
    }
    //Ciclo que checa que todos los campos hayan sido llenados antes de cargar la BD
    // Se pretende que nunca se llegue a esta condicion mediante JS local pero si se burla
    // Se detiene aqui.
    console.log(val.el1.length);
    for(let i = 0; i < val.el1.length; i++){
        if(val.el1[i] == ''){
            console.log(i + 'Esta vacio');
            request.session.info = 'Hay campos incompletos';
            return request.session.save(err => {
                response.redirect('/login/registrarse');
            });
        }
    }
    const reg = new User(val.el1[0], val.el1[1], val.el1[2], val.el1[4], val.el1[3], val.el1[5], val.el1[6], val.el1[7]);
    console.log(reg);
    /*reg.save().then(() =>{
        response.redirect('/success');
        return
    }).catch((error) => {
        console.log(error);
        response.redirect('/fail');
    })*/;
}

exports.registro = (request, response, next) => {
    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';
    // Se forza a que se guarde el valor de la sesion para que no se repita el mensaje con un refresh
    return request.session.save(err => {
        // Render de la pagina con el mensaje mas actual
        response.render('./Login/registro', {info : msg });
    });
    
    
}

exports.verificarcorr = (request, response, next,) => {
    console.log(request.body);
    let errors = validationResult(request);
    console.log(errors);
    response.status(200).json(errors.array());
}

exports.verificarcontra = (request, response, next,) => {
    console.log(request.body);
    let errors = validationResult(request);
    console.log(errors);
    response.status(200).json(errors.array());
}
exports.logout = (request, response, next) => {
    request.session.destroy(() => {
        response.redirect('/login'); //Este código se ejecuta cuando la sesión se elimina.
    });
};