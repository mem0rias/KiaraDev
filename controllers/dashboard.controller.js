const path = require('path');
const Dashboard = require('../models/dashboard.model');
const User = require('../models/dashboard.model');

//El metodo obtiene las 4 propiedades más recientes
exports.get_dashboard = (request, response, next) => {
    let sesionID = response.locals.IdUser;
    Dashboard.fetchUser(sesionID).then( ([usuarioData, fieldData]) => {
        
        Dashboard.fetchPropiedadesPropias(sesionID).then(([userProps, fieldData]) => {
            console.log(userProps);
            let hasprop = userProps.length > 0 ? true : false;
            //console.log(sesionID);
            //console.log(usuarioData);
           // console.log('Infor del usuario');
            //console.log(usuarioData);
            //console.log(response.locals.Email);
            response.render(path.join('dashboard', 'dashboard.ejs'), {
                usuario: usuarioData[0],
                sesionId    : response.locals.IdRol     , 
                sesionUser  : response.locals.IdUser    ,
                nombre      : response.locals.NombreUser    ,
                telefono    : response.locals.Telefono  ,
                email       : response.locals.Email     ,
                HasProp     : hasprop,
                
                
                permisos: request.session.permisos,
            }); 
            

        }).catch( (error) => {
            console.log(error);
        });    
    }).catch( (err) => {
        console.log(err);
    })
            
};

exports.get_Info =  (request, response, next) => {
    let sesionID = response.locals.IdUser;
    Dashboard.fetchUser(sesionID)
        .then( ([info, fieldData]) => {
        
            response.status(200).json(info[0]);
            console.log(['info del servidor']);
            console.log(info[0]);

            ;
        }).catch( (error) => {
            console.log(error);
        });

};

exports.post_Info =  (request, response, next) => {
    let sesionID = response.locals.IdUser;
    let v = request.body;
    console.log('request.body que ha');
    console.log(request.body);

    request.session.Telefono = v.telefono;
    request.session.Email = v.email;
    request.session.NombreUser= v.nombre + ' ' + v.pa + ' ' + v.sa;

    Dashboard.updateInfo(v.nombre,v.pa,v.sa,v.email,v.telefono,v.ocupacion,v.curp,sesionID).then(()=>{
        response.status(200).json('OK');
    }).catch(err =>{
        console.log(err);
        response.status(503).json('FAIL');
    });


};

exports.get_propiedadesAsignadas = (request, response, next) => {
    let id = response.locals.IdUser;
    Dashboard.fetchAsigando(id)
        .then( ([propiedadesAsignadas, fieldData]) => {
            Dashboard.fetchUser(id).then( ([usuarioData, fieldData]) => {
                    //console.log('-----------------PROPIEDADES ASIGNADAS-------------');
                    //console.log(propiedadesAsignadas[0]);
                    //console.log(id);
                    let cantidad = propiedadesAsignadas[0].length;
                    console.log(cantidad);
                    response.render(path.join('dashboard', 'dashboard.propiedadAsignada.ejs'), {
                        usuario: usuarioData[0],

                        sesionId    : response.locals.IdRol     , 
                        sesionUser  : response.locals.IdUser    ,
                        nombre      : response.locals.NombreUser    ,
                        telefono    : response.locals.Telefono  ,
                        email       : response.locals.Email     ,


                        propiedad   : propiedadesAsignadas[0]      ,
                        cantidad    : cantidad                  ,
                        permisos    : request.session.permisos  ,
                        info        : request.session.info      ,
                    }); 
                    
        
                }).catch( (error) => {
                    console.log(error);
                });  
        }).catch( (error) => {
            console.log(error);
        });

};

exports.getPropiedades_Propias = (request, response, next) => {
    let sesionID = response.locals.IdUser;
    Dashboard.fetchUser(sesionID).then( ([usuarioData, fieldData]) => {
        
        Dashboard.fetchPropiedadesPropias(sesionID).then(([userProps, fieldData]) => {
            console.log(userProps);
            let hasprop = userProps.length > 0 ? true : false;
            let cantidad = userProps.length;
            //console.log(sesionID);
            //console.log(usuarioData);
           // console.log('Infor del usuario');
            //console.log(usuarioData);
            //console.log(response.locals.Email);
            response.render(path.join('dashboard', 'dashboard.propiedadAsignada.ejs'), {
                usuario: usuarioData[0],
                sesionId    : response.locals.IdRol     , 
                sesionUser  : response.locals.IdUser    ,
                nombre      : response.locals.NombreUser    ,
                telefono    : response.locals.Telefono  ,
                email       : response.locals.Email     ,
                HasProp     : hasprop,
                propiedad   : userProps     ,
                cantidad    : cantidad,
                permisos: request.session.permisos,
            }); 
            

        }).catch( (error) => {
            console.log(error);
        });    
    }).catch( (err) => {
        console.log(err);
    })
}

exports.get_userlist = (request, response, next) =>{
    response.render(path.join('dashboard', 'dashboard.listaUsuarios.ejs'),{
        usuario: '',
        sesionId    : response.locals.IdRol     , 
        sesionUser  : response.locals.IdUser    ,
        nombre      : response.locals.NombreUser    ,
        telefono    : response.locals.Telefono  ,
        email       : response.locals.Email     ,
        permisos: request.session.permisos,

    });

}

exports.get_roluserlist = (request, response, next) =>{
    response.render(path.join('dashboard', 'listaUsuarios.ejs'),{
        usuario: '',
        sesionId    : response.locals.IdRol     , 
        sesionUser  : response.locals.IdUser    ,
        nombre      : response.locals.NombreUser    ,
        telefono    : response.locals.Telefono  ,
        email       : response.locals.Email     ,
        permisos: request.session.permisos,

    });

}
exports.get_search = (request, response, next) => {

    let selector = (request.params.busc == ',1');
    User.fetchEmailRol(request.params.busc, selector).then(([rows, FieldData]) =>{
        //console.log(' -------------- ROWS BUSQUEDA -----------');
        //console.log(rows);
        response.status(200).json(rows);
    }).catch(err =>{
        console.log(err);
        response.status(200).json('noconn');
    })
    

}

exports.delete_user = (request, response, next) => {

    //console.log(request.body);
    let selector = (request.params.busc == ',1');
    Dashboard.deleteUser(request.body.id_user).then(() =>{
        User.fetchEmailRol('', selector).then(([rows, FieldData]) =>{
            response.status(200).json(rows);
        }).catch(err =>{
            console.log(err);
            response.status(200).json('noconn');
        })
    }).catch(err => {
        console.log(err);
        response.status(200).json("mori");
    });
}

exports.saveRol = (request, response, next) => {
    //console.log('-----MAPA DE USUARIO----');
    //console.log(request.body.mapUser);
    //console.log(request.body.mapRol);
    let mapRol =request.body.mapRol;
    let mapUser = request.body.mapUser;
    let mapString = '';
    let rolmapString = '';
    
    for(let i = 0; i < mapRol.length; i++){
        mapString += mapUser[i];
        rolmapString += mapRol[i];
        if(i != mapRol.length-1){
            mapString += ',';
            rolmapString += ',';
            
        }
    }
    
    User.updateRol(mapString,rolmapString,mapRol.length).then(() =>{
        console.log("Se logro");
        response.status(200).json("hola");
    }).catch(err => {
        console.log(err);
        response.status(200).json("mori");

    });
    //console.log(mapString);
    //console.log(rolmapString);
    
}

