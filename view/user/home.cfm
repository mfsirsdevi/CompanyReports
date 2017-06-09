<!DOCTYPE html>
<!--
* File: home.cfm
* Author: Satyapriya Baral
* Purpose: contains the view of the home page.
* Date: 06-06-2017
-->
<html>
	<head>
		<link rel="stylesheet" href = "<cfoutput>#request.webRoot#</cfoutput>assets/custom/css/home.css?ver=sksfg">
		<link rel="stylesheet" href = "<cfoutput>#request.webRoot#</cfoutput>assets/custom/css/main.css?ver=nsdfg">
	</head>
	<body>
		<cfif  SESSION.isLogged EQ "false">
			<cflocation url="#request.webRoot#view/login/login.cfm" addToken="false"></cflocation>
		</cfif>
		<cfset companyObject = CreateObject("component","controller.companyController") />
		<cfset VARIABLES.analystData = companyObject.analystDetails()>
		<cfif isdefined("url.search")>
  			<cfset searchcontent = url.search>
		<cfelse>
  			<cfset searchcontent = "">
		</cfif>
		<cfif isdefined("url.page")>
  			<cfset intCurrentPage = val(url.page)>
		<cfelse>
  			<cfset intCurrentPage = 1>
		</cfif>
		<cfif isdefined("url.analyst")>
  			<cfset analyst = val(url.analyst)>
		<cfelse>
  			<cfset analyst = 0>
		</cfif>
		<div id = "wrapper" class="grid">
			<div class="row">
				<div class="col-6">
					Hi <cfoutput>#SESSION.user#</cfoutput>
				</div>
				<div class="col-6">
					<a class="signout" href="http://www.companyreports.com/controller/userController.cfc?method=signoutUser">signout</a>
				</div>
			</div>
			<div class="row">
				<div class="title col-6">
					<h1><i class="fa fa-lock color-red" aria-hidden="true"></i>
      				<span class="color-blue">Public</span> <span class="color-red">Company</span> <span class="color-brown title-end">Report</span></h1>
				</div>
				<div class="col-6">
					<cfform id="myform" class="selectAnalyst" name="frm_analyst" action="" method="post">
						<span class="spanAnalyst">Analyst</span> 
						<cfselect id="analyst" class="dropdown" name="analyst">
							<cfif isdefined("url.analyst") && url.analyst NEQ 0>
								<option value="0"><cfoutput>#VARIABLES.analystData.getResult().str_analyst[url.analyst]#</cfoutput></option>
							</cfif>
							<option value="0">All</option>
							<cfloop from="1" to="#VARIABLES.analystData.getResult().recordcount#" index="i">
								<option value="<cfoutput>#VARIABLES.analystData.getResult().int_analystid[i]#</cfoutput>"><cfoutput>#VARIABLES.analystData.getResult().str_analyst[i]#</cfoutput></option>
							</cfloop>
						</cfselect>
							<button id="btnsbt" type="submit" name="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
					</cfform>
					<cfif IsDefined("form.analyst")>
						<cfset analyst = #form.analyst#>
						<cfset form.analyst = 0>
						<cflocation url="?page=1&search=#searchcontent#&analyst=#analyst#" addToken="false">
						<cfdump var = "#analyst#">	
					</cfif>
					<cfif StructKeyExists(form,"searchbtn")>
						<cfset VARIABLES.searchText = "#form.companyName#">
						<cflocation url="?page=1&search=#form.companyName#&analyst=#analyst#" addToken="false">
					</cfif>
				</div>
			</div>
			<div class="header-div row">
				<div class="header-title  col-6">
					Monitored Company Data
				</div>
				<div class="col-6">
					<cfform class="search-form" name="frm_search" action="" method="post">
						<span>Search</span>
						<cfinput type="text" class="input" value="#searchcontent#" name="companyName" />
						<button type="submit" class="search-button" name="searchbtn">Go</button>
					</cfform>
				</div>
			</div>
			<cfset VARIABLES.companyDetails = companyObject.companySearch(searchText = "#searchcontent#", selectAnalyst = "#analyst#")>
			<cfset intPagesToLinkTo = 3>
			<cfset intItemsPerPage = 2>
			<cfset intNumberOfTotalItems = VARIABLES.companyDetails.getResult().recordcount>
			<cfset intMaxLinkToShow = ceiling(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo>
			<cfset intMinLinkToShow = (int(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo)+1>
			<cfif intMaxLinkToShow eq (int(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo)>
  				<cfset intMinLinkToShow = intMaxLinkToShow - (intPagesToLinkTo - 1)>
			</cfif>
			<cfif intMaxLinkToShow gt intNumberOfTotalItems / intItemsPerPage>
  				<cfset intMaxLinkToShow = ceiling(intNumberOfTotalItems / intItemsPerPage)>
			</cfif>
			<cfif intMaxLinkToShow - intPagesToLinkTo LTE 0>
  				<cfset boolShowBackButton = 0>
			<cfelse>
  				<cfset boolShowBackButton = 1>
			</cfif>
			<cfif ceiling(intNumberOfTotalItems / intItemsPerPage) lte intMaxLinkToShow>
  				<cfset boolShowForwardButton = 0>
			<cfelse>
  				<cfset boolShowForwardButton = 1>
			</cfif>
			<cfset intMinItemsToShow = (intItemsPerPage * (intCurrentPage - 1))+ 1>
			<cfset intMaxItemsToShow = intMinItemsToShow + intItemsPerPage - 1>
			<cfif intMaxItemsToShow gt intNumberOfTotalItems>
  				<cfset intMaxItemsToShow = intNumberOfTotalItems>
			</cfif>
			<cfset VARIABLES.companyDetailsPage = companyObject.companyPerPage(start = "#variables.intMinItemsToShow#", end = "#variables.intMaxItemsToShow#", search = "#searchcontent#", selectAnalyst = "#analyst#")>
			<div class="row">
				<table class="table col-12">
					<thead class="thead">
						<tr class="table-row row">
							<td class="col-5">Company</td>
							<td class="col-2">I-Metrix Data<br id="BR_276" />Available</td>	
							<td class="col-2">Analyst</td>
							<td class="col-1">Status</td>	
							<td class="col-2">Auto Report Page</td>
						</tr>
					</thead>
					<tbody>
						<cfloop from="1" to="#VARIABLES.companyDetailsPage.getResult().recordcount#" index="i">
							<cfset VARIABLES.reportDetails = companyObject.getReportId(companyId = VARIABLES.companyDetailsPage.getResult().int_companyId[i])>						
							<tr class="table-row row">
								<td class="table-def col-5"><cfoutput>#VARIABLES.companyDetailsPage.getResult().str_companyname[i]#</cfoutput></td>
								<td class="table-def col-2"></td>
								<td class="table-def col-2"><cfoutput>#VARIABLES.companyDetailsPage.getResult().str_analyst[i]#</cfoutput></td>
								<td class="table-def col-1"></td>
								<td class="table-def col-1">
									<cfloop from="1" to="#VARIABLES.reportDetails.getResult().recordcount#" index="j">
										<a href="www.companyreports.com/view/user/autoreport.cfm?cId=<cfoutput>#VARIABLES.reportDetails.getResult().int_companyid[j]#</cfoutput>&rId=<cfoutput>#VARIABLES.reportDetails.getResult().int_reportid[j]#</cfoutput>">Report</a>
									</cfloop>
								</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</div>
  			<cfif variables.boolShowBackButton>
    			<div style="float:left;font-weight:bold;margin:5px;padding:5px;border:1px solid black;">
      				<a href="?page=<cfoutput>#intMinLinkToShow-1#</cfoutput>">&lt;</a>
    			</div>
  			</cfif>
  			<cfloop from="#variables.intMinLinkToShow#" to="#variables.intMaxLinkToShow#" index="i">
    			<div style="float:left;font-weight:bold;margin:5px;padding:5px;border:1px solid black;">
      				<cfoutput>
        			<cfif intCurrentPage eq i>
          				#i#
        			<cfelse>
          				<a href="?page=#i#&search=#VARIABLES.searchcontent#">#i#</a>
        			</cfif>
      				</cfoutput>
    			</div>
  			</cfloop>
  			<cfif variables.boolShowForwardButton>
    			<div style="float:left;font-weight:bold;margin:5px;padding:5px;border:1px solid black;">
      				<a href="?page=<cfoutput>#intMaxLinkToShow+1#</cfoutput>">&gt;</a>
    			</div>
  			</cfif>
		</div>
		<div style="clear:both;"></div>
		</p>
		</div>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/home.js?ver=1342ssss"></script>
	</body>
</html>