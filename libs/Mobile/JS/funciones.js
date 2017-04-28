function irARegistro(){
	if(window.matchMedia("screen and (orientation:landscape)")){
		document.getElementById('login').classList.toggle('hideLoginLand');
		document.getElementById('registro').classList.toggle('showRegistroLand');
	}
	else if(window.matchMedia("screen and (orientation:portrait)")){
		document.getElementById('login').classList.toggle('hideLogin');
		document.getElementById('registro').classList.toggle('showRegistro');
	}
}

function irALogin(){
	if(window.matchMedia("screen and (orientation:landscape)")){
		document.getElementById('login').classList.toggle('hideLoginLand');
		document.getElementById('registro').classList.toggle('showRegistroLand');
	}
	else if(window.matchMedia("screen and (orientation:portrait)")){
		document.getElementById('login').classList.toggle('hideLogin');
		document.getElementById('registro').classList.toggle('showRegistro');
	}
}