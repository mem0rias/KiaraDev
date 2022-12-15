module.exports = (request, response, next) => {
    let permisos = request.session.permisos;
    if (permisos.indexOf('revisar_expediente') == -1) {
        return response.redirect('/dashboard');
    }else  
        next();
}