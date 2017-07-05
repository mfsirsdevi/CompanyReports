var section_global = {};
var is_global_save = false;
var modified_sections_count = 0;

// intializes the section's global section object with default properties 
function createSectionObj_global(button_id){
    sectionObj = {
            section_modified : false,  //set by user.. true .. 
            save_button_id : button_id, //retrieved along with the collection
            action_completed : false, // at the end of save_call of section set this to true (automatically set to true when you set the call status)
            errors_arr : null // if messages[].length == 0 no errors... function successful.
    }
    return sectionObj;
}

// set function call finished status from individual sections' ajax call
function setActionCompleted(key, errors ){
    section_global[key].action_completed = true;
    if( errors != undefined && errors.length > 0 ) {
        section_global[key].errors_arr = errors ;
    }
    else {
        section_global[key].errors_arr = [];
    }
    if( allFunctionsFinished() ){
        removeLoader();
        showGlobaMessageDialog();
        is_global_save = false;
    }
}

function setSectionModified(key, status){
    section_global[key].section_modified = true;
}

// when a custom section is created ..this functions should be called .. along with a parameter to section name
function createGlobalSection(section_name, save_button_id){
    section_global[section_name] = createSectionObj_global(save_button_id);
}

function showGlobaMessageDialog(){
    var errorStr = "";
    for( i in section_global ){
        if(section_global[i].section_modified) {
            errorStr += "<span><strong>" + i + "</strong> : </span>";
            if(section_global[i].errors_arr.length > 0)
                for(j=0; j<= section_global[i].errors_arr.length; j++ ) // iterate over the errors array
                    errorStr +=  "<p style='color:red;text-align:right;margin:0px;'>" + section_global[i].errors_arr[j] + "</p>";
            else    errorStr +=  "<span style='color:green;text-align:right;'>save successful</span>";    
            section_global[i].section_modified = false;
        }
    }
    newStr = "<div>" + errorStr + "</div>";
    $(newStr).dialog({modal:true,buttons: {
        Close : function() {
          $( this ).dialog( "close" );
        }
      }});
}

function update_ModfiedSectionsCount(){
    modified_sections_count = 0;
    for( i in section_global )
        if( section_global[i].section_modified == true )
            modified_sections_count++;
}

function allFunctionsFinished(){
    var finished_sections_count = 0;
    for( i in section_global ) {
        if( section_global[i].action_completed == true ) finished_sections_count++;
    }
    if( finished_sections_count == modified_sections_count )    return true;
    else    return false;
}

function globalSave(){
    update_ModfiedSectionsCount();

    if( modified_sections_count > 0 ) {
        showLoader();
        is_global_save = true;
        for( i in section_global ) {
            if(section_global[i].section_modified == true ) {
                $( "#" + section_global[i].save_button_id ).trigger('click');
            }
        }
    }
    else{
        $("<div>No sections to Save!</div>").dialog({modal:true});
    }
}

$(document).ready(function(){
    // creates the global section object with properties
    $.each($(".section_global"), function(i, el){
        var section_name = $(el).data("section-name");
        var button_id = $(el).attr("id");
        section_global[section_name] = createSectionObj_global(button_id);
    });
});


// tiny loader functions for whole page :D
function showLoader(){
    $("body").addClass("overlay-loader").append("<div class='loader'></div>");
}
function removeLoader(){
    $("body").removeClass("overlay-loader");
    $(".loader").remove();
}
