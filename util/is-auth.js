
module.exports = (request, response, next) => {
    if (!request.session.isLoggedIn) {
        request.session.info = 'Necesitas iniciar sesion primero';
        return response.redirect('/login');
    }
    next();
}