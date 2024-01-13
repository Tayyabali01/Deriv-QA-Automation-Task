*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${Browser}              chrome
${URL}                  https://opensource-demo.orangehrmlive.com/
${USERNAME}             admin
${PASSWORD}             admin123
${BASE_FOLDER}          Myinfo_Screenshots
${SCREENSHOT_FOLDER}    ${BASE_FOLDER}


*** Test Cases ***
Update Date
    Open Browser And Maximize
    sleep                        5
    Capture Screenshot           URL_Successfully_Opened

    Perform Login
    sleep                 6
    Capture Screenshot    UserloginSuccessfully

    MyInfo_Page

    [Teardown]    Close Browser


*** Keywords ***
Open Browser And Maximize
    Open Browser               ${URL}    ${Browser}
    Maximize Browser Window

Capture Screenshot
    [Arguments]                ${screenshot_name}
    Capture Page Screenshot    ${SCREENSHOT_FOLDER}/${screenshot_name}.png

Log And Print
    [Arguments]       ${message}    ${status}=PASS
    Log To Console    ${message}    ${status}

Perform Login
    Input Text    xpath://input[@placeholder='Username']    ${USERNAME}

    Input Text    xpath://input[@placeholder='Password']    ${PASSWORD}

    Click Button    xpath://button[@type='submit']

Perform Login With Alternative XPaths
    Input Text    xpath://input[@placeholder='username']    ${USERNAME}

    Input Text    xpath://input[@placeholder='password']    ${PASSWORD}

    Click Button    xpath://button[@type='submit']

MyInfo_Page

    Click Element         xpath://span[normalize-space()='My Info']
    sleep                 3                                            
    Capture Screenshot    MyInfo_Page

    ${JS_Script}          Set Variable        window.scrollTo(0, (window.scrollY + window.innerHeight) / 2);
    Execute Javascript    ${JS_Script}
    Sleep                 5
    Capture Screenshot    ScrolltoHalfPage

    Click Element         xpath://body/div[@id='app']/div[@class='oxd-layout']/div[@class='oxd-layout-container']/div[@class='oxd-layout-context']/div[@class='orangehrm-background-container']/div[@class='orangehrm-card-container']/div[@class='orangehrm-edit-employee']/div[@class='orangehrm-edit-employee-content']/div[@class='orangehrm-horizontal-padding orangehrm-vertical-padding']/form[@class='oxd-form']/div[@class='oxd-form-row']/div[@class='oxd-grid-3 orangehrm-full-width-grid']/div[1]/div[1]/div[2]/div[1]/div[1]/i[1]
    sleep                 3
    Capture Screenshot    DOB Textbox

    Click Element         xpath://div[contains(text(),'27')]
    sleep                 3
    Capture Screenshot    SelectDate_27

    Click Button          xpath://div[@class='orangehrm-horizontal-padding orangehrm-vertical-padding']//button[@type='submit'][normalize-space()='Save']
    sleep                 6
    Capture Screenshot    UpdatedDate



Handle Errors And Alternative XPaths
    Open Browser And Maximize

    Run Keyword And Ignore Error    Perform Login
    ${error_message}=               Get Last Keyword Status
    Run Keyword If                  '${error_message}' == 'FAIL'    Perform Login With Alternative XPaths
    Log And Print                   Login Successful!
    Run Keyword If                  '${error_message}' == 'FAIL'    Log And Print                            Login Failed!    FAIL

    Capture Screenshot    User_Logged_In_Successfully.png
   # Add more verification steps here as needed

    [Teardown]    Close Browser