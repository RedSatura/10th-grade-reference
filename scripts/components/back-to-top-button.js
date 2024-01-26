const template = document.createElement("template");
template.innerHTML = `
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
	<style>
		.back-to-top-button {
			width: 50px;
			height: 50px;
			background-color: #DC82D2;
			border: 5px solid #B46EAA;
			display: flex;
			justify-content: center;
			align-items: center;
			color: white;
			border-radius: 50%;
			position: fixed;
			bottom: 5%;
			right: 5%;
		}

		.back-to-top-button i {
			font-weight: bold;
			font-size: 2rem;
			-webkit-text-stroke: 2px;
		}
	</style>
	<a href="#top"><div class="back-to-top-button">
		<i class="bi bi-chevron-up"></i>
	</div></a>
`

class BackToTopComponent extends HTMLElement {
	constructor() {
		super();
	}
	
	connectedCallback() {
		const shadowRoot = this.attachShadow({mode: "closed"});
		
		shadowRoot.appendChild(template.content);
	}
}

customElements.define("back-to-top-component", BackToTopComponent);