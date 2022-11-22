const path = require('path');
const Propiedad = require('../models/propiedad.model');

exports.get_propiedades = (request, response, next) => {

    Propiedad.fetchAll()
        .then( ([rows, fieldData]) => {

            response.render(path.join('propiedad', 'propiedad.vista.global.ejs'), {
                propiedad: rows,
            }); 

        }).catch( (error) => {
            console.log(error);
        });

};

exports.get_one = (request, response, next) => {
    Propiedad.fetchOne(request.params.id).then( ([rows, fieldData]) => {
            console.log(rows);
            var monto = rows[0].Precio;
            precio = Intl.NumberFormat('es-MX',{style:'currency',currency:'MXN',minimumFractionDigits:0,maximumFractionDigits:0}).format(monto);
             Propiedad.isResidencial(request.params.id).then( ([res,fieldData]) => {
                if (res.length > 0){
                    console.log(res);
                    
                    response.render(path.join('propiedad', 'propiedad.vista.residencial.ejs'), {
                        propiedad: rows[0],
                        residencial: res[0],
                        precio: precio,
                        
                    }); 
                }
                else {
                    Propiedad.isComercial(request.params.id).then( ([com,fieldData]) => {
                        if (com.length > 0){
                            console.log(com);
                            response.render(path.join('propiedad', 'propiedad.vista.comercial.ejs'), {
                                propiedad: rows[0],
                                comercial: com[0],
                                precio: precio,
                            });
                        }
                        else{
                            Propiedad.isTerreno(request.params.id).then( ([terr,fieldData]) => {
                                if (terr.length > 0){
                                    console.log(terr);
                                    response.render(path.join('propiedad', 'propiedad.vista.terreno.ejs'), {
                                        propiedad: rows[0],
                                        terreno: terr[0],
                                        precio: precio,
                                    });
                                }
                            }).catch((error) => {
                                console.log(error);
                            });
                        }
                    }).catch();
                }
            }).catch();

        }).catch( (error) => {
            console.log(error);
        });

};


exports.get_new = (request, response, next) => {
    response.render(path.join('propiedad', 'propiedad.registrar.ejs'),{
        propiedad: '',
        residencial: '',
        comercial: '',
        tipoP: '',

    });
    
};

exports.post_new = (request, response, next) => {
    
    console.log(request.body);
    let v = request.body;
    const userId = parseInt(response.locals.IdUser);

    if(request.body.tipoPropiedad == 'Residencial') {

        const recamaras         = parseInt(v.recamaras);
        const estacionamiento   = parseInt(v.estacionamiento);
        const banos             = parseInt(v.banos);
        const pisos             = parseInt(v.pisos);
        const gas               = parseInt(v.gas);
        const cocina            = parseInt(v.cocina);

        var d = {
            titulo          : v.titulo,
            descripcion     : v.descripcion,
            precio          : v.precio,
            estado          : v.estado,
            muncipio        : v.muncipio,
            colonia         : v.colonia,
            calle           : v.calle,
            cp              : v.cp,
            uso             : v.uso,
            mterreno        : v.mterreno,
            mconstruccion   : v.mconstruccion,
            tipotransaccion : v.tipotransaccion,
            tipopropiedad   : v.tipopropiedad,
            imagenes        : v.video,
            video           : v.video,
            recamaras       : recamaras,
            banos           : banos,
            cocina          : cocina,
            pisos           : pisos,
            estacionamiento : estacionamiento,
            gas             : gas,
            userid          : userId
        };

        console.log(d.banos);

        //Convertir en tipo int datos requeridos
        Propiedad.agregarResidencial(d)
                .then( () => {
                        response.redirect('/dashboard/asignado');
                }).catch( (error) => {
                        console.log(error);
        });
    }

    else if(request.body.tipoPropiedad == 'Comercial'){
        const recamaras = parseInt(request.body.recamaras);
        const estacionamiento = parseInt(request.body.estacionamiento);
        const banos = parseInt(request.body.banos);
        const pisos = parseInt(request.body.pisos);
        const oficinas = parseInt(request.body.oficinas);
        Propiedad.saveComercial(v.descripcion, v.precio,v.estado,v.muncipio,v.colonia,v.calle,v.cp,v.video,v.video,v.imagenes,estacionamiento,banos,oficinas,pisos)
                .then( () => {
                        response.redirect('/propiedades');
                }).catch( (error) => {
                        console.log(error);
        });
    } 
    

    
};

exports.get_edit = (request, response, next) => {
    Propiedad.fetchOne(request.params.id).then( ([rows, fieldData]) => {
            console.log(rows);
            var monto = rows[0].Precio;
            let tipoP;
            precio = Intl.NumberFormat('es-MX',{style:'currency',currency:'MXN',minimumFractionDigits:0,maximumFractionDigits:0}).format(monto);
            Propiedad.isResidencial(request.params.id).then( ([res,fieldData]) => {
                if (res.length > 0){
                    console.log(res);
                    
                    tipoP = 1;
                    console.log(tipoP);
                    response.render(path.join('propiedad', 'propiedad.registrar.ejs'), {
                        propiedad: rows[0],
                        residencial: res[0],
                        tipoP: tipoP,
                        
                    }); 
                }
                else {
                    Propiedad.isComercial(request.params.id).then( ([com,fieldData]) => {
                        if (com.length > 0){
                            console.log(com);
                            response.render(path.join('propiedad', 'propiedad.registrar.ejs'), {
                                propiedad: rows[0],
                                comercial: com[0],
                                precio: precio,
                            });
                        }
                        else{
                            Propiedad.isTerreno(request.params.id).then( ([terr,fieldData]) => {
                                if (terr.length > 0){
                                    console.log(terr);
                                    response.render(path.join('propiedad', 'propiedad.registrar.ejs'), {
                                        propiedad: rows[0],
                                        terreno: terr[0],
                                        precio: precio,
                                    });
                                }
                            }).catch((error) => {
                                console.log(error);
                            });
                        }
                    }).catch();
                }
            }).catch();

        }).catch( (error) => {
            console.log(error);
        });

};

exports.get_buscar =  (request, response, next) => {
    
    console.log(request.params.valor_busqueda);
    Propiedad.find(request.params.valor_busqueda)
        .then( ([rows, fieldData]) => {

            response.status(200).json(rows);
            console.log(rows)
        }).catch( (error) => {
            console.log(error);
        });

};

exports.post_edit = (request, response, next) => {
    let v = request.body;
    console.log(v.id);
    console.log(v.titulo);
    console.log(v.recamaras);
    console.log(v.descripcion);
    Propiedad.updateResidencial(v.id,v.titulo,v.descripcion,v.recamaras)
        .then( () => {
            response.redirect('/dashboard/asignado');
        }).catch( (error) => {
            console.log(error);
        });
    
};

