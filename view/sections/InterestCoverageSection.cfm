<div class="header top-header">
  <p>Interest Coverage</p><span class="pull-right">+</span>
</div>
<div class="content">
  <div id="chart_div"></div>
  <div id="hideColumn">

<!---
    signature:

    `<label>
        <input type="checkbox"  data-int-period-id="`+data_arr[0]+`" `+ checked +`>
        <small id="id`+i+`">`+period_end_date+`</small>
    </label>`;
 --->
    <label>
      <input type="checkbox" checked>
      <small id="id0">12/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id1">13/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id2">14/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id3">16/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id4">16/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id5">17/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id6">18/12/2017</small>
    </label>

    <label>
      <input type="checkbox" checked>
      <small id="id7">19/12/2017</small>
    </label>

  </div>
  <form>
      <button type="button" class="ui-button ui-widget ui-corner-all" onclick="saveChartData();">Save</button>
  </form>
  <div id="chart-pref-dialog" title="Successful">
      <p>
          <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
          preferences updated successfully.
      </p>
  </div>
</div>
