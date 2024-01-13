*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${Browser}              chrome
${URL}                  https://opensource-demo.orangehrmlive.com/
${USERNAME}             admin
${PASSWORD}             admin123
${BASE_FOLDER}          Logout Page_Screenshots
${SCREENSHOT_FOLDER}    ${BASE_FOLDER}


*** Test Cases ***
Performing Logout
    Open Browser And Maximize
    sleep                        5
    Capture Screenshot           URL_Successfully_Opened

    Perform Login
    sleep                 5
    Capture Screenshot    UserloginSuccessfully

    Perform Logout

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
    sleep         3

    Input Text    xpath://input[@placeholder='Password']    ${PASSWORD}
    sleep         3

    Click Button    xpath://button[@type='submit']


Perform Login With Alternative XPaths
    Input Text    xpath://input[@placeholder='username']    ${USERNAME}
    sleep         3

    Input Text    xpath://input[@placeholder='password']    ${PASSWORD}
    sleep         3

    Click Button    xpath://button[@type='submit']


Perform Logout

    Click Element         xpath://span[@class='oxd-userdropdown-tab']
    sleep                 3                                              
    Capture Screenshot    Perform Logout

    Click Element         xpath://a[normalize-space()='Logout']
    sleep                 5                                        
    Capture Screenshot    Logout Successfully



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
