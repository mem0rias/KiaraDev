// Arreglo de archivos añadidos/modificados
const filemap = new Array();
// Arreglo de archivos previamente añadidos que se elminaran
const removefile = new Array();
// Direcciones de archivos que se borraran del servidor
const removepaths = new Array();
let changes = false;
// Ultima seleccion de tipo de expediente.
let prevsel;

// Recarga el ultimo estado seleccionado.
const revertirCambios = (elemento) => {
    elemento.value = prevsel;
    document.getElementById('aviso').classList.add('is-hidden');
    cargarexp(elemento);
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

const cargarexp = (elemento) =>{
    // Se vacian las variables de estado y el evento que pregunta si quieres recargar la pagina
    window.onbeforeunload = 0;
    filemap.length = 0;
    removefile.length = 0;
    removepaths.length = 0;
    changes = false;

    // Estados posibles de los archivos.
    let estados = ['Faltante', 'Pendiente', 'Aceptado', 'Rechazado'];
    let query = elemento.value;
    let Tipo_exp = query;
    if(query == 0)
        return;
    prevsel = query;
    document.getElementById('Tipo_Exp').value = query;
    //Fetch de requisitos del tipo de expediente seleccionado
    fetch('/expediente/fetch/' + query, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        }
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
                    elements.Comentarios = ' ';
                
                // Se define si ciertos parametros se deben esconder dependiento del estado del elemento.
                let hidden = (elements.URL != undefined && elements.URL != '') ? '' : 'is-hidden';
                let fileName = (elements.URL == undefined | elements.URL == '') ? '' : (elements.URL.split('/')).pop();
                // Define si ya habia un tipo de archivo registrado en la BD.
                let preloaded = hidden != 'is-hidden' ? 1 : 0;
                //let msgbutton = (fileName != '') ? 'Descargar Archivo' : 'Selecciona Archivo';
                html +=
                `
                <div class="has-background-light box">
                    <div class="columns is-flex is-vcentered">
                        <input type="hidden" name="Tipo_Doc" value="${elements.tipo_doc}">
                        <div class="column is-3">
                            <label class="label"> ${elements.descripcion}</label>
                            <input type="hidden" value="${preloaded}" id="preloaded-${elements.tipo_doc}" name="preloaded">
                            <input type="hidden" value="${elements.URL}" id="archivofull-${elements.tipo_doc}" name="archivofull">
                        </div>
                            <div class="column is-narrow" style="width: 200px;">
                                <div class="file is-small is-boxed has-name is-danger ">
                                    <label class="file-label ">
                                        <input class="file-input"  accept=".pdf" type="file" name="archivo2" id="boton-${elements.tipo_doc}" onchange="clickArchivo(this)">
                                        <span class="file-cta">
                                        
                                            <span class="file-label">
                                                Seleccionar Archivo
                                            </span>
                                        </span>
                                        
                                        <span class="file-name ${hidden}" id="archivo-${elements.tipo_doc}">
                                            ${fileName}
                                        </span>
                                     
                                    </label>
                                    
                                    <div>
                                        <table>
                                                <span id="erase-${elements.tipo_doc}" class="level-right button is-boxed is-danger ${hidden} "onclick="removerArchivo(this)" style="margin-left: 10px; margin-bottom: 10px">
                                                    <i class="tiny material-icons"> clear </i>  
                                                </span>
                                            
                                                <a href="/expediente/download/${elements.tipo_doc}/${Tipo_exp}" id="download-${elements.tipo_doc}" class="level-right button is-boxed is-danger ${hidden}" style="margin-left: 10px">
                                                    <i class="tiny material-icons"> download </i>  
                                                </a>
                                        </table>
                                    </div>
                                    
                                    
                                    
                                </div>
                            </div>
                    <div class="column is-5">
                        <h2 class="label"> ${elements.Comentarios} </h2>
                    </div>
                    <div class="column is-2"> <h2 class="label"> ${estados[elements.estatus]} </h2></div>
                    </div> 
                </div>

                    
                `
                
            }
            document.getElementById('exp').innerHTML = html;
        }
    }).catch(err => {
        bulmaToast.toast({ message: 'Hay un problema con el servidor', type: 'is-danger', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }})
    });
}
const subirarchivo = () =>{
    let element = document.getElementById('subirarch');
    let dynelements = document.getElementById('dynelements');
    window.onbeforeunload = 0;

    //Aqui validamos los archivos antes de iniciar la llamada de subida, por que multer se pone muy spicy si lo hacemos del backend
    // Aunque si se burla esto, el backend evita que se suban archivos.
    let sizecheck = checkfilesize();
    let typecheck = checkfileType();

    if(sizecheck && typecheck){
        dynelements.innerHTML = 
        `
        <input type="hidden" value="${filemap}" id="selectedFiles" name="SelFiles">
        <input type="hidden" value="${removefile}" id="removedFiles" name="RMFiles">
        <input type="hidden" value="${removefile.length}" id="NremovedFiles" name="NRMFiles">
        <input type="hidden" value="${removepaths}" id="removepaths" name="removepaths">
        
        `; 
        element.submit();
    }
    else if(!sizecheck && typecheck)   
        bulmaToast.toast({ message: 'Uno de tus archivos supera el limite de carga (20 MB)', type: 'is-danger', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});
    else if(sizecheck && !typecheck)
        bulmaToast.toast({ message: 'Uno de tus archivos no es del tipo <strong> .pdf </strong>', type: 'is-danger', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});
    else
        bulmaToast.toast({ message: 'Revisa el tamaño y tipo de tus archivos', type: 'is-danger', position: 'bottom-right', animate: { in: 'fadeIn', out: 'fadeOut' }});

}

