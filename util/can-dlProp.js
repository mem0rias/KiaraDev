const dashboard = require('../models/dashboard.model');
module.exports = (request, response, next) => {
    let permisos = request.session.permisos;
    if (permisos.indexOf('revisar_expediente') > -1) {
        return next();
    }else{
        dashboard.fetchPropiedadesPropias(request.session.IdUser).then(([Props, fielData]) =>{
            let Prop = request.params.IdProp;
            
            if(Props.length > 0){
                for(element of Props){
                    if(element.IdPropiedad == Prop)
                        return next();
                }
                return response.redirect('/dashboard');
            }
            else
                return response.redirect('/dashboard');  
        }).catch(err =>{
            console.log(err);
            return response.redirect('/dashboard');
        })
    }
        
}