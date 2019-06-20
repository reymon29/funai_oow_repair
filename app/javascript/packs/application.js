import "bootstrap";
import "datatables.net-bs4";

$(document).ready(function() {
    $('#orders').DataTable();
} );

$(document).ready(function() {
    $('#calls').DataTable( {
        "scrollCollapse": true,
        "paging":         false,
    } );
} );


