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
			handler.getMap().setCenter({lat:54.525961, lng:15.255119});//Baltic Sea = center of Europe
			handler.getMap().setZoom(3);
		}
	});
}

var generate_map_iframe=function(){
	var width = 800;
	if ($('#width_iframe_map').val()){
		width = $('#width_iframe_map').val()
	}
	var height = 400;
	if ($('#height_iframe_map').val()){
		height = $('#height_iframe_map').val()
	}

	return "<iframe src='" + window.location.href + "/embed/embedmap' seamless style='border: none; width:"+width+"px; height:"+height+"px;'></iframe>"
}

var generate_tl1_iframe=function(){
	var width = 800;
	if ($('#width_iframe_tl1').val()){
		width = $('#width_iframe_tl1').val()
	}
	var height = 400;
	if ($('#height_iframe_tl1').val()){
		height = $('#height_iframe_tl1').val()
	}
	return '<iframe src="'+ window.location.href + '/embed/embedtimeline1" seamless style="border: none; width: '+ width +'px; height: '+height+'px;"></iframe>'
}

var generate_tl2_iframe=function(){
	var width = 800;
	if ($('#width_iframe_tl2').val()){
		width = $('#width_iframe_tl2').val()
	}
	var height = 400;
	if ($('#height_iframe_tl2').val()){
		height = $('#height_iframe_tl2').val()
	}
	return '<iframe src="'+ window.location.href + '/embed/embedtimeline2" seamless style="border: none; width: '+ width +'px; height: '+height+'px;"></iframe>'
}