let Tipo_exp = 0;
let prevsel;
let map = new Array();
let changes = false;
const checkbutton = (map) =>{
    let savebutton = document.getElementById('botonguardar');
    //Si el arreglo tiene un tamaño mayor a 0 significa que hay inputs que no cumplen con la regla y se deshabilita el boton.
    if(map.length > 0)
        savebutton.disabled = true;
    else
        savebutton.disabled = false;
}
const cambiarcolor = (identificador) => { //Esta funcion se llama desde expediente.ejs para verificar que no se rechace un documento sin explicacion
    //Obtenemos el Tipo_doc como id para cada bloque
    changes = true;
    let elementid = (identificador.id.split('-'))[1];
    console.log(elementid);
    let elemento = document.getElementById('comentarios-'+elementid);
    let drop = document.getElementById('dropdown-'+elementid).value;
    document.getElementById('botonguardar').classList.remove('is-hidden');
    console.log(elementid);
    //Se verifica que no este vacio y en rechazado.
    if(drop == 3 & elemento.value == ""){
        //Si esta rechzado se cambia el color y se añade el id del bloque a un arreglo
        elemento.classList.add('is-danger');
        if(map.indexOf(elementid) == -1){
            map.push(elementid);
        } 
    }else{
        //Si no esta vacio y/o rechazado, se quita el highlight y se elimina del arreglo en caso de que estuviera antes.
        elemento.classList.remove('is-danger');
        if(map.indexOf(elementid) > -1){
            map.splice(map.indexOf(elementid),1);
        }
    }
    //Se verifica que el mapa este vacio para habilitar el boton de guardado.
    checkbutton(map);
   
    


}

const descargarArchivo = (id) => {
    bulmaToast.toast({ message: 'Descargando Archivo!', type: 'is-success', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }})
}


        // Si hay cambios pendientes pregunta al usuario si los desea desechar
        const llamarcarga = (elemento) => {
            if(changes){
                if(confirm('Tus cambios no se guardaran si cambias de pestaña')){
                    cargarexp(elemento);
                    document.getElementById('aviso').classList.add('is-hidden');
                }
            }
            else
                cargarexp(elemento);
        }
        // Generacion de los tipos de documentos dependiendo del tipo de expediente.
        const cargarexp = (elemento) =>{
            // Se vacian las variables de estado y el evento que pregunta si quieres recargar la pagina
            window.onbeforeunload = 0;
            changes = false;
            prevsel = elemento;
            // Estados posibles de los archivos.
            let estados = ['Faltante', 'Pendiente', 'Aceptado', 'Rechazado'];
            let query = elemento.value;
            Tipo_exp = query;
            let user = document.getElementById('IdUsuario').value;
            
            //Fetch de requisitos del tipo de expediente seleccionado
            fetch('/expediente/fetch/' + query +'/' +  user, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
                
            }).then(result => {
                return result.json();
            }).then(data => {
                console.log(data);
                if(data == 'fail'){
                    bulmaToast.toast({ message: 'Hay un problema con el servidor, intenta mas tarde', type: 'is-danger', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }})
                }else{
                    // Generacion de ajax con los valores respectivos de cada tipo de archivo
                    document.getElementById('mainbody').classList.remove('is-hidden');
                    document.getElementById('botonguardar').classList.add('is-hidden');
                    let html = '';
                    for(elements of data){
                        if(elements.estatus == undefined)
                            elements.estatus = 0;
                        if(elements.Comentarios == undefined)
                            elements.Comentarios = '';
                        
                        // Se define si ciertos parametros se deben deshabilitar, si es que su estatus es igual a 0 (Faltante)
                        let present = (elements.estatus != 0) ? '' : 'disabled';
                        html +=
                        `
                            <div class="has-background-light box">
                                <div class="columns">
                                    <input type="hidden" name="Tipo_Doc" value="${elements.tipo_doc}">
                                    <div class="column is-3">
                                        <label class="label"> ${elements.descripcion} </label> 
                                    </div>
                                    <div class="column is-2">
                                        <a href="/expediente/download/<%= info.Tipo_Doc %>" class="button is-danger is-fullwidth" onclick="descargarArchivo(this)" type="button" id="boton" name="boton" value="${elements.tipo_doc}" ${present}>
                                            Descargar Archivo
                                        </a>
                                    </div>
                                    <div class="column is-5"> 
                                        <input class="input" type="text" id="comentarios-${elements.tipo_doc}" name="Comments" placeholder="Comentarios" maxlength="255" value="${elements.Comentarios}" onkeyup="cambiarcolor(this)" ${present}>
                                    </div>
                                    <div class="column"> 
                                        <div class="field">
                                            <div class="control">
                                            <div class="select">
                                                <select name="estatus" id="dropdown-${elements.tipo_doc}" onchange="cambiarcolor(this)" ${present}>
                                                    <option value="1" ${elements.estatus == 1 ? 'selected' : ''}> Pendiente </option> 
                                                    <option value="2" ${elements.estatus == 2 ? 'selected' : ''}> Aceptado  </option>
                                                    <option value="3" ${elements.estatus == 3 ? 'selected' : ''}> Rechazado </option>
                                                    <option value="0" ${elements.estatus == 0 ? 'selected' : ''}> Faltante  </option>
                                                </select>
                                            </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>

                            
                        `
                        
                    }
                    document.getElementById('exp').innerHTML = html;
                }
            }).catch(err => {
                bulmaToast.toast({ message: 'Hay un problema con el servidor', type: 'is-danger', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});
                console.log(err);
            });
        }

        // Funcion que recupera el tipo de documento que fue editado.
        const recuperarValidos = () => {
            let tiposVal = document.getElementsByName('estatus');
            let validos = new Array();
            for(elements of tiposVal){
                // Los elementos que no tengan estatus 0, es decire esten habilitados se toman en cuenta
                // Se mete el tipo de documento en el arreglo.
                if(elements.disabled == false){
                    validos.push(elements.id.split('-')[1]);
                }
            }
            // Se retorna el tipo de arreglo en el orden que se encuentra, esto nos ayuda a saber que comentario corresponde a que documento.
            return validos;
        }

        // Funcion asincrona que obtiene los parametros que se han cambiado para subirlos a la BD
        const actualizarExp = () => {
            let user = document.getElementById('IdUsuario').value;
            let forma = new FormData(document.getElementById('actualizar'));
            let csrftoken = document.getElementsByName('_csrf')[0].value;
            fetch('/expediente/actualizar', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                       Comments  : (forma.getAll('Comments')),
                       estatus   :  (forma.getAll('estatus')),
                       Tipo_Doc  : (recuperarValidos()),
                       IdUsuario : user,
                       Tipo_Exp  : Tipo_exp,
                       _csrf     : csrftoken,
                }),
                }).then(result => {
                    return result.json();
                }).then(data => {
                    console.log(data);
                    if(data == 'OK'){
                        bulmaToast.toast({message: 'Datos guardados correctamente', type: 'is-success',position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});
                        cargarexp(prevsel);
                    }else if(data == 'FAIL'){
                        bulmaToast.toast({message: 'Hay un problema con la pagina, intenta mas tarde', type: 'is-danger',position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});
                        cargarexp(prevsel);
                    }
                }).catch( err => {
                    console.log(err);
                    bulmaToast.toast({message: 'Hay un problema con la pagina, intenta mas tarde', type: 'is-danger',position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});
                    cargarexp(prevsel);
                });
        }