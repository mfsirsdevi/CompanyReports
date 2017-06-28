/**
* File    : creditFacility.js
* Purpose : Contains all jquery codes for credit facility section
* Created : 20-june-2017
* Author  : Satyapriya Baral
*/
$(document).ready(function(){

    //Function to append a div for adding amendment date
    $('.addAmendmentDate').click(function(){
        $('.amendmentEditFields').append('<div><input type="date" name="amendmentDate" value="" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeAmendmentDate"></span></div>');
    });
    //Function to remove amendment date div
    $('.amendmentEditFields').on( "click", "span.removeAmendmentDate" , function(){
        $(this).parent().remove();
    }); 
    //Function to append a div for adding lenders
    $('.addOtherLenders').click(function(){
        $('.otherLendersFields').append('<div><input type="text" name="otherLenders" value="" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeOtherLenders"></span></div>');
    });
    //Function to remove lenders div
    $('.otherLendersFields').on( "click", "span.removeOtherLenders" , function(){
        $(this).parent().remove();
    });
    //Function to append a div for adding agent bank
    $('.addAgentBank').click(function(){
        $('.agentBankFields').append('<div><input type="text" name="agentBank" class="appendData" value=""/><span class="appendCloseSpan ui-icon ui-icon-closethick removeAgentBank"></span></div>');
    });
    //Function to remove agent bank div
    $('.agentBankFields').on( "click", "span.removeAgentBank" , function(){
        $(this).parent().remove();
    });
    //Function to append a div for adding simultaneous
    $('.addSimultaneous').click(function(){
        $('.simultaneousFields').append('<div><input type="text" name="simultaneous" value="" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeSimultaneous"></span></div>');
    });
    //Function to remove simultaneous div
    $('.simultaneousFields').on( "click", "span.removeSimultaneous" , function(){
        $(this).parent().remove();
    });
    //Function to append a div for adding financial div
    $('.addFinancial').click(function(){
        $('.financialFields').append('<div><input type="text" name="financial" value="" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeFinancial"></span></div>');
    });
    //Function to remove financial div
    $('.financialFields').on( "click", "span.removeFinancial" , function(){
        $(this).parent().remove();
    });
    //Function to trigger on intrest rate selected
    $('.interestRateSelect').change(function(){
        var selected_mode = $(this).val();
        if(typeof(selected_mode) != "undefined"){
            if(selected_mode == 'range'){
                $(this).parent().find('#interestRateValue').hide();
                $(this).parent().find('#interestRateRange').show();
                
            }else if(selected_mode == 'value'){
                $(this).parent().find('#interestRateRange').hide();
                $(this).parent().find('#interestRateValue').show();
            }else{
                $(this).parent().find('#interestRateRange').hide();
                $(this).parent().find('#interestRateValue').hide();
            }
        }
    })

    /**
    * Function to convert data to json format.
    *
    * @param Null
    * @return Null
    */
    $.fn.serializeObject = function()
    {
        var obj = {};
        var array = this.serializeArray();
        $.each(array, function() {
            if (obj[this.name] !== undefined) {
                if (!obj[this.name].push) {
                        obj[this.name] = [obj[this.name]];
                }
                obj[this.name].push(this.value || '');
            } else {
                obj[this.name] = this.value || '';
            }
        });
        return obj;
    };

    /**
    * Function to clear all data of the dilog fields
    *
    * @param Null
    * @return Null
    */
    function clearFields() 
    {
        $('#newCreditFacilityForm').find("input[type=number], input[type=date], select").val("");
        $('#newCreditFacilityForm textarea').each(function(){
            edit_field_id  = $(this).attr("id");
            tinymce.get(edit_field_id).setContent('');
        });
        $('.amendmentEditFields div').remove(); 
        $('.otherLendersFields div').remove(); 
        $('.agentBankFields div').remove(); 
        $('.simultaneousFields div').remove(); 
        $('.financialFields div').remove(); 
        $('.rcfidData div').remove();
    }
    /**
    * Function to trigger new credit details window on click
    *
    * @param Null
    * @return Null
    */
    $('#addCreditLayout').click(function(){
        clearFields();
        $('#newCreditFacilityDialog').dialog('open');
    });

    /**
    * Function to trigger new credit details window on click
    *
    * @param Null
    * @return Null
    */
    $(document).on("click", ".editCreditFacility" , function(){
        var rcfid = $(this).attr("rcf_id");
        clearFields();
        addFieldValue(rcfid);
        $('#editCreditFacilityDialog').dialog('open');
    });

    /**
    * Opens a dialog to add credit details
    *
    * @param Null
    * @return Null
    */
    $('#newCreditFacilityDialog').dialog({
        autoOpen: false,
        height: 700,
        width: 900,
        title: "New Credit Facility Data",
        buttons: { 
            Save: function() {
                var obj = {};
                //gets all data of tinymce
                $('#newCreditFacilityForm textarea').each(function(){
                    edit_field_id  = $(this).attr("id");
                    obj[edit_field_id] = tinymce.get(edit_field_id).getContent();
                }); 
                var tinymceDate = JSON.stringify(obj);
                var jsonText = JSON.stringify($('#newCreditFacilityForm').serializeObject());
                var op="";
                $.ajax({
                    type:'post',
                    url: "../../../controller/companyController.cfc?method=addCreditFacility" ,
                    data:{'formData':jsonText, 'obj':tinymceDate},
                    success : function(data){
                        cfDetails = jQuery.parseJSON(data);
                        op+="<div class='creditFacilityDataSection' rcf_id='"+cfDetails.creditFieldData.DATA[0][0]+"'>";
                        op+="<div class='creditFacilityHeader creditFacilityHeaderStyle' rcf_id='"+cfDetails.creditFieldData.DATA[0][0]+"'>Credit Facility #"+cfDetails.totalRecords+"</div>";
                        op+="<div class='creditFieldsSection field_"+cfDetails.creditFieldData.DATA[0][0]+"' id='creditFieldsSectionId'>";
                        op+="</div>";
                        op+="</div>";
                        $( "#headerData" ).append( op );
                        appendData(data);
                    },
                    error: function( xhr, errorType ){
                        if (errorType == "error"){
                            alert("error !!");
                        }
                    }
                })
                $( "#newCreditFacilityDialog" ).dialog( "close" ); 
            } 
        },
        close: function() {

              }
    });

    /**
    * Opens a dialog to add credit details
    *
    * @param Null
    * @return Null
    */
    $('#editCreditFacilityDialog').dialog({
        autoOpen: false,
        height: 700,
        width: 900,
        title: "Edit Credit",
        buttons: { 
            Save: function() {
                var obj = {};
                //gets all data of tinymce
                $('#editCreditFacilityForm textarea').each(function(){
                    edit_field_id  = $(this).attr("id");
                    obj[edit_field_id] = tinymce.get(edit_field_id).getContent();
                }); 
                var tinymceData = JSON.stringify(obj);
                var jsonText = JSON.stringify($('#editCreditFacilityForm').serializeObject());
                $.ajax({
                    type:'post',
                    url: "../../../controller/companyController.cfc?method=editCreditFacility",
                    data:{'formData':jsonText, 'obj':tinymceData},
                    success : function(data){
                        appendData(data);
                    },
                    error: function( xhr, errorType ){
                        if (errorType == "error"){
                            alert("error !!");
                        }
                    }
                })
                $( "#editCreditFacilityDialog" ).dialog( "close" ); 
            } 
        },
        close: function() {

              }
    });
    /**
    * Function to append a new record of credit facilty
    *
    * @param data - contains all data of credit facility
    * @return Null
    */
    function appendData(data) {
        var op="";
        cfDetails = jQuery.parseJSON(data);
        for(i=0 ; i< cfDetails.sortDetails.DATA.length ;i++) {
            for(j=0 ; j<cfDetails.columnDetails.DATA.length ; j++)
                if(cfDetails.columnDetails.DATA[j][0] === cfDetails.sortDetails.DATA[i][1])
                {             
                    if(cfDetails.columnDetails.DATA[j][1] === "availability_comment" || cfDetails.columnDetails.DATA[j][1] === "interest_rate_comment" ||  cfDetails.columnDetails.DATA[j][1] === "security_comment" ||  cfDetails.columnDetails.DATA[j][1] === "comments")
                    {
                        if(cfDetails.sortDetails.DATA[i][3] === 1) {
                            op+= "<div class='creditFieldsBig' id='column_"+cfDetails.sortDetails.DATA[i][0]+"' style='display: block;'>";
                        } else {
                            op+= "<div class='creditFieldsBig' id='column_"+cfDetails.sortDetails.DATA[i][0]+"' style='display: none;'>";
                            }
                        } else {
                            if(cfDetails.sortDetails.DATA[i][3] === 1) {
                                op+= "<div class='creditFields' id='column_"+cfDetails.sortDetails.DATA[i][0]+"' style='display: block;'>";
                            } else {
                                op+= "<div class='creditFields' id='column_"+cfDetails.sortDetails.DATA[i][0]+"' style='display: none;'>";
                            }
                        }
                        op+="<div class='creditFieldSubject'>";
                        op+="<span class='creditField bold'>"+cfDetails.columnDetails.DATA[j][2]+" :</span>";
                        op+="<span class='creditFieldValue'>";
                        if(cfDetails.columnDetails.DATA[j][1] === "str_lenders") {
                            for(k=0 ; k<cfDetails.extraColumnDetails.LENDERS.DATA.length ; k++)
                            {
                                op+=cfDetails.extraColumnDetails.LENDERS.DATA[k][0]+",";
                            }
                        } else if(cfDetails.columnDetails.DATA[j][1] === "str_financial_convenants_data") {
                            for(k=0 ; k<cfDetails.extraColumnDetails.FINANCIALCONVENANTS.DATA.length ; k++)
                            {
                                op+=cfDetails.extraColumnDetails.FINANCIALCONVENANTS.DATA[k][0]+",";
                            }
                        }else if(cfDetails.columnDetails.DATA[j][1] === "str_convenants") {
                            for(k=0 ; k<cfDetails.extraColumnDetails.CONVENANTS.DATA.length ; k++)
                            {
                                 op+=cfDetails.extraColumnDetails.CONVENANTS.DATA[k][0]+",";
                            }
                        }else if(cfDetails.columnDetails.DATA[j][1] === "str_agent_bank") {
                            for(k=0 ; k<cfDetails.extraColumnDetails.AGENTBANK.DATA.length ; k++)
                            {
                                op+=cfDetails.extraColumnDetails.AGENTBANK.DATA[k][0]+",";
                            }
                        }else if(cfDetails.columnDetails.DATA[j][1] === "date_amendment") {
                            for(k=0 ; k<cfDetails.extraColumnDetails.AMENDMENT.DATA.length ; k++)
                            {
                                var dateFormat = new Date(cfDetails.extraColumnDetails.AMENDMENT.DATA[k][0]);
                                var dateValue = $.datepicker.formatDate('yy-mm-dd', dateFormat);
                                op+=dateValue+",";
                            }
                        } else {
                            for(k=0 ; k<cfDetails.creditFieldData.COLUMNS.length ; k++)
                            {
                                if(cfDetails.columnDetails.DATA[j][1].toUpperCase() === cfDetails.creditFieldData.COLUMNS[k])
                                {
                                    if(cfDetails.creditFieldData.DATA[0][k] != null) {
                                        if(cfDetails.creditFieldData.COLUMNS[k] === "ORIGINAL_FACILITY_DATE" || cfDetails.creditFieldData.COLUMNS[k] === "MATURITY_DATE" || cfDetails.creditFieldData.COLUMNS[k] === "AVAILBILITY_DATE"){
                                            dateFormat = new Date(cfDetails.creditFieldData.DATA[0][k]);
                                            dateValue = $.datepicker.formatDate('yy-mm-dd', dateFormat);
                                            op+=dateValue;
                                        } else {
                                            op+=cfDetails.creditFieldData.DATA[0][k];
                                        }
                                    }
                                }
                            }
                        }
                        op+="</span>";
                        op+="</div>";
                        op+="</div>";
                    }
                }
                op+="<div class='editCredit'>";
                op+="<button type='button' class='creditButtonStyle editCreditFacility' id='editCreditFacility' rcf_id='"+cfDetails.creditFieldData.DATA[0][0]+"'>Edit Credit Facility</button>";
                op+="<button type='button' class='creditButtonStyle customLayout' id='customLayout' rcf_id='"+cfDetails.creditFieldData.DATA[0][0]+"'>Customise Layout</button>";
                $( '.field_'+cfDetails.creditFieldData.DATA[0][0]).html("");
                $( '.field_'+cfDetails.creditFieldData.DATA[0][0]).append( op );
                $(".creditFieldsSection").sortable({
                    update: function(event, ui) {
                    var postData = $(this).sortable('toArray');
                    var sortData = postData.join(", ");
                    var rcfid = $(this).parent().attr('rcf_id');
                    $.ajax({
                        type:'post',
                        url: "../../../controller/companyController.cfc?method=updateCreditFacilitySortOrder" ,
                        data:{'sortData':sortData, 'rcfid':rcfid},
                        success:function(data){ },
                        error: function( xhr, errorType ){
                        if (errorType == "error"){
                            alert("error !!");
                        }
                    }
                })
            }
        });
    }
    /**
    * Ajax call to sort the highlight data
    *
    * @param Null
    * @return Null
    */
    $(".creditFieldsSection").sortable({
         update: function(event, ui) {
             var postData = $(this).sortable('toArray');
            var sortData = postData.join(", ");
             var rcfid = $(this).parent().attr('rcf_id');
            $.ajax({
                type:'post',
                url: "../../../controller/companyController.cfc?method=updateCreditFacilitySortOrder" ,
                data:{'sortData':sortData, 'rcfid':rcfid},
                success:function(data){ },
                error: function( xhr, errorType ){
                if (errorType == "error"){
                    alert("error !!");
                }
            }
            })
         }
    });

    /**
    * Function to customize dialog with data
    *
    * @param Null
    * @return Null
    */
    $(document).on("click", ".customLayout" , function(){
        var rcfid = $(this).attr('rcf_id');
        var op="";
        $.ajax({
            type:'post',
            url: "../../../controller/companyController.cfc?method=getCustomLayoutDetails" ,
            data:{'rcfid':rcfid},
            success:function(data){
                jsonOBJ = jQuery.parseJSON(data);
                var arr = $.map(jsonOBJ, function(el) { return el });
                $( ".creditFieldCheck" ).each(function( index ) {
                    $('.fieldName_'+index).text(arr[index].columnNameText);
                    $('.fieldName_'+index).attr("id", arr[index].id);
                    if(arr[index].customizeId == 1) {
                        $(this).prop('checked', true); 
                    } else {
                        $(this).prop('checked', false); 
                    }
                });
            },
            error: function( xhr, errorType ){
                if (errorType == "error"){
                    alert("error !!");
                }
            }
        })
        jQuery( ".CustomiseLayout" ).dialog( 'open' );
    });

    /**
    * Opens a dialog to customize hide or show data
    *
    * @param Null
    * @return Null
    */
    $( ".CustomiseLayout" ).dialog({
        autoOpen: false,
        height: 700,
        width: 900,
        title: "Custom Layout",
        buttons: { 
            Save: function() {
                var obj = {};
                $( ".creditFieldCheck" ).each(function( index ) {
                    var value = ($('.fieldName_'+index).attr('id'));
                    if($(this).prop('checked') == true) {
                        $("#column_" + value).css("display","block");
                        obj[value] = 1;
                    } else {
                        $("#column_" + value).css("display","none");
                        obj[value] = 0;
                    }
                });
                $( ".CustomiseLayout" ).dialog( "close" ); 
                var tinymceDate = JSON.stringify(obj);
                $.ajax({
                    type:'post',
                    url: "../../../controller/companyController.cfc?method=editCustomize" ,
                    data:{'obj':tinymceDate},
                    dataType : 'json',
                    success : function(data){},
                    error: function( xhr, errorType ){
                        if (errorType == "error"){
                            alert("error !!");
                        }
                    }
                })
             } 
         }
    });

    /**
    * Function to add related value of the fields
    *
    * @param Null
    * @return Null
    */
    function addFieldValue(rcfid) 
    {
        $('.rcfidData').append('<div><input type="hidden" name="rcfId" value="'+rcfid+'"></div>');
        $.ajax({
            type:'post',
            url: "../../../controller/companyController.cfc?method=creditFacilityDataJsonFormat" ,
            data:{'rcfid':rcfid},
            success : function(data){
                cfDetails = jQuery.parseJSON(data);
                for(creditFields in cfDetails) {
                    if(cfDetails[creditFields][0] != "") {
                        $('#editCreditFacilityForm textarea').each(function(){
                            edit_field_id  = $(this).attr("id");
                            if(creditFields === edit_field_id){
                                tinymce.get(edit_field_id).setContent(cfDetails[creditFields][0]);
                            }
                        });
                        $('#editCreditFacilityForm input[type=date]').each(function(){
                            edit_field_id  = $(this).attr("id");
                            if(creditFields === edit_field_id){
                                var dateFormat = new Date(cfDetails[creditFields][0]);
                                var dateValue = $.datepicker.formatDate('yy-mm-dd', dateFormat);
                                $('#'+edit_field_id).val(dateValue);
                            }
                        });
                        $('#editCreditFacilityForm input[type=number]').each(function(){
                            edit_field_id  = $(this).attr("id");
                            if(creditFields === edit_field_id){
                                $('#'+edit_field_id).val(cfDetails[creditFields][0]);
                            }
                        });
                        $('#editCreditFacilityForm select').each(function(){
                            edit_field_id  = $(this).attr("id");
                            if(creditFields === edit_field_id){
                                $('#'+edit_field_id).val(cfDetails[creditFields][0]);
                            }
                        });
                        if(creditFields === "date_amendment")
                            for(i=0 ; i<cfDetails[creditFields].length ; i++) {
                                var dateFormat = new Date(cfDetails[creditFields][i]);
                                var dateValue = $.datepicker.formatDate('yy-mm-dd', dateFormat);
                                $('.amendmentEditFields').append('<div><input type="date" name="amendmentDate" value="'+dateValue+'" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeAmendmentDate"></span></div>');
                            }
                        }
                        if(creditFields === "str_agent_bank") {
                            for(i=0 ; i<cfDetails[creditFields].length ; i++) {
                                $('.agentBankFields').append('<div><input type="text" name="agentBank" class="appendData" value="'+cfDetails[creditFields][i]+'"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeAgentBank"></span></div>');
                            }
                        }
                        if(creditFields === "str_convenants") {
                            for(i=0 ; i<cfDetails[creditFields].length ; i++) {
                               $('.simultaneousFields').append('<div><input type="text" name="simultaneous" value="'+cfDetails[creditFields][i]+'" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeSimultaneous"></span></div>');
                            }
                        }
                        if(creditFields === "str_financial_convenants_data") {
                            for(i=0 ; i<cfDetails[creditFields].length ; i++) {
                                $('.financialFields').append('<div><input type="text" name="financial" value="'+cfDetails[creditFields][i]+'" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeFinancial"></span></div>');
                            }
                        }
                        if(creditFields === "str_lenders") {
                            for(i=0 ; i<cfDetails[creditFields].length ; i++) {
                                $('.otherLendersFields').append('<div><input type="text" name="otherLenders" value="'+cfDetails[creditFields][i]+'" class="appendData"/><span class="appendCloseSpan ui-icon ui-icon-closethick removeOtherLenders"></span></div>');
                            }
                        }
                    }
            },
            error: function( xhr, errorType ){
                if (errorType == "error"){
                    alert("error !!");
                }
            }
        })
    }
});