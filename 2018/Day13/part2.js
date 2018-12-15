var fs = require('fs');
 
var contents = fs.readFileSync('input.txt', 'utf8');

var carts = [];
var map = [];

contents.split('\n').forEach(function (line, y) {
	var mapRow = [];
	line.split('').forEach(function (letter, x) {
		if (letter == ">") {
			carts.push(createCart(x, y, ">"));
			mapRow.push("-");
		} else if (letter == "<") {
			carts.push(createCart(x, y, "<"));
			mapRow.push("-");
		} else if (letter == "^") {
			carts.push(createCart(x, y, "^"));
			mapRow.push("|");
		} else if (letter == "v") {
			carts.push(createCart(x, y, "v"));
			mapRow.push("|");
		} else {
			mapRow.push(letter);
		}
	});
	map.push(mapRow);
});

console.log(carts)

while (carts.length > 1) {
	carts.sort(compare).forEach(function (cart) {
		var cartType = cart.cart;
		var currentSpace = map[cart.y][cart.x];
				
		if (cartType == ">") {
			if (currentSpace == "-") {
				cart.x++;
			} else if (currentSpace == "\\") {
				cart.y++;
				cart.cart = "v";
			} else if (currentSpace == "/") {
				cart.y--;
				cart.cart = "^";
			} else if (currentSpace == "+") {
				if (cart.nextTurn == "l") {
					cart.y--;
					cart.cart = "^";
				} else if (cart.nextTurn == "r") {
					cart.y++;
					cart.cart = "v";
				} else if (cart.nextTurn = "s") {
					cart.x++;
				}
				cart.nextTurn = determineNextTurn(cart.nextTurn);
			}
		} else if (cartType == "<") {
			if (currentSpace == "-") {
				cart.x--;
			} else if (currentSpace == "/") {
				cart.y++;
				cart.cart = "v"
			} else if (currentSpace == "\\") {
				cart.y--;
				cart.cart = "^"
			} else if (currentSpace == "+") {
				if (cart.nextTurn == "l") {
					cart.y++;
					cart.cart = "v";
				} else if (cart.nextTurn == "r") {
					cart.y--;
					cart.cart = "^";
				} else if (cart.nextTurn = "s") {
					cart.x--;
				}
				cart.nextTurn = determineNextTurn(cart.nextTurn);
			}
		} else if (cartType == "^") {
			if (currentSpace == "|") {
				cart.y--;
			} else if (currentSpace == "/") {
				cart.x++;
				cart.cart = ">";
			} else if (currentSpace == "\\") {
				cart.x--;
				cart.cart = "<";
			} else if (currentSpace == "+") {
				if (cart.nextTurn == "l") {
					cart.x--;
					cart.cart = "<";
				} else if (cart.nextTurn == "r") {
					cart.x++;
					cart.cart = ">";
				} else if (cart.nextTurn = "s") {
					cart.y--;
				}
				cart.nextTurn = determineNextTurn(cart.nextTurn);
			}
		} else if (cartType == "v") {
			if (currentSpace == "|") {
				cart.y++;
			} else if (currentSpace == "\\") {
				cart.x++;
				cart.cart = ">";
			} else if (currentSpace == "/") {
				cart.x--;
				cart.cart = "<";
			} else if (currentSpace == "+") {
				if (cart.nextTurn == "l") {
					cart.x++;
					cart.cart = ">";
				} else if (cart.nextTurn == "r") {
					cart.x--;
					cart.cart = "<";
				} else if (cart.nextTurn = "s") {
					cart.y++;
				}
				cart.nextTurn = determineNextTurn(cart.nextTurn);
			}
		}
		
		console.log(carts)
		
		colisionX = -1;
		colisionY = -1;
		carts.forEach(function (cart1, i1) {
			carts.forEach(function (cart2, i2) {
				if ((cart1.x == cart2.x && cart1.y == cart2.y) && i1 != i2) {
					colisionX = cart1.x
					colisionY = cart1.y
				}
			});
		});
		carts = carts.filter(function (cart, i) {
			return !(cart.x == colisionX && cart.y == colisionY)
		})
		
	});
	
}

console.log(carts[0].x + "," + carts[0].y);

function createCart(x, y, cart) {
	return {
		"x": x,
		"y": y,
		"cart": cart,
		"nextTurn": "l"
	};
}

function determineNextTurn(lastTurn) {
	if (lastTurn == "l") {
		return "s";
	} else if (lastTurn == "s") {
		return "r";
	} else if (lastTurn == "r") {
		return "l";
	}
}

function compare(a,b) {
	if (a.y < b.y) {
		return -1;
	}
	if (a.y > b.y) {
		return 1;
	} 
	if (a.x < b.x) {
		return -1;
	} 
	if (a.x > b.x) {
		return 1;
	}
	return 0;
}