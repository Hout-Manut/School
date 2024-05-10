function extractPrice(text) {
	const regex = /\$(\d+)\.\d{2}/;
	const match = text.match(regex);

	if (match) {
		const price = parseInt(match[1]);
		return price;
	} else {
		return 0;
	}
}

function createPhoneCard(phone) {
	const col = document.createElement("div");
	col.classList.add("col");

	col.innerHTML =
    <ul>
    <li><p>${phone.brand}</p></li>
    <li><p>${phone.modal}</p></li>
    <li><p>${phone.dimension}</p></li>
    <li><p>${phone.chipset}</p></li>
    <li><p>${phone.camera}</p></li>
    <li><p>${phone.battery}</p></li>
</ul>
    ;

	return col;
}

function displayStorageOptions(phone) {
	const storageContainer = document.getElementById("storage");

	if (phone.storage && Array.isArray(phone.storage)) {
		phone.storage.forEach((storageOption) => {
			const storageElement = document.createElement("option");
            storageElement.value = extractPrice(storageOption)
			storageElement.text = storageOption;
			storageContainer.appendChild(storageElement);
		});
	}
}
function displayColorOptions(phone) {
	const colorContainer = document.getElementById("color");

	if (phone.color && Array.isArray(phone.color)) {
		phone.color.forEach((colorOption) => {
			const colorElement = document.createElement("option");
			colorElement.text = colorOption;
			colorContainer.appendChild(colorElement);
		});
	}
}

const featuredPhonesContainer = document.getElementById("info");
const productImageContainer = document.getElementById("product-image");

const urlParams = new URLSearchParams(window.location.search);
const phoneIdParam = urlParams.get("phoneIndex");

fetch("data/phones.json")
	.then((response) => response.json())
	.then((data) => {
		const matchingPhone = data.find((phone) => phone.id === phoneIdParam);

		if (matchingPhone) {
			const phoneCard = createPhoneCard(matchingPhone);
			featuredPhonesContainer.appendChild(phoneCard);

			const imageElement = document.createElement("img");
			imageElement.src = matchingPhone.img;
			imageElement.alt = "Blue Phone";
			imageElement.classList.add("phone-image");
			productImageContainer.appendChild(imageElement);
			displayStorageOptions(matchingPhone);
            displayColorOptions(matchingPhone);
		} else {
			console.error("Phone not found with ID:", phoneIdParam);
		}
	})
	.catch((error) => {
		console.error("Error fetching JSON data:", error);
	});
