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
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require bootstrap-datepicker

$(document).ready(function() {
  $('a[disabled=disabled]').click(function(event){
    event.preventDefault(); // Prevent link from following its href
  });

  $.fn.datepicker.defaults.format = "mm/dd/yyyy";
  $('.datepicker').datepicker()

  $('#date').datepicker({
     orientation: "bottom auto",
    autoclose: true
  })

  $('[data-toggle=tooltip]').tooltip();

  if ( $('[type="date"]').prop('type') != 'date' ) {
    $('[type="date"]').datepicker();
  }


});
