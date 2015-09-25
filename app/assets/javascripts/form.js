function invalid_field(field, error) {
   if(error)
      field.style.border = "1px solid #ea1515";
   else
      field.style.border = "";

}


function check_username(field) {

  var regex = /^[a-zA-Z0-9_ éè]{2,15}$/i;
  if(field.value.length < 2 || field.value.length > 15) {
    invalid_field(field, true);
    document.getElementById('username_error').innerHTML = "De 2 à 15 caractères"
    return false;
  } else if (!regex.test(field.value)) {
      invalid_field(field, true);
      document.getElementById('username_error').innerHTML = "Lettres maj, min, e accents et chiffres uniquement"
      return false;
  } else {
    invalid_field(field, false, "");
    document.getElementById('username_error').innerHTML = ""
    return true;
   }
}

function check_email(field) {

  var regex = /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i;
  if(field.value.length < 5 || field.value.length > 30) {
    invalid_field(field, true);
    document.getElementById('email_error').innerHTML = "De 5 à 30 caractères"
    return false;
  } else if (!regex.test(field.value)) {
    invalid_field(field, true);
    document.getElementById('email_error').innerHTML = "Adresse mail invalide"
    return false;    
  }
  else {
    invalid_field(field, false);
    document.getElementById('email_error').innerHTML = ""
    return true;
   }
}

function check_password(field) {

  if(field.value.length < 10 || field.value.length > 50) {
    invalid_field(field, true);
    document.getElementById('password_error').innerHTML = "De 10 à 50 caractères"
    return false;
  }
  else {
    invalid_field(field, false);
    document.getElementById('password_error').innerHTML = ""
    return true;
   }
}

function check_password_confirmation(field) {

  if(field.value != document.getElementById('user_password').value) {
    invalid_field(field, true);
    document.getElementById('password_confirmation_error').innerHTML = "Les mdp doivent être identiques"
    return false;
  }
  else {
    invalid_field(field, false);
    document.getElementById('password_confirmation_error').innerHTML = ""
    return true;
   }
}
 

