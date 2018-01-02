/*jslint devel:true, browser:true */
/*global google, $ */

function initMapPositionShow() {
    "use strict";

    function getLatLngLiteralFromTextField() {
        var lat = parseFloat($("#place_latitude").text());
        var lng = parseFloat($("#place_longitude").text());
        return {lat: lat, lng: lng};
    }

    // マーカーを追加する関数の宣言
    function addMarker(place) {
        // マーカーの生成
        marker = new google.maps.Marker({
            position: {
                lat: place.lat,
                lng: place.lng
            },
            map: map
        });

    }

    // テキストフィールドから緯度経度を取得
    var latLngLiteral = getLatLngLiteralFromTextField();

    // マップの生成
    var map = new google.maps.Map($("#map-position-show")[0], {
        zoom: 11,
        center: latLngLiteral
    });

    var marker;
    addMarker(latLngLiteral);
}
