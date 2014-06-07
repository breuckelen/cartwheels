//Globals
var controller;
var lat, lng;

/*
 * Call init funcitons once the page loads.
 */
function init() {
    controller = $('#uploads-new')
    navigator.geolocation.getCurrentPosition(showSubmit);
}

function showSubmit(position) {
    getPositionSuccess(position);
    controller.find('input[type=submit]').show();
}

/*
 * Get the current position of the user.
 */
function getPosition() {
    navigator.geolocation.getCurrentPosition(getPositionSuccess);
}

/*
 * Set hiden input fields to the position of the user.
 */
function getPositionSuccess(position) {
    var inputLat = controller.find('#upload_cart_attributes_lat'),
        inputLon = controller.find('#upload_cart_attributes_lon');

    lat = position.coords.latitude;
    lng = position.coords.longitude;

    inputLat.val(lat);
    inputLon.val(lng);
}

/*
 * On page load.
 */
$(function() {
    //Init
    init();

    //Variables
    var watchId = navigator.geolocation.watchPosition(getPosition);
});
