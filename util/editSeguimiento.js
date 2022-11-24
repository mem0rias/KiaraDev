module.exports = (request, response, next) => {
    if (!request.session.permisos.indexOf('editar_seguimiento') != -1) {
        return response.redirect('/user/login');
    }
    next();
}