const template = document.createElement("template");
template.innerHTML = `
<div class="header-content">
	<h1 id="header-title"><a href
</div>
`

class SiteHeader extends HTMLElement {
	constructor() {
		super();
		const shadow = this.attachShadow({mode: "open"})
		this.innerHTML = "I'm a custom!";
	}
}

customElements.define("site-header", SiteHeader);