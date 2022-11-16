const db = require('../util/database');
const bcrypt = require('bcryptjs');
const { response } = require('express');
module.exports = class Login {
    constructor(nombre, A1, A2, EC, Email, Ocup, Tel, password, N_Docs, U_DocsList){
        this.nombre = nombre;
        this.A1 = A1;
        this.A2 = A2;
        this.EC = EC;
        this.Email = Email;
        this.Ocup = Ocup;
        this.Tel = Tel;
        this.pass = password
        this.N_Docs = N_Docs;
        this.U_DocsList = U_DocsList;
    }
    

    save(){
        return bcrypt.hash(this.pass,12).then((password_cifrado) =>{
            return db.execute(
                'CALL CreateUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
                [this.nombre, this.A1, this.A2, this.Email, this.EC, this.Ocup, this.Tel, password_cifrado, 0, this.N_Docs, this.U_DocsList]);
        }).catch( (error) => {
            console.log(error);
        });
     
    }

    Update(n, a1, a2){
        return db.execute('UPDATE usuario SET nombre = ?, PA = ?, SA = ?, email = ?, eciv = ?, ocupacion = ?, Telefono = ? where nombre = ? and Primer_Apellido = ? and Segundo_Apellido = ?',
        [this.nombre, this.A1, this.A2, this.Email, this.EC, this.Ocup, this.Tel, n, a1, a2]);
    }

    static fetchNames(){
        return db.execute('SELECT nombre, PA, SA FROM usuario');
    }

    static fetchOne(n, a1, a2){
        return db.execute('SELECT * from usuario where nombre = (?) and PA = (?) and SA = (?)', [n,a1,a2]);
    }

    static fetchmail(u) {
        return db.execute('SELECT email, password, IdUsuario, IdRol from usuario where email = (?)', [u]);
    }

    static fetchDocTypes(){
        return db.execute('SELECT Tipo_Doc from tipo_doc');
    }

    
}