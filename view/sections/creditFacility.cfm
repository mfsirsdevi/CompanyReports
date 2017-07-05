<!--
* File: creditFacility.cfm
* Author: Satyapriya Baral
* Purpose: contains the view for credit facility section.
* Date: 18-06-2017
-->   
<div class="header top-header auto_report_section" section_name="Revolving Credit Facility"><p>Revolving Credit Facility</p><span class="pull-right">+</span></div>
    <div class="content revolvingCreditFacility">
    <cfset VARIABLES.creditFacilityData = companyObject.getCreditFacilityData(cid = "#cid#") />
    <cfset VARIABLES.columnDetails = companyObject.getColumnDetails() />
    <div id="headerData">
        <!--- loop for getting all credit facility records --->
        <cfloop from="1" to="#VARIABLES.creditFacilityData.recordcount#" index="i">
            <div class="creditFacilityDataSection" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">
                 <!--- Credit Facility Record Header --->
                <div class="creditFacilityHeader creditFacilityHeaderStyle" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Credit Facility #<cfoutput>#i#</cfoutput></div>
                <div class="creditFieldsSection field_<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>" id="creditFieldsSectionId" recordNo="<cfoutput>#i#</cfoutput>">
                    <!--- Getting record of sort details for displaying in sorting order --->
                    <cfset VARIABLES.sortDetails = companyObject.getSortDetails(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                    <!--- Looping through the records according to the sort details --->
                    <cfloop from="1" to="#VARIABLES.sortDetails.recordcount#" index="j">
                        <cfset VARIABLES.facilityColumnName = VARIABLES.columnDetails.str_credit_facility_columns[#VARIABLES.sortDetails.int_cf_id[j]#]/>
                        <cfset VARIABLES.columnName = VARIABLES.columnDetails.str_column_names[#VARIABLES..sortDetails.int_cf_id[j]#]/>
                        <!--- Show and hide the records according to re required details --->
                        <cfif VARIABLES.facilityColumnName EQ "availability_comment" || VARIABLES.facilityColumnName EQ "interest_rate_comment" || VARIABLES.facilityColumnName EQ "security_comment" || VARIABLES.facilityColumnName EQ "comments">
                            <cfif VARIABLES.sortDetails.int_cf_costomize_sort_id[j] EQ 1>
                                <div class="creditFieldsBig" id="column_<cfoutput>#VARIABLES.sortDetails.int_sort_credit_id[j]#</cfoutput>" style="display: block;">
                            <cfelse>
                                <div class="creditFieldsBig" id="column_<cfoutput>#VARIABLES.sortDetails.int_sort_credit_id[j]#</cfoutput>" style="display:none;">
                            </cfif>
                        <cfelse>
                            <cfif VARIABLES.sortDetails.int_cf_costomize_sort_id[j] EQ 1>
                                <div class="creditFields" id="column_<cfoutput>#VARIABLES.sortDetails.int_sort_credit_id[j]#</cfoutput>" style="display: block;">
                            <cfelse>
                                <div class="creditFields" id="column_<cfoutput>#VARIABLES.sortDetails.int_sort_credit_id[j]#</cfoutput>" style="display:none;">
                            </cfif>
                        </cfif>
                        <div class="creditFieldSubject">
                            <span class="creditField bold"><cfoutput>#VARIABLES.columnName#</cfoutput> :</span>
                            <span class="creditFieldValue">
                                <!--- Getting the records of different table acording to the record id --->
                                <cfset VARIABLES.multiColumnDetails = companyObject.getMultiColumnDetails(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                                <cfif VARIABLES.facilityColumnName EQ "date_amendment">
                                    <cfloop from="1" to="#VARIABLES.multiColumnDetails.amendment.recordcount#" index="k">
                                        <cfoutput>#DateTimeFormat(VARIABLES.multiColumnDetails.amendment.date_amendment[k], "yyyy.MM.dd")#</cfoutput>,
                                    </cfloop>
                                <cfelseif VARIABLES.facilityColumnName EQ "str_lenders">
                                    <cfloop from="1" to="#VARIABLES.multiColumnDetails.lenders.recordcount#" index="k">
                                        <cfoutput>#VARIABLES.multiColumnDetails.lenders.str_lenders[k]#</cfoutput>,
                                    </cfloop>
                                <cfelseif VARIABLES.facilityColumnName EQ "str_agent_bank">
                                    <cfloop from="1" to="#VARIABLES.multiColumnDetails.agentBank.recordcount#" index="k"> 
                                        <cfoutput>#VARIABLES.multiColumnDetails.agentBank.str_agent_bank[k]#</cfoutput>,
                                    </cfloop>
                                <cfelseif VARIABLES.facilityColumnName EQ "str_convenants">
                                    <cfloop from="1" to="#VARIABLES.multiColumnDetails.convenants.recordcount#" index="k">
                                        <cfoutput>#VARIABLES.multiColumnDetails.convenants.str_convenants[k]#</cfoutput>,
                                    </cfloop>
                                <cfelseif VARIABLES.facilityColumnName EQ "str_financial_convenants_data">
                                    <cfloop from="1" to="#VARIABLES.multiColumnDetails.financialConvenants.recordcount#" index="k">
                                        <cfoutput>#VARIABLES.multiColumnDetails.financialConvenants.str_financial_convenants_data[k]#</cfoutput>,
                                    </cfloop>
                                <cfelse>
                                    <cfset value = VARIABLES.creditFacilityData[#VARIABLES.facilityColumnName#][i]>
                                    <cfoutput>#value#</cfoutput>
                                </cfif>
                            </span>
                        </div>
                        </div>
                    </cfloop> 
                    <div class="editCredit">
                        <!---On click of this button modal will pop up for editing the records --->
                        <button type="button" class="creditButtonStyle editCreditFacility" id="editCreditFacility" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Edit Credit Facility</button>
                        <!---On click of this button modal will pop up for hide ans show elements in the records --->
                        <button type="button" class="creditButtonStyle customLayout" id="customLayout" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Customise Layout</button>
                    </div>     
                </div>

            </div>
        </cfloop>
    </div>
    <!---On click of this button modal will pop up for adding credit facility--->
    <div class="editCredit" id="editCredit">
        <button type="button" class="creditButtonStyle" id="addCreditLayout">Add New Credit Facility</button>
    </div>
    <div id="newCreditFacilityDialog" class="newCreditFacilityDialog" style="display:none;">
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
                            <input type="date"  name="maturityDate" value="">
                        </div>
                    </div>
                </div>
                <!---Adding Letter of credit sublimit section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Letter of Credit Sublimit</div>
                    <div class="leftFieldsStyleValue">
                        <input class="numeric_field" type=number step=any name="letterOfCreditSublimit" value="">&nbsp; Value
                        <select name="letterOfCreditSublimitCurrencyId">
                            <option value="">--Select--</option>                    
                            <option value="2">Euro</option>                     
                            <option value="1">U.S. Dollar</option>
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
                            <input class="numeric_field" type=number step=any name="maximumBorrowings">
                            &nbsp;Value
                            <select name="maximumBorrowingsCurrencyId">
                                <option value="">--Select--</option>
                                <option value="2">Euro</option>  
                                <option value="1">U.S. Dollar</option>
                            </select>
                        </div>
                    </div>
                </div>
                <!---Adding Availability Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input class="numeric_field" type=number step=any name="availability">
                            &nbsp;Value
                            <select name="availabilityCurrencyId">
                                <option value="">--Select--</option>
                                <option value="2">Euro</option>
                                <option value="1">U.S. Dollar</option>
                            </select>
                        </div> 
                    </div>
                </div>
                <!---Adding Interest Rate Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Interest Rate</div>
                    <div class="leftFieldsStyleValue">
                        <select name="interestRateType" >
                            <option value="">Select</option>
                            <option value="LIBOR Rate">LIBOR Rate</option>
                            <option value="Prime Rate">Prime Rate</option>
                        </select>+
                        <select class="interestRateSelect" name="interestRate" >
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
                            <button type="button" class="addSimultaneous creditButtonStyle"> Add Simultaneous Financial Covenants </button>
                        </div>
                    </div>
                </div>
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Financial Covenants - text</div>
                    <div class="leftFieldsStyleValue"> 
                        <div class="financialFields">
                        </div>
                        <div>
                            <button type="button" class="addFinancial creditButtonStyle"> Add Financial Covenants </button>
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
     <div id="editCreditFacilityDialog" class="editCreditFacilityDialog" style="display:none;">
        <form id="editCreditFacilityForm">
            <fieldset class="creditHeaderFieldset">
                <!---input field for getting the company Id--->
                <input type="hidden" name="companyID" value="<cfoutput>#cid#</cfoutput>">
                <!---Adding Other Lenders Section--->
                <div class="rcfidData">
                </div>
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
                            <input type="date" name="originalFacilityDate" id="original_facility_date">
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
                            <input type="date"  name="maturityDate" id="maturity_date">
                        </div>
                    </div>
                </div>
                <!---Adding Letter of credit sublimit section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Letter of Credit Sublimit</div>
                    <div class="leftFieldsStyleValue">
                        <input class="numeric_field" type=number step=any name="letterOfCreditSublimit" id="letter_of_credit_sublimit">&nbsp; Value
                        <select name="letterOfCreditSublimitCurrencyId" id="letter_of_credit_sublimit_currency_id">
                            <option value="">--Select--</option>                    
                            <option value="1">Euro</option>                     
                            <option value="2">U.S. Dollar</option>
                        </select>
                    </div>
                </div>
                <!---Adding Availability Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability Comment</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="availability_comment" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Maximum Borrowing Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Maximum Borrowings</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input class="numeric_field" type=number step=any name="maximumBorrowings" id="maximum_borrowings">
                            &nbsp;Value
                            <select name="maximumBorrowingsCurrencyId" id="maximum_borrowings_currency_id">
                                <option value="">--Select--</option>
                                <option value="1">Euro</option>  
                                <option value="2">U.S. Dollar</option>
                            </select>
                        </div>
                    </div>
                </div>
                <!---Adding Availability Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input class="numeric_field" type=number step=any name="availability" id="Availbility">
                            &nbsp;Value
                            <select name="availabilityCurrencyId" id="availability_currency_id">
                                <option value="">--Select--</option>
                                <option value="1">Euro</option>
                                <option value="2">U.S. Dollar</option>
                            </select>
                        </div> 
                    </div>
                </div>
                <!---Adding Interest Rate Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Interest Rate</div>
                    <div class="leftFieldsStyleValue">
                        <select name="interestRateType" id="interest_rate_type">
                            <option value="">Select</option>
                            <option value="LIBOR Rate">LIBOR Rate</option>
                            <option value="Prime Rate">Prime Rate</option>
                        </select>+
                        <select class="interestRateSelect" name="interestRate" id="interest_rate_mode">
                            <option value="">Select</option>
                            <option value="range">Interest Rate Range</option>
                            <option value="value">Interest Rate</option>
                        </select>
                        <!---These fields are hidden until a specific interest rate type is selected--->
                        <!---This span shows when range type is selected--->
                        <span id="interestRateRange" style="display:none">
                            Low <input class="numericField" type=number step=any name="interestRateLow" id="interest_rate_low" style="width:10%">
                            High <input class="numericField" type=number step=any name="interestRateHigh" id="interest_rate_high" style="width:10%">
                        </span>
                        <!---This span shows when value type is selected--->
                        <span id="interestRateValue" style="display:none">
                            Interest Rate <input class="numericField" type=number step=any name="interestRate" id="interest_rate" style="width:10%">
                        </span>
                        <div class="interestRateText" style="margin-left:50%">Enter as whole number in percentage form. Example: 150 Basis Points – enter as "1.50"</div>
                    </div>
                </div>
                <!---Adding Imterest Rate Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Interest Rate Comment</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="interest_rate_comment" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Security Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Security</div>
                    <div class="leftFieldsStyleValue">
                        <select name="security" id="security">
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
                        <textarea id="security_comment" rows="7" class="highlight-text"></textarea>
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
                        <textarea id="borrowing_base" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Credit Facility Comment Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Credit Facility Comments</div>
                    <div class="leftFieldsStyleValue">
                        <textarea id="comments" rows="7" class="highlight-text"></textarea>
                    </div>
                </div>
                <!---Adding Financial Covenants Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Financial Covenants - Database</div>
                    <div class="leftFieldsStyleValue">
                        <div class="simultaneousFields">
                        </div>
                        <div>
                            <button type="button" class="addSimultaneous creditButtonStyle"> Add Simultaneous Financial Covenants </button>
                        </div>
                    </div>
                </div>
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Financial Covenants - text</div>
                    <div class="leftFieldsStyleValue"> 
                        <div class="financialFields">
                        </div>
                        <div>
                            <button type="button" class="addFinancial creditButtonStyle"> Add Financial Covenants </button>
                        </div>
                    </div>
                </div>
                <!---Adding Availability Section--->
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability (as of) Date</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <input type="date" name="availabilityDate" id="availability_date">
                        </div>
                    </div>
                </div>
                <div class="DivBlocks">
                    <div class="leftFields leftFieldsStyle">Availability Date Type</div>
                    <div class="leftFieldsStyleValue">
                        <div>
                            <select name="availabilityDateType" id="availability_period_duration">
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
                            <select name="availabilityNonQuarterEndPeriodDuration" id="availability_non_quarter_end_period_duration">
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
    <div id="CustomiseLayout" class="CustomiseLayout" style="display:none";">
        <div class="customizeLayoutSection">
            <div class="fieldHeader">
                <div class="pullleft bold">Fields</div>
                <div class="bold pullright">Toggle</div>
            </div>
            <div class="fieldBody">
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_0">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_1">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_2">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_3">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_4">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" id = "satya" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_5">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_6">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_7">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_8">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_9">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_10">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_11">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
            </div>
        </div>
        <div class="customizeLayoutSection">
            <div class="fieldHeader">
                <div class="pullleft bold">Fields</div>
                <div class="bold pullright">Toggle</div>
            </div>
            <div class="fieldBody">
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_12">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_13">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="0" checked=false>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_14">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked="true">
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_15">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked="false">
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_16">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" >
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_17">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_18">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_19">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_20">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_21">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>
                <div id="creditFields">
                    <div class="pullleft fieldCheck fieldName_22">
                    </div>
                    <label class="switch">
                        <input type="checkbox" class="creditFieldCheck" name="switch" value="1" checked>
                        <div class="slider round"></div>
                    </label>
                </div>           
            </div>
        </div>
    </div>
</div>