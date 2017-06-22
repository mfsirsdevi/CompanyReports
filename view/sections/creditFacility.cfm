<!--
* File: creditFacility.cfm
* Author: Satyapriya Baral
* Purpose: contains the view for credit facility section.
* Date: 18-06-2017
-->   
<!---<cfloop from="1" to="#VARIABLES.highlightData.recordcount#" index="i">
                  <div id="item_<cfoutput>#VARIABLES.highlightData.int_highlight_sec_id[i]    #</cfoutput>">
                    <h5 class="subjectStyle"><cfoutput>#VARIABLES.highlightData.str_subject[i]#</cfoutput></h5>
                    <hr class="hr-color">
                    <div class="bodyStyle"><cfoutput>#VARIABLES.highlightData.str_text[i]#</cfoutput>
                      <span class="deleteSymbol">&#x2716;</span>
                    </div>                 
                  </div>
                            </cfloop>--->
<div class="header top-header"><p>Revolving Credit Facility</p><span class="pull-right">+</span></div>
    <div class="content revolvingCreditFacility">
    <cfset VARIABLES.creditFacilityData = companyObject.getCreditFacilityData(cid = "#cid#") />
    <cfdump var="#creditFacilityData#">
        <cfloop from="1" to="#VARIABLES.creditFacilityData.recordcount#" index="i">
            <div class="creditFacilityDataSection" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>" report_id="">
                <div class="creditFacilityHeader creditFacilityHeaderStyle" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Credit Facility </div>
                <div class="" id="creditFieldsSection" style="margin-bottom: 2%;margin-top: 2%;">
                    <cfset VARIABLES.sortDetails = companyObject.getSortDetails(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                    <cfdump var="#sortDetails#">
                    <cfset VARIABLES.columnDetails = companyObject.getColumnDetails() />
                    <cfdump var="#columnDetails#">
                    <div class="creditFieldDisplay" id="credit_field_4_view" field_id="4" style="display:block">
                        <span class="credit_field bold">Original Facility Date :</span>  <span class="credit_field credit_field_view_text"></span>
                    </div>
                    <div class="edit_credit_div">
                        <button type="button" class="creditButtonStyle" id="editCreditFacility" report_id="26521" rcf_id="">Edit Credit Facility</button>
                        <button type="button" class="creditButtonStyle" rcf_id="">Customise Layout</button>
                    </div>       
                </div>
            </div>
        </cfloop>
    <!---On click of this button modal will pop up for adding credit facility--->
    <button type="button" class="creditButtonStyle" id="addCreditLayout">Add New Credit Facility</button>
    <div id="newCreditFacilityDialog" style="display:none";">
        <form id="newCreditFacilityForm">
            <fieldset class="creditHeaderFieldset">
                <!---input field for getting the company Id--->
                <input type="hidden" name="companyID" value="<cfoutput>#cid#</cfoutput>">
                <!---Adding Other Lenders Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Other Lenders</div>
                    <div class="leftFieldsStyleValue">
                        <div class="otherLendersFields">
                        </div>
                        <div>
                            <button type="button" class="addOtherLenders creditButtonStyle" rcf_id="0"> Add Other Lenders</button>
                        </div> 
                    </div>
                </div>
                <!---Adding Original Facility Date Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Original Facility Date</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input type="date" name="originalFacilityDate" value="">
                        </div>
                    </div>
                </div>
                <!---Adding Amendment Date Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Amendment Date</div>
                    <div class="leftFieldsStyleValue">
                        <div class="amendmentEditFields">
                        </div>
                        <div>
                            <button type="button" class="addAmendmentDate creditButtonStyle" rcf_id="0"> Add Amendment Date </button>
                        </div>
                    </div>
                </div>
                <!---Adding Maturity Date Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Maturity Date</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input type="date" name="maturityDate" value="">
                        </div>
                    </div>
                </div>
                <!---Adding Letter of credit sublimit section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Letter of Credit Sublimit</div>
                    <div class="leftFieldsStyleValue">
                        <input class="numeric_field" type=number step=any id="testValue" name="letterOfCreditSublimit" value="">&nbsp; Value
                        <select name="letterOfCreditSublimitCurrencyId">
                            <option value="0">--Select--</option>                    
                            <option value="2">Euro</option>                     
                            <option value="1" selected="">U.S. Dollar</option>
                        </select>
                    </div>
                </div>
                <!---Adding Availability Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability Comment</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="availabilityComment" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Maximum Borrowing Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Maximum Borrowings</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input class="numeric_field" type="text" name="maximumBorrowings" value="">
                            &nbsp;Value
                            <select name="maximumBorrowingsCurrencyId">
                                <option value="0">--Select--</option>
                                <option value="2">Euro</option>  
                                <option value="1" selected="">U.S. Dollar</option>
                            </select>
                        </div>
                    </div>
                </div>
                <!---Adding Availability Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input class="numeric_field" type=number step=any name="availability" value="">
                            &nbsp;Value
                            <select name="availabilityCurrencyId">
                                <option value="0">--Select--</option>
                                <option value="2">Euro</option>
                                <option value="1" selected="">U.S. Dollar</option>
                            </select>
                        </div> 
                    </div>
                </div>
                <!---Adding Interest Rate Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Interest Rate</div>
                    <div class="leftFieldsStyleValue">
                        <select name="interestRateType">
                            <option value="">Select</option>
                            <option value="LIBOR Rate">LIBOR Rate</option>
                            <option value="Prime Rate">Prime Rate</option>
                        </select>+
                        <select class="interestRateSelect" name="interestRate">
                            <option value="">Select</option>
                            <option value="range">Interest Rate Range</option>
                            <option value="value">Interest Rate</option>
                        </select>
                        <!---These fields are hidden until a specific interest rate type is selected--->
                        <!---This span shows when range type is selected--->
                        <span id="interestRateRange" style="display:none">
                            Low <input class="numericField" type=number step=any name="interestRateLow" value="" style="width:10%">
                            High <input class="numericField" type=number step=any name="interestRateHigh" value="" style="width:10%">
                        </span>
                        <!---This span shows when value type is selected--->
                        <span id="interestRateValue" style="display:none">
                            Interest Rate <input class="numericField" type=number step=any name="interestRate" value="" style="width:10%">
                        </span>
                        <div class="interestRateText" style="margin-left:50%">Enter as whole number in percentage form. Example: 150 Basis Points – enter as "1.50"</div>
                    </div>
                </div>
                <!---Adding Imterest Rate Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Interest Rate Comment</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="interestComment" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Security Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Security</div>
                    <div class="leftFieldsStyleValue">
                        <select name="security">
                            <option value="">Select</option>
                            <option value="secured">Secured</option>
                            <option value="unsecured">Unsecured</option>
                        </select>
                    </div>
                </div>
                <!---Adding Security Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Security Comment</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="securityComment" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Agent Bank Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Agent Bank</div>
                    <div class="leftFieldsStyleValue">
                        <div class="agentBankFields">
                        </div>
                        <div>
                            <button type="button" class="addAgentBank creditButtonStyle" rcf_id="0"> Add Agent Bank </button>
                        </div>
                    </div>
                </div>
                <!---Adding Borrowing Base Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Borrowing Base</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="borrowingBase" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Credit Facility Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Credit Facility Comments</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="creditFacilityComment" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Financial Covenants Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Financial Covenants - Database</div>
                    <div class="leftFieldsStyleValue">
                        <div class="simultaneousFields">
                        </div>
                        <div>
                            <button type="button" class="addSimultaneous creditButtonStyle" rcf_id="0"> Add Simultaneous Financial Covenants </button>
                        </div>
                    </div>
                </div>
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Financial Covenants - text</div>
                    <div class="leftFieldsStyleValue"> 
                        <div class="financialFields">
                        </div>
                        <div>
                            <button type="button" class="addFinancial creditButtonStyle" rcf_id="0"> Add Financial Covenants </button>
                        </div>
                    </div>
                </div>
                <!---Adding Availability Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability (as of) Date</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input type="date" name="availabilityDate" value="">
                        </div>
                    </div>
                </div>
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability Date Type</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <select name="availabilityDateType">
                                <option value="">--Select--</option>
                                <option value="1Q">1Q</option>
                                <option value="2Q">2Q</option>
                                <option value="3Q">3Q</option>
                                <option value="FYE">FYE</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability NON-QUARTER-END (as of) Period Duration</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <select name="availabilityNonQuarterEndPeriodDuration">
                                <option value="">--Select--</option>
                                <option value="1Q">1Q</option>
                                <option value="2Q">2Q</option>
                                <option value="3Q">3Q</option>
                                <option value="FYE">FYE</option>
                            </select>
                        </div>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</div>