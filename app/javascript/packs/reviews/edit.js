let reviewEditButton = document.getElementById("review-edit");
reviewEditButton.onclick = function() {
  switchEditReview('.userReview', '.editUserReview', '.userReviewEditLabel');
}
let switchEditReview = (textClass, inputClass, labelClass) => {
    if ($(textClass).css('display') == 'block') {
        $(labelClass).text("キャンセル");
        $(textClass).removeClass('show');
        $(inputClass).addClass('show');
    } else {
        $(labelClass).text("編集");
        $(textClass).addClass('show');
        $(inputClass).removeClass('show');
    }
}