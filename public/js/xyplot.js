function Point(name, url, x, y){
	this.name = name;
	this.url = url;
	this.x = x;
	this.y = y;
}

Point.prototype.draw = function(color) {
	$('.matrix').append('<div id="'+ this.name +'"></div>');
	var container = $('#' + this.name);
	container.html('<a href="' + this.url + '"><span class="point-title">' + this.name + '</span></a>');
	container.css({position: 'absolute', top: this.y, left: this.x});
	container.find('a').css('background-color',color);
}