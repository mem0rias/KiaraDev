const db = require('../util/database');
const bcrypt = require('bcryptjs');
const { response } = require('express');
module.exports = class User {
    constructor(nombre, A1, A2, EC, Email, Ocup, Tel, password){
        this.nombre = nombre;
        this.A1 = A1;
        this.A2 = A2;
        this.EC = EC;
        this.Email = Email;
        this.Ocup = Ocup;
        this.Tel = Tel;
        this.pass = password;
    }
    

    save(){
        return bcrypt.hash(this.pass,12).then((password_cifrado) =>{
            return db.execute(
                'INSERT INTO usuarios(nombre, Primer_Apellido, Segundo_Apellido, Correo_Electronico, Estado_Civil, Ocupacion, Telefono, Password, rol) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', 
                [this.nombre, this.A1, this.A2, this.Email, this.EC, this.Ocup, this.Tel, password_cifrado, 0]);
        }).catch( (error) => {
            console.log(error);
        });

        
            
    }

    Update(n, a1, a2){
        return db.execute('UPDATE usuarios SET nombre = ?, Primer_Apellido = ?, Segundo_Apellido = ?, Correo_Electronico = ?, Estado_Civil = ?, Ocupacion = ?, Telefono = ? where nombre = ? and Primer_Apellido = ? and Segundo_Apellido = ?',
        [this.nombre, this.A1, this.A2, this.Email, this.EC, this.Ocup, this.Tel, n, a1, a2]);
    }

    static fetchNames(){
        return db.execute('SELECT nombre, Primer_Apellido, Segundo_Apellido FROM usuarios');
    }

    static fetchOne(n, a1, a2){
        return db.execute('SELECT * from usuarios where nombre = (?) and Primer_Apellido = (?) and Segundo_Apellido = (?)', [n,a1,a2]);
    }

    static fetchmail(u) {
        return db.execute('SELECT Correo_Electronico, password from usuarios where Correo_Electronico = (?)', [u]);
    }

    
}