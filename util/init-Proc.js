module.exports = (request, response, next) => {
    let permisos = request.session.permisos;
    if (permisos.indexOf('editar_seguimiento') == -1) {
        return response.redirect('/dashboard');
    }else  
        next();
}