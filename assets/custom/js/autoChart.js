var url = window.location.href;
var arr = url.split("/");
var domain = arr[0] + "//" + arr[2]; //contains the domain name straing from the 'http:/....com'

var cols = [];  //cols array containing indexes/id of the row not to be shown in CHART
var chart_rows; //this will contain the all the row data for the drawChart() to be populated on the page load
var vmin, vmax, vinterval; // for setting global chart options .. 

$('document').ready(function(){

  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(function(){
      getPeriodsAndDrawChart();
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
          if(getCustomChartOptions())  // all fields valids.. then 
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
var changeChartView = function() {
    var key = parseInt($(this).next().attr('id').match(/\d+/)[0]);
    console.log(key);
    if (($.inArray(key, cols) == -1) && !this.checked) {
       cols.push(key);
    } else if(($.inArray(key, cols) > -1) && this.checked) {
      var index = $.inArray(key, cols);
      cols.splice(index, 1);
    }
  drawChart(cols, chart_rows);
}

function getPeriodsAndDrawChart(){
  
  var reportID = $("#report_id").val(); 
  // get dates & values - then call method to update UI & draw chart
  $.ajax({
    url: domain + "/controller/reportController.cfc?method=getDates",
    data: {
      reportid : reportID
    },
    dataType : "JSON"
  }).done(function(response){
     populatePeriodsUI(response);
  }).fail(function(error){
    alert("can't retrieve the dates... try again.");
  });

}

// to populate the UI of the dates & ranges
function populatePeriodsUI(response){
    var dates_arr = [];
    var dates_arr_checked = [];
    var dates_arr_unchecked = [];
    var checked = true;
    // empty the hidecolumn div for loading the latest from database
    $('#hideColumn').empty();

    // iterate over the response query to know reflow the chart
    $.each(response.DATA, function(i, data_arr){
      var period_end_date = new Date(data_arr[1]).toLocaleDateString();
      var hidden = data_arr[2];

      // contains data to populate the original google chart
      var arr_temp = [];
      arr_temp.push(period_end_date);
      arr_temp.push(data_arr[3]);
      dates_arr.push(arr_temp);

      if(hidden == false ) {
        dates_arr_checked.push(period_end_date);
        checked = "checked";
      }
      else{
        dates_arr_unchecked.push(period_end_date);
        cols.push(i); // push the unchecked dates' indexes to the global "cols" array
        checked = "";
      }
      var hideColumnEl =  `<label>
                            <input type="checkbox"  data-int-period-id="`+data_arr[0]+`" `+ checked +`>
                            <small id="id`+i+`">`+period_end_date+`</small>
                          </label>`;
      $('#hideColumn').append(hideColumnEl);
    });
    // attach event listeners for dynamically created elements on autoreport page
    $("#hideColumn label input").on('change', changeChartView );

    // global Assigning for using whenever calling the drawchart() fn
    chart_rows = dates_arr;
    drawChart(cols, chart_rows);
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
  else //the fake datas.. mostly for test purpose
      data.addRows([
          ['12/12/2017', 100],
          ['13/12/2017', 120],
          ['14/12/2017', 130],
          ['15/12/2017', 90],
          ['16/12/2017', 70],
          ['17/12/2017', 30],
          ['18/12/2017', 80],
          ['19/12/2017', 100]]);

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
    var checked_cols = [];
    
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
        url: domain + "/controller/reportController.cfc?method=updateChartPreference",
        data : {
            hidden_dates : JSON.stringify(unchecked_cols),
            not_hidden_dates : JSON.stringify(checked_cols)
        },
        dataType: "JSON"
    }).done(function(response){
        if (response == true ){
          saveChartvAxisValues();
        }
        else alert("couldn't save the data. please try again.");
    }).fail(function(){
      alert("couldn't save the data.. please try again.");
    });
}

// save the chart vAxis(vertical axis , min max interval between ticks etc..) values
function saveChartvAxisValues() {
  var reportid = parseInt($("#report_id").val());
  var companyid = parseInt($("#company_id").val());

  if( vmin != undefined ){
    $.ajax({
      url: domain + "/controller/reportController.cfc?method=setChartvAxisValues",
      data: {
        cid: companyid,
        rid: reportid,
        min: vmin,
        max: vmax,
        interval: vinterval
      },
      dataType: "JSON"
    }).done(function(response){
      if(response == true){
          $("#chart-pref-dialog").dialog('open');        
      }
    }).fail(function(error){
        alert("error on saving the chart vAxis Data. Please try again.");
    });
  }
}


// for showing the customize google chart dialog box
function showOptions(){
  $("#chart-customization-dialog").dialog('open');
  $(".ui-widget-overlay").css("background-color", "white");
  // fill the boxes with the previously populated value- TBD
}

//get the chart vAxis options & change the chart view using the min/max/interval values
function getCustomChartOptions(){
  if( $("#chart-customization-form").valid() ){
    
    // global variables that stores the custom ranges & scaling
    // when not changed the values.. they contain undefined.. in which case 
    // when saving the chart preferences they should n't be updated in the DB .. only the dates should be updated
    // so check for undefined values when saving preferences
    vmin = parseInt($("#v-min").val());
    vmax = parseInt($("#v-max").val());
    vinterval = parseInt($("#v-interval").val());
    var ticks = [];

    for(var i=vmin; i<=vmax; i+=vinterval){
      ticks.push(i);
    }
    // added to the ticks values
    if( $.inArray(vmax, ticks) == -1 ){
      ticks.push(vmax);
    }

    // create the vAxis object for the google chart customization
    var vAxis = {
      viewWindow : {
        min : vmin,
        max : vmax,
      },
      ticks : ticks
    }
    // draw the chart with the options 
    drawChart(cols, chart_rows, vAxis);
    return true;
  }
  else 
    return false;
}