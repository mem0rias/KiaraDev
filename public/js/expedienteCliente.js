// Arreglo de archivos añadidos/modificados
const filemap = new Array();
// Arreglo de archivos previamente añadidos que se elminaran
const removefile = new Array();
// Direcciones de archivos que se borraran del servidor
const removepaths = new Array();
let changes = false;
// Ultima seleccion de tipo de expediente.
let prevsel;
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