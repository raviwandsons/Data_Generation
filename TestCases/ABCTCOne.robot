*** Settings ***
Library   SeleniumLibrary
Library   String
Library   Collections
Library   openpyxl
Library  ../Resources/Input.py
Library  ../Resources/DataRepository.py
Resource  ../Resources/Variables/Variables.robot
Resource  ../Resources/Keywords/Keywords.robot

*** Variables ***
${SearchTextField}  //*[@class="gLFyf gsfi"]
${SearchGoogleBtn}  (//*[@class="gNO89b" and @value="Google Search"])[2]
#${FirstRecord}   (//*[@class="rISBZc"])[1]  #(//*[@class="cXedhc uQ4NLd"])[1]
${FirstRecord}   (//img[@class="rISBZc" and @height="200" and @width="652"])
${FirstRest}  (//*[@class="VkpGBb"])
#${CommonRestPlane}  //*[@class="g kno-kp mnr-c g-blk"]
${CommonRestPlane}  //*[@class="Ftghae iirjIb DaSCDf"]
${CloseCommonRestPlane}  //*[@class="QU77pf" and @role="button"]
${RestAddress}   //*[@class="LrzXr"]
${RestContactNo}   //*[@class="LrzXr zdqRlf kno-fv"]
${RestMenu}   (//*[@class="fl"])[13]
${RestRating}  (//*[@class="Aq14fc"])[7]
${NoOfGoogleReviews}  //*[@class="hqzQac"]
${WorkingHours}   (//*[@class="zloOqf PZPZlf"])[2]
${WebsiteBtn}  (//*[@class="CL9Uqc ab_button"])[1]
${NEXT}   //*[@id="pnnext"]
${GoogleHomePage}   //*[@id="logo"]
${Hours}  //*[@class="JjSWRd"]
${ClickedHours}   //*[@class="WgFkxc"]
${PopUpTimingPage}  //*[@class="ynlwjd oLLmo fkbZ7b u98ib"]
${PopUpTimingGrid}  (//*[@class="WgFkxc CLtZU"])[1]
${ClosePopUpTimingPage}   (//*[@class="Xvesr"])[last()]
${RestTag}  (//*[@class="YhemCb"])
${RestTag2}  (//*[@class="YhemCb"])[2]


*** Keywords ***
Data is Available
    Wait Until Element Is Enabled    ${FirstRecord}
    Set Focus To Element    ${FirstRecord}
    Click Element    ${FirstRecord}

Data is NOT Available
    Click Element     ${GoogleHomePage}
#    Wait Until Element Is Visible  ${SearchTextField}
    Continue For Loop

Second MyLoop
    FOR  ${PageIndex}  IN RANGE   2  ${TotalPages}
        Set Suite Variable    ${PageIndex}
        Check Next Page Availablity
        Sleep  3s
        My loop
    END

My loop
    Wait Until Element Is Visible  ${FirstRest}
    Page Should Contain Element  ${FirstRest}
    FOR  ${loopIndex}  IN RANGE   1  ${TotalRecords}
        Set Test Variable    ${loopIndex}
        Check Next Restaurant Availablity
    END


*** Test Cases ***
Getting Data...
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Delete All Cookies

    ${Key_query} =  Set Variable   query
    ${Key_filename} =  Set Variable   filename
    ${Key_categorycode} =  Set Variable   categorycode
    ${InputData} =   Get Input Query   ${InputFileName}
    ${MyList} =    Create Dictionary
    log to console  ${MyList}
    Set To Dictionary    ${MyList}    Foo1    Value1

    FOR  ${x}  IN  @{InputData}
        ${SearchQuery} =   Get From Dictionary   ${x}  ${Key_query}
        log to console   ${SearchQuery}
        ${file_name} =   Get From Dictionary   ${x}  ${Key_filename}
        log to console   ${file_name}
        ${category_code} =   Get From Dictionary   ${x}  ${Key_categorycode}
        log to console   ${category_code}
        Set Test Variable   ${category_code}

        Delete All Cookies
        Wait Until Element Is Visible  ${SearchTextField}
        input text  ${SearchTextField}    ${SearchQuery}
        Wait Until Element Is Enabled    ${SearchGoogleBtn}
        Set Focus To Element    ${SearchGoogleBtn}
        Click Element    ${SearchGoogleBtn}

#++++++++
        log to console  files not set
        Set Test Variable  ${FileName}
        ${sheetcheck} =   Set Variable  ${false}

         ${sheetcheck}=  Run keyword If  '${Filename}' in ${MyList}
         ...  Set Variable  ${true}
         ...  ELSE  Set Variable  ${false}

        log to console  ${sheetcheck}
        Run keyword If  ${sheetcheck} == ${false}    Set To Dictionary   ${MyList}  ${FileName}   ${FileName}
        Run keyword If  ${sheetcheck} == ${false}  Create Xlsx Sheet and Its Columns   ${file_name}

        ${DataRestRating}    Run Keyword And Return Status
                 ...    Element Should Be Visible    ${FirstRecord}
        Run Keyword If     ${DataRestRating}       Data is Available
        ...    ELSE                        Data is NOT Available
#++++++++
        Log to console  ${Page}1
        My loop
        Second MyLoop
        Click Element     ${GoogleHomePage}
    END
