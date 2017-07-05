var section_global = {};
var is_global_save_clicked =false;
$('.loader').hide();

function createSectionObj_global(){
    sectionObj = {
             modified : false,  
             saveButtonId : null, 
             fnCallFinished: false, 
             errorMsg: null 
        }
    return sectionObj;
}
function createGlobalSection(section_name){
    section_global[section_name] = createSectionObj_global();
}

function setSectionModified(section_name, status, button_id) {
    section_global[section_name].modified = status;
    section_global[section_name].saveButtonId = button_id;
}

function setActionCompleted(section_name, errors){
    if(errors != undefined) {
        section_global[section_name].errorMsg = errors;
    }
    section_global[section_name].fnCallFinished = true;
    showDialog();
}

function showDialog() {
    var flag = 0;
    var globalDialog = "";
    globalDialog+= "<div class='global_dialog_save' id='global_dialog_save'>";
    jQuery.each( section_global, function( i, val ) {
        if(val.modified === true) {
            if(val.fnCallFinished === true) {
                globalDialog+= i;
                if(val.errorMsg !== null) {
                    for(i=0;i<val.errorMsg.length;i++) {
                        globalDialog+= "</br>"+val.errorMsg[i];
                        console.log(val.errorMsg[i]);
                    }
                } else {
                    globalDialog+= "</br> Saved Succesfully";
                }
            } else {
                flag = 1;
            }
        }
    });
    globalDialog+= "</div>";
    if(flag === 0) {
        jQuery.each( section_global, function( i, val ) {
           val.errorMsg = null;
           val.fnCallFinished = false;
           val.modified = false;
        });
        var test = "<div>"+globalDialog+"</div>";
        if (is_global_save_clicked === true) {
            $(test).dialog({modal:true});
            is_global_save_clicked = false;
            $('.loader').hide();
        }
    }
}
$(document).ready(function(){
    $('.auto_report_section').each(function(){
        field_id  = $(this).attr("section_name");
        section_global[field_id] = createSectionObj_global();
        console.log(section_global);

    });
    $('#all_sections').append("<div id='global_save'><input type='button' id='global_save_button' value='save'></div>");

    $('#global_save_button').click(function(){
        is_global_save_clicked = true;
        jQuery.each( section_global, function( i, val ) {
            if(val.modified === true) {
                $('.loader').show();
                $('#'+val.saveButtonId).trigger('click');
            }
        });
    });
});