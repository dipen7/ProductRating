//var fromdaterange="12", todaterange="13";
$(function () {
    debugger;
    if (userrights.view) {
        debugger;
        loadSelect('#StoreSelection', 4, 'store', '', currentStoreId);
        $('#StoreSelection').on('change', function (e) {
            setStore(this.value);
        });
        $("#StoreSelectionDiv").toggle();
    }
    debugger;
});
