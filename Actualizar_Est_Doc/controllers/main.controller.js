const path = require('path');
const User = require('../models/user.model');
const bcrypt = require('bcryptjs');
const bulmaToast = require('bulma-toast');
exports.inicio = (request, response, next) => {
    response.render('inicio');
}

exports.preguntas = (request,response, next) => {
    response.render('preguntas');
}

exports.submit = (request, response, next) => {
    
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

exports.nav = (request, response, next) =>{
    let val = request.body.boton;
    request.session.info = '';
    console.log(val);
    response.redirect(val);
}

exports.edit = (request, response, next) => {
    
    User.fetchNames().then(([rows, fieldData]) => {
        //console.log(rows);
        response.render('edit.ejs',{nombres: rows, busqueda: 0});
        
    }).catch((error) =>{
        console.log(error);
        response.redirect('/fail');
    });
   
}

exports.selectedit = (request, response, next) => {
    let parameters = request.params.consulta.split("^");
    console.log(parameters);
    if(parameters != undefined){
        User.fetchOne(parameters[0], parameters[1], parameters[2]).then(([rows, fieldData]) => {
            //console.log(rows);
            console.log(rows);
            User.fetchNames().then(([rows2, fieldData2]) => {
                //console.log(rows);
                response.status(200).json(rows);
                return
            }).catch((error) =>{
                console.log(error);
                response.redirect('/fail');
                return
            });
        }).catch((error) =>{
            console.log(error);
            response.redirect('/fail');
            return
        });
    } 
}

exports.updateinfo = (request, response, next) => {
    let val = request.body;
    let parameters = request.body.enviar.split("^");
    let toastvar = 'Error editando usuario'
    console.log(parameters);
    const reg2 = new User(val.nombre, val.A1, val.A2, val.ECiv, val.Email, val.Ocupacion, val.Tel);
    reg2.Update(parameters[0], parameters[1], parameters[2]).then(() =>{
        console.log("Se logro!");
        response.redirect('/success');
    }).catch((error) => {
        console.log(error);
        response.redirect('/fail');
    });
    
    
    
}

exports.fail = (request, response, next) => {
    response.render('fail');
}

exports.success = (request, response, next) => {
    response.render('exito');
}
exports.error = (request, response, next) => {
    response.status(404);
    response.render('error');
}


exports.login = (request, response, next) => {
    
    //Token = request.csrfToken();
    //console.log(Token);
    response.render('login', {info: request.session.info ? request.session.info : ''});
}

exports.loginverf = (request, response, next) => {
    let info = request.body;
    
    User.fetchmail(info.User).then(([rows, fieldData]) =>{
        bcrypt.compare(info.Pass, rows[0].password).then(doMatch => {
            
            if (doMatch) {
                request.session.isLoggedIn = true;
                request.session.user = info.User;
                return request.session.save(err => {
                    console.log(request.session.user);
                    //response.redirect('/inicio');
                    response.redirect('/inicio');
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

exports.busqueda = (request, response, next) => {
    response.status(200).json("Recibsite cosas importantes pa");
}
exports.logout = (request, response, next) => {
    request.session.destroy(() => {
        response.redirect('/login'); //Este código se ejecuta cuando la sesión se elimina.
    });
};