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
  	$("#saveHighlight").on("click",function(){
    	var subject = $("#subject").val();
		var body = $("#body").val();
    	var tag = $("#tag").val();
    	var rid = $("#recordId").val();
    	//sets the div where crops to be displayed.
	 	var div=$(this).parent().children();
     	var op="";
	    $.ajax({
      		type:'get',
      		url: "http://www.companyreports.com/controller/reportController.cfc?method=getTotalHighlight" ,
      		success:function(data){ 
		  		jsonOBJ = jQuery.parseJSON(data);
				var arr = $.map(jsonOBJ, function(el) { return el });
				var total=arr[0].total;
    			$.ajax({
      				type:'post',
      				url: "http://www.companyreports.com/controller/reportController.cfc?method=addHighlight" ,
      				data:{'subject':subject, 'body':body, 'tag':tag, 'rid':rid, 'sid':total+1},
      				success:function(data){ 
		  				jsonOBJ = jQuery.parseJSON(data);
						var arr = $.map(jsonOBJ, function(el) { return el });
		  				for(i=0 ; i<arr.length; i++) {
			  				op+= '<div id=item_'+arr[i].id+'>';
			  				op+= arr[i].subject;
			  				op+= arr[i].body;
			  				op+= '</div>';
		  				}
		 				div.find('#highlightData').html(" ");
         				div.find('#highlightData').append(op);
      				}
    			})
      		}
    	})
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
      			success:function(data){ }
    		})
		}
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