*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Accounts overview
    [Tags]    Accounts_Overview
    Click element      //*[@id="leftPanel"]/ul/li[2]/a     #overview of all available accounts
    Capture element screenshot        //*[@id="rightPanel"]       ${OUTPUTDIR}/all_account_blnc.png