const checkfilesize = () => {
    for(elements of filemap){
        let fileup = document.getElementById('boton-'+elements);
        if(fileup.files[0].size > (20*1024*1024)){ // 20MB file size
            return false;
        }
    }
    return true;
}

const checkfileType = () => {
    for(elements of filemap){
        let fileup = document.getElementById('boton-'+elements);
        if(fileup.files[0].type != 'application/pdf'){ // Archivo PDF
            return false;
        }
    }
    return true;
}

const clickArchivo = (element) => {
    //Esta funcion obtiene el tipo de documento y lo añade a un  arreglo para saber que se cargo en la BD.
    
    //  Variable que refleja si ha habido cambios
    changes = true;
    let tipo_doc = (element.id.split('-'))[1];
    // Revisa que se haya insertado un archivo y que este no se encuentre en el arreglo de archivos modificados
    if(element.value  != ' ' & filemap.indexOf(tipo_doc) < 0){
        filemap.push(tipo_doc);
        // Se escribe el nombre del archivo en el DOM para que lo vea el usuario
        document.getElementById('archivo-'+tipo_doc).innerHTML = element.files[0].name;
        document.getElementById('archivo-'+tipo_doc).classList.remove('is-hidden');
        // Se muestra el boton para eliminar la seleccion de archivo
        document.getElementById('erase-'+tipo_doc).classList.remove('is-hidden');
        // Si el tipo de documento ya contenia un archivo en la BD, se añade el path del archivo que se reemplazara para borrarlo.
        if(document.getElementById('preloaded-'+tipo_doc).value == 1){
            removepaths.push(document.getElementById('archivofull-'+tipo_doc).value);
            document.getElementById('preloaded-'+tipo_doc).value = 0;
            document.getElementById('aviso').classList.remove('is-hidden');
        }
        // Se tiene que mantener siempre en orden el arreglo de archivos modificados ya que multer registra en orden de despliegue los documentos 
        filemap.sort()
        // Si se iba a eliminar el archivo yluego se decide cargar uno nuevo, se elimina la entrada en el arreglo de eliminacion.
        if(removefile.indexOf(tipo_doc) >= 0){
            removefile.splice(removefile.indexOf(tipo_doc),1);
        }
    
    // Si ya habia un archivo seleccionado y se cambio, solo se actualiza el campo que despliega el nombre del archivo seleccionado en el DOM
    }else if(element.value != ' ' & filemap.indexOf(tipo_doc) >= 0){
        document.getElementById('archivo-'+tipo_doc).innerHTML = element.files[0].name;
    }
    // Al haber cambios se activa el evento para evitar que se refresque la pagina inmediatamente.
    window.onbeforeunload = cambios;
    console.log(filemap);
    console.log(removepaths);
    document.getElementById('botonguardar').classList.remove('is-hidden');
}

const removerArchivo = (element) => {
    // Esta funcion quita el elemento del arreglo por si el usuario decide no subir el archivo una vez que se ha seleccionado
    changes = true;
    let tipo_doc = (element.id.split('-'))[1];
    let button = document.getElementById('boton-'+tipo_doc);
    console.log(button.value);
    // Si el archivo se selecciono en la sesion actual y no hay elementos en la base de datos
    // unicamente se limpia el campo que despliega el nombre del archivo seleccionado y el arreglo de cambios
    // Se esconde de igual manera el boton de borrar seleccion.
    if(button.value != ' ' & filemap.indexOf(tipo_doc) >= 0){
        button.value = '';
        document.getElementById('archivo-'+tipo_doc).innerHTML = '';
        document.getElementById('archivo-'+tipo_doc).classList.add('is-hidden');
        document.getElementById('download-'+tipo_doc).classList.add('is-hidden');
        filemap.splice(filemap.indexOf(tipo_doc),1);
        element.classList.add('is-hidden');
        filemap.sort();
    }else{
        // Este caso considera que ya hay un archivo en la BD y el servidor, por lo que se añade el archivo a la lista de eliminacions y se esconden los botones de borrar
        // De igual forma se depsliega el aviso que se borrara el archivo tanto de la BD como el servidor.
        removefile.push(tipo_doc);
        console.log(removefile);
        element.classList.add('is-hidden');
        document.getElementById('archivo-'+tipo_doc).innerHTML = '';
        document.getElementById('archivo-'+tipo_doc).classList.add('is-hidden');
        document.getElementById('download-'+tipo_doc).classList.add('is-hidden');
        if(document.getElementById('preloaded-'+tipo_doc).value == 1){
            removepaths.push(document.getElementById('archivofull-'+tipo_doc).value);
            document.getElementById('preloaded-'+tipo_doc).value = 0;
            document.getElementById('aviso').classList.remove('is-hidden');
        }
    }
    // Si se intenta recargar la pagina se mostrara una advertencia
    window.onbeforeunload = cambios;
    console.log(filemap);
    console.log(removepaths);
    document.getElementById('botonguardar').classList.remove('is-hidden');
    
}
// Advertencia si hay cambios y se intenta recargar la pagina
const cambios = () => {
    return 'Tienes cambios sin guardar, ¿Deseas salir de la pagina?'; 
}
// Manejo de la advertencia  que aparece al modificar archivos que ya se han guardado anteriormente.
document.addEventListener('DOMContentLoaded', () => {
    (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
      const $notification = $delete.parentNode;
  
      $delete.addEventListener('click', () => {
        $notification.parentNode.removeChild($notification);
      });
    });
  });


  window.onload = llamarcarga(document.getElementById('initval'));