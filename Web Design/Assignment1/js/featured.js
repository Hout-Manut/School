function createPhoneCard(phone) {
    const col = document.createElement("div");
    col.classList.add("col");

    col.innerHTML = `
        <a href="detail.html?phoneIndex=${phone.id}">
            <img src="${phone.img}" alt="${phone.modal}" />
        </a>
        <a href="detail.html?phoneIndex=${phone.id}">
            <h2>${phone.modal}</h2>
            <p class="price">${phone.price}</p>
        </a>
    `;

    return col;
}

const featuredPhonesContainer = document.getElementById("featured-phones-container");
let slideIndex = 1;
let timer;
showSlides(slideIndex);

fetch("data/phones.json")
    .then(response => response.json())
    .then(data => {
        const first8Phones = data.slice(0, 8);

        first8Phones.forEach(phone => {
            const phoneCard = createPhoneCard(phone);
            featuredPhonesContainer.appendChild(phoneCard);
        });
    })
    .catch(error => {
        console.error("Error fetching JSON data:", error);
    });

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
	
	timer = setTimeout(function () {
		changeSlides(1);
	}, 5000);
}
