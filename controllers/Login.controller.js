const path = require('path');
const User = require('../models/Login.model');
const bcrypt = require('bcryptjs');
const { body, validationResult } = require('express-validator');


exports.login = (request, response, next) => {

    // Funcion de login, carga el mensaje en caso de que haya uno que se necesite desplegar
    // Se limpia la variable de sesion de info para evitar tener mensajes repetidos
    let msgpos = request.session.infopositiva ? request.session.infopositiva : '';
    request.session.infopositiva = '';

    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';

    if (msgpos != '')
        msg = '';
    // Se forza a que se guarde el valor de la sesion para que no se repita el mensaje con un refresh
    return request.session.save(err => {
        // Render de la pagina con el mensaje mas actual
        response.render('./Login/login', { info: msg, infopositiva: msgpos });
    });
}

exports.loginverf = (request, response, next) => {

    let info = request.body;

    User.fetchmail(info.User).then(([rows, fieldData]) => {
        //Checamos primero que la consulta nos regrese algo
        if (rows.length > 0) {
            // Comparacion de la contraseña que se ingreso y la que corresponde en la BD
            bcrypt.compare(info.Pass, rows[0].password).then(doMatch => {
                // Si la contraseña coincide, se almacena informacion clave del usuario en la sesion
                if (doMatch) {

                    
                    request.session.isLoggedIn = true;
                    request.session.user = info.User;
                    request.session.IdUser = rows[0].IdUsuario;
                    request.session.IdRol = rows[0].IdRol;
                    request.session.Telefono = rows[0].Telefono;
                    request.session.Email = rows[0].email;
                    request.session.NombreUser= rows[0].Nombre + ' ' + rows[0].PA + ' ' +  rows[0].SA;
                    

                    User.getPermisos(rows[0].IdUsuario)
                                .then( ([permisos, fieldData]) => {
                                    request.session.permisos = new Array();
                                    for (let permiso of permisos) {
                                        request.session.permisos.push(permiso.nombre);
                                        console.log(permiso);
                                    }
                                    
                                    return request.session.save(err => {
                                        response.redirect('/');
                                    });
                                }).catch(err => console.log(err));



                } else { // Si la contra no coincide
                    request.session.info = 'Usuario y/o contraseña incorrecta';
                    response.redirect('/login');
                }

            }).catch(err => {
                console.log(err);
                response.redirect('/login');
            });

        } else {
            //Si no hay un correo que coincida en la BD
            request.session.info = 'Usuario y/o contraseña incorrecta';
            response.redirect('/login');
        }


    }).catch((error) => { // Si la BD no esta disponible se envia este mensaje.
        request.session.info = 'Hay un problema con la pagina, intentalo mas tarde';
        console.log(error);
        response.redirect('/login');

    })
}

exports.registrarse = (request, response, next) => {

    let val = request.body;
    if (val.boton == '/inicio') {
        response.redirect(val.boton);

    }
    //Ciclo que checa que todos los campos hayan sido llenados antes de cargar la BD
    // Se pretende que nunca se llegue a esta condicion mediante JS local pero si se burla
    // Se detiene aqui.
    console.log(val.el1.length);
    for (let i = 0; i < val.el1.length; i++) {
        if (val.el1[i] == '') {
            //console.log(i + 'Esta vacio');
            request.session.info = 'Hay campos incompletos';
            return request.session.save(err => {
                response.redirect('/login/registrarse');
            });
        }
    }

    //Validaciones de informacion desde el backend, que se hacen igual en front end
    let errors = validationResult(request);
    //console.log(errors);
    // Si no hay errores en ninguna de las comparaciones del middle-ware
    if (errors.array().length == 0) {
        // Se obtiene el mail y se revisa la BD
        User.fetchmail(request.body.el1[3]).then(([rows, fieldData]) => {
            console.log(rows);
            //Si se recibe un elemento significa que ya existe ese correo en la BD
            if (rows.length > 0) {
                request.session.info = 'El correo ya esta en uso';
                return request.session.save(err => {
                    response.redirect('/login/registrarse');
                });
            } else {
                //Si el elemento esta vacio significa que no existe ese correo en la BD
                const reg = new User(val.el1[0], val.el1[1], val.el1[2], val.el1[4], val.el1[3], val.el1[5], val.el1[6], val.el1[7]);
                //console.log(reg);

                // Se ejecuta el proceso para guardar toda la informacion del usuario dentro de la BD
                reg.save().then(() => {
                    // Se envia mensaje de registro y se redirige al login.
                    request.session.infopositiva = 'Registro exitoso!';
                    return request.session.save(err => {
                        response.redirect('/login');
                    });
                }).catch((error) => {
                    // Si la BD no esta disponible se envia este mensaje
                    request.session.info = 'Hay un problema con la pagina, intentalo mas tarde';
                    return request.session.save(err => {
                        response.redirect('/login/registrarse');
                    });
                });
            }
        }).catch(err => {
            //Error por si la BD falla cuando se checa el correo.
            request.session.info = 'Hay un problema con la pagina, intentalo mas tarde';
            return request.session.save(err => {
                response.redirect('/login/registrarse');
            });
        });
    } else {
        // Error si el correo o contra no pasan el middleware  de verificacion y se intenta salva
        request.session.info = 'Revisa tus campos';
        return request.session.save(err => {
            response.redirect('/login/registrarse');
        });
    }


}

exports.registro = (request, response, next) => {
    let msg = request.session.info ? request.session.info : '';
    request.session.info = '';
    // Se forza a que se guarde el valor de la sesion para que no se repita el mensaje con un refresh
    return request.session.save(err => {
        // Render de la pagina con el mensaje mas actual
        response.render('./Login/registro', { info: msg });
    });


}

exports.verificarcorr = (request, response, next, ) => {
    //console.log(request.body);
    let errors = validationResult(request);
    //console.log(errors);
    if (errors.array().length == 0) {
        User.fetchmail(request.body.email).then(([rows, fieldData]) => {
            console.log(rows);
            if (rows.length > 0) {
                response.status(200).json('usedEmail');
            } else
                response.status(200).json('');
        }).catch(err => {
            console.log(err);
            response.status(200).json('noConn');
        });
    } else {
        response.status(200).json('invalidEmail');
    }


}

exports.verificarcontra = (request, response, next, ) => {
    //console.log(request.body);
    let errors = validationResult(request);
    //console.log(errors);
    response.status(200).json(errors.array());
}
exports.logout = (request, response, next) => {
    request.session.destroy(() => {
        response.redirect('/login'); //Este código se ejecuta cuando la sesión se elimina.
    });
};