const db = require('../util/database');
const bcrypt = require('bcryptjs');

module.exports = class expediente{

    static fetchRequirements(te){
        return db.execute('(SELECT etd.Tipo_Doc, descripcion, etd.Comentarios, etd.Estatus, etd.URL FROM exp_tipo_doc etd, tipo_doc td WHERE etd.Tipo_Doc = td.Tipo_Doc AND etd.IdCliente = ?) UNION ((SELECT r.Tipo_Doc, descripcion, NULL AS "Comentarios", 0 AS "Estatus", NULL AS "URL"  FROM requisitos r, tipo_doc td WHERE r.Tipo_Exp = 3 AND r.Tipo_Doc = td.Tipo_Doc ) except (SELECT etd.Tipo_Doc, descripcion,  NULL AS "Comentarios",  0 AS "Estatus", NULL AS "URL" FROM exp_tipo_doc etd, tipo_doc td WHERE etd.Tipo_Doc = td.Tipo_Doc AND etd.IdCliente = ?))',[te,te]);
    }

    static UpdateRequirements(Comments, estatus, IdUsuario, Tipo_Doc, N_docs){
        return db.execute('CALL `ActualizarExp`(?, ?, ?, ?, ?)', [N_docs,IdUsuario,Comments,estatus,Tipo_Doc]);
    }


    static GetRents(IdUsuario){
        return db.execute('SELECT IdUsuario from cliente_pr_prop where IdUsuario = ?',[IdUsuario]);
    }

    static GetBuy(IdUsuario){
        return db.execute('SELECT IdUsuario from cliente_pc_prop where IdUsuario = ?',[IdUsuario]);
    }

    static GetSelling(IdUsuario){
        return db.execute('SELECT IdUsuario from asignacion where IdUsuario = ?',[IdUsuario]);
    }

    static fetchReqs(tipo){
        return db.execute('SELECT r.Tipo_doc, tp.descripcion from requisitos r, tipo_doc tp WHERE r.Tipo_Doc = tp.Tipo_Doc AND Tipo_Exp = ?' , [tipo]);
    }

    static fetchFiles(IdUsuario){
        return db.execute('SELECT etd.Tipo_doc, etd.comentarios, etd.URL, etd.estatus FROM exp_tipo_doc etd WHERE IdCliente = ?', [IdUsuario]);

    static DownloadFile(fileType, ExpType, IdUsuario){
        return db.execute("select URL from exp_tipo_doc where IdCliente = ? and Tipo_Exp = ? and Tipo_Doc = ?", [IdUsuario, ExpType, fileType]);

    }
}