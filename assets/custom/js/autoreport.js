$(document).ready(function() {
    $(".header").click(function() {

        $header = $(this);
        //getting the next element
        $content = $header.next();
        //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
        $content.slideToggle(2000, function() {
            //execute this after slideToggle is done
            //change text of header based on visibility of content div
            $header.children('span').text(function() {
                //change text based on condition
                return $content.is(":visible") ? "-" : "+";
            });
        });
    });
    tinymce.init({
        selector: '.analytical-text',
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

    function getUrlParameter(sParam) {
        var sPageUrl = window.location.search.substring(1);
        var sURLVariables = sPageUrl.split('&');
        for (var i = 0; i < sURLVariables.length; i++) {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam) {
                return decodeURIComponent(sParameterName[1]);
            }
        }
    }

    /**
     * Save the analytical overview text in the database
     */
    $('#add-analysis').on('click', function() {
        editorContent = tinymce.editors[0].getContent();
        var cid = getUrlParameter('cid');
        var rid = getUrlParameter('rid');
        var data = {
            "cid": cid,
            "rid": rid,

        };
        console.log(data);
        // $.ajax({
        //     url: "http://www.companyreports.com/controller/reportController.cfc?method=saveAnalysis",
        //     data: editorContent,
        //     success: function(result) {
        //         $("#div1").html(result);
        //     }
        // });
    });
});