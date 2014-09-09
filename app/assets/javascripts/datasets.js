var showMap = function(hash){
	handler = Gmaps.build('Google');
	handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
		markers = handler.addMarkers(hash);
		handler.bounds.extendWith(markers);
		handler.fitMapToBounds();
		if (markers.length == 1){
			handler.getMap().setZoom(7);
		}
		if (markers.length == 0){
			handler.getMap().setCenter({lat:54.525961, lng:15.255119});
			handler.getMap().setZoom(3);
		}
	});
}