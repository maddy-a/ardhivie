
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
// I am getting the onClick latitude longitude from teh map and passing it to marker. I have to somehow 
// find a way to pass this latitude and longitude to 



var marker = new google.maps.Marker({
	position: latlng, 
	map: map, 
	title: 'Click me', 
	});
	
	
/* This particular sends an Ajax request to the controller to add the latitude and longitude of the points where there is a double click */	
	google.maps.event.addListener(map, 'dblclick', function(event) {
		marker = new google.maps.Marker({position: event.latLng, map: map});
		var latitude=event.latLng.lat();
		var longitude=event.latLng.lng(); 
		var datastring = 'latitude=' + latitude + '&longitude=' + longitude;
		$.ajax({
			type: "POST",
			url: "/locations",
			data: datastring,
			success: function(){}
		});

	});
	
/*	var infowindow = new google.maps.InfoWindow({
	  content: 'Hello world'
	});infowindow.open(map, marker);
	google.maps.event.addListener(marker, 'click', function() {
	  infowindow.open(map, marker);
	});
*/

}