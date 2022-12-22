const path = require('path');
const Propiedad = require('../models/propiedad.model');
const Dashboard = require('../models/dashboard.model');
const expediente = require('../models/expediente.model');
const fs = require('fs');

// Esta variable nos ayuda en el manejo de varios archivos. Si estamos trabajando en windows utiliza '\\' si es en linux o el server (lo mismo) usa '/'
let OSVar = '\\';
exports.get_propiedades = (request, response, next) => {

    Propiedad.fetchAll()
        .then( ([propiedades, fieldData]) => {

            Propiedad.fetchAllResidencial()
            .then( ([residencial, fieldData]) => {

                Propiedad.fetchAllComercial()
                .then( ([comercial, fieldData]) => {
                    console.log(comercial);
                    response.render(path.join('propiedad', 'propiedad.vista.global.ejs'), {
                        propiedad: propiedades,
                        residencial: residencial,
                        comercial: comercial,
                    }); 
    
                }).catch( (error) => {
                    console.log(error);
                });

            }).catch( (error) => {
                console.log(error);
            });

        }).catch( (error) => {
            console.log(error);
        });

};

exports.get_one = (request, response, next) => {
    let idPropiedad = request.params.id ;
    console.log(idPropiedad);
    Propiedad.fetchOne(request.params.id).then( ([rows, fieldData]) => {
        Propiedad.fetchImages(request.params.id).then( ([imagenes, fieldData]) => {
            console.log(imagenes);

                const imagenesLista = [];
                for(p of imagenes){
                    imagenesLista.push(p.Imagen.split('/')[2]); 
                }

            Propiedad.getAgenteTel(request.params.id).then(([tel, fieldDataTel]) =>{
                    console.log('id de propiedad');
                    console.log(request.params.id);
                    let precio = 0;
                    console.log(tel);
                    let TelAgente = tel.length > 0? tel[0].Telefono : '';
                    Propiedad.isResidencial(request.params.id).then( ([res,fieldData]) => {
                        if (res.length > 0){
                            console.log(res);
                            response.render(path.join('propiedad', 'propiedad.vista.residencial.ejs'), {
                                propiedad: rows[0],
                                ubicacion: rows[0].Calle+','+rows[0].Colonia+','+rows[0].Estado+',Mexico',
                                residencial: res[0],
                                precio: Intl.NumberFormat('es-MX',{style:'currency',currency:'MXN',minimumFractionDigits:0,maximumFractionDigits:0}).format(rows[0].Precio),
                                numeroenc: TelAgente,
                                imagenes: imagenesLista,
                            }); 
                        }
                        else 
                        {
                            Propiedad.isComercial(request.params.id).then( ([com,fieldData]) => {
                                if (com.length > 0){
                                    console.log(com);
                                    response.render(path.join('propiedad', 'propiedad.vista.comercial.ejs'), {
                                        propiedad: rows[0],
                                        ubicacion: rows[0].Calle+','+rows[0].Colonia+','+rows[0].Estado+',Mexico',
                                        comercial: com[0],
                                        precio: Intl.NumberFormat('es-MX',{style:'currency',currency:'MXN',minimumFractionDigits:0,maximumFractionDigits:0}).format(rows[0].Precio),
                                        imagenes: imagenesLista,
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
            
            }).catch( err =>{
                console.log(err);
            });        
        
        }).catch( err =>{
            console.log(err);
        });
            

};


exports.get_new = (request, response, next) => {
    response.render(path.join('propiedad', 'propiedad.registrar.ejs'),{
        propiedad: '',
        residencial: '',
        comercial: '',
        tipoP: '',
        fotos: '',

    });
    
};

exports.post_new = (request, response, next) => {
            
    let v                   = request.body;
    const userId            = parseInt(response.locals.IdUser);

    console.log(request.files);
    let stringpath = '';
    let headerImage = null;
    let N_Pics = request.body.NPics;
    let arrayImages = [];
    // Se generan los paths para la BD y se define la header image, es la primera que se selecciona desde el front end.

    // La OSVar nos ayuda para hacer los splits con los paths resultantes.
    if(request.files.imagen){
        headerImage  = request.files.imagen[0].path.split(OSVar)[2];
        console.log('headerImage');
        console.log(request.files.imagen[0].path.split(OSVar)[2]);
        for(elements of request.files.imagen){

            arrayImages.push(elements.path.split(OSVar)[2]);
            console.log(elements.path.split(OSVar)[2]);
            stringpath += elements.path + ',';

        }
        N_Pics = request.files.imagen.length;
        
        console.log(stringpath);
    }else{
         N_Pics = 0;
    }
        

    if(v.uso == '1') {

        const recamaras         = parseInt(v.recamaras);
        const estacionamiento   = parseInt(v.estacionamiento);
        const banos             = parseInt(v.banos);
        const pisos             = parseInt(v.pisos);
        const gas               = parseInt(v.gas);
        const cocina            = parseInt(v.cocina);
        const precio            = parseInt(v.precio);

        let d = {
            titulo          : v.titulo ,
            descripcion     : v.descripcion,
            precio          : precio,
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
            imagenes        : headerImage,
            video           : v.video ? v.video : '',
            recamaras       : recamaras,
            banos           : banos,
            cocina          : cocina,
            pisos           : pisos,
            estacionamiento : estacionamiento,
            gas             : gas,
            userid          : userId
        };

        Propiedad.agregarResidencial(d).then( () => {
                Propiedad.saveImages(stringpath,N_Pics).then(() =>{     
                    Propiedad.updateHeader(headerImage).then(() =>{
                        response.redirect('/dashboard/asignado'); 
                    }).catch(err =>{
                        console.log(err);
                        response.redirect('/dashboard/asignado');
                    });
                            
                }).catch(err =>{
                    console.log(err);
                    response.redirect('/dashboard/asignado');
                });
                
            }).catch( (error) => {
                console.log(error);
                response.redirect('/dashboard/asignado');
        });
    }

    else if(v.uso == '2'){

        const estacionamiento   = parseInt(v.estacionamiento);
        const banos             = parseInt(v.banos);
        const pisos             = parseInt(v.pisos);
        const cuartos           = parseInt(v.oficinas);

        let d = {
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
            imagenes        : headerImage,
            video           : v.video ? v.video : '',
            cuartos         : cuartos,
            banos           : banos,
            pisos           : pisos,
            estacionamiento : estacionamiento,
            userid          : userId
        };

        Propiedad.agregarComercial(d)
                .then( () => {
                    Propiedad.saveImages(stringpath,N_Pics).then(() =>{
                        response.redirect('/dashboard/asignado');
                    }).catch(err =>{
                        console.log(err);
                        response.redirect('/dashboard/asignado');
                    });
                    
                }).catch( (error) => {
                    console.log(error);
                    response.redirect('/dashboard/asignado');
        }).catch(err => {
            console.log(err);
            response.redirect('/dashboard/asignado');
        });
    } 

};

exports.get_edit = (request, response, next) => {
    Propiedad.fetchOne(request.params.id).then( ([rows, fieldData]) => {
            console.log(rows);
            var monto = rows[0].Precio;
            let tipoP;
            let comercial;
            
            precio = Intl.NumberFormat('es-MX',{style:'currency',currency:'MXN',minimumFractionDigits:0,maximumFractionDigits:0}).format(monto);
            Propiedad.fetchImages(request.params.id).then(([photos, fieldData]) => {
                console.log(photos);
                // Obtenemos las fotos de la BD y las adecuados al formato que se utiliza en la vista.
                let convertedphotos = new Array();
                for(element of photos){
                    let aux = new Object();
                    aux.IdImagen = element.IdImagen;
                    aux.Imagen = element.Imagen.split(OSVar)[2];
                    aux.fullPath = element.Imagen;
                    convertedphotos.push(aux);
                }
                console.log(convertedphotos);
                Propiedad.isResidencial(request.params.id).then( ([res,fieldData]) => {
                    if (res.length > 0){
                        console.log(res);
                        
                        tipoP = 1;
                        console.log(tipoP);
                        response.render(path.join('propiedad', 'propiedad.registrar.ejs'), {
                            propiedad: rows[0],
                            residencial: res[0],
                            tipoP: tipoP,
                            comercial: comercial,
                            fotos : convertedphotos,
                            
                        }); 
                    }
                    else {
                        Propiedad.isComercial(request.params.id).then( ([com,fieldData]) => {
                            if (com.length > 0){
                                console.log(com[0]);
                                response.render(path.join('propiedad', 'propiedad.registrar.ejs'), {
                                    residencial: '',
                                    propiedad: rows[0],
                                    comercial: com[0],
                                    precio: precio,
                                    tipoP: tipoP,
                                    fotos : convertedphotos,
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
                                            tipoP: tipoP,
                                            fotos : convertedphotos,
                                        });
                                    }
                                }).catch((error) => {
                                    console.log(error);
                                });
                            }
                        }).catch();
                    }
                }).catch();
            }).catch(err =>{
                console.log(err);
            });
            
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

    let v                   = request.body;

    console.log(v);
    let stringpath = '';
    let N_Pics = 0;
    let arrayImages = [];
    let idPropiedad = v.id;
    // Para borrar imagenes
    let removeList = v.removePathsId;
    let n_removeList = v.nPaths;
    let removePaths = v.removePaths;
    // Para definir la nueva imagen principal.
    let newHeader = '';
    // Si hay nuevas imagenes que se subieron al servidor, se hace el index.
    if(request.files.imagen){
        
        for(elements of request.files.imagen){

            arrayImages.push(elements.path.split(OSVar)[2]);
            console.log(elements.path.split(OSVar)[2]);
            stringpath += elements.path + ',';

        }
        N_Pics = request.files.imagen.length;
        
        console.log(stringpath);
        console.log(N_Pics);
    }else{
         N_Pics = 0;
    }
    // Iniciamos guardando las nuevas imagenes en la BD
    Propiedad.saveEditImages(stringpath,N_Pics, idPropiedad).then(() =>{
        console.log(removeList);
        console.log(n_removeList);
        console.log(removePaths);
        // Despues borramos las que se eligieron
        Propiedad.removeImages(removeList,n_removeList,idPropiedad).then(([data,fieldData]) => {
            //console.log(data[0][0].newHead.split(OSVar)[2]);
            // El nuevo header siempre se llena con la IdImagen mas pequeña de la propiedad. Vaya la foto mas vieja en la BD, si se borra cambia y se actualiza.
            newHeader = data[0][0].newHead.split(OSVar)[2];
                // Si se borraron imagenes, se borran del servidor de igual manera.
                if(removePaths != ''){
                    let delPaths = removePaths.split(',');
                        for(elements of delPaths){
                                //si ha una coma sola, puede hacer un super bug asi que esto evita que destruyamos cosas.
                                if(elements != ''){
                                    let pathDel = '.' + OSVar + elements;
                                    console.log(pathDel);
                                    fs.unlinkSync(pathDel);
                                }
                                
                        }
                }   
                // Los datos que obtenemos para actualizar aqui van
                if(v.usodata == '1') {
                    console.log(request.body);
                    console.log('residencial');
                    let d = {
                        id              : v.id,
                        titulo          : v.titulo,
                        descripcion     : v.descripcion,
                        precio          : v.precio,
                        estado          : v.estado,
                        muncipio        : v.muncipio,
                        colonia         : v.colonia,
                        calle           : v.calle,
                        cp              : v.cp,
                        mterreno        : v.mterreno,
                        mconstruccion   : v.mconstruccion,
                        tipotransaccion : v.tipotransaccion,
                        tipopropiedad   : v.tipopropiedad,
                        imagenes        : newHeader,
                        video           : v.video ? v.video : '',
                        visibilidad     : v.visibilidad,
                        recamaras       : v.recamaras,
                        banos           : v.banos,
                        cocina          : v.cocina,
                        pisos           : v.pisos,
                        estacionamiento : v.estacionamiento, 
                        gas             : v.gas
            
                    };
                    console.log(d);
                    Propiedad.actulizarResidencial(d)
                        .then( () => {
                            response.redirect('/dashboard/asignado');
                        }).catch( (error) => {
                            console.log(error);
                        });
                }
            
                else if(v.usodata == '2') {
                    console.log('comercial');
                    const estacionamiento   = parseInt(v.estacionamiento);
                    const banos             = parseInt(v.banos);
                    const pisos             = parseInt(v.pisos);
                    const cuartos           = parseInt(v.oficinas);
                    let d = {
                        id              : v.id,
                        titulo          : v.titulo,
                        descripcion     : v.descripcion,
                        precio          : v.precio,
                        estado          : v.estado,
                        muncipio        : v.muncipio,
                        colonia         : v.colonia,
                        calle           : v.calle,
                        cp              : v.cp,
                        mterreno        : v.mterreno,
                        mconstruccion   : v.mconstruccion,
                        tipotransaccion : v.tipotransaccion,
                        tipopropiedad   : v.tipopropiedad,
                        imagenes        : newHeader,
                        video           : v.video ? v.video : '',
                        cuartos         : cuartos,
                        banos           : banos,
                        pisos           : pisos,
                        estacionamiento : estacionamiento,
                        visibilidad     : v.visibilidad,
                    };
                    console.log(d);
                    Propiedad.actulizarComercial(d)
                        .then( () => {
                            response.redirect('/dashboard/asignado');
                        }).catch( (error) => {
                            console.log(error);
                        });
                }  
            
            
        }).catch(err =>{
            console.log(err);
        })
    }).catch(err => {
        console.log(err);
    })
    
};

exports.post_delete = (request, response, next) => {
    let idUser = response.locals.IdUser;
    console.log(idUser);
    Propiedad.delete(request.body.id)
        .then(()=> {
            Dashboard.fetchAsigando(idUser).then(([propiedades, fieldData])=>{
                response.status(200).json({
                    data: propiedades,
                });
            }).catch(error => {console.log(error)});
        }).catch(error => {console.log(error)});
    
};


exports.get_buscarAsigandos =  (request, response, next) => {
    let idUser = response.locals.IdUser;
    console.log(request.params.valor_busqueda);
    Dashboard.fetchAsigandoPropiedades(idUser,request.params.valor_busqueda)
        .then( ([propiedades, fieldData]) => {
        
            response.status(200).json(propiedades[0]);
            console.log(propiedades[0]);
        }).catch( (error) => {
            console.log(error);
        });

};

exports.get_Imagenes =  (request, response, next) => {

    console.log(request.params.valor_busqueda)
    Propiedad.fetchImages(request.params.valor_busqueda).then( ([imagenes, fieldData]) => {
        console.log(imagenes);
    
            const imagenesLista = [];
            for(p of imagenes){
                imagenesLista.push(p.Imagen.split('/')[2]); 
            }
            response.status(200).json(imagenesLista);
            console.log(imagenesLista)

            ;
        }).catch( (error) => {
            console.log(error);
        });
};

