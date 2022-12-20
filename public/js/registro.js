

let map = ['1','2','3','4','5','6','7'];
let valid_mail = false;
let valid_pass = false;
let valid_phone = false;
let csrfToken = document.getElementsByName('_csrf')[0].value;
const checkbutton = (map) =>{
    let savebutton = document.getElementById('enviar');
    //Si el arreglo tiene un tamaño mayor a 0 significa que hay inputs que no cumplen con la regla y se deshabilita el boton.
    //console.log(map);
    if(map.length > 0 || !valid_mail || !valid_pass || !valid_phone){
        savebutton.disabled = true;
        document.getElementById('mensaje').innerHTML= 'Llena todos los campos :)';
    }
    else if(valid_mail && valid_pass && valid_phone){
        savebutton.disabled = false;
        document.getElementById('mensaje').innerHTML= '';
    }
}
const cambiarcolor = (identificador) => { //Esta funcion se llama desde expediente.ejs para verificar que no se rechace un documento sin explicacion
    //Obtenemos el Tipo_doc como id para cada bloque
    let elementid = (identificador.id.split('-'))[1];
    //console.log(elementid);
    let elemento = document.getElementById('campo-'+elementid);
    //console.log(elementid);
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
    //Primera carga de la pagina, deshabilita el envio del registro, ya que esta vacia
    let savebutton = document.getElementById('enviar');
    savebutton.disabled = true;
    
}

const correovalido = (id) => {
    // Llamada de ajax con el correo, se checa que el correo sea valido en estructura, aun falta validar con la BD.
    let savebutton = document.getElementById('enviar');
    // Llamada de AJAX para verificar que se tiene un correo valido
    fetch('/login/verificarcorreo', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            email : document.getElementById('campo-4').value,
            _csrf : csrfToken,
        }),
        }).then(result => {
            return result.json();
        }).then(data => {
            //console.log(data);
            // Dependiendo el caso que se recibe se cambiar el mensaje dentro de la pagina.
            if(data == 'invalidEmail'){
                document.getElementById('correo').innerHTML = 'Tu correo es invalido';
                valid_mail = false;
            }else if(data == 'usedEmail'){
                document.getElementById('correo').innerHTML = 'El correo ya esta en uso';
                valid_mail = false;
            }else if(data == 'noConn'){
                document.getElementById('correo').innerHTML = 'Tenemos problemas para validar tu correo';
                valid_mail = false;
            }
            else{
                document.getElementById('correo').innerHTML = '';
                valid_mail = true;   
            }
            // Se checa el estado de los inputs para ver si se libera o no el boton de registro dependiendo la flag 'valid_email'
            checkbutton(map);
                
        }).catch(err =>{
            // Caso donde no se reciba respuesta con el servidor.
            //console.log(err);
            document.getElementById('correo').innerHTML = 'Tenemos problemas para validar tu correo';
            valid_mail = false;
            checkbutton(map);
        });
}

const contravalido = (id) => {
    // Llamada de ajax para validar que la contraseña cumpla con el requisito de longitud
    let savebutton = document.getElementById('enviar');
    fetch('/login/verificarcontra', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            pass : document.getElementById('campo-7').value,
            _csrf : csrfToken,
        }),
        }).then(result => {
            return result.json();
        }).then(data => {
            console.log(data);
            // Arreglo de errores se recibe, si es 0 significa que no hay errores y por lo tanto es valido.
            if(data.length > 0){
                document.getElementById('pass').innerHTML = 'Tu contraseña debe tener al menos 8 caracteres';
                valid_pass = false;
            }
            else{
                document.getElementById('pass').innerHTML = '';
                valid_pass = true;   
            }
            // Se checa el estado de los inputs para ver si se libera o no el boton de registro
            checkbutton(map);    
        }).catch(err =>{
            // Si no se recibe respuesta del servidor.
           // console.log(err);
            document.getElementById('correo').innerHTML = 'Tenemos problemas para validar tu contraseña';
            valid_pass = false;
            checkbutton(map);  
        }); 
}


const phonecheck = () => {
    // Se hace una llamada al JS de intlTelInput para validar si un numero de telefono es valido.
    let phone = phoneInput.getNumber();
    let telbox = document.getElementById('Tel');
    // Se revisa que sea valido o que sea posiblemente valido, por eso esa el getValidationError()
    if(phoneInput.isValidNumber() || phoneInput.getValidationError() == 0){
        document.getElementById('telefono').value = phone;
        valid_phone = true;
        telbox.innerHTML = '';
    }else{
        valid_phone = false;
        //console.log(phoneInput.getValidationError());
        telbox.innerHTML = 'Ingresa un telefono valido';
    }
    checkbutton(map);
    
}
// Libreria para checar si el telefono es valido
const phoneInputField = document.getElementById('campo-6');
   const phoneInput = window.intlTelInput(phoneInputField, {
    utilsScript:
       "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
    autoPlaceholder:
        "off",
    preferredCountries:
        ["mx", "us", "ca"],
   });
//Evento para llamar a la funcion de phonecheck() en caso de que se cambie de opcion de pais.
   phoneInputField.addEventListener('countrychange', function() {
     phonecheck();
   });

//Se llama la funcion firstload al momento de que se carga la pagina   
window.onload = firstload;