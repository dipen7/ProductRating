$(function () {
    //$("#account").validate();
    $("#Email").rules("add", {
        required: true,
        messages: {
            required: "Email is Required"
        }
    });
    $("#Password").rules("add", {
        required: true,
        messages: {
            required: "Password is Required"
        }
    });
    
});