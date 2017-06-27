<html>
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      // Load the Visualization API and the corechart package.--- &  set a callback
      google.charts.load('current', {'packages':['line','corechart'], callback: drawChart });

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      console.log(google);
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();

        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Mushrooms', 3],
          ['Onions', 1],
          ['Olives', 1],
          ['Zucchini', 1],
          ['Pepperoni', 2]
        ]);

        // Set chart options
        var options = {'title':'How Much Pizza I Ate Last Night',
                       'width':500,
                       'height':300,
                       curveType: "function"
                   	};

       // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);

		




        var data1 = new google.visualization.DataTable();

		data1.addColumn('string', 'salary_breakdowns');
        data1.addColumn('number', 'amount');
        data1.addRows([
        		['Basic', 16500],
        		['Varpay', 2000],
        		['Other Allowances', 6000],
        		['HRA', 7000]
        	]);
        var options1 = {
        	title : 'The Salary Structure',
        	width : 800,
        	height : 300,
        	// curveType : "function"
        }
        var chart1 = new google.visualization.PieChart(document.getElementById('draw_here'));
        chart1.draw(data1,options1);
      }
    </script>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
    <div id="draw_here"></div>
  </body>
</html>
