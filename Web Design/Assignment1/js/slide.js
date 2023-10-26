let slideIndex = 1;
let timer;
showSlides(slideIndex);

// Next/previous controls
function changeSlides(n) {
	clearTimeout(timer);
	
	showSlides((slideIndex += n));
}

// Thumbnail image controls
function currentSlide(n) {
	showSlides((slideIndex = n));
}

function showSlides(n) {
	let i;
	let slides = document.getElementsByClassName("slide");
	if (n > slides.length) {
		slideIndex = 1;
	} else if (n < 1) {
		slideIndex = slides.length;
	}
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";
	}
	slides[slideIndex - 1].style.display = "block";
	
	// timer = setTimeout(function () {
	// 	changeSlides(1);
	// }, 5000);
}
