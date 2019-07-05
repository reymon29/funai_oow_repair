import "bootstrap";
import "datatables.net-bs4";
import "print-js";
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../maps/init_mapbox';

initMapbox();

$(document).ready(function() {
    $('#orders').DataTable();
} );

$(document).ready(function() {
    $('#calls').DataTable( {
        "scrollCollapse": true,
        "paging":         false,
    } );
} );


$(function(){
  $(".form-control-file").on("change", function(){
    var preview = document.querySelector('#preview');
    var files   = document.querySelector('input[type=file]').files;

    function readAndPreview(file) {

      if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
        var reader = new FileReader();

        reader.addEventListener("load", function () {
          var image = new Image();
          image.height = 100;
          image.width = 100;
          image.title = file.name;
          image.src = this.result;
          preview.appendChild( image );
        }, false);

        reader.readAsDataURL(file);
      }

    }

    if (files) {
      [].forEach.call(files, readAndPreview);
    }
  })
})

$('#image_images').on('click', function(e){
   var $el = $('#image_images');
   var $el2 = $('#preview');
   $el.wrap('<form>').closest('form').get(0).reset();
   $el.unwrap();
   $el2.empty();

});
