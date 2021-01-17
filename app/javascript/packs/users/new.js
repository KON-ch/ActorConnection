/* global $ */
document.addEventListener('turbolinks:load', function(){
  document.getElementById('user_image').addEventListener( "change", function(){
    if (this.files && this.files[0]) {
      let reader = new FileReader();
        reader.addEventListener("load", function(e) {
          document.getElementById('user-image-preview').setAttribute('src', e.target.result);
          document.getElementById('user-image-preview').setAttribute('class', "img-fluid w-25");
        })
      reader.readAsDataURL(this.files[0]);
    }
  });
});