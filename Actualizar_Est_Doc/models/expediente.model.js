const db = require('../util/database');
const bcrypt = require('bcryptjs');

module.exports = class expediente{

    static fetchRequirements(te){
        return db.execute('(SELECT etd.Tipo_Doc, descripcion, etd.Comentarios, etd.Estatus, etd.URL FROM exp_tipo_doc etd, tipo_doc td WHERE etd.Tipo_Doc = td.Tipo_Doc AND etd.IdCliente = ?) UNION ((SELECT r.Tipo_Doc, descripcion, NULL AS "Comentarios", 0 AS "Estatus", NULL AS "URL"  FROM requisitos r, tipo_doc td WHERE r.Tipo_Exp = 3 AND r.Tipo_Doc = td.Tipo_Doc ) except (SELECT etd.Tipo_Doc, descripcion,  NULL AS "Comentarios",  0 AS "Estatus", NULL AS "URL" FROM exp_tipo_doc etd, tipo_doc td WHERE etd.Tipo_Doc = td.Tipo_Doc AND etd.IdCliente = ?))',[te,te]);
    }

    static UpdateRequirements(Comments, estatus, IdUsuario, Tipo_Doc){
        return db.execute('UPDATE exp_tipo_doc set Comentarios = ?, Estatus = ? where IdCliente = ? and Tipo_Doc = ?', [Comments,estatus,IdUsuario,Tipo_Doc]);
    }
}