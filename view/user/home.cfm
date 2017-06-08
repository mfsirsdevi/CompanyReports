<html>
	<head>
		<link rel="stylesheet" href = "<cfoutput>#request.webRoot#</cfoutput>assets/custom/css/home.css?ver=sndfg">
		<link rel="stylesheet" href = "<cfoutput>#request.webRoot#</cfoutput>assets/custom/css/main.css?ver=nsdfg">
	</head>
	<body>
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
					<form class="selectAnalyst" name="frm_analyst" action="" method="post">
						<span class="spanAnalyst">Analyst</span> 
						<select class="dropdown" name="analyst"></select>
					</form>
				</div>
			</div>
			<div class="header-div row">
				<div class="header-title  col-6">
					Monitored Company Data
				</div>
				<div class="col-6">
					<form class="search-form" name="frm_search" action="" method="post">
						<span>Search</span>
						<input type="text" class="input" name="companyname" />
						<input type="submit" class="search-button" name="search" value="Go" />
					</form>
				</div>
			</div>
			<div class="row">
				<table class="table col-12">
					<thead class="thead">
						<tr class="table-row row">
							<td class="col-6">Company</td>
							<td class="col-2">I-Metrix Data<br id="BR_276" />Available</td>	
							<td class="col-1">Analyst</td>
							<td class="col-1">Status</td>	
							<td class="col-2">Auto Report Page</td>
						</tr>
					</thead>
				</table>
			</div>
<!--- How many pages should you link to at any one time? --->
<cfset intPagesToLinkTo = 5>
<!--- How many items are you displaying per page? --->
<cfset intItemsPerPage = 10>
<!--- How many items do you need to display, across all pages. --->
<cfset intNumberOfTotalItems = 500>
<!--- What is the current page you are on? --->
<cfif isdefined("url.page")>
  <cfset intCurrentPage = val(url.page)>
<cfelse>
  <cfset intCurrentPage = 1>
</cfif>
<!--- Find the closest numbers to intCurrentPage that is divisible by intPagesToLinkTo --->
<cfset intMaxLinkToShow = ceiling(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo>
<cfset intMinLinkToShow = (int(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo)+1>
<!--- Is intMaxLinkToShow equal to the unadjusted intMinLinkToShow value? If so, reset intMinLinkToShow to be where it should be. --->
<cfif intMaxLinkToShow eq (int(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo)>
  <cfset intMinLinkToShow = intMaxLinkToShow - (intPagesToLinkTo - 1)>
</cfif>
<!--- Is intMaxLinkToShow bigger than we need to shouw intNumberOfTotalItems?  If so, reset it. Use ceiling() to round it up. --->
<cfif intMaxLinkToShow gt intNumberOfTotalItems / intItemsPerPage>
  <cfset intMaxLinkToShow = ceiling(intNumberOfTotalItems / intItemsPerPage)>
</cfif>
<!--- Should I show the back button? --->
<cfif intMaxLinkToShow - intPagesToLinkTo LTE 0>
  <cfset boolShowBackButton = 0>
<cfelse>
  <cfset boolShowBackButton = 1>
</cfif>
<!--- Should I show the forward button? --->
<cfif ceiling(intNumberOfTotalItems / intItemsPerPage) lte intMaxLinkToShow>
  <cfset boolShowForwardButton = 0>
<cfelse>
  <cfset boolShowForwardButton = 1>
</cfif>
<!--- What items should I show on the page? --->
<cfset intMinItemsToShow = (intItemsPerPage * (intCurrentPage - 1))+ 1>
<cfset intMaxItemsToShow = intMinItemsToShow + intItemsPerPage - 1>
<!--- Have you reached the maximum number of items to show? --->
<cfif intMaxItemsToShow gt intNumberOfTotalItems>
  <cfset intMaxItemsToShow = intNumberOfTotalItems>
</cfif>


<!--- Display the results --->
<div>
<cfloop from="#variables.intMinItemsToShow#" to="#variables.intMaxItemsToShow#" index="i">
  <div style="float:left;font-weight:bold;margin:10px;padding:20px;border:1px solid black;">
    <cfoutput>#i#</cfoutput>
  </div>
</cfloop>
</div>
<!--- Display the pagination buttons --->
<div style="clear:both; margin-top:10px;">
  <!--- Show a "back button" that link to the smallest number page - 1 --->
  <cfif variables.boolShowBackButton>
    <div style="float:left;font-weight:bold;margin:5px;padding:5px;border:1px solid black;">
      <a href="?page=<cfoutput>#intMinLinkToShow-1#</cfoutput>">&lt;</a>
    </div>
  </cfif>
  <!--- Loop through and create links to intPagesToLinkTo pages --->
  <cfloop from="#variables.intMinLinkToShow#" to="#variables.intMaxLinkToShow#" index="i">
    <div style="float:left;font-weight:bold;margin:5px;padding:5px;border:1px solid black;">
      <cfoutput>
        <cfif intCurrentPage eq i>
          #i#
        <cfelse>
          <a href="?page=#i#">#i#</a>
        </cfif>
      </cfoutput>
    </div>
  </cfloop>
  <!--- Show a "forward button" that links to the largest number page + 1 --->
  <cfif variables.boolShowForwardButton>
    <div style="float:left;font-weight:bold;margin:5px;padding:5px;border:1px solid black;">
      <a href="?page=<cfoutput>#intMaxLinkToShow+1#</cfoutput>">&gt;</a>
    </div>
  </cfif>
</div>
<div style="clear:both;"></div>
</p>
		</div>
	</body>
</html>