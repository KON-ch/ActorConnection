window.handleImage = function(image) {
  let reader = new FileReader();
  reader.addEventListener("load", function() {
    let imagePreview = document.getElementById("user-image-preview");
    imagePreview.setAttribute('src', reader.result);
    imagePreview.setAttribute('class', "img-fluid");
    imagePreview.setAttribute('style', "height: 9.6rem;");
  });
  reader.readAsDataURL(image[0]);
}