<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Auto Report</title>
    <link rel="stylesheet" href="../../assets/vendors/normalize.css">
    <link rel="stylesheet" href="../../assets/custom/css/main.css">
    <link rel="stylesheet" href="../../assets/custom/css/autoreport.css?ver=dkasbd">
    <link rel="stylesheet" href="../../assets/vendors/font-awesome/css/font-awesome.min.css">
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
    <cfset VARIABLES.reportData = reportObject.generateReport(cid = "#cid#", rid = "#rid#") />
    <cfset companyObject = CreateObject("component","controller.companyController") />
		<cfset VARIABLES.analystData = companyObject.getAnalyst(cid = "#cid#") />
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
        <div class="header"><span>Expand</span>
        </div>
        <div class="content">
          <ul>
            <li>This is just some random content.</li>
            <li>This is just some random content.</li>
            <li>This is just some random content.</li>
            <li>This is just some random content.</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/autoreport.js?"></script>
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
						<h5>Old Highlights</h5>
					</div>
			</div>
			</cfform>
  </div>
  <script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/highlight.js?ver=1342ssss"></script>
</body>
</html>