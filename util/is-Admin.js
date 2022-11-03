module.exports = (request, response, next) => {
    if (request.session.IdRol == '3') {
        request.session.info = 'No tienes los permisos para entrar aqui';
        return response.redirect('/dashboard');
    }
    next();
}