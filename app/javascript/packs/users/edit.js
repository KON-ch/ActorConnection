function handleImage(image) {
  let reader = new FileReader();
  reader.onload = function(e) {
    let imagePreview = $("#user-image-preview");
    imagePreview.attr("src", e.target.result);
    imagePreview.attr("class", "img-fluid w-25");
  };
console.log(image);
reader.readAsDataURL(image[0]);
}
