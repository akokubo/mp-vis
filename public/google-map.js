/*jslint devel:true, browser:true */
/*global google, $ */

function initMap() {
    "use strict";

    // マップの生成
    var map = new google.maps.Map($("#map")[0], {
        zoom: 3,
        center: {
            lat: 40.4998235,
            lng: 141.5320309
        }
    });

    // マーカーを追加する関数の宣言
    function addMarker(place) {
        // マーカーの生成
        var marker = new google.maps.Marker({
            position: {
                lat: place.latitude,
                lng: place.longitude
            },
            map: map
        });

        // 情報ウィンドウの生成
        var content = "<h1>" + place.name + "</h1>";
        content += "<p>Mass: " + place.mass + "</p>";
        content += "<p>Collected At: " + place.collected_at + "</p>";

        if (typeof place.description !== "undefined" && place.description !== null) {
            content += "<p>" + place.description + "</p>";
        }
        if (place.photos.length > 0) {
            var index = Math.floor(Math.random(place.photos.length));
            content += "<p><img src=\"" + place.photos[index].url + "\" alt=\"" + place.name + "\" width=\"200\"></p>";
        }

        var infoWindow = new google.maps.InfoWindow({
            content: content
        });

        // マーカーをクリックすると、情報ウィンドウを開くように設定
        marker.addListener("click", function () {
            infoWindow.open(map, marker);
        });
    }

    $.getJSON("/places.json", function (places) {
        var i = 0;
        while (i < places.length) {
            addMarker(places[i]);
            i += 1;
        }
    });
}
