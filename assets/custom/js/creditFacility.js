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
    * Function to trigger new credit details window on click
    *
    * @param Null
    * @return Null
    */
    $('#addCreditLayout').click(function(){
        jQuery( "#newCreditFacilityDialog" ).dialog( 'open' );
    });

    /**
    * Opens a dialog to add credit details
    *
    * @param Null
    * @return Null
    */
    $( "#newCreditFacilityDialog" ).dialog({
        autoOpen: false,
        height: 700,
        width: 900,
        title: "New Credit Facility Data",
        buttons: { 
            Save: function() {
                $( "#newCreditFacilityDialog" ).dialog( "close" ); 
                var obj = {};
                //gets all data of tinymce
                $('#newCreditFacilityForm textarea').each(function(){
                    edit_field_id  = $(this).attr("id");
                    obj[edit_field_id] = tinymce.get(edit_field_id).getContent();
                }); 
                var tinymceDate = JSON.stringify(obj);
                var jsonText = JSON.stringify($('form').serializeObject());
                console.log(jsonText);
                //ajax call to submit data to the database
                $.ajax({
                    type:'post',
                    url: "../../../controller/companyController.cfc?method=addCreditFacility" ,
                    data:{'formData':jsonText, 'obj':tinymceDate},
                    dataType : 'json',
                    success:function(data){ 

                    },
                    //if any error occurs show an error message.
                    error: function( xhr, errorType ){
                        if (errorType == "error"){
                            alert("error !!");
                        }
                    }
                })
            } 
        },
        close: function(ev, ui) { 
            $(this).hide();
        }
    });

    /**
    * Ajax call to sort the highlight data
    *
    * @param Null
    * @return Null
    */
    $(".creditFieldsSection").sortable({
         update: function(event, ui) {
             var postData = $(this).sortable('toArray');
       console.log(postData);
            var sortData = postData.join(", ");
       console.log(sortData);
             var rcfid = $(this).parent().attr('rcf_id');
             console.log(rcfid);
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
    $('.customLayout').click(function(){
        var rcfid = $(this).attr('rcf_id');
        console.log(rcfid);
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
                    } else {console.log("its false");
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
                    success:function(data){ },
                    //if any error occurs show an error message.
                    error: function( xhr, errorType ){
                        if (errorType == "error"){
                            alert("error !!");
                        }
                    }
                })
             } 
        },
        close: function(ev, ui) { 
            $(this).hide();
        }
    });
});
//                 if($("#satya").prop('checked') == true){
//     console.log("correct");
// } else {console.log("correctdffsd");}
            //     $( "#newCreditFacilityDialog" ).dialog( "close" ); 
            //     var obj = {};
            //     //gets all data of tinymce
            //     $('#newCreditFacilityForm textarea').each(function(){
            //         edit_field_id  = $(this).attr("id");
            //         obj[edit_field_id] = tinymce.get(edit_field_id).getContent();
            //     }); 
            //     var tinymceDate = JSON.stringify(obj);
            //     var jsonText = JSON.stringify($('form').serializeObject());
            //     console.log(jsonText);
            //     //ajax call to submit data to the database
            //     $.ajax({
            //         type:'post',
            //         url: "../../../controller/companyController.cfc?method=addCreditFacility" ,
            //         data:{'formData':jsonText, 'obj':tinymceDate},
            //         dataType : 'json',
            //         success:function(data){ 

            //         },
            //         //if any error occurs show an error message.
            //         error: function( xhr, errorType ){
            //             if (errorType == "error"){
            //                 alert("error !!");
            //             }
            //         }
            //     })


    // $( "#editCreditLayout" ).on('click', function() {
    //     var id = $(this).attr('id');
    //             var rcf_id = $(this).attr("rcf_id");
    //             $('#amendment_date_edit_fields_0 div').remove(); 
    //             for(i=0;i<2;i++) {
    //             $('#amendment_date_edit_fields_0').append('<div><input type="text" name="amendment_date" dom_view="1" value="'+id+'" style="margin-bottom: 2%;"/><span class="ui-icon ui-icon-closethick remove_amendment_date" style="display:inline-block"></span></div>');
    //     }
    //     $("#testValue").val(id);
    //     $("#new_credit_detail_window").dialog({
    //         height: 700,
    //         width: 900,
    //         title: "New Credit Facility Data",
    //         buttons: {
    //                     Save: function() {
    //                         var formData = $('form').serialize();
    //                         console.log(formData);
    //                         var validate_message = validateCreditFacilityFields("0");
    //                         if(validate_message.trim().length){
    //                             showUserMessageWindow("Validation",validate_message);
    //                         }else{
                                
    //                             $('#new_credit_detail_form .financial_covenants_db_edit_fields').find('select[name="simultaneous_financial_covenants_event"]').each(function(){
    //                         if($(this).children("option").filter(":selected").val() == 'trigger'){
    //                             $(this).removeAttr("disabled");
    //                         }
    //                     });
                                
    //                             $('#new_credit_detail_form .creditfieldsValue textarea').each(function(){
    //                             edit_field_id    = $(this).attr("id");
    //                             $('#'+edit_field_id).val(tinymce.get(edit_field_id).getContent());
    //                         }); 
    //                             $('#new_credit_detail_form').ajaxSubmit({
    //                                 cache: false,
    //                         type: "post",
    //                         url : '/cfc/report_automation.cfc',
    //                         dataType : 'json',
    //                         beforeSend:function(){
    //                             $('.loader').show();
    //                         },
    //                         success : function(data) {    
    //                             if(typeof(data)!='undefined' && data.SUCCESS){
    //                                 company_id = $("#new_credit_detail_form input[name='companyID']").val();
    //                                 window.location.href = window.location.href.substring(0, window.location.href.indexOf("?")) + '?cid=' + company_id +'&save=1';
    //                                 edit_credit_dialog.dialog( "close" );
    //                             }else if(data.VALIDATION && data.MESSAGE.length){
    //                                 showUserMessageWindow("Validation",data.MESSAGE);
    //                             }else{
    //                                 showUserMessageWindow("Error","Some Error Occurred");
    //                             }
    //                             $('.loader').hide();
    //                         },
    //                         error : function(){
    //                             $('.loader').hide();
    //                             showUserMessageWindow("Error","Some Error Occurred");
    //                         }
    //                     });
    //                         } 
    //                         }
    //                     },
    //                     close: function() {

    //                     }
    //     });
    // });