$(function () {
    $.validator.addMethod("valueNotEquals", function (value, element, arg) {
        return arg != jQuery(element).find('option:selected').val();
    }, "Value must not equal arg.");
    $("#rateForm").validate({
        errorElement: 'span',
        errorPlacement: function (error, element) {
            error.addClass('invalid-feedback');
            element.closest('div').append(error);
        },
        highlight: function (element, errorClass, validClass) {
            $(element).addClass('is-invalid');
        },
        unhighlight: function (element, errorClass, validClass) {
            $(element).removeClass('is-invalid');
        }
    });

    $("Ratings").rules("add", {
        required: true,
        messages: {
            required: "Name is Required"
        }
    });
    $("#RatingRemarks").rules("add", {
        required: true,
        messages: {
            required: "Name is Required"
        }
    });
});

    
