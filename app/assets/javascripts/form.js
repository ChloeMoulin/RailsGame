function invalid_field(field, error) {
   if(error)
      field.style.border = "1px solid #ea1515";
   else
      field.style.border = "";

}


function check_username(field) {

  var regex = /^[a-zA-Z0-9_ éè]{2,15}$/i;
  if(field.value.length < 2 || field.value.length > 15 || !regex.test(field.value)) {
    invalid_field(field, true);
    return false;
  }
  else {
    invalid_field(field, false);
    return true;
   }
}

function check_email(field) {

  var regex = /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i;
  if(field.value.length < 5 || field.value.length > 30 || !regex.test(field.value)) {
    invalid_field(field, true);
    return false;
  }
  else {
    invalid_field(field, false);
    return true;
   }
}

function check_password(field) {

  if(field.value.length < 10 || field.value.length > 50) {
    invalid_field(field, true);
    return false;
  }
  else {
    invalid_field(field, false);
    return true;
   }
}

function check_password_confirmation(field) {

  if(field.value != document.getElementById('user_password').value) {
    invalid_field(field, true);
    return false;
  }
  else {
    invalid_field(field, false);
    return true;
   }
}