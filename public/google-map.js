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
            /*
            icon: {
                path: google.maps.SymbolPath.CIRCLE,
                fillColor: 'red',
                fillOpacity: 0.5,
                strokeColor: 'white',
                strokeWeight: 1,
                strokeOpacity: 0.8,
                scale: Math.sqrt(place.mass) * 10
            },
            */
            map: map
        });

        // 情報ウィンドウの生成
        var content = "<h1>" + place.name + "</h1>";
        content += "<p>Mass: " + place.mass + "</p>";
        content += "<p>Collected At: " + place.collected_at + "</p>";

        if (typeof place.description !== "undefined" && place.description !== null) {
            content += "<p>" + place.description + "</p>";
        }

        /*
        if (place.photos.length > 0) {
            var index = Math.floor(Math.random() * place.photos.length);
            content += "<p><img src=\"" + place.photos[index].url + "\" alt=\"" + place.name + "\" width=\"200\"></p>";
        }
        */

        if (place.photos.length > 0) {
            content += "<div id=\"carousel-infowindow\" class=\"carousel slide\" data-ride=\"carousel\">";
            content += "<!-- Indicators -->";
            content += "<ol class=\"carousel-indicators\">";
            var i = 0;
            while (i < place.photos.length) {
                if (i === 0) {
                    content += "<li data-target=\"#carousel-infowindow\" data-slide-to=\"" + i + "\" class=\"active\"></li>";
                } else {
                    content += "<li data-target=\"#carousel-infowindow\" data-slide-to=\"" + i + "\"></li>";
                }
                i += 1;
            }
            content += "</ol>";
            content += "<!-- Wrapper for slides -->";
            content += "<div class=\"carousel-inner\" role=\"listbox\">";

            i = 0;
            while (i < place.photos.length) {
                if (i === 0 ) {
                    content += "<div class=\"item active\" style=\"width: 400px; height: 400px;\">";
                } else {
                    content += "<div class=\"item\" style=\"width: 400px; height: 400px;\">";                
                }
                content += "<img src=\"" +  place.photos[i].url + "\" alt=\"...\">";
                content += "<div class=\"carousel-caption\">";
                content += "...";
                content += "</div>";
                content += "</div>";
                i += 1;
            }
            content += "</div>";
            content += "<!-- Controls -->";
            content += "<a class=\"left carousel-control\" href=\"#carousel-infowindow\" role=\"button\" data-slide=\"prev\">";
            content += "<span class=\"glyphicon glyphicon-chevron-left\" aria-hidden=\"true\"></span>";
            content += "<span class=\"sr-only\">Previous</span>";
            content += "</a>";
            content += "<a class=\"right carousel-control\" href=\"#carousel-infowindow\" role=\"button\" data-slide=\"next\">";
            content += "<span class=\"glyphicon glyphicon-chevron-right\" aria-hidden=\"true\"></span>";
            content += "<span class=\"sr-only\">Next</span>";
            content += "</a>";
            content += "</div>";
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
