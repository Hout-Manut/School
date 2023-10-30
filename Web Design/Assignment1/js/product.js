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

const featuredPhonesContainer = document.getElementById("product-container");

fetch("data/phones.json")
    .then(response => response.json())
    .then(data => {
        data.forEach(phone => {
            const phoneCard = createPhoneCard(phone);
            featuredPhonesContainer.appendChild(phoneCard);
        });
    })
    .catch(error => {
        console.error("Error fetching JSON data:", error);
    });