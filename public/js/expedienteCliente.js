const filemap = new Array();
const clickArchivo = (element) => {
    //Esta funcion obtiene el tipo de documento y lo añade a un  arreglo para saber que se cargo en la BD.
    let tipo_doc = (element.id.split('-'))[1];
    if(element.value  != ' ' & filemap.indexOf(tipo_doc) < 0){
        filemap.push(tipo_doc);
        document.getElementById('erase-'+tipo_doc).classList.remove('is-hidden');
        filemap.sort();
    }
    
    document.getElementById('selectedFiles').value = filemap;
    
    console.log(filemap);
}

const removerArchivo = (element) => {
    // Esta funcion quita el elemento del arreglo por si el usuario decide no subir el archivo una vez que se ha seleccionado
    let tipo_doc = (element.id.split('-'))[1];
    let button = document.getElementById('boton-'+tipo_doc);
    console.log(button.value);
    if(button.value != ' ' & filemap.indexOf(tipo_doc) >= 0){
        button.value = '';
        filemap.splice(filemap.indexOf(tipo_doc),1);
        element.classList.add('is-hidden');
        filemap.sort();
    }
    
    document.getElementById('selectedFiles').value = filemap;
    console.log(filemap);
    
}