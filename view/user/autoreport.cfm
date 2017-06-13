<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Auto Report</title>
    <link rel="stylesheet" href="../../assets/vendors/normalize.css">
    <link rel="stylesheet" href="../../assets/custom/css/main.css">
    <link rel="stylesheet" href="../../assets/custom/css/autoreport.css?ver=dkasbd">
    <link rel="stylesheet" href="../../assets/vendors/font-awesome/css/font-awesome.min.css">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
  </head>
<body>
  <cfif  SESSION.isLogged EQ "false">
			<cflocation url="#request.webRoot#view/login/login.cfm" addToken="false"></cflocation>
	</cfif>
  <div id="wrapper" class="grid">
    <cfif IsDefined(url.cid) && IsDefined(url.rid)>
    <cfset cid = val(url.cid) />
    <cfset rid = val(url.rid) />
    </cfif>
    <cfset reportObject = CreateObject("component","controller.reportController") />
    <cfset modelObject = CreateObject("component","model.reportModel") />
    <cfset VARIABLES.reportData = reportObject.generateReport(cid = "#cid#", rid = "#rid#") />
    <cfset companyObject = CreateObject("component","controller.companyController") />
		<cfset VARIABLES.analystData = companyObject.getAnalyst(cid = "#cid#") />
    <cfset VARIABLES.highlightData = reportObject.getHighlightData(rid = "#rid#") />
    <cfset VARIABLES.overviewData = modelObject.hasQuarterlyOverview(id = "#rid#")/>
    <cfset VARIABLES.previousData = modelObject.hasPreviousOverview(id = "#rid#")/>
    <div class="row">
				<div class="col-6">
					Hi <cfoutput>#SESSION.user#</cfoutput>
				</div>
				<div class="col-6">
					<a class="signout" href="http://www.companyreports.com/controller/userController.cfc?method=signoutUser">signout</a>
				</div>
			</div>
    <div class="row">
      <h1 class="title"><i class="fa fa-lock color-red" aria-hidden="true"></i>
      <span class="color-blue">Public</span> <span class="color-red">Company</span> <span class="color-brown title-end">Report</span></h1>
    </div>
    <div class="row">
      <h2 class="color-blue company-name"><cfoutput>#reportData.str_title#</cfoutput></h2>
    </div>
    <div class="row">
      <div class="col-6">
        <strong>
	        <p ><span class="color-blue">Analyst:</span> <span class="name">
          <cfif IsSimpleValue(analystData)>
          <cfoutput>No Analyst</cfoutput>
          <cfelse>
          <cfoutput>#analystData.str_analyst#</cfoutput>
          </cfif>
          </span></p>
	        <p><span class="color-blue">Phone: </span><cfif IsSimpleValue(analystData)>
          <cfoutput>No Number</cfoutput>
          <cfelse>
          <cfoutput>#analystData.str_phone#</cfoutput>
          </cfif>
          </p>
	        <p>Report Period: <span class="color-red"><cfoutput>#reportData.str_summary#</cfoutput></span></p>
        </strong>
      </div>
      <div class="col-6 logo">
        <h2>Walmart</h2>
      </div>
    </div>
    <hr class="color-blue">
    <div class="row">
      <div class="col-9 display-panel">
        <div class="row">
          <p class="col-12 detail-heading"><strong>Retailer View</strong></p>
        </div>
        <div class="row">
          <p><span class="color-red"><strong>Credit Score:</strong></span> <span class="score"><strong><cfoutput>#reportData.str_creditscore#</cfoutput></strong></span></p>
        </div>
        <div class="row">
          <div class="col-4">

            <p class="color-red"><strong>General Information</strong></p>
            <p><cfoutput>#reportData.str_address#</cfoutput></p>
            <p><span class="color-red"><strong>Phone:</strong></span> <cfoutput>#reportData.str_phone#</cfoutput></p>

          </div>
          <div class="col-8">

            <p class="color-red"><strong>Key Personnel</strong></p>
            <p><strong>CEO</strong> <cfoutput>#reportData.str_ceo#</cfoutput></p>
            <p><strong>CFO</strong> <cfoutput>#reportData.str_cfo#</cfoutput></p>
            <p><strong>Auditor</strong> Ernst & Young LLP</p>

          </div>
        </div>
        <div class="row company-url">
          <a href="#"><cfoutput>#reportData.str_url#</cfoutput></a>
        </div>
      </div>
      <div class="col-3 right-col display-panel">
        <div class="row">
          <div class="col-10"><p class="detail-heading">Credit Rating Chart</p></div>
          <div class="col-2"><p class="rating"><cfoutput>#reportData.str_creditscore#</cfoutput></p></div>
        </div>
      </div>
      
    </div>
    <hr class="color-blue">
    <div class="row">
      <div class="col-12">
        <div class="header top-header"><p>Analitycal Overview</p><span class="pull-right">+</span>
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
              <cfoutput>#overviewData.getResult().str_text#</cfoutput>
            </cfif>
          </div>
        </div>
      </div>
    </div>
  
    	<cfform>
			<div class="HighlightDiv">
					 <button class="save-btn" type="button" id="saveHighlight" name="savebtn">Save</button>
					<div class="subjectHeader">
					<h5 class="Highlight">Highlight Subject</h5>
					<cfinput class="HighlightSubject" id="subject" type="text" name="highlightText" />
					</div>
					<h5 class="Highlight">Highlight Body</h5>
          	<cfinput class="HighlightSubject" id="body" type="text" name="highlightBody" />
            <cfinput id="recordId" type="hidden" name="recordId" value="#rid#"/>
					<h5 class="Highlight">Highlight Index Tags:(separate words with commas)</h5>
					<cfinput class="HighlightSubject" id="tag" type="text" name="highlightTag" />
					<div class="old">
						<h5>Old Highlights</h5><hr>
            <div id="highlightData">
              <cfloop from="1" to="#VARIABLES.highlightData.getResult().recordcount#" index="i">
                <div id="item_<cfoutput>#highlightData.getResult().int_highlight_sec_id[i]#</cfoutput>">
                <cfoutput>#highlightData.getResult().str_subject[i]#</cfoutput><hr>
                <cfoutput>#highlightData.getResult().str_text[i]#</cfoutput><hr><hr>
                </div>
						  </cfloop>
            </div>
					</div>
			</div>
			</cfform>
  </div>
  </div>
  <script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/autoreport.js?"></script>
  <script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
   <script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/js/jQuery-ui/jquery-ui.js"></script>
	<script src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/highlight.js?ver=1342ssss"></script>
</body>
</html>