<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Auto Report</title>
    <link rel="stylesheet" href="../../assets/vendors/normalize.css">
    <link rel="stylesheet" href="../../assets/custom/css/main.css">
    <link rel="stylesheet" href="../../assets/custom/css/autoreport.css?ver=dkavvssdbd">
    <link rel="stylesheet" href="../../assets/vendors/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../../assets/custom/css/creditFacility.css?ver=sdhs">
    <link rel="stylesheet" href="../../assets/custom/css/autoReport/interestCoverage.css">
    <link rel="stylesheet" href="../../assets/template/js/jQuery-ui/jquery-ui.theme.css">
    <link rel="stylesheet" href="../../assets/template/js/jQuery-ui/jquery-ui.css">
    <!--- <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script> --->
  </head>
<body>
  <cfif  SESSION.isLogged EQ "false">
    <cflocation url="#request.webRoot#view/login/login.cfm" addToken="false"></cflocation>
  </cfif>

  <div id="wrapper" class="grid">
<div class="loader"></div>
    <cfif IsDefined('url.cid') && IsDefined('url.rid')>
      <cfset cid = val(url.cid) />
      <cfset rid = val(url.rid) />

    <cfelse>
      <cflocation url="#request.webRoot#view/errorPage.cfm">
    </cfif>

    <cfset reportObject = CreateObject("component","controller.reportController") />
    <cfset modelObject = CreateObject("component","model.reportModel") />
    <cfset VARIABLES.reportData = reportObject.generateReport(cid = "#cid#", rid = "#rid#") />
    <cfset companyObject = CreateObject("component","controller.companyController") />
    <cfset VARIABLES.analystData  = companyObject.getAnalyst(cid = "#cid#") />
    <cfset VARIABLES.highlightData= reportObject.getHighlightData(rid = "#rid#") />
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
        <span class="color-blue">Public</span> <span class="color-red">Company</span> <span class="color-brown title-end">Report</span>
      </h1>
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
            <p><span class="color-blue">Phone: </span>
          <cfif IsSimpleValue(analystData)>
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
    <div id="all_sections">
    <div class="row">
      <div class="col-12">
        <div class="header top-header section_header" data-section-name="AnalyticsHeader">
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
            <button id="add-analysis" class="section_global" data-section-name="credit analysis">save</button>
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
      </div>
    </div>
    <!---Highlight Section--->
      <div class="header highlightHeader auto_report_section" section_name="Highlight"><p>Highights</p><span class="pull-right">+</span></div>
      <div class="content-inside" id="highlight_section">
        <cfform id="saveHighlightForm">
			    <div class="HighlightDiv">
					  <button class="save-btn section_global" type="button" id="saveHighlight" name="savebtn" data-section-name="highlight section">Save</button>
					  <div class="subjectHeader">
					    <h5 class="Highlight">Highlight Subject</h5>
					    <cfinput class="HighlightSubject" id="subject" type="text" name="Subject" />
              <cfinput id="recordId" type="hidden" name="recordId" value="#rid#" />
					  </div>
					  <h5 class="Highlight">Highlight Body</h5>
            <div class="tinyMceStyle">
              <textarea rows="20" class="highlight-text"></textarea>
            </div>
            <h5 class="Highlight">Highlight Index Tags:(separate words with commas)</h5>    
             <cfinput class="HighlightSubject" id="tag" type="text" name="highlightTag" />   
          </div>
					<div class="old">
            <fieldset>
						  <legend><h5 class="oldHeading">Old Highlights</h5></legend>
              <div id="highlightData">
                <cfloop from="1" to="#VARIABLES.highlightData.recordcount#" index="i">
                  <div id="item_<cfoutput>#VARIABLES.highlightData.int_highlight_sec_id[i]#</cfoutput>">
                    <h5 class="subjectStyle"><cfoutput>#VARIABLES.highlightData.str_subject[i]#</cfoutput></h5>
                    <hr class="hr-color">
                    <div class="bodyStyle"><cfoutput>#VARIABLES.highlightData.str_text[i]#</cfoutput>
                      <span class="deleteSymbol">&#x2716;</span>
                    </div>
                  </div>
						    </cfloop>
              </div>
            </fieldset>
					</div>
		    </cfform>
      </div>
    <cfinclude template="../sections/creditFacility.cfm">
    <div class="row">
      <div class="col-12">
        <cfinclude template="../sections/InterestCoverageSection.cfm" />
      </div>
    </div>
  <button type="button" onclick="globalSave();" >Save All Sections</button>
    
  </div>
  </div>

  <script src="../../assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
  <script src="../../assets/custom/js/globalSaveModule.js"></script>
  <script src="../../assets/custom/js/creditFacility.js?ver=asdfadsf"></script>
  <script src="../../assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
  <script src="../../assets/template/js/jQuery-ui/jquery-ui.js"></script>
  <script src="../../assets/template/js/jquery-validation-1.16.0/dist/jquery.validate.js"></script>
  <script src="../../assets/custom/js/autoreport.js?"></script>
	<script src="../../assets/custom/js/highlight.js"></script>
  <script src="../../assets/custom/js/globalSaveModule.js"></script>
  <script src="../../assets/custom/js/creditFacility.js?"></script>
  <script src="../../assets/template/plugins/tinymce/js/tinymce/tinymce.min.js"></script>
  
  <!--Load the AJAX Google Chart API-->
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript" src="../../assets/custom/js/autoChart.js"></script>

</body>
</html>
