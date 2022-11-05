

let map = ['1','2','3','4','5','6','7'];
let valid_mail = false;
const checkbutton = (map) =>{
    let savebutton = document.getElementById('enviar');
    //Si el arreglo tiene un tamaño mayor a 0 significa que hay inputs que no cumplen con la regla y se deshabilita el boton.
    console.log(map);
    if(map.length > 0 || !valid_mail){
        savebutton.disabled = true;
        document.getElementById('mensaje').innerHTML= 'Llena todos los campos :)';
    }
    else if(valid_mail){
        savebutton.disabled = false;
        document.getElementById('mensaje').innerHTML= '';
    }
}
const cambiarcolor = (identificador) => { //Esta funcion se llama desde expediente.ejs para verificar que no se rechace un documento sin explicacion
    //Obtenemos el Tipo_doc como id para cada bloque
    let elementid = (identificador.id.split('-'))[1];
    console.log(elementid);
    let elemento = document.getElementById('campo-'+elementid);
    console.log(elementid);
    //Se verifica que no este vacio y en rechazado.
    if(elemento.value == ''){
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

const firstload = () =>{
    let savebutton = document.getElementById('enviar');
    savebutton.disabled = true;

}

const correovalido = (id) => {
    let savebutton = document.getElementById('enviar');
    fetch('/login/verificar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            email : document.getElementById('campo-4').value,
            
        }),
        }).then(result => {
            return result.json();
        }).then(data => {
            console.log(data);
            if(data.length > 0){
                document.getElementById('correo').innerHTML = 'Tu correo es invalido';
                valid_mail = false;
            }
            else{
                document.getElementById('correo').innerHTML = '';
                valid_mail = true;   
            }
                
        }).catch(err =>{
            console.log(err);

        });
}

window.onload = firstload;