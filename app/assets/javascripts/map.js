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


// **************************  Markers init on Log in ****************//
/*
Pass a GET request to the index function in Locations model to get the locations marked by the user. 

$.ajax({
	type: "GET",
    dataType: "json",
	 url: "/ufiles",
	success: function(data1){
	/	var str= "<table id='tableList' border='0' cellpadding='0' cellspacing='0' class='dataTable'>";
		for( var i=0; i<data.length; i++ ){
			var file=data[i].name;
			alert(file);
		//	str= str + "<tr><td>" + file +  "</td></tr>";
		}
	//	str = str + "</table>";
	}
	)
	
	
	*/
	var str="";
	
	$.ajax({
		    type: "GET",
		    dataType: "json",
		    url: "/ufiles",
			success: function(data){
				str = "<table>"
				for( var i=0; i<data.length; i++ ){
					var file=data[i].name;
					str= str + "<tr><td>" + file + "<td></tr>";
				}
				str = str + "</table>"	
			}
		});
	
alert(str);

var contentString = "<form method='post' action='/ufiles'><table>" +
             "<tr><td>Name:</td> <td><input id='ufile_name' name='ufile[name]' size='30' type='text'/></td> </tr>" +
            "<tr><td align=right ><input type='submit' value='New' /></td>" +
             "</tr></table></form>";

var infowindow = new google.maps.InfoWindow({
        content: contentString
    });
$.ajax({
	    type: "GET",
	    dataType: "json",
	    url: "/locations",
	    success: function(data){
			for( var i=0; i<data.length; i++ ){
				// Pass the latitude and longitude from data to maps.
				var marker_latlng= new google.maps.LatLng(data[i].latitude,data[i].longitude);
				var loc_id=data[i].id;
				var marker = new google.maps.Marker({
					position: marker_latlng, 
					map: map,
					title: 'Click me'
					});
						
						google.maps.event.addListener(marker, 'click', function() {
						      infowindow.open(map,this);
						    });

				}
			}
	});	

/* This particular sends an Ajax request to the controller to add the latitude and longitude of the points where there is a double click */	

google.maps.event.addListener(map, 'dblclick', function(event) {
		var marker = new google.maps.Marker({position: event.latLng, draggable: true, map: map});
			google.maps.event.addListener(marker, 'click', function() {
			      infowindow.open(map,marker);
			    });
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

}
