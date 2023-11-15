//header-related js
var dropdowns = document.getElementsByClassName("dropdown-content");
var dropdownButton = document.getElementsByClassName("dropdown-button");

dropdownButton[0].addEventListener("click", showMapehDropdown);
dropdownButton[1].addEventListener("click", showSpecsDropdown);

//i think this is a terrible way to implement this but i'm tired and out　of ideas
function showMapehDropdown() {
	hideDropdowns();
	document.getElementById("header-mapeh-dropdown-content").classList.toggle("show-dropdown");
}

function showSpecsDropdown() {
	hideDropdowns();
	document.getElementById("header-specs-dropdown-content").classList.toggle("show-dropdown");
}

window.onclick = function(event) {
	if (!event.target.matches(".dropdown-button")) {
		hideDropdowns();
	}
}

function hideDropdowns() {
	for (let i = 0; i < dropdowns.length; i++) {
		if (dropdowns[i].classList.contains("show-dropdown")) {
			dropdowns[i].classList.remove("show-dropdown");
		}
	}
}