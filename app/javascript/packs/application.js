import "bootstrap";
import "datatables.net-bs4";

$(document).ready(function() {
    $('#orders').DataTable();
} );

$(document).ready(function() {
    $('#receive').DataTable( {
        "scrollY":        "200px",
        "scrollCollapse": true,
        "paging":         false,
    } );
} );
