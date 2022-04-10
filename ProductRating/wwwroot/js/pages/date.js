//var fromdaterange="12", todaterange="13";
$(document).ready(function () {
    $(".DateFilter").toggle();
    $(".breadcrumbColshow").toggle();
    document.getElementById("FromDateRange").nepaliDatePicker();
    document.getElementById("ToDateRange").nepaliDatePicker();
    $(document).on("click", '#applyDateFilter', function (event) {
        $('#example2').DataTable().draw();
    })
    $(document).on('keypress', '#FromDateRange,#ToDateRange', function (event) {
        if (event.keyCode == 13) {
            //var BSFromsplit = $('#FromDateRange').val().split('-');
            //var BSTosplit = $('#ToDateRange').val().split('-');
            //var ADFromDate = NepaliFunctions.BS2AD({ year: BSFromsplit[0], month: BSFromsplit[1], day: BSFromsplit[2] })
            //var ADToDate = NepaliFunctions.BS2AD({ year: BSTosplit[0], month: BSTosplit[1], day: BSTosplit[2] })
            //fromdaterange = new Date('' + ADFromDate.year + '/' + ADFromDate.month + '/' + ADFromDate.day);
            //todaterange = new Date('' + ADToDate.year + '/' + ADToDate.month + '/' + ADToDate.day);
            //todaterange = max;//document.getElementById("ToDateRange").value;
            //fromdaterange = min;//document.getElementById("FromDateRange").value;
            $('#example2').DataTable().draw();
        }
    });
    //document.getElementById("FromDateRange").addEventListener("focusout", function () {
    //    fromdaterange = document.getElementById("FromDateRange").value;
    //    console.log(fromdaterange);
    //    $('#example2').DataTable().draw();
    //});
    //document.getElementById("ToDateRange").addEventListener("focusout", function () {
    //    debugger;
    //    todaterange = document.getElementById("ToDateRange").value;
    //    console.log(todaterange);
    //    $('#example2').DataTable().draw();
    //});

});
