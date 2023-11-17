var specs_subject = document.getElementsByClassName("subject-specs");

specs_subject[0].addEventListener("click", showDropdown);

function showDropdown() {
	document.getElementById("subject-specs-second-quarter-dropdown").classList.toggle("show-dropdown");
}