var url = window.location.href;
var arr = url.split("/");
var domain = arr[0] + "//" + arr[2]; //contains the domain name straing from the 'http:/....com'

var cols = [];  //cols array containing indexes/id of the row not to be shown in CHART
var chart_rows; //this will contain the all the row data for the drawChart() to be populated on the page load

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
});

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

  $.ajax({
    url: domain + "/controller/reportController.cfc?method=getDates",
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
        cols.push(i);
        checked = "";
      }
      var hideColumnEl =  `<label>
                            <input type="checkbox"  data-int-period-id="`+data_arr[0]+`" `+ checked +`>
                            <small id="id`+i+`">`+period_end_date+`</small>
                          </label>`;
      $('#hideColumn').append(hideColumnEl);
    });
    // attach event listeners for dynamically created elements;
    $("#hideColumn label input").on('change', changeChartView );

    // global Assigning for using whenever calling the drawchart() fn
    chart_rows = dates_arr;
    console.log(dates_arr);
    console.log(chart_rows);
    drawChart(cols, chart_rows);
}


// function for drawing the chart
// @param - arr - contains the id of the dates which is to be hidden
// @param - OriginalRows - contains all the Periods & associates values with that period
  function drawChart(arr, OriginalRows) {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'x');
    data.addColumn('number', 'values');
    if ( OriginalRows != undefined )
        data.addRows(OriginalRows);
    else
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
    var options_lines = {
        width: '900',
        title: 'Point intervals, default',
        pointSize: 7,
        legend: 'none'
    };
    var view = new google.visualization.DataView(data);
    if(arr)
      view.hideRows(arr);
    var chart_lines = new google.visualization.LineChart(document.getElementById('chart_div'));
    chart_lines.draw(view, options_lines);
  }

  function saveChartData(){
      var unchecked_cols = [];
      var checked_cols = [];
      $.each($("#hideColumn label input"), function(i,el){
         var periodId = $(this).data("int-period-id");
         if(el.checked == false){
             unchecked_cols.push(periodId);
         }
         else {
             checked_cols.push(periodId);
         }
      });
      //update database with hidden date fields
      $.ajax({
          url: domain + "/controller/reportController.cfc?method=updateChartPreference",
          data : {
              hidden_dates : JSON.stringify(unchecked_cols),
              not_hidden_dates : JSON.stringify(checked_cols)
          },
          dataType: "JSON"
      }).done(function(response){
          console.log(response);
          if (response == true )
            $("#chart-pref-dialog").dialog('open');
      }).fail();
  }
