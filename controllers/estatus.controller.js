const { request } = require('http');
const path = require('path');
const listEstatus = require('../models/estatus.model');

exports.get_root = (request, response, next) => {


    listEstatus.fetchAll()
        .then( ([rows, fieldData]) => {
            //console.log(rows);
            response.render(path.join('Estatus', 'estatus.ejs'), {
                listEstatus: rows
            }); 

        }).catch( (error) => {
            console.log(error);
        });

}

exports.miEstatus = (request, response, next) => {
    
    let userid = request.session.IdUser;
    expediente.GetRents(userid).then(([rows, fieldata]) =>{
        expediente.GetBuy(userid).then(([rows2, fieldata2]) =>{
            expediente.GetSelling(userid).then(([rows3, fieldata3]) =>{
                let array = new Array();
                let arraytipos = ['5','3','1'];
                let funcs = new Array();
                array.push(rows.length != 0);
                array.push(rows2.length != 0);
                array.push(rows3.length != 0);
                console.log(array);
                response.render('./Estatus/estatus', {arr: array});
                
                
            })
        })
    })

    
};