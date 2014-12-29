// Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/





var annotation_list = new Array();
var text_to_edit = new Array();
var comment_by=new Array();

function init() {
  obj=document.getElementById('annotatableImage');
  anno.makeAnnotatable(obj);
  loadAnnotations();
}

function appendComment(itemToAppend){
  $( "#comments" ).append(itemToAppend);
  $("#comment_value").val("");
}

function editComment(id){


  var top = document.getElementById("comment"+id);
  var btns = top.getElementsByClassName("image-comment-buttons-container");
  btns[0].style.display="none";
  commentId = id;
  var sub=top.getElementsByTagName("span");
  text_to_edit[commentId] = sub.value.innerHTML

  sub.value.innerHTML="<form accept-charset='UTF-8' action='"+url_for_comments+"/"+id+"' class='new_comment' data-remote='true' id='new_comment' method='post'><input type='text' value='"+text_to_edit[commentId]+"' name='value'><input type='submit' value='update'><span onClick=resetComment("+commentId+")> cancel </span></form>";


}
function resetComment(id){
  var top = document.getElementById("comment"+id);
  var sub=top.getElementsByTagName("span");
  var btns = top.getElementsByClassName("image-comment-buttons-container");
  btns[0].style.display="block";
  sub.value.innerHTML=text_to_edit[id];
  // sub.value.innerHTML="<div class='image-comment-buttons-container'><a href='"+url_for_comments+"/"+id+"' data-method='delete' data-confirm='Are you sure you want to delete this comment?'> <div class='image-comment-delete'> </div> </a> <div class='image-comment-edit'onClick='editComment("+id+")' ></div></div> <div class='image-comment-content'> <span id='value'>"+text_to_edit[id]+"</span></div> ";
}

function removeComment(comment_id){
  document.getElementById("comment"+comment_id).remove();
}


function updateComment(id,value){
  var top = document.getElementById("comment"+id);
  top.innerHTML="<div class='image-comment-buttons-container'><a href='"+url_for_comments+"/"+id+"' data-method='delete' data-confirm='Are you sure you want to delete this comment?'> <div class='image-comment-delete'> </div> </a> <div class='image-comment-edit'onClick='editComment("+id+")' ></div></div> <div class='image-comment-content'><span id='value'>"+value+"</span></div> ";
  loadAnnotations();
}



//Annotation functions

function appendAnnotation(data,id,name){
  annotation_object=JSON.parse(data);
  var comment_div = document.createElement("div");
  comment_div.className = "image-comment"

  comment_div.id="comment"+id;
  var span_value = document.createElement("span");
  span_value.id="value";
  span_value.innerHTML = annotation_object.text;

  var image_comment_content = document.createElement("div");
  image_comment_content.className = "image-comment-content";
  image_comment_content.innerHTML = name +": ";
  image_comment_content.appendChild(span_value);



  var image_comment_buttons_container = document.createElement("div");
  image_comment_buttons_container.className= "image-comment-buttons-container"
  image_comment_buttons_container.innerHTML="<a href='"+url_for_comments+"/"+id+"' data-method='delete' data-confirm='Are you sure you want to delete this comment?'> <div class='image-comment-delete'> </div> </a>";

  var image_comment_edit = document.createElement("div");
  image_comment_edit.className="image-comment-edit";
  image_comment_edit.onclick = function(){ editComment(id); };
  var comment_delete_link = document.createElement("a");
  comment_delete_link.href = url_for_comments+"/"+id;
  image_comment_buttons_container.appendChild(image_comment_edit);

  comment_div.appendChild(image_comment_buttons_container);
  comment_div.appendChild(image_comment_content);
  $( "#comments" ).append(comment_div);

}



function loadAnnotations() {
  var j=0;
  jQuery.getJSON(url_for_annotations,function(data) {
    for (var i = 0; i < data.annotations.length; i++){
      annotation = JSON.parse(data.annotations[i].json)
      if(annotation!=null){
        annotation.id = JSON.parse(data.annotations[i].id);
        annotation.text=data.annotations[i].value;
        annotation_list[j]=(annotation);
        j++;
      }
    }
    drawAnnotations();
  });
}

function drawAnnotations(){
  for(var i=0; i<annotation_list.length; i++){
    anno.addAnnotation(annotation_list[i]);
  }
}


function updateAnnotationComment(id,value){
  var top = document.getElementById("comment"+id);
  var sub = top.getElementsByClassName("image-comment-content");
  var span=top.getElementsByTagName("span");
  span.value.innerHTML = value;





  var btns = top.getElementsByClassName("image-comment-buttons-container");
  btns[0].style.display="block";







}

//This gets called when the user clicks on the save button
anno.addHandler('onAnnotationCreated', function(annotation) {
  jQuery.ajax({
    type: "POST",
    url: url_for_annotations,
    dataType: "JSON",
    data: "annotation="+JSON.stringify(annotation),
    success: function(data) {
        annotation.id = data.id;
        appendAnnotation(data.json,data.id,data.comment_name)
    }
    });
});

// this gets called when the user clicks the delete icon
anno.addHandler('beforeAnnotationRemoved', function(annotation) {
  var r=confirm("Are you sure you want to delete this annotation?");
  if (r==false) { return false;}
});

// this is what gets called when the annotation is actually deleted (assuming the user clicks OK to the confirmation dialog)
anno.addHandler('onAnnotationRemoved', function(annotation) {
  jQuery.ajax({
    type: "delete",
    url: url_for_annotations+"/"+annotation.id,
    dataType: "script"
    });
  // succes function gets called from annotations/destroy.js
});

//This egt's called when you added an annotation on the image
anno.addHandler('onAnnotationUpdated', function(annotation) {
  alert("here");
  jQuery.ajax({
    type: "PUT",
    dataType: "SCRIPT",
    url: url_for_annotations+"/"+annotation.id,
    data: "annotation="+JSON.stringify(annotation),
    // succes function gets called from annotations/update.js.erb
  });
});
