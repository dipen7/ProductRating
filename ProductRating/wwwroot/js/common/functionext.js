        var regCodeIds=[];
function buildSelect(options, default1) {
    var option;
    for (var i = 0; i < options.length; i++) {
        option = option + '<option value="' + options[i].value + '" ';
        if (options[i].value == default1) {
            option = option + ' selected="selected" ';
        }
        option = option + '>' + options[i].text + '</option>';
    }
    return option;
}
function buildMultiSelect(options, default1) {
    var option;
    for (var i = 0; i < options.length; i++) {
        option = option + '<option value="' + options[i].value + '" ';
        if (default1.includes(options[i].value)) {
            option = option + ' selected="selected" ';
        }
        option = option + '>' + options[i].text + '</option>';
    }
    return option;
}
function showStatusSimple(status, message) {
    var classname = '';
    if (status == 'server error') { classname = 'alert-danger'; }
    else if (status == 'error') { classname = 'alert-warning'; }
    else if (status == 'success') { classname = 'alert-success'; }
    var ihtmltext = '<div class="alert ' + classname + ' alert-dismissible">'
        + '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'
        + message
        + '</div>';
    $('#alert-messsages').html(ihtmltext);
    $("#alert-messsages").fadeTo(2000, 500).slideUp(500, function () {
        $("#alert-messsages").slideUp(500);
    });
}//#alert-messsages component
function showStatus(status, message) {
    var classname = '';
    if (status == 'server error') { classname = 'alert-danger'; }
    else if (status == 'error') { classname = 'alert-warning'; }
    else if (status == 'success') { classname = 'alert-success'; }
    var ihtmltext = '<div class="alert ' + classname + ' alert-dismissible">'
        + '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'
        + message
        + '</div>';
    $('#alert-messsages').html(ihtmltext);
    $("#alert-messsages").fadeTo(2000, 500).slideUp(500, function () {
        $("#alert-messsages").slideUp(500);
    });
}//#alert-messsages component
function showModalStatus(status, message) {
    var classname = '';
    if (status == 'server error') { classname = 'alert-danger'; }
    else if (status == 'error') { classname = 'alert-warning'; }
    else if (status == 'success') { classname = 'alert-success'; }
    var ihtmltext = '<div class="alert ' + classname + ' alert-dismissible">'
        + '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'
        + message
        + '</div>';
    $('#modalAlert-messsages').html(ihtmltext);
    $("#modalAlert-messsages").fadeTo(2000, 500).slideUp(500, function () {
        $("#modalAlert-messsages").slideUp(500);
    });
}//#alert-messsages component
function loadCascadingSelect(selectId, SelectNo, ControllerName, SearchText = null) {
    var urls = '/' + ControllerName + '/getDropDown?Id=' + SelectNo + '&SearchText=' + SearchText;
    $.ajax({
        url: urls,
        type: 'GET',
        dataType: 'json',
        async:false,
    }).done(function (data) {
        $(selectId).find('option').remove().end()
            .append(buildSelect(data.data));
    }).fail(function () {
        alert("error loading select" + SelectNo);
    });
}
function loadCascadingSelect2(select2Id, SelectNo, ControllerName, SearchText = null) {
    var urls = '/' + ControllerName + '/getDropDown?Id=' + SelectNo + '&SearchText=' + SearchText;
    $.ajax({
        url: urls,
        type: 'GET',
        dataType: 'json',
        async: false,
    }).done(function (data) {
        $(select2Id).select2('destroy').find('option').remove().end()
            .append(buildSelect(data.data)).select2();
    }).fail(function () {
        alert("error loading select" + SelectNo);
    });
}
function loadSelect(selectId, SelectNo, ControllerName, SearchText = '',default1=null) {
    var urls = '/' + ControllerName + '/getDropDown?Id=' + SelectNo + '&SearchText=' + SearchText;
    $.ajax({
        url: urls,
        type: 'GET',
        dataType: 'json',
    }).done(function (data) {
        $(selectId).find('option').remove().end()
            .append(buildSelect(data.data, default1));
    }).fail(function () {
        alert("error loading select" + SelectNo);
    });
}
function loadSelect2(selectId, SelectNo, ControllerName, SearchText = null) {
    var urls = '/' + ControllerName + '/getDropDown?Id=' + SelectNo + '&SearchText=' + SearchText;
    $(selectId).select2({
        ajax: {
            delay: 1000, // wait 1000 milliseconds before triggering the request,
            url: '/' + ControllerName + '/getDropDown?Id=' + SelectNo,
            data: function (params) {
                var query = {
                    search: params.term
                }
                return query;
            },
            processResults: function (data) {
                //console.log(data);
                return {
                    results: data.data.map(function (option) {
                        return { id: option.value, text: option.text }
                    })
                };
            }
        },
        minimumInputLength: 1
    });
}
function loadTotAmount(rateId, quantityId, totAmountId) {
    QtyEl = document.getElementById(quantityId);
    RateEl = document.getElementById(rateId);
    TotAmEl = document.getElementById(totAmountId);
    QtyEl.addEventListener("change", (e) => {
        QtyEl.value = Math.abs(QtyEl.value);
        TotAmEl.value = MultiplyEl(QtyEl, RateEl);
    });
    RateEl.addEventListener("change", (e) => {
        RateEl.value = Math.abs(RateEl.value);
        TotAmEl.value = MultiplyEl(QtyEl, RateEl);
    });
}
function MultiplyEl(QtyEl, RateEl) {
    return QtyEl.value * RateEl.value;
}
function setSelect(selectid, default1) {
    $(selectid).val(default1);
    $(selectid).trigger('change');
}//applies for select2 jquery commponent as well
function resetForm(formId) {
    resetFormu(formId);
    $(formId+" input[name=flag]").val('i');
}//formId=#addEditForm reset form for create module
function resetFormu(formId) {
    $(formId).find(':input').each(function () {
        switch (this.type) {
            case 'password':
            case 'select-multiple':
            case 'select-one':
            case 'text':
            case 'hidden':
            case 'textarea':
            case 'number':
            case 'date':
            case 'datetime':
            case 'datetime-local':
                $(this).val('');
                break;
            case 'checkbox':
            case 'radio':
                this.checked = false;
        }
    });
}//formId=#addEditForm reset form
function setEngNepDatePickerHtml(dateSpanArr, dateSpanLabel, datePicArr) {
    dateSpanArr.forEach(function (item, index) {
        //debugger;
        var contentstr = '<div class="form-group row">'
            + '<div class="col-sm-2">'
            + '    <label>' + dateSpanLabel[index] + 'Date:</label>'
            + '  </div>'
            + '  <div class="col-sm-5">'
            + '    <div class="input-group">'
            + '    <input type="text" id="' + datePicArr[index] + 'BS" class="form-control" name="' + datePicArr[index] + 'BS" data-inputmask=\'"mask": "9999-99-99"\'/>'
            + '      <div class="input-group-append">'
            + '          <div class="input-group-text">B.S.</div>'
            + '      </div>'
            + '    </div>'
            + '  </div>'
            + '  <div class="col-sm-5"> '
            + '  <div class="input-group date">'
            + '    <input type="text" class="form-control datetimepicker-input" id="' + datePicArr[index] + '" data-target="#' + datePicArr[index] + '" data-toggle="datetimepicker" name="' + datePicArr[index] + '" data-inputmask=\'"mask": "99/99/9999"\'/>'
            + '    <div class="input-group-append">'
            + '        <div class="input-group-text">A.D.</div>'
            + '    </div>'
            + '  </div>'
            + '</div>'
            + '</div>'
        $('#' + item).html(contentstr);
        //debugger;
    });
    datePicArr.forEach(function (item, index) {
        //debugger;
        $('#' + item).datetimepicker({
            format: 'L'
        });
        $('#' + item + 'BS').inputmask({ 'placeholder': 'yyyy-mm-dd' });
        //var RegistrationDateBS = document.getElementById(item +"BS");
        $("#" + item).on("change.datetimepicker", ({ date }) => {
            var ADsplit = $('#' + item).val().split('/');
            var BsDate = NepaliFunctions.AD2BS({ year: ADsplit[2], month: ADsplit[0], day: ADsplit[1] })
            var bsMonthStr = '' + BsDate.month;
            var bsDayStr = '' + BsDate.day;
            if (BsDate.month < 10) { bsMonthStr = '0' + bsMonthStr; }
            if (BsDate.day < 10) { bsDayStr = '0' + bsDayStr; }
            document.getElementById(item + "BS").value = '' + BsDate.year + '-' + bsMonthStr + '-' + bsDayStr;
        });
    });
}//tempusdominus english datepicker and nepali.datepicker nep date picker
function setNtriggerEngDatepicker(datepickerId,datestring) {
    $(datepickerId).datetimepicker('date', new Date(datestring));
    $(datepickerId).trigger('change.datetimepicker');
}//#datepickerId,datestring:"2022-01-12T00:00:00"
function setNepDatePickerChangeEvent(datePicArr) {
    datePicArr.forEach(function (item, index) {
        //debugger;
        var RegistrationDateBS = document.getElementById(item + "BS");
        RegistrationDateBS.nepaliDatePicker({
            onChange: function () {
                var RegistrationDateBS = document.getElementById(item + "BS");
                var BSsplit = RegistrationDateBS.value.split('-');
                var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] })
                $('#' + item).datetimepicker('date', new Date('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day));
                //document.getElementById("PurchaseDate").value=PurchaseDateBS.value;
            }
        });
        //debugger;
        //focusout
        document.getElementById(item + "BS").addEventListener("focusout", function () {
            var RegistrationDateBS = document.getElementById(item + "BS");
            var BSsplit = RegistrationDateBS.value.split('-');
            var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] });
            $('#' + item).datetimepicker('date', new Date('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day));
        });
    });
}//call in window.onload =function(){};
function setFormNepDatePickerChangeEvent(datePicArr, formId) {
    debugger;
    var formElement = document.getElementById(formId);
    datePicArr.forEach(function (item, index) {
        //debugger;
        var RegistrationDateBS = formElement.elements[item + "BS"];
        //var RegistrationDateBS = document.getElementById(item + "BS");
        RegistrationDateBS.nepaliDatePicker({
            onChange: function () {
                var RegistrationDateBS = formElement.elements[item + "BS"];
                var BSsplit = RegistrationDateBS.value.split('-');
                var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] })
                $('#' + formId + ' input[name=' + item +']').datetimepicker('date', new Date('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day));
                //document.getElementById("PurchaseDate").value=PurchaseDateBS.value;
            }
        });
        //debugger;
        //focusout
        formElement.elements[item + "BS"].addEventListener("focusout", function () {
            var RegistrationDateBS = formElement.elements[item + "BS"];
            var BSsplit = RegistrationDateBS.value.split('-');
            var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] });
            $('#' + formId + ' input[name=' + item + ']').datetimepicker('date', new Date('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day));
        });
    });
}//call in window.onload =function(){};
function setFormNepDatePickerOnlyChangeEvent(nepDatePicArr, formId) {
    var formElement = document.getElementById(formId);
    nepDatePicArr.forEach(function (item, index) {
        var RegistrationDateBS = formElement.elements[item + "BS"];
        //var RegistrationDateBS = document.getElementById(item + "BS");
        RegistrationDateBS.nepaliDatePicker({
            onChange: function () {
                debugger;
                var RegistrationDateBS = formElement.elements[item + "BS"];
                var BSsplit = RegistrationDateBS.value.split('-');
                var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] })
                debugger;
                console.log($('#' + formId + ' input[name=' + item + ']'));
                console.log('#' + formId + ' input[name=' + item + ']');
                console.log(new Date('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day));
                console.log('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day);
                $('#' + formId + ' input[name=' + item + ']').val('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day);
                //document.getElementById("PurchaseDate").value=PurchaseDateBS.value;
            }
        });
        //focusout
        formElement.elements[item + "BS"].addEventListener("focusout", function () {
            var RegistrationDateBS = formElement.elements[item + "BS"];
            var BSsplit = RegistrationDateBS.value.split('-');
            var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] });
            $('#' + formId + ' input[name=' + item + ']').val( '' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day);
        });
        $('#' + formId + ' input[name=' + item + 'BS]').inputmask({ 'placeholder': 'yyyy-mm-dd' });
    });
}//call in window.onload =function(){};
function setNTriggerFormNepDatePickerOnlyValue(bsDateIdwithoutBS, setValueBS, formId) {
    debugger;
    var formElement = document.getElementById(formId);
    formElement.elements[bsDateIdwithoutBS + 'BS'].value = setValueBS;
    if (setValueBS == '') {
        $('#' + formId + ' input[name=' + bsDateIdwithoutBS + ']').val('');
    }
    else {
        var BSsplit = setValueBS.split('-');
        var AdDate = NepaliFunctions.BS2AD({ year: BSsplit[0], month: BSsplit[1], day: BSsplit[2] });
        $('#' + formId + ' input[name=' + bsDateIdwithoutBS + ']').val('' + AdDate.year + '/' + AdDate.month + '/' + AdDate.day);
    }
    //if ("createEvent" in document) {
    //    var evt = document.createEvent("HTMLEvents");
    //    evt.initEvent("change", false, true);
    //    formElement.elements[bsDateIdwithoutBS + 'BS'].dispatchEvent(evt);
    //}
    //else {
    //    formElement.elements[bsDateIdwithoutBS + 'BS'].fireEvent("onchange");
    //}
    //$(formElement.elements[bsDateIdwithoutBS + 'BS']).trigger('change');
    $(formElement.elements[bsDateIdwithoutBS + 'BS']).trigger('onchange');
    //formElement.elements[bsDateIdwithoutBS + 'BS'].dispatchEvent(new Event('change'));
}
function setFormEngNepDatePickerHtml(dateSpanArr, dateSpanLabel, datePicArr, formId) {
    var formElement = document.getElementById(formId);
    dateSpanArr.forEach(function (item, index) {
        //debugger;
        var contentstr = '<div class="form-group row">'
            + '<div class="col-sm-2">'
            + '    <label>' + dateSpanLabel[index] + 'Date:</label>'
            + '  </div>'
            + '  <div class="col-sm-5">'
            + '    <div class="input-group">'
            + '    <input type="text" id="' + datePicArr[index] + 'BS" class="form-control" name="' + datePicArr[index] + 'BS" data-inputmask=\'"mask": "9999-99-99"\'/>'
            + '      <div class="input-group-append">'
            + '          <div class="input-group-text">B.S.</div>'
            + '      </div>'
            + '    </div>'
            + '  </div>'
            + '  <div class="col-sm-5"> '
            + '  <div class="input-group date">'
            + '    <input type="text" class="form-control datetimepicker-input" id="' + datePicArr[index] + '" data-target="#' + datePicArr[index] + '" data-toggle="datetimepicker" name="' + datePicArr[index] + '" data-inputmask=\'"mask": "99/99/9999"\'/>'
            + '    <div class="input-group-append">'
            + '        <div class="input-group-text">A.D.</div>'
            + '    </div>'
            + '  </div>'
            + '</div>'
            + '</div>'
        //debugger;
        //console.log($('#' + formId + ' span#' + item).html());
        $('#' + formId +' span#' + item).html(contentstr);
        //console.log($('#' + formId + ' span#' + item).html());
        //debugger;
    });
    datePicArr.forEach(function (item, index) {
        $('#' + formId + ' input[name=' + item + ']').datetimepicker({
            format: 'L'
        });
        $('#' + formId + ' input[name=' + item + 'BS]').inputmask({ 'placeholder': 'yyyy-mm-dd' });
        //var RegistrationDateBS = document.getElementById(item +"BS");
        $("#" + formId + ' input[name=' + item + ']').on("change.datetimepicker", ({ date }) => {
            var ADsplit = $('#' + formId + ' input[name=' + item + ']').val().split('/');
            var BsDate = NepaliFunctions.AD2BS({ year: ADsplit[2], month: ADsplit[0], day: ADsplit[1] })
            var bsMonthStr = '' + BsDate.month;
            var bsDayStr = '' + BsDate.day;
            if (BsDate.month < 10) { bsMonthStr = '0' + bsMonthStr; }
            if (BsDate.day < 10) { bsDayStr = '0' + bsDayStr; }
            formElement.elements[item + "BS"].value = '' + BsDate.year + '-' + bsMonthStr + '-' + bsDayStr;
        });
    });
}//tempusdominus english datepicker and nepali.datepicker nep date picker
function loadSelectFromArray(selectIds, selectNos, Controllers) {
    debugger;
    selectIds.forEach(function (item, index) {
        loadSelect(item, selectNos[index], Controllers[index]);
    });
}
function currentBsDateString() {
    var today = new Date();
    //var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    //var BsDate = NepaliFunctions.AD2BS({ year: ADsplit[2], month: ADsplit[0], day: ADsplit[1] })
    var BsDate = NepaliFunctions.AD2BS({ year: today.getFullYear(), month: today.getMonth() + 1, day: today.getDate() })
    var bsMonthStr = '' + BsDate.month;
    var bsDayStr = '' + BsDate.day;
    if (BsDate.month < 10) { bsMonthStr = '0' + bsMonthStr; }
    if (BsDate.day < 10) { bsDayStr = '0' + bsDayStr; }
    return '' + BsDate.year + '-' + bsMonthStr + '-' + bsDayStr;
}
function currentAdDateString() {
    var today = new Date();
    var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    return date;
}
function triggerReadonlyToInput(inputId) {
    let input = document.getElementById(inputId);
    if(input.readOnly)
        input.removeAttribute('readonly');
    else
        input.setAttribute('readonly', true);
}
function setReadonlyToInput(inputId, truefalse) {
    console.log(truefalse);
    let input = document.getElementById(inputId);
    if (!truefalse)
        input.removeAttribute('readonly');
    else
        input.setAttribute('readonly', true);
}
function getImgFromApi(relativeImgUrl,imgId) {
    //const imageUrl = "/image/Get";
    const imageUrl = relativeImgUrl;

    const reader = new FileReader();
    reader.onloadend = () => {
        const base64data = reader.result;
        $('#' + imgId).attr('src', base64data);
        //console.log(base64data);
    }
    (async () => {
        const response = await fetch(imageUrl)
        const imageBlob = await response.blob()
        reader.readAsDataURL(imageBlob);
    })()
}
function postImgToApi(relativeImgUrl, imgId) {
    //const imageUrl = "/image/Get";
    const imageUrl = relativeImgUrl;

    const reader = new FileReader();
    reader.onloadend = () => {
        const base64data = reader.result;
        $('#' + imgId).attr('src', base64data);
        //console.log(base64data);
    }
    (async () => {
        const response = await fetch(imageUrl)
        const imageBlob = await response.blob()
        reader.readAsDataURL(imageBlob);
    })()
}
function changeMainStore(mainStoreValue) {
    debugger;
    if (!(mainStoreValue < 0)) {
        mainStore = mainStoreValue;
    }
    if (mainStoreValue > 0) {
        $('#IsMainDiv').addClass('d-none');
        $("#IsMain").prop("disabled", true);
    } else {
        $('#IsMainDiv').removeClass('d-none');
        $("#IsMain").prop("disabled", false);
    }
}
function setStore(curStoreId) {
    debugger;
    if (curStoreId != 0) {
        $.ajax({ url: '/store/setCurStore', type: "POST", datatype: "json", data: { curStoreId: curStoreId } })
            .done(function (data) {
                if (data.data.errorCode == 0) {
                    debugger;
                    showStatus('success', data.data.mes);
                }
                else {
                    showStatus('error', data.data.mes)
                }
            }).fail(function () {
                showStatus('server error', data.data.spName + ' error:' + data.data.mes);
            }).always(function () {
                $('#example2').DataTable().ajax.reload();
            });
    }
}
function setAutoComplete(textFieldId, SelectNo, ControllerName, SearchText = '') {
    $(textFieldId).autocomplete({
        delay: 500,
        source: function (request, responce) {
            $.ajax({
                url: "/" + ControllerName+"/getAutoComplete?id=" + SelectNo + "&searchtext=" + encodeURIComponent(request.term),
                type: "get",
                contentType: "application/json;charset=utf-8",
                //data: JSON.stringify({ type: type, query: request.term }),
                //data: JSON.stringify({ id: 1, searchtext: request.term }),
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    var suggestions = [];
                    $.each(data, function (i, val) {
                    console.log(val);
                        suggestions.push({
                            label: val.text,
                            value: ''+val.value,
                            id:''+ val.Value
                        });
                    });
                    console.log(suggestions);
                    responce(suggestions);
                },
                error: function (err) {
                    alert(err);
                }
            });
        },
        select: function (e, ui) {
            var thisInput = e.target;
            $(thisInput).val(ui.item.label);
            //GetItemInfo(ui.item.id);
        }
    });
}
function loadSelect2Auto(selectId, SelectNo, ControllerName, SearchText = null, regCodeIdFiler=false) {
    var urls = '/' + ControllerName + '/getAutoComplete?Id=' + SelectNo;// + '&SearchText=' + SearchText;
    debugger;
    $(selectId).select2({
        ajax: {
            delay: 1000, // wait 1000 milliseconds before triggering the request,
            url: urls,//'/' + ControllerName + '/getAutoComplete?Id=' + SelectNo,
            data: function (params) {
                var query = {
                    SearchText: params.term
                }
                return query;
            },
            processResults: function (data) {
                if (regCodeIdFiler) {
                    //debugger;
                    const optResult = data.filter(i => !regCodeIds.includes(i.value));
                    return {
                        results: optResult.map(function (option) {
                            return { id: option.value, text: option.text }
                        })
                    };
                }
                //debugger;
                return {
                    results: data.map(function (option) {
                        return { id: option.value, text: option.text }
                    })
                };
            }
        }//,
        //minimumInputLength: 1
    });
    debugger;
}
function sanamSir() {
    $(id).autocomplete({
        source: function (request, responce) {
            //$('#<%=txtAvailableCount.ClientID %>').val('');
            //$('#<%=txtRate.ClientID %>').val('');
            //$('#<%=txtTotal.ClientID %>').val('');
            $.ajax({
                url: "/SetupServices.svc/GetSuggestions_New",
                type: "post",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify({ type: type, query: request.term }),
                dataType: 'json',
                success: function (data) {
                    var suggestions = [];
                    $.each(data, function (i, val) {
                        suggestions.push({
                            label: val.Label,
                            value: val.Label,
                            id: val.Value
                        });
                    });
                    responce(suggestions);
                },
                error: function (err) {
                    alert(err);
                }
            });
        },
        select: function (e, ui) {
            var thisInput = e.target;
            $(thisInput).val(ui.item.label);
            //GetItemInfo(ui.item.id);
        }
    });
}


////onselect2 select change
//function setSelect2Change() {
//    $('#ItemId').on("select2:selecting", function (e) {
//        //console.log(e.args);
//        console.log(e.params.args);
//        console.log(e.params.args.data);
//        $('#ItemName').val(e.params.args.data.text);
//        console.log(e.params.args.data.text);
//        // what you would like to happen
//    });
//}