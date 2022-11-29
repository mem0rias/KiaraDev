const path = require('path');
const Dashboard = require('../models/dashboard.model');
const User = require('../models/dashboard.model');

//El metodo obtiene las 4 propiedades más recientes
exports.get_dashboard = (request, response, next) => {
    let sesionID = response.locals.IdUser;
    Dashboard.fetchUser(sesionID).then( ([usuarioData, fieldData]) => {
            console.log(sesionID);
             console.log(usuarioData);
            console.log('Infor del usuario');
            console.log(usuarioData);
            console.log(response.locals.Email);
            response.render(path.join('dashboard', 'dashboard.ejs'), {
                usuario: usuarioData[0],
                sesionId    : response.locals.IdRol     , 
                sesionUser  : response.locals.IdUser    ,
                nombre      : response.locals.NombreUser    ,
                telefono    : response.locals.Telefono  ,
                email       : response.locals.Email     ,
                
                
                permisos: request.session.permisos,
            }); 
            

        }).catch( (error) => {
            console.log(error);
        });    
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

                    console.log(usuarioData);
                    console.log(propiedadesAsignadas);
                    console.log(id);
                    let cantidad = propiedadesAsignadas.length;
                    response.render(path.join('dashboard', 'dashboard.propiedadAsignada.ejs'), {
                        usuario: usuarioData[0],

                        sesionId    : response.locals.IdRol     , 
                        sesionUser  : response.locals.IdUser    ,
                        nombre      : response.locals.NombreUser    ,
                        telefono    : response.locals.Telefono  ,
                        email       : response.locals.Email     ,


                        propiedad   : propiedadesAsignadas      ,
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
        console.log(rows);
        response.status(200).json(rows);
    }).catch(err =>{
        console.log(err);
        response.status(200).json('noconn');
    })
    

}

exports.saveRol = (request, response, next) => {
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
    console.log(mapString);
    console.log(rolmapString);
    
}

