module.exports = (request, response, next) => {
    //Evita que el usuario entre a login otra vez is ya tiene una sesion iniciada.
    if (request.session.isLoggedIn) {
        return response.redirect('/dashboard');
    }
    else
        next();
}