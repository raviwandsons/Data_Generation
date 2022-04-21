*** Settings ***
Library   String
Library   Collections

*** Keywords ***
Check Next Page Availablity
        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible     ${NEXT}
        Run Keyword If     ${DataRestRating}       Next Page Available
        ...    ELSE                        Unavailable Next Page

Next Page Available
        log to console  ${Page}${PageIndex}
        Click Element   ${NEXT}

Unavailable Next Page
        log to console  All Pages Over here...
        Exit For Loop

#***************************************************************************************************

Check Next Restaurant Availablity
        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible      (//*[@class="dbg0pd"])[${loopIndex}]
        Run Keyword If     ${DataRestRating}       Next Restaurant is Available
        ...    ELSE                        Next Restaurant is Unavailable

Next Restaurant is Available
        Log to console  ${SrNO}${loopIndex}

        Wait Until Element Is Enabled    (//*[@class="dbg0pd"])[${loopIndex}]
        Set Focus To Element    (//*[@class="dbg0pd"])[${loopIndex}]
        ${RestNamePrint} =  Get Text  (//*[@class="dbg0pd"])[${loopIndex}]
        Set Test Variable    ${RestNamePrint}
        log to console  ${Name}${RestNamePrint}
        Click Element    (//*[@class="dbg0pd"])[${loopIndex}]

        Wait Until Element Is Enabled  ${CommonRestPlane}
        Wait Until Element Is Visible  ${CommonRestPlane}
        Page Should Contain Element  ${CommonRestPlane}

        ${DataRestMenu}    Run Keyword And Return Status
                 ...    Element Should Be Visible    ${WebsiteBtn}
        Run Keyword If     ${DataRestMenu}       Available Restaurant Website
        ...    ELSE                        Unavailable Restaurant Website

        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible    ${RestRating}
        Run Keyword If     ${DataRestRating}       Available Restaurant Rating
        ...    ELSE                        Unavailable Restaurant Rating

        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible    ${NoOfGoogleReviews}
        Run Keyword If     ${DataRestRating}       Available Restaurant Google Review Counts
        ...    ELSE                        Unavailable Restaurant Google Review Counts

        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible   ${RestTag}
        Run Keyword If     ${DataRestRating}       Restaurant Tag is Available
        ...    ELSE                        Restaurant Tag is Unavailable

        ${DataRestMenu}    Run Keyword And Return Status
                 ...    Element Should Be Visible     ${RestAddress}
        Run Keyword If     ${DataRestMenu}       Available Restaurant Address
        ...    ELSE                       Unavailable Restaurant Address

        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Not Be Visible    ${Hours}
        Run Keyword If     ${DataRestRating}       Unavailable Restaurant Hours on Google
        ...    ELSE                        Available Restaurant Hours on Google

        ${DataRestMenu}    Run Keyword And Return Status
                 ...    Element Should Be Visible    ${RestMenu}
        Run Keyword If     ${DataRestMenu}       Available Restaurant MenuLink
        ...    ELSE                        Unavailable Restaurant MenuLink

        ${DataRestMenu}    Run Keyword And Return Status
                 ...    Element Should Be Visible     ${RestContactNo}
        Run Keyword If     ${DataRestMenu}       Available Restaurant ContactNO
        ...    ELSE                       Unavailable Restaurant ContactNO

        Wait Until Element Is Enabled    ${CloseCommonRestPlane}
        Click Element    ${CloseCommonRestPlane}
        Put data into Xlsx Sheet

Next Restaurant is Unavailable
        Exit For Loop

#***************************************************************************************************

Unavailable Restaurant Address
        ${NoOfGoogleReviewsPrint}    Set Variable    ${NODataFound}
        Set Test Variable    ${NoOfGoogleReviewsPrint}
#        log to console  ${ReviewCount}${NoOfGoogleReviewsPrint}
Available Restaurant Address
        ${GetRestAddressPrint} =  Get Text  ${RestAddress}
#        log to console    ${GetRestAddressPrint}
        @{GetRestAddressPrintSplit} =	Split String	${GetRestAddressPrint}	 ,${SPACE}
#        log to console    ${GetRestAddressPrintSplit}
        Reverse List   ${GetRestAddressPrintSplit}
#        log to console    ${GetRestAddressPrintSplit}
        Set Test Variable  ${GetRestAddressPrintSplit}
        ${country} =  Get From List   ${GetRestAddressPrintSplit}   0
        Set Test Variable    ${country}
#        log to console    ${country}
        ${ZipcodeAndState} =  Get From List   ${GetRestAddressPrintSplit}   1
        @{ZipcodeAndStateSplit} =	Split String	${ZipcodeAndState}	 ${SPACE}
        ${state} =  Get From List   ${ZipcodeAndStateSplit}   0
        Set Test Variable    ${state}
#        log to console    ${state}
        ${zipcode} =  Get From List   ${ZipcodeAndStateSplit}   1
        Set Test Variable    ${zipcode}
#        log to console    ${zipcode}
        ${city} =  Get From List   ${GetRestAddressPrintSplit}   2
        Set Test Variable    ${city}
#        log to console    ${city}
#        ${street} =  Get From List   ${GetRestAddressPrintSplit}   3
#        Set Test Variable    ${street}
#        log to console    ${street}
        ${DataRestMenu}    Run Keyword And Return Status
                 ...   Get From List   ${GetRestAddressPrintSplit}   3
        Run Keyword If     ${DataRestMenu}       Check for fourth Index
        ...   ELSE                        Index three is not available

Check for fourth Index
        ${DataRestMenu}    Run Keyword And Return Status
                 ...   Get From List   ${GetRestAddressPrintSplit}   4
        Run Keyword If     ${DataRestMenu}       Print index four
        ...   ELSE                        Print index three

Print index three
        ${street} =  Get From List   ${GetRestAddressPrintSplit}    3
        Set Test Variable    ${street}
#        log to console    ${street}
Print index four
        ${a} =  Get From List   ${GetRestAddressPrintSplit}    3
        Set Test Variable   ${a}
#        log to console    ${a}
        ${b} =  Get From List   ${GetRestAddressPrintSplit}    4
        Set Test Variable   ${b}
#        log to console    ${b}
        ${street}=    Set Variable   ${b},${SPACE}${a}
        Set Test Variable    ${street}
#        Log To Console    ${street}                                            # prints First, Second

Index three is not available
        ${street}    Set Variable    ${NODataFound}
        Set Test Variable    ${street}
#        log to console    ${street}

#---------------------------------------------------------------------------------------

Available Restaurant ContactNO
        ${RestContactNoPrint} =  Get Text  ${RestContactNo}
        Set Test Variable    ${RestContactNoPrint}
#        log to console  ${Contact}${RestContactNoPrint}
Unavailable Restaurant ContactNO
        ${RestContactNoPrint}    Set Variable    ${NODataFound}
        Set Test Variable    ${RestContactNoPrint}
#        log to console  ${Contact}${RestContactNoPrint}

#---------------------------------------------------------------------------------------

Available Restaurant Website
        ${RestURL}=  Get Element Attribute  ${WebsiteBtn}    href
        Set Test Variable    ${RestURL}
#        log to console  ${website}${RestURL}
Unavailable Restaurant Website
        ${RestURL}    Set Variable    ${NODataFound}
        Set Test Variable    ${RestURL}
#        log to console  ${website}${RestURL}

#---------------------------------------------------------------------------------------
Available Restaurant MenuLink
        ${RestMenuPrint}=  Get Element Attribute  ${RestMenu}    href
        Set Test Variable    ${RestMenuPrint}
#        log to console  ${Menu}${RestMenuPrint}
Unavailable Restaurant MenuLink
        ${RestMenuPrint}    Set Variable    ${NODataFound}
        Set Test Variable    ${RestMenuPrint}
#        log to console  ${Menu}${RestMenuPrint}

#---------------------------------------------------------------------------------------

Available Restaurant Rating
        ${RestRatingPrint} =  Get Text  ${RestRating}
        Set Test Variable    ${RestRatingPrint}
#        log to console  ${Rating}${RestRatingPrint}
Unavailable Restaurant Rating
        ${RestRatingPrint}    Set Variable    ${NODataFound}
        Set Test Variable    ${RestRatingPrint}
#        log to console  ${Rating}${RestRatingPrint}

#---------------------------------------------------------------------------------------

Available Restaurant Google Review Counts
        ${TextNoOfGoogleReviews} =  Get Text  ${NoOfGoogleReviews}
        @{NoOfGoogleReviewsPrintNO} =	Split String	${TextNoOfGoogleReviews}	 ${SPACE}
        ${NoOfGoogleReviewsPrint} =  Get From List   ${NoOfGoogleReviewsPrintNO}   0
        Set Test Variable    ${NoOfGoogleReviewsPrint}
#        log to console  ${ReviewCount}${NoOfGoogleReviewsPrint}
Unavailable Restaurant Google Review Counts
        ${NoOfGoogleReviewsPrint}    Set Variable    ${NODataFound}
        Set Test Variable    ${NoOfGoogleReviewsPrint}
#        log to console  ${ReviewCount}${NoOfGoogleReviewsPrint}

#---------------------------------------------------------------------------------------

Unavailable Restaurant Hours on Google
        ${HoursPrint}    Set Variable    ${NODataFound}
        Set Test Variable     ${HoursPrint}
        log to console  No Data Found - Google haven't Hours Data of this Restaurant

Available Restaurant Hours on Google
#        Wait until element is clickable   ${Hours}
        Click Element    ${Hours}
        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible    ${ClickedHours}
        Run Keyword If     ${DataRestRating}       Available Restaurant Hours on Same Page
        ...    ELSE                        Available Restaurant Hours on pop-ups

Available Restaurant Hours on pop-ups
        Wait Until Element Is Visible   ${PopUpTimingPage}  #Popup page
        Wait Until Element Is Enabled   ${PopUpTimingPage}
        Element Should Be Visible  ${PopUpTimingPage}
        ${HoursPrint} =  Get Text    ${PopUpTimingGrid}  #Get Text of timing
        Set Test Variable     ${HoursPrint}
        log to console   I Am on Pop-Up Page
        Wait Until Element Is Enabled    ${ClosePopUpTimingPage}
        Click Element   ${ClosePopUpTimingPage}

Available Restaurant Hours on Same Page
        Wait Until Element Is Visible   ${ClickedHours}  #Same page
        Wait Until Element Is Enabled   ${ClickedHours}
        ${HoursPrint} =  Get Text   ${ClickedHours}
        Set test Variable    ${HoursPrint}

#---------------------------------------------------------------------------------------

Restaurant Tag is Available
        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible   ${RestTag2}
        Run Keyword If     ${DataRestRating}       Print Second Entity
        ...    ELSE                        Print Available Entity

Print Second Entity
        ${RestTagPrint} =  Get Text  ${RestTag2}
        Set Test Variable    ${RestTagPrint}
        log to console  ${RestTagPrint}
Print Available Entity
        ${RestTagPrint} =  Get Text  ${RestTag}
        Set Test Variable    ${RestTagPrint}
        log to console  ${RestTagPrint}

Restaurant Tag is Unavailable
        ${RestTagPrint}    Set Variable    ${NODataFound}
        Set Test Variable    ${RestTagPrint}
        log to console  ${RestTagPrint}

#***************************************************************************************************

Create Xlsx Sheet and Its Columns
    [Arguments]   ${FileName}

    Make Excel File   ${FileName}

    Add Value  ${FileName}   A$1   ${SrNO}
    Add Value  ${FileName}   B$1   ${Name}
    Add Value  ${FileName}   C$1   ${Rating}
    Add Value  ${FileName}   D$1   ${review_count}
    Add Value  ${FileName}   E$1   ${colstreet}
    Add Value  ${FileName}   F$1   ${colcity}
    Add Value  ${FileName}   G$1   ${colstate}
    Add Value  ${FileName}   H$1   ${colzipcode}
    Add Value  ${FileName}   I$1   ${colcountry}
    Add Value  ${FileName}   J$1   ${Contact}
    Add Value  ${FileName}   K$1   ${website}
    Add Value  ${FileName}   L$1   ${Menu}
    Add Value  ${FileName}   M$1   ${HoursPrint}
    Add Value  ${FileName}   N$1   ${categorytype}
    Add Value  ${FileName}   O$1   ${colRestTagPrint}
#---------------------------------------------------------------------------------------

Put data into Xlsx Sheet
    ${GetMaxRow} =   Get Maxrow   ${FileName}
    ${PrintGetMaxRow} =  Set Variable    ${GetMaxRow+1}

    Add Value  ${FileName}   A${PrintGetMaxRow}   ${GetMaxRow}
    Add Value  ${FileName}   B${PrintGetMaxRow}   ${RestNamePrint}
    Add Value  ${FileName}   C${PrintGetMaxRow}   ${RestRatingPrint}
    Add Value  ${FileName}   D${PrintGetMaxRow}   ${NoOfGoogleReviewsPrint}
    Add Value  ${FileName}   E${PrintGetMaxRow}   ${street}
    Add Value  ${FileName}   F${PrintGetMaxRow}   ${city}
    Add Value  ${FileName}   G${PrintGetMaxRow}   ${state}
    Add Value  ${FileName}   H${PrintGetMaxRow}   ${zipcode}
    Add Value  ${FileName}   I${PrintGetMaxRow}   ${country}
    Add Value  ${FileName}   J${PrintGetMaxRow}   ${RestContactNoPrint}
    Add Value  ${FileName}   K${PrintGetMaxRow}   ${RestURL}
    Add Value  ${FileName}   L${PrintGetMaxRow}   ${RestMenuPrint}
    Add Value  ${FileName}   M${PrintGetMaxRow}   ${HoursPrint}
    Add Value  ${FileName}   N${PrintGetMaxRow}   ${category_code}
    Add Value  ${FileName}   O${PrintGetMaxRow}   ${RestTagPrint}

#***************************************************************************************************



