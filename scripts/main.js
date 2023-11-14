//header-related js
var icons = document.getElementsByClassName("header-dropdown");
var headerButton = document.getElementById("specs-dropdown-button");

headerButton.addEventListener("click", showHeaderDropdown);

//i think this is a terrible way to implement this but i'm tired and out　of ideas
function showHeaderDropdown() {
	document.getElementById("specs-header-dropdown-content").classList.toggle("show-dropdown");
}

window.onclick = function(event) {
	if (!event.target.matches(".header-dropdown")) {
		if (document.getElementById("specs-header-dropdown-button") != null) {
			document.getElementById("specs-header-dropdown-content").classList.remove("show-dropdown");
		}
	}
}