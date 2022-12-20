module.exports = (request, response, next) => {
    let permisos = request.session.permisos;
    if (permisos.indexOf('panel_admin') == -1) {
        return response.redirect('/dashboard');
    }else  
        next();
}