const path = require('path');
const User = require('../models/Login.model');
const bcrypt = require('bcryptjs');

exports.login = (request, response, next) => {
    
    //Token = request.csrfToken();
    //console.log(Token);
    response.render('./Login/login', {info: request.session.info ? request.session.info : ''});
}

exports.loginverf = (request, response, next) => {
    let info = request.body;
    
    User.fetchmail(info.User).then(([rows, fieldData]) =>{
        bcrypt.compare(info.Pass, rows[0].password).then(doMatch => {
            
            if (doMatch) {
                request.session.isLoggedIn = true;
                request.session.user = info.User;
                request.session.IdUser = rows[0].IdUsuario;
                request.session.IdRol = rows[0].IdRol;
                return request.session.save(err => {
                    console.log(request.session);
                    //response.redirect('/inicio');
                    response.redirect('/dashboard');
                });
                
                
                
            }
            request.session.info = 'Usuario y/o contraseña incorrecta';
            response.redirect('/login');
        }).catch(err => {
            console.log(err);
            response.redirect('/login');
        });
        
    }).catch((error)=>{
        console.log(error);
        response.redirect('/fail');
        
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