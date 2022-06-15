function readerCantBeReached(){
  Swal.fire({
      icon: 'error',
      title: 'Oops...',
      text: 'Le lecteur RFID distant n\'est pas atteignable',
  
    }).then(function(){
      location.replace("index.php");
    })
}
function noTagPresent(){
  Swal.fire({
      icon: 'error',
      title: 'Oops...',
      text: 'Le tag RFID n\'a pas été présenté sur le lecteur. Veuillez réessayer ou saisir le badge manuellement',

    }).then(function(){
      location.replace("index.php");
    })
}
function added(){
  Swal.fire({
      icon: 'success',
      text: 'L\'utilisateur à bien été ajouté',
    }).then(function(){
    location.replace("index.php");
  })
}

function deleted(){
  Swal.fire({
      icon: 'success',
      text: 'L\'utilisateur à bien été supprimé',
    }).then(function(){
     location.replace("index.php");
   })
}

function edited(){
  Swal.fire({
    icon: 'success',
    text: 'L\'utilisateur à bien été modifié',
  }).then(function(){
   location.replace("index.php");
 })
}

function addUser(){
  location.replace("addUser.php");
}

function delUser(id){
  var form = document.getElementById('delForm'+id);
  console.log('delForm'+id);
  Swal.fire({
  title: 'Vous êtes sur?',
  icon: 'warning',
  showCancelButton: true,
  confirmButtonColor: '#3085d6',
  cancelButtonColor: '#d33',
  cancelButtonText:'Annuler',
  confirmButtonText: 'Oui, supprimer !'
  }).then((result) => {
  if (result.isConfirmed) {
    form.submit();
  }
  })
}

function editUser(id){
  var form = document.getElementById('editForm'+id);
  console.log('editForm'+id);
  Swal.fire({
    title: 'Vous êtes sur?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    cancelButtonText:'Annuler',
    confirmButtonText: 'Oui, modifier'
  }).then((result) => {
    if (result.isConfirmed) {
      location.replace("editUser.php?id="+id);
    }
  })
}

function cancel(){
  Swal.fire({
    title: 'Vous êtes sur?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    cancelButtonText:'Annuler',
    confirmButtonText: 'Oui, quitter'
  }).then((result) => {
    if (result.isConfirmed) {
      location.replace("index.php");
    }
  })
}

function showPreviousData(id,name,surname,password){
  var nom = document.getElementById('nom');
  var prenom = document.getElementById('prenom');
  var motdepasse = document.getElementById('password');
  var show = document.getElementById('show');

  nom.setAttribute("value",name);
  prenom.setAttribute("value",surname);
  motdepasse.setAttribute("value",password);
  show.innerHTML=(id+1);
}

function showPreviousTag(tag){
  var badge = document.getElementById('textManuel');
  badge.setAttribute("value",tag);
}

function nothingChanged(id){
  Swal.fire({
    icon: 'error',
    title: 'Oops...',
    text: 'Veuillez modifier au moins un des éléments pour valider et/ou présenter un autre badge',
  }).then(function(){
    location.replace("editUser.php?id="+id);
  })
}

function tagAlreadyUsedEdit(id){
  Swal.fire({
    icon: 'error',
    title: 'Oops...',
    text: 'Le tag est déjà utilisé par un autre utilisateur',
  }).then(function(){
    location.replace("editUser.php?id="+id);
  })
}

function tagAlreadyUsedAdd(){
  Swal.fire({
    icon: 'error',
    title: 'Oops...',
    text: 'Le tag est déjà utilisé par un autre utilisateur',
  }).then(function(){
 //   location.replace("addUser.php");
  })
}

function loading(){
  Swal.fire({
    title: 'Please Wait',
    allowEscapeKey: false,
    allowOutsideClick: false,
    background: '#19191a',
    showConfirmButton: false,
    onOpen: ()=>{
        Swal.showLoading();
    }

    // timer: 3000,
    // timerProgressBar: true
});
}

function showLoadingTag(){
  var loading = document.getElementById("loading");
  loading.style.display = 'block';
}
function hideLoadingTag(){
  var loading = document.getElementById("loading");
  loading.style.display = 'none';
}