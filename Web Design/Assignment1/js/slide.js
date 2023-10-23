let slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function changeSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("slide");
  let bars = document.getElementsByClassName("bar");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < bars.length; i++) {
    bars[i].className = bars[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  bars[slideIndex-1].className += " active";
}
