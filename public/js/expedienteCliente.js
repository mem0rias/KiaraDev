const filemap = new Array();
const removefile = new Array();
const removepaths = new Array();
let changes = false;
const clickArchivo = (element) => {
    //Esta funcion obtiene el tipo de documento y lo añade a un  arreglo para saber que se cargo en la BD.
    changes = true;
    let tipo_doc = (element.id.split('-'))[1];
    if(element.value  != ' ' & filemap.indexOf(tipo_doc) < 0){
        filemap.push(tipo_doc);
        document.getElementById('archivo-'+tipo_doc).innerHTML = element.files[0].name;
        document.getElementById('archivo-'+tipo_doc).classList.remove('is-hidden');
        document.getElementById('erase-'+tipo_doc).classList.remove('is-hidden');
        if(document.getElementById('preloaded-'+tipo_doc).value == 1){
            removepaths.push(document.getElementById('archivofull-'+tipo_doc).value);
            document.getElementById('preloaded-'+tipo_doc).value = 0;
            document.getElementById('aviso').classList.remove('is-hidden');
        }

        filemap.sort();
        if(removefile.indexOf(tipo_doc) >= 0){
            removefile.splice(removefile.indexOf(tipo_doc),1);
        }
    }
    window.onbeforeunload = cambios;
    console.log(filemap);
    console.log(removepaths);
}

const removerArchivo = (element) => {
    // Esta funcion quita el elemento del arreglo por si el usuario decide no subir el archivo una vez que se ha seleccionado
    changes = true;
    let tipo_doc = (element.id.split('-'))[1];
    let button = document.getElementById('boton-'+tipo_doc);
    console.log(button.value);
    if(button.value != ' ' & filemap.indexOf(tipo_doc) >= 0){
        button.value = '';
        document.getElementById('archivo-'+tipo_doc).innerHTML = '';
        document.getElementById('archivo-'+tipo_doc).classList.add('is-hidden');
        filemap.splice(filemap.indexOf(tipo_doc),1);
        element.classList.add('is-hidden');
        filemap.sort();
    }else{
        removefile.push(tipo_doc);
        console.log(removefile);
        element.classList.add('is-hidden');
        document.getElementById('archivo-'+tipo_doc).innerHTML = '';
        document.getElementById('archivo-'+tipo_doc).classList.add('is-hidden');
        if(document.getElementById('preloaded-'+tipo_doc).value == 1){
            removepaths.push(document.getElementById('archivofull-'+tipo_doc).value);
            document.getElementById('preloaded-'+tipo_doc).value = 0;
            document.getElementById('aviso').classList.remove('is-hidden');
        }
    }
    window.onbeforeunload = cambios;
    console.log(filemap);
    console.log(removepaths);
    
}

const cambios = () => {
    return 'Tienes cambios sin guardar, ¿Deseas salir de la pagina?'; 
}

document.addEventListener('DOMContentLoaded', () => {
    (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
      const $notification = $delete.parentNode;
  
      $delete.addEventListener('click', () => {
        $notification.parentNode.removeChild($notification);
      });
    });
  });