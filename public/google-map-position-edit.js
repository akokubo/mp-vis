/*jslint devel:true, browser:true */
/*global google, $ */

function initMapPositionEdit() {
    "use strict";

    function getLatLngLiteralFromTextField() {
        var lat = parseFloat($("#place_latitude").val());
        var lng = parseFloat($("#place_longitude").val());
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
            map: map,
            draggable: true,
            title: "Drag me!"
        });

        // 情報ウィンドウの生成
        var content = "<p>マーカーを移動して位置を指定してください</p>";
        var infoWindow = new google.maps.InfoWindow({
            content: content
        });

        infoWindow.open(map, marker);
        // マーカーをクリックすると、情報ウィンドウを開くように設定
        //marker.addListener("click", function () {
        //    infowindow.open(map, marker);
        //});

        marker.addListener("dragend", function () {
            var latLng = marker.getPosition();
            $("#place_latitude").val(latLng.lat());
            $("#place_longitude").val(latLng.lng());
        });

        function setMarkerPositionFromTextField() {
            var latLngLiteral = getLatLngLiteralFromTextField();
            marker.setPosition(latLngLiteral);
            map.setCenter(latLngLiteral);
        }

        $("#place_latitude").on("change", function () {
            setMarkerPositionFromTextField();
        });

        $("#place_longitude").on("change", function () {
            setMarkerPositionFromTextField();
        });
    }

    // テキストフィールドから緯度経度を取得
    var latLngLiteral = getLatLngLiteralFromTextField();

    // マップの生成
    var map = new google.maps.Map($("#map-position")[0], {
        zoom: 11,
        center: latLngLiteral
    });

    var marker;
    addMarker(latLngLiteral);
}
