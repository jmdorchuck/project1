function loggedIn() {
  var cookies = document.cookie.split(';');
  console.log(cookies);
  var pair;
  var name="";
  for (var i=0; i < cookies.length; i++) {
     pair=cookies[i].split('=');
     console.log(pair[0]);
     console.log(pair[1]);
     if(pair[0].trim()=="name")
       name=pair[1];
  }
  console.log(name);
  if(name != "") {
    var main_container = document.getElementById("main")[0]; 
    var body = document.getElementsByTagName("body")[0];
    var welcome = document.createElement("h2");
    var welcome_name = document.createTextNode("Welcome "+ name);
    welcome.appendChild(welcome_name);
    body.insertBefore(welcome, main_container);
  }
}


