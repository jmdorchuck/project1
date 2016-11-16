var textFieldCount=new Object();
var textFieldLimit=50;

function addTextField(parent_id, name, size) {
    if (textFieldCount[parent_id]==undefined)
       textFieldCount[parent_id]=0;
    console.log(textFieldCount[parent_id]);
    if(textFieldCount[parent_id]==textFieldLimit){
       alert("You have reached the limit of additional text fields.");
    }
    else{
        parent_container = document.getElementById(parent_id);
        new_container = document.createElement('li')
        new_field = document.createElement('input');
        new_field.setAttribute('type', 'text');
        new_field.setAttribute('name', name);
        new_field.setAttribute('size', size);
        new_container.appendChild(new_field);
        parent_container.appendChild(new_container);
        textFieldCount[parent_id]++;
    }
    
}

