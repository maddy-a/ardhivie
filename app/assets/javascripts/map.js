
function initialize() 
{
	var map;
	var latlng = new google.maps.LatLng(37.09, -95.71);
	var options = {
	zoom: 5, 
	center: latlng, 
	mapTypeId: google.maps.MapTypeId.ROADMAP,
	disableDefaultUI: true,
	disableDoubleClickZoom: true,
	noClear: true,
	navigationControl: true,
	navigationControlOptions: {
		position: google.maps.ControlPosition.TOP_RIGHT
	}
	};
	
    map = new google.maps.Map(document.getElementById('map'), options);

	var marker = new google.maps.Marker({
	position: latlng, 
	map: map, 
	title: 'Click me', 
	});
	
	google.maps.event.addListener(map, 'dblclick', function(event) {

	    marker = new google.maps.Marker({position: event.latLng, map: map});

	});
	//Info Window
	
	// Creating an InfoWindow object
	var infowindow = new google.maps.InfoWindow({
	  content: 'Hello world'
	});infowindow.open(map, marker);
	google.maps.event.addListener(marker, 'click', function() {
	  infowindow.open(map, marker);
	});
}