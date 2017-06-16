 $('document').ready(function(){
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);

  function drawChart(arr) {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'x');
    data.addColumn('number', 'values');
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

  var cols = [];
  $("#hideColumn label input").on('change', function() {
      var key = parseInt($(this).next().attr('id').match(/\d+/)[0]);
      if (($.inArray(key, cols) == -1) && !this.checked) {
         cols.push(key);
      } else if(($.inArray(key, cols) > -1) && this.checked) {
        var index = $.inArray(key, cols);
        cols.splice(index, 1);
      }
    drawChart(cols);
  });
});