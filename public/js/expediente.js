

let map = new Array();

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
    let elementid = identificador.id.slice(-1);
    let elemento = document.getElementById('comentarios'+elementid);
    let drop = document.getElementById('dropdown'+elementid).value;
    
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

