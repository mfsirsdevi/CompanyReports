<input type="hidden" value="<cfoutput>#URL.rid#</cfoutput>" id="report_id">  <!--- uesd for getting in javascript --->
<input type="hidden" value="<cfoutput>#URL.cid#</cfoutput>" id="company_id">  <!--- uesd for getting in javascript --->

<div class="header top-header auto_report_section" section_name="Interest Coverage">
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
  <!--- save chart preferences --->
  <button type="button" class="ui-button" onclick="saveChartData();">Save</button>
  
  <!--- save cart data successful dialog --->
  <div id="chart-pref-dialog" title="Successful">
      <p><span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
          preferences updated successfully.</p>
  </div>

  <!--- customize min, max, interval --->
  <button type="button" class="ui-button" onclick="showOptions();">Customize</button>

  <!--- Chart customization Dialog --->
  <div id="chart-customization-dialog">
    <form id="chart-customization-form" onsubmit="return false;">
      <label>
        <span>Minimum</span>
        <input type="number" id="v-min" name="v-min" value="" class="ui-widget ui-widget-content ui-corner-all" required>
      </label>
      <label>
        <span>Maximum</span>
        <input type="number" id="v-max" name="v-max" value="" class="ui-widget ui-widget-content ui-corner-all" required >
      </label>
      <label>
        <span>Interval</span>
        <input type="number" id="v-interval" name="v-interval" value="" class="ui-widget ui-widget-content ui-corner-all" required>
      </label>
      <input type="submit" style="display:none;">
    </form>
  </div>
</div>
