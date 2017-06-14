/**
* File    : profile.js
* Purpose : Contains all jquery codes for profile validation fields
* Created : 10-may-2017
* Author  : Satyapriya Baral
*/
$(document).ready(function(){
    /**
    * Function to validate profile data
    *
    * @param null.
    * @return error messages if found.
    */
    $("#analyst").on('change', function(e) {
        e.preventDefault();
        $("#btnsbt").trigger('click');
    });
});