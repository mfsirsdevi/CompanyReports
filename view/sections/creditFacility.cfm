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
                  </div><span class="credit_field bold">Amendment Date :</span>
                            </cfloop>--->
                            <!--- <cfset VARIABLES.facilityColumnName = "something">
                            <cfset something = "anything">

                            <cfset newValue = evaluate("#VARIABLES.facilityColumnName#")>
                            Evaluate("qNames.#colname#[#index#]")
                            <cfdump var="#newValue#"> --->
<div class="header top-header"><p>Revolving Credit Facility</p><span class="pull-right">+</span></div>
    <div class="content revolvingCreditFacility">
    <cfset VARIABLES.creditFacilityData = companyObject.getCreditFacilityData(cid = "#cid#") />
    <cfset VARIABLES.columnDetails = companyObject.getColumnDetails() />
        <cfloop from="1" to="#VARIABLES.creditFacilityData.recordcount#" index="i">
            <div class="creditFacilityDataSection" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>" report_id="">
                <div class="creditFacilityHeader creditFacilityHeaderStyle" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Credit Facility #<cfoutput>#i#</cfoutput></div>
                <div class="creditFieldsSection" id="creditFieldsSectionId">
                    <cfset VARIABLES.sortDetails = companyObject.getSortDetails(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                    <cfloop from="1" to="#VARIABLES.sortDetails.recordcount#" index="j">
                        <cfset VARIABLES.facilityColumnName = VARIABLES.columnDetails.str_credit_facility_columns[#VARIABLES.sortDetails.int_cf_id[j]#]/>
                        <cfset VARIABLES.columnName = VARIABLES.columnDetails.str_column_names[#VARIABLES..sortDetails.int_cf_id[j]#]/>
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
                        <cfif VARIABLES.facilityColumnName EQ "date_amendment">
                            <cfset VARIABLES.adendmentDetails = companyObject.getAmendment(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                            <cfloop from="1" to="#VARIABLES.adendmentDetails.recordcount#" index="k">
                                <cfoutput>#DateTimeFormat(VARIABLES.adendmentDetails.date_amendment[k], "yyyy.MM.dd")#</cfoutput>,
                            </cfloop>
                        <cfelseif VARIABLES.facilityColumnName EQ "str_lenders">
                            <cfset VARIABLES.lendersDetails = companyObject.getLenders(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                            <cfloop from="1" to="#VARIABLES.lendersDetails.recordcount#" index="k">
                                <cfoutput>#VARIABLES.lendersDetails.str_lenders[k]#</cfoutput>,
                            </cfloop>
                        <cfelseif VARIABLES.facilityColumnName EQ "str_agent_bank">
                            <cfset VARIABLES.agentBankDetails = companyObject.getAgentBank(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                            <cfloop from="1" to="#VARIABLES.agentBankDetails.recordcount#" index="k"> 
                                <cfoutput>#VARIABLES.agentBankDetails.str_agent_bank[k]#</cfoutput>,
                            </cfloop>
                        <cfelseif VARIABLES.facilityColumnName EQ "str_convenants">
                            <cfset VARIABLES.convenantsDetails = companyObject.getConvenants(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                            <cfloop from="1" to="#VARIABLES.convenantsDetails.recordcount#" index="k">
                                <cfoutput>#VARIABLES.convenantsDetails.str_convenants[k]#</cfoutput>,
                            </cfloop>
                        <cfelseif VARIABLES.facilityColumnName EQ "str_financial_convenants_data">
                            <cfset VARIABLES.financialConvenantsDetails = companyObject.getFinancialConvenants(rcfId = "#VARIABLES.creditFacilityData.rcf_id[i]#") />
                            <cfloop from="1" to="#VARIABLES.financialConvenantsDetails.recordcount#" index="k">
                                <cfoutput>#VARIABLES.financialConvenantsDetails.str_financial_convenants_data[k]#</cfoutput>,
                            </cfloop>
                        <cfelse>
                            <cfset value = VARIABLES.creditFacilityData[#VARIABLES.facilityColumnName#][i]>
                            <cfoutput>#value#</cfoutput>
                        </cfif></span>
                        </div>
                        </div>
                    </cfloop> 
                    <div class="editCredit">
                        <button type="button" class="creditButtonStyle" id="editCreditFacility" report_id="" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Edit Credit Facility</button>
                        <button type="button" class="creditButtonStyle customLayout" id="customLayout" rcf_id="<cfoutput>#VARIABLES.creditFacilityData.rcf_id[i]#</cfoutput>">Customise Layout</button>
                    </div>     
                </div>

            </div>
        </cfloop>
    <!---On click of this button modal will pop up for adding credit facility--->
    <div class="editCredit">
        <button type="button" class="creditButtonStyle" id="addCreditLayout">Add New Credit Facility</button>
    </div>
    <div id="newCreditFacilityDialog" style="display:none;">
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
                    
<div id="CustomiseLayout" class="CustomiseLayout" style="display:none";">
                    <div class="edit_layout_section">
                        <div class="field_custom_header">
                            <div class="pullleft bold">Fields</div>
                            <div class="bold pullright">Toggle</div>
                        </div>
                        <div class="field_custom_section">
                                                       <div id="credit_field_15_check" field_id="15">
                                        <div class="pullleft field_check fieldName_0">
                                             Letter of Credit Sublimit
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                    <div id="credit_field_20_check" field_id="20">
                                        <div class="pullleft field_check fieldName_1">
                                             Financial Covenants - Database
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_11_check" field_id="11">
                                        <div class="pullleft field_check fieldName_2">
                                             Interest Rate
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_6_check" field_id="6">
                                        <div class="pullleft field_check fieldName_3">
                                             Maturity Date
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_5_check" field_id="5">
                                        <div class="pullleft field_check fieldName_4">
                                             Amendment Date
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" id = "satya" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                               
                                    <div id="credit_field_4_check" field_id="4">
                                        <div class="pullleft field_check fieldName_5">
                                             Original Facility Date
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_21_check" field_id="21">
                                        <div class="pullleft field_check fieldName_6">
                                             Financial Covenants - text
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_10_check" field_id="10">
                                        <div class="pullleft field_check fieldName_7">
                                             Availability
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_13_check" field_id="13">
                                        <div class="pullleft field_check fieldName_8">
                                             Security
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_19_check" field_id="19">
                                        <div class="pullleft field_check fieldName_9">
                                             Availability Comment
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_15_check" field_id="15">
                                        <div class="pullleft field_check fieldName_10">
                                             Letter of Credit Sublimit
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                                                        <div id="credit_field_15_check" field_id="15">
                                        <div class="pullleft field_check fieldName_11">
                                             Letter of Credit Sublimit
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                                                        
                                
                        </div>
                    </div>

                    <div class="edit_layout_section">
                        <div class="field_custom_header">
                            <div class="pullleft bold">Fields</div>
                            <div class="bold pullright">Toggle</div>
                        </div>
                        <div class="field_custom_section">
                            <div id="credit_field_15_check" field_id="15">
                                        <div class="pullleft field_check fieldName_12">
                                             Letter of Credit Sublimit
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                    <div id="credit_field_9_check" field_id="9">
                                        <div class="pullleft field_check fieldName_13">
                                             Maximum Borrowings
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="0" checked=false>
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_27_check" field_id="27">
                                        <div class="pullleft field_check fieldName_14">
                                             Availability Date Type
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="true">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_16_check" field_id="16">
                                        <div class="pullleft field_check fieldName_15">
                                             Borrowing Base
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="false">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_8_check" field_id="8">
                                        <div class="pullleft field_check fieldName_16">
                                             Other Lenders
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" >
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_18_check" field_id="18">
                                        <div class="pullleft field_check fieldName_17">
                                             Credit Facility Comments
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_28_check" field_id="28">
                                        <div class="pullleft field_check fieldName_18">
                                             Availability NON-QUARTER-END (as of) Period Duration
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_12_check" field_id="12">
                                        <div class="pullleft field_check fieldName_19">
                                             Interest Rate Comment
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_7_check" field_id="7">
                                        <div class="pullleft field_check fieldName_20">
                                             Agent Bank
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_14_check" field_id="14">
                                        <div class="pullleft field_check fieldName_21">
                                             Security Comment
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                
                                    <div id="credit_field_26_check" field_id="26">
                                        <div class="pullleft field_check fieldName_22">
                                             Availability (as of) Date
                                        </div>
                                        <label class="switch">
                                            <input type="checkbox" class="credit_field_check" name="switch" value="1" checked="">
                                            <div class="slider round"></div>
                                        </label>
                                    </div>
                                             
                                
                        </div>
                    </div>

    </div>
</div>