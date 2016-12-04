// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require_tree .
//= require filterrific/filterrific-jquery
//= require chardinjs
/*global google*/


function showPasswordUpdateDiv() {
    $("#change-email-div").hide();
    $("#change-pw-div").toggle();
    if($('#change-pw-div').is(':visible')) {
        document.getElementById('new-password-input').required = true;
    }
    else {
        document.getElementById('new-password-input').required = false;
    }

    if($('#change-pw-div').is(':visible')) {
        document.getElementById('new-password-confirmation-input').required = true;
    }
    else {
        document.getElementById('new-password-confirmation-input').required = false;
    }
}

function showEmailUpdateDiv() {
    $("#change-pw-div").hide();
    $("#change-email-div").toggle();
    if($('#change-email-div').is(':visible')) {
        document.getElementById('new-email-input').required = true;
    }
    else {
        document.getElementById('new-email-input').required = false;
    }
}

function checkPasswordMatch() {
    var password = $("#password").val();
    var confirmPassword = $("#password_confirmation").val();

    if (password != confirmPassword)
        $("#divCheckPasswordMatch").html("Passwords do not match!");
    else
        $("#divCheckPasswordMatch").html("");
}

function checkNewPasswordMatch() {
    var password = $("#new-password-input").val();
    var confirmPassword = $("#new-password-confirmation-input").val();

    if (password != confirmPassword)
        $("#divCheckPasswordMatch").html("Passwords do not match!");
    else
        $("#divCheckPasswordMatch").html("");
}

$('document').ready(function() {

    $(".home").click(function() {
        window.document.location = $(this).data("href");
    });

    $( "#pw-submit-button" ).button();
    $( "#email-submit-button" ).button();

    $("#change-pw-div").hide();
    $("#change-email-div").hide();

    $("#password_confirmation").keyup(checkPasswordMatch);

    $( "#accordion" ).accordion();

    $( "#button" ).button();
    $( "#button-icon" ).button({
        icon: "ui-icon-gear",
        showLabel: false
    });



    $( "#radioset" ).buttonset();



    $( "#controlgroup" ).controlgroup();



    $( "#tabs" ).tabs();



    $( "#dialog" ).dialog({
        autoOpen: false,
        width: 400,
        buttons: [
            {
                text: "Ok",
                click: function() {
                    $( this ).dialog( "close" );
                }
            },
            {
                text: "Cancel",
                click: function() {
                    $( this ).dialog( "close" );
                }
            }
        ]
    });

    // Link to open the dialog
    $( "#dialog-link" ).click(function( event ) {
        $( "#dialog" ).dialog( "open" );
        event.preventDefault();
    });



    $( "#datepicker" ).datepicker({
        inline: true
    });



    $( "#slider" ).slider({
        range: true,
        values: [ 17, 67 ]
    });



    $( "#progressbar" ).progressbar({
        value: 20
    });



    $( "#spinner" ).spinner();



    $( "#menu" ).menu();



    $( "#tooltip" ).tooltip();



    $( "#selectmenu" ).selectmenu();


    // Hover states on the static widgets
    $( "#dialog-link, #icons li" ).hover(
        function() {
            $( this ).addClass( "ui-state-hover" );
        },
        function() {
            $( this ).removeClass( "ui-state-hover" );
        }
    );

});

