*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${n_check_acc} =    0000
${n_save_acc} =     0000

*** Keywords ***
Create a new checking account
    Set Selenium Speed      1 seconds
    Click element              //*[@id="leftPanel"]/ul/li[1]/a       #open new account
    Page should contain     Open New Account
    Select from list by value       //*[@id="type"]       0     #checking account
    Wait until page contains element        //*[@id="fromAccountId"]
    #Select from list by value       //*[@id="fromAccountId"]            ${main_acc}
    Click Button        //*[@id="openAccountForm"]/form/div/input
    Page should contain     Account Opened!
    Page should contain     Congratulations, your account is now open.
    Get all links
    Wait until page contains element        //*[@id="newAccountId"]
    Click link         css=#newAccountId
    Capture element screenshot     //*[@id="rightPanel"]       ${OUTPUTDIR}/new_account_checking.png
    Wait until page contains element        css=#accountId
    ${c_acc} =  Get text     //*[@id="accountId"]
    Set global variable     ${n_check_acc}      ${c_acc}

Create a new savings account
    Set Selenium Speed      1 seconds
    Click element           //*[@id="leftPanel"]/ul/li[1]/a       #open new account
    Page should contain     Open New Account
    Select from list by value       //*[@id="type"]       1     #savings account
    Wait until page contains element        //*[@id="fromAccountId"]
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Click Button        //*[@id="openAccountForm"]/form/div/input
    Page should contain     Account Opened!
    Page should contain     Congratulations, your account is now open.
    Get all links
    Wait until page contains element        //*[@id="newAccountId"]
    Click link         css=#newAccountId
    Capture element screenshot     //*[@id="rightPanel"]       ${OUTPUTDIR}/new_account_savings.png
    Wait until page contains element        css=#accountId
    ${s_acc} =  Get text     //*[@id="accountId"]
    Set global variable     ${n_save_acc}      ${s_acc}

