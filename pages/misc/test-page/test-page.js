class Header extends HTMLElement {
	constructor() {
		super();
		this.attachShadow({mode: 'open'})
	}
	
	connectedCallback() {
		this.shadowRoot.innerHTML = `
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
		<style>
			.header {
				background-color: #000000;
				padding: 10px;
				color: white;
				position: sticky;
				top: 0;
				font-family: sans-serif;
				margin: 0;
			}

			.header-content {
				display: flex;
				justify-content: space-between;
				align-items: center;
			}

			#header-title {
				font-size: 1.5rem;
				display: inline;
			}

			.header-icons-container {
				display: flex;
				gap: 10px;
			}

			.header-icon {
				position: relative;
				height: 50px;
				width: 50px;
				border: 5px solid #2D2D32;
				display: flex;
				justify-content: center;
				align-items:　center;
				font-size: 2rem;
			}
			
			i {
				margin: auto;
			}
			
			a {
				text-decoration: none;
				color: white;
				display: block;
			}
			
			body {
				background-color: black;
			}
			
			/* subject colors */
			.math {
				background-color: #CC0000;
			}

			.science {
				background-color: #0ACD00;
			}

			.english {
				background-color: #9100CD;
			}

			.filipino {
				background-color: #CD7800;
			}

			.ap {
				background-color: #0037CD;
			}

			.computer {
				background-color: #643C28;
			}

			.music {
				background-color: #E5CD00;
			}

			.arts {
				background-color: #B3A424;
			}

			.pe {
				background-color: #807833;
			}

			.health {
				background-color: #4C492E;
			}

			.specs {
				background-color: #9B461E;
			}

			.ve {
				color: #000000;
				background-color: #FFFFFF;
			}

			.mapeh {
				background-color: #E6E100;
			}

			.unavailable {
				color: white;
				background-color: #788C9B;
			}
			
			/* dropdowns */
			.dropdown-button {
				padding: 10px;
				position: absolute;
				height: 100%;
				width: 100%;
				border: none;
				background: none;
			}

			.header-dropdown-content {
				top: 66px;
				min-width: 150px;
			}

			.header-dropdown-content a {
				display: block;
				font-size: 1rem;
				font-weight: bold;
				padding: 10px;
			}

			.dropdown-content {
				display: none;
				background-color: #828282;
				border: 5px solid #5A5A5A;
				z-index: 1;
			}

			.show-dropdown {
				display: block;
				position: absolute;
			}
		
			
			
		</style>
		<header class="header">
			<div class="header-content">
				<h1 id="header-title"><a href="index.html">10th Grade Reference</a></h1>
				<div class="header-icons-container">
					<a href="pages/second quarter/math/math-second-quarter.html"><div class="header-icon math">
						<i class="bi bi-calculator-fill"></i>
					</div></a>
					<a href="pages/second quarter/science/science-second-quarter.html"><div class="header-icon science">
						<i class="bi bi-rocket-takeoff-fill"></i>
					</div></a>
					<a href="pages/second quarter/english/english-second-quarter.html"><div class="header-icon english">
						<i class="bi bi-book-fill"></i>
					</div></a>
					<a href="pages/second quarter/filipino/filipino-second-quarter.html"><div class="header-icon filipino">
						<i class="bi bi-book-fill"></i>
					</div></a>
					<a href="pages/second quarter/ap/ap-second-quarter.html"><div class="header-icon ap">
						<i class="bi bi-globe-asia-australia"></i>
					</div></a>
					<a href="pages/second quarter/computer/computer-second-quarter.html"><div class="header-icon computer">
						<i class="bi bi-code-slash"></i>
					</div></a>
					<div class="header-icon mapeh">
						<i class="bi bi-palette-fill"></i>
						<button class="dropdown-button" id="dropdown-button"></button>
						<div class="header-dropdown-content dropdown-content show-dropdown" id="header-mapeh-dropdown-content">
							<a href="pages/second quarter/music/music-second-quarter.html">Music</a>
							<a href="pages/second quarter/arts/arts-second-quarter.html">Arts</a>
							<a href="pages/second quarter/pe/pe-second-quarter.html">PE</a>
							<a href="pages/second quarter/health/health-second-quarter.html">Health</a>
						</div>
					</div>
					<div class="header-icon specs">
						<i class="bi bi-rulers"></i>
						<button class="dropdown-button show-dropdown" id="specs-dropdown-button"></button>
						<div class="header-dropdown-content dropdown-content" id="header-specs-dropdown-content">
							<a href="pages/second quarter/bookkeeping/bookkeeping-second-quarter.html">Bookkeeping</a>
							<a href="pages/second quarter/cookery/cookery-second-quarter.html">Cookery</a>
							<a href="pages/second quarter/drafting/drafting-second-quarter.html">Drafting</a>
						</div>
					</div>
					<a href="pages/second quarter/ve/ve-second-quarter.html"><div class="header-icon ve">
						<i class="bi bi-person-arms-up"></i>
					</div></a>
				</div>
			</header>
		`;
		
		let dropdowns = this.shadowRoot.querySelectorAll(".dropdown-content");
		let dropdownButton = this.shadowRoot.querySelectorAll(".dropdown-button");

		dropdownButton[0].addEventListener("click", showMapehDropdown);
		dropdownButton[1].addEventListener("click", showSpecsDropdown);

		//i think this is a terrible way to implement this but i'm tired and out　of ideas
		function showMapehDropdown() {
			hideDropdowns();
			let dropdownContent = this.shadowRoot.querySelector("#header-mapeh-dropdown-content");
			console.log(dropdownContent);
			//this.shadowRoot.querySelector("#header-mapeh-dropdown-content").classList.toggle("show-dropdown");
		}

		function showSpecsDropdown() {
			hideDropdowns();
			let dropdownContent = this.shadowRoot.querySelector("#header-specs-dropdown-content");
			console.log(dropdownContent);
			//dropdownContent("#header-specs-dropdown-content").classList.toggle("show-dropdown");
		}

		window.onclick = function(event) {
			if (!event.target.matches(".dropdown-button") && !event.target.matches(".subject-specs")) {
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
	}
}

customElements.define("header-component", Header);