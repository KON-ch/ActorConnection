/* global $ */
$(document).on('turbolinks:load', () => {
  $('#user_image').onchange(function() {
    if (this.files && this.files[0]) {
      let reader = new FileReader();
        reader.onload = function(e) {
          $('#user-image-preview').attr('src', e.target.result);
          $('#user-image-preview').attr('class', 'img-fluid w-25');
        }
      reader.readAsDataURL(this.files[0]);
    }
  });
});