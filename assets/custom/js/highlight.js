/**
* File    : highlight.js
* Purpose : Contains all jquery codes for highlight menu
* Created : 12-june-2017
* Author  : Satyapriya Baral
*/

$(document).ready(function(){

	/**
  	* Ajax call to input highlight data and display it
  	*
  	* @param Null
  	* @return Null
  	*/
	$(document).on('click', '#saveHighlight', function() {
    var subject = $("#subject").val();
    var arr1 = [];
    console.log(is_global_save_clicked);
    if(is_global_save_clicked === false) {
        setSectionModified("Highlight", false, "saveHighlight");
    }
    if(subject === ""){
      if(is_global_save_clicked === false) {
        $("<div class='global_dialog' id='global_dialog'>Please Enter Subject</div>").dialog();
      } else {
        arr1[0] = "Please Enter Subject";
        setActionCompleted("Highlight", arr1);
      }
    } else {
		var body = $.trim(tinymce.editors[1].getContent());
    var tag = $("#tag").val();
    var rid = $("#recordId").val();
    	//sets the div where crops to be displayed.
		var div=$(this).parent().parent().children().children();
     	var op="";
    	$.ajax({
      		type:'post',
      		url: "http://www.companyreports.com/controller/reportController.cfc?method=addHighlight" ,
      		data:{'subject':subject, 'body':body, 'tag':tag, 'rid':rid},
      		success:function(data){ 
            if(data === "false") {
            if(is_global_save_clicked === false) { 
            alert("error");
          }else{
            arr1[0] = "error occured somewhere";
            setActionCompleted("Highlight", arr1);
       }
          } else {
				$("#subject").val('');
				tinymce.editors[1].setContent('');
		  		jsonOBJ = jQuery.parseJSON(data);
				var arr = $.map(jsonOBJ, function(el) { return el });
		  		for(i=0 ; i<arr.length; i++) {
			  		op+= '<div id=item_'+arr[i].id+'>';
			  		op+= '<h5 class="subjectStyle">'+arr[i].subject+'</h5>';
					op+= '<hr class="hr-color">';
			  		op+= '<div class="bodyStyle">'+arr[i].body+'<span class="deleteSymbol">&#x2716;</span>';
			  		op+= '</div></div>';
		  		}
		 		div.find('#highlightData').html(" ");
         		div.find('#highlightData').append(op);
              setActionCompleted("Highlight");
            }
      		},
			error: function( xhr, errorType ){
          if(is_global_save_clicked === false) { 
            alert("error");
          }else{
            arr1[0] = "error occured somewhere";
            setActionCompleted("Highlight", arr1);
        }
				//}
			}
    	})
    }
  	});

$("#saveHighlightForm :input").keyup(function() {
  //if($("#saveHighlightForm :input").val() != ""){
    setSectionModified("Highlight", true, "saveHighlight");
});

	/**
  	* Ajax call to sort the highlight data
  	*
  	* @param Null
  	* @return Null
  	*/
  	$("#highlightData").sortable({
		update: function(event, ui) {
			var postData = $(this).sortable('toArray');
			var sortData = postData.join(", ");
			var rid = $("#recordId").val();
			$.ajax({
      			type:'post',
      			url: "http://www.companyreports.com/controller/reportController.cfc?method=updateHighlight" ,
      			data:{'sortData':sortData, 'rid':rid},
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
  	* Ajax call to delete a highlight data
  	*
  	* @param Null
  	* @return Null
  	*/
	$(document).on('click', '.deleteSymbol', function() {
		var id = $(this).parent().parent().attr('id');
		var highlightId = id.match(/\d+/)[0];
		var rid = $("#recordId").val();
		var div=$(this).parent().parent().parent().parent();
     	var op="";
		$.ajax({
      		type:'post',
      		url: "http://www.companyreports.com/controller/reportController.cfc?method=deleteHighlight" ,
      		data:{'highlightId':highlightId, 'rid':rid},
      		success:function(data){
		  		jsonOBJ = jQuery.parseJSON(data);
				var arr = $.map(jsonOBJ, function(el) { return el });
		  		for(i=0 ; i<arr.length; i++) {
			  		op+= '<div id=item_'+arr[i].id+'>';
			  		op+= '<h5 class="subjectStyle">'+arr[i].subject+'</h5>';
					op+= '<hr class="hr-color">';
			  		op+= '<div class="bodyStyle">'+arr[i].body+'<span class="deleteSymbol">&#x2716;</span>';
			  		op+= '</div></div>';
		  		}
		 		div.find('#highlightData').html(" ");
         		div.find('#highlightData').append(op);
			},
			error: function( xhr, errorType ){
            	if (errorType == "error"){
					alert("error !!");
				}
			}
    	})
	});

	tinymce.init({
        selector: '.highlight-text',
        toolbar1: "newdocument fullpage | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
        toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image media code | insertdatetime preview | forecolor backcolor | table | hr removeformat | subscript superscript | charmap emoticons | print fullscreen | ltr rtl | visualchars visualblocks nonbreaking template pagebreak restoredraft",

        menubar: false,
        toolbar_items_size: 'small',

        style_formats: [{
            title: 'Bold text',
            inline: 'b'
        }, {
            title: 'Red text',
            inline: 'span',
            styles: {
                color: '#ff0000'
            }
        }, {
            title: 'Red header',
            block: 'h1',
            styles: {
                color: '#ff0000'
            }
        }, {
            title: 'Example 1',
            inline: 'span',
            classes: 'example1'
        }, {
            title: 'Example 2',
            inline: 'span',
            classes: 'example2'
        }, {
            title: 'Table styles'
        }, {
            title: 'Table row 1',
            selector: 'tr',
            classes: 'tablerow1'
        }],

        templates: [{
            title: 'Test template 1',
            content: 'Test 1'
        }, {
            title: 'Test template 2',
            content: 'Test 2'
        }]
    });
 })