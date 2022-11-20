const db = require('../util/database');
const bcrypt = require('bcryptjs');
const { query } = require('../util/database');

module.exports = class expediente{

    static fetchRequirements(te, id){
        return db.execute('select tip.tipo_doc, tip.descripcion, user.URL, user.Comentarios, user.estatus from  (select ex.tipo_doc, ex.URL, ex.Comentarios, ex.estatus from exp_tipo_doc ex where ex.IdCliente = ?) user right join (select r.tipo_doc, tp.tipo_doc as "tipo_documento", tp.descripcion from requisitos r, tipo_doc tp where r.tipo_doc = tp.tipo_doc and r.Tipo_Exp = ?) tip on user.tipo_doc = tip.tipo_doc', [id,te]);
        //return db.execute('select distinct exp.Tipo_Doc, exp.URL, exp.Idcliente, exp.Comentarios, doc.descripcion, exp.estatus from exp_tipo_doc exp, requisitos req, tipo_doc doc where exp.Tipo_Doc = req.Tipo_Doc and exp.Tipo_Doc = doc.Tipo_Doc and IdCliente = ? and req.Tipo_Exp = ?', [id,te]);
        //return db.execute('(SELECT etd.Tipo_Doc, descripcion, etd.Comentarios, etd.Estatus, etd.URL FROM exp_tipo_doc etd, tipo_doc td WHERE etd.Tipo_Doc = td.Tipo_Doc AND etd.IdCliente = ?) UNION ((SELECT r.Tipo_Doc, descripcion, NULL AS "Comentarios", 0 AS "Estatus", NULL AS "URL"  FROM requisitos r, tipo_doc td WHERE r.Tipo_Exp = 3 AND r.Tipo_Doc = td.Tipo_Doc ) except (SELECT etd.Tipo_Doc, descripcion,  NULL AS "Comentarios",  0 AS "Estatus", NULL AS "URL" FROM exp_tipo_doc etd, tipo_doc td WHERE etd.Tipo_Doc = td.Tipo_Doc AND etd.IdCliente = ?))',[te,te]);
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
    }

    static CheckforUpdates(IdUsuario){
        return db.execute('SELECT tp.tipo_doc from (select Tipo_doc from exp_tipo_doc where IdCliente = ?) tp2 right join tipo_doc tp on tp.tipo_doc = tp2.tipo_doc where tp2.tipo_doc is NULL',[IdUsuario]);
    }
    static DownloadFile(fileType, ExpType, IdUsuario){
        return db.execute("select URL from exp_tipo_doc where IdCliente = ? and Tipo_Exp = ? and Tipo_Doc = ?", [IdUsuario, ExpType, fileType]);

    }

    static UploadFile(docList, N_docs, IdUsuario, URLs, estatuslist){
        return db.execute('CALL `UploadFiles`(?,?,?,?,?)', [URLs, docList, IdUsuario, N_docs, estatuslist]);
    }
}