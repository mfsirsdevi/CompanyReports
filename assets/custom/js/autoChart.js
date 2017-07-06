var interest_coverage_private = {
  vmin : undefined,
  vmax : undefined,
  vinterval : undefined,
  dataMatrix : undefined,
  hidden_cols : undefined
}

$('document').ready(function(){

  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(function(){
      getDatesAndDrawChart();
      //drawChart(); //view demo
  });
  
  $("#hideColumn label input").on('change', changeChartView );
  $("#chart-pref-dialog").dialog({
      autoOpen: false,
      modal: true,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
        }
      }
  });

  $("#chart-customization-dialog").dialog({
      autoOpen: false,
      closeOnEscape: true,
      closeText: "close",
      width: 350,
      modal: true,
      title: "Customize Chart",
      buttons: {
        Update: function() {
          // clicking "update" gets the chart options & draws the chart
          if( setCustomChartOptions() )   // all fields valids.. then 
            $( this ).dialog( "close" );
        },
        Close : function() {
          $( this ).dialog( "close" );
        }
      }
  });
  $("#chart-customization-form").validate();
});


/**
 *  function for changing the google chart view as the user 
 *  unchecks or checks some of the data columns
 */
var changeChartView = function(vAxis) {
    setSectionModified( $("#ic_saveChart").data('section-name'), true);

    if(vAxis.ticks);
    else {
      if( interest_coverage_private.vmin == undefined ) vAxis = undefined;
      else {
        var vticks = createTickArray(interest_coverage_private.vmin, interest_coverage_private.vmax, interest_coverage_private.vinterval);
        vAxis = {
          viewWindow : {
            min  : interest_coverage_private.vmin,
            max  : interest_coverage_private.vmax,
          },
          ticks : vticks
        }
      }
    }
    var hide_cols = [];
    $.each($("#hideColumn label input"), function(e, el){
      if( !el.checked ){
        key = parseInt($(el).next().attr('id').match(/\d+/)[0]);
        hide_cols.push(key);
      }
    });
  getDates(undefined, hide_cols, vAxis);
}

// on page refresh it fetches the dates & repopulates the UI with dates (x_axis) & draws the chart
function getDatesAndDrawChart(){
  getDates(populateUI,undefined, undefined);
}


// get dates & values - then call method to update UI & draw chart
// @param col_obj - it is received when any column is unchecked/checked in UI.. in  which case 
// we have to update the chart with the data again with getting the dates list & 
function getDates(callback, hidden_cols, vAxis){
  var report_id = $("#report_id").val();
  $.ajax({
    url:"../../controller/reportController.cfc?method=getDates",
    data: {
      reportid : report_id
    },
    dataType : "JSON",
    success: function(response){
      if(response.DATA && response.DATA.length > 0){
        var dataMatrix = getDataMatrix(response);
        
        if( hidden_cols === undefined )  //undefined in case of page reload  & defined incase of some data hidden/shown
          hidden_cols = getHiddenCols(response);

        if( callback == undefined ) {
          drawChart( hidden_cols, dataMatrix, vAxis);
        }
        else {
          // it is called when page is refreshed.. with the callback - ' populateUI'
          callback(response); //populate UI
          getvAxisObj(hidden_cols, dataMatrix); //get the vAxis values for chart & draw
        }
      }
      else {
        str = "No data from DB to work with :'( ";
        $("#hideColumn").prepend("<div class='temp-alert' style='background-color:red;color:white;padding: 10px;'>"+ str +"</div>");
        if(is_global_save) {
          setActionCompleted($("#ic_saveChart").data('section-name'), ["error retrieving data from Database"]);
        }
        else {
          $("<div>DB error<div>").dialog({modal:true});
          setSectionModified($("#ic_saveChart").data('section-name'),false);
        }
      }
    },
    error : function(error){
      if(is_global_save) {
          setActionCompleted($("#ic_saveChart").data('section-name'), ["error retrieving data from Database"]);
      }
      else {
        alert("can't retrieve the dates... try again.");
        setSectionModified($("#ic_saveChart").data('section-name'), false);
      }
    }
  });
}

// generate a datamatrix for creating the google chart with the ajax response
function getDataMatrix(response){
  var dataMatrix = [];
  
   $.each(response.DATA, function(i, data_arr){
      var period_end_date = new Date(data_arr[1]).toLocaleDateString();
      var value = data_arr[3];
      
      // contains data to populate the original google chart
      var arr_temp = [];
      arr_temp.push(period_end_date);
      arr_temp.push(value);

      dataMatrix.push(arr_temp);
   });
   return dataMatrix;
}

// get hidden cols array
function getHiddenCols(response){
  var hidden_cols = [];
  $.each(response.DATA, function(i, data_arr){
    var hidden = data_arr[2];
    // push the unchecked dates index to "hidden_cols" array
    if(hidden == true ) hidden_cols.push(i); 
  });
  return hidden_cols;
}

// to populate the UI of the dates & ranges
var populateUI = function(response){
    var checked = "";
    // empty the hidecolumn div for loading the latest from database
    $('#hideColumn').empty();

    // iterate over the response query to know reflow the chart
    $.each(response.DATA, function(i, data_arr){
      var period_id = data_arr[0];
      var period_end_date = new Date(data_arr[1]).toLocaleDateString();
      var hidden = data_arr[2];

      if(hidden == false ) {
        checked = "checked";
      }
      else{
        // for unchecking those dates which are hidden in chart
        checked = "";
      }
      var hideColumnEl =  `<label>
                            <input type="checkbox"  data-int-period-id="`+ period_id +`" `+ checked +`>
                            <small id="id`+i+`">`+period_end_date+`</small>
                          </label>`;
      $('#hideColumn').append(hideColumnEl);
    });
    // attach event listeners for dynamically created elements on autoreport page
    $("#hideColumn label input").on('change', changeChartView );
}

function getvAxisObj(hidden_cols, dataMatrix){
  var reportid = parseInt($("#report_id").val());
  var companyid = parseInt($("#company_id").val());
  $.ajax({
    url: "../../controller/reportController.cfc?method=getvAxisValues",
    data: {
      cid : companyid,
      rid : reportid
    },
    dataType: "JSON"
  }).done(function(res){
    if(res.DATA.length ) {    
      var axis_array = res.DATA[0];
      var min = axis_array[0];
      var max = axis_array[1];
      var interval = axis_array[2];
      var tick = createTickArray( min, max, interval );
      
      var axisObj = {
        viewWindow: {
          min: min,
          max: max
        },
        ticks : tick
      };
      // draw fresh chart for the retrieved values.
      drawChart( hidden_cols, dataMatrix, axisObj );

      // save data in global variable for repeated use
      interest_coverage_private.vmin = min;
      interest_coverage_private.vmax = max;
      interest_coverage_private.vinterval = interval;
    }
    else{
      // no rows in database defining the vAxis properties..
      drawChart( hidden_cols,dataMatrix, undefined );
    }
  }).fail(function(error){
    alert("Error retrieving the vAxis values from Database.")
  });

}
/**
  function for drawing the chart
  @param - excludeColsArr - contains the id of the dates which is to be hidden
  @param - dataMatrix - contains all the Periods & associates values with that period
 */
function drawChart(excludeColsArr, dataMatrix, vAxisObj) {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'x');
  data.addColumn('number', 'values');
  if ( dataMatrix != undefined )
      data.addRows(dataMatrix);
  // else //the fake datas.. mostly for test purpose
  //     data.addRows([
  //         ['12/12/2017', 100], 
  //         ['13/12/2017', 120],
  //         ['19/12/2017', 100]]);

  // The intervals data as narrow lines (useful for showing raw source data)
  if (vAxisObj == undefined ) { vAxis = "" }

  var options_lines = {
      width: '900',
      title: 'Point intervals, default',
      pointSize: 7,
      legend: 'none',
      vAxis: vAxisObj
  };
  var view = new google.visualization.DataView(data);
  if(excludeColsArr)
    view.hideRows(excludeColsArr);
  var chart_lines = new google.visualization.LineChart(document.getElementById('chart_div'));
  chart_lines.draw(view, options_lines);
}

function saveChartData(){
    var unchecked_cols = [];
    var checked_cols = []
    // get data
    $.each($("#hideColumn label input"), function(i,el){
        var periodId = $(this).data("int-period-id");
        if(el.checked == false){
            unchecked_cols.push(periodId);
        }
        else {
            checked_cols.push(periodId);
        }
    });

      //store data update database with hidden/shown date fields
    $.ajax({
        url: "../../controller/reportController.cfc?method=updateChartPreference",
        data : {
            hidden_dates : JSON.stringify(unchecked_cols),
            not_hidden_dates : JSON.stringify(checked_cols)
        },
        dataType: "JSON"
    }).done(function(response){
        if (response == true ){
          // checks if chart axis values changed then alerts save successful
          saveChartvAxisValues();
        }
    }).fail(function(){
      alert("couldn't save the data to DB.. please try again.");
    });
}

/**
 * save the chart vAxis(vertical axis , min max interval between ticks etc..) values
 * called in saveChartData();
 */
function saveChartvAxisValues() {
  var reportid = parseInt($("#report_id").val());
  var companyid = parseInt($("#company_id").val());

  if( interest_coverage_private.vmin != undefined ){
    $.ajax({
      url: "../../controller/reportController.cfc?method=setChartvAxisValues",
      data: {
        cid: companyid,
        rid: reportid,
        min: interest_coverage_private.vmin,
        max: interest_coverage_private.vmax,
        interval: interest_coverage_private.vinterval
      },
      dataType: "JSON"
    }).done(function(response){
      if(response == true){
          if(is_global_save) setActionCompleted($("#ic_saveChart").data('section-name') );
          else $("#chart-pref-dialog").dialog('open');  
      }
    }).fail(function(error){
        if(is_global_save) setActionCompleted($("#ic_saveChart").data('section-name'),["Can't save the vertical AxisData for google chart in DB"] );
        else alert("error on saving the chart vAxis Data. Please try again.");
    });
  }
  else {
    if(is_global_save) setActionCompleted($("#ic_saveChart").data('section-name') );
    else $("#chart-pref-dialog").dialog('open');
  }
}


// for showing the customize google chart dialog box
function showOptions(){
  $("#chart-customization-dialog").dialog('open');
  $(".ui-widget-overlay").css("background-color", "white");
  // fill the boxes with the previously populated value- TBD
}

//get the chart vAxis options & draw the chart using the min/max/interval values
function setCustomChartOptions(){
  if( $("#chart-customization-form").valid() ){
    setSectionModified($("#ic_saveChart").data('section-name'), true); 
    
    var vmin = parseInt($("#v-min").val());
    var vmax = parseInt($("#v-max").val());
    var vinterval = parseInt($("#v-interval").val());
    var ticks = createTickArray(vmin, vmax, vinterval);
    
    // assign global variables for saving process - check for this value while saving to DB - if undefined - no changes made
    interest_coverage_private.vmin = vmin;
    interest_coverage_private.vmax = vmax;
    interest_coverage_private.vinterval = vinterval;

    // create the vAxis object for the google chart customization
    var vAxis = {
      viewWindow : {
        min : vmin,
        max : vmax,
      },
      ticks : ticks
    }
    // signal to change chart view with the current coorinates..
    changeChartView(vAxis); 
    return true;
  }
  else 
    return false;
}

// creating returning the Tick Array of regular intervals for the google chart
function createTickArray(min, max, interval){
  var ticks = [];
  for(var i=min; i<=max; i+=interval){
    ticks.push(i);
  }
    // added to the ticks values
  if( $.inArray(max, ticks) == -1 ){
    ticks.push(max);
  }
  return ticks;
}