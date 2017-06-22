<div class="header top-header">
          <p>Analitycal Overview</p><span class="pull-right">+</span>
        </div>
        <div class="content">
          <div class="header"><p>Analitycal Overview</p><span class="pull-right">+</span></div>
          <div class="content">
            <cfif overviewData.getResult().recordcount EQ 0>
              <textarea rows="5" class="analytical-text"></textarea>
            <cfelse>
              <textarea rows="5" class="analytical-text">
                <cfoutput>#overviewData.getResult().str_text#</cfoutput>
              </textarea>
            </cfif>
            <input id="uid" type="hidden" value="<cfoutput>#SESSION.id#</cfoutput>"/>
            <button id="add-analysis">save</button>
          </div>
          <div class="header"><p>Old Analytical Overview</p><span class="pull-right">+</span></div>
          <div class="content">
            <cfif previousData.getResult().recordcount EQ 0 >
              <p>No Data</p>
            <cfelse>
              <cfoutput>#previousData.getResult().str_text#</cfoutput>
            </cfif>
          </div>
        </div>