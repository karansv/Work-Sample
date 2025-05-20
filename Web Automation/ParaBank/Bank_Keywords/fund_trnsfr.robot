*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Transfer Funds to Checking account
    Click element      //*[@id="leftPanel"]/ul/li[3]/a
    Input text      //*[@id="amount"]       50
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Select from list by value       //*[@id="toAccountId"]          ${n_check_acc}
    Click button        //*[@id="transferForm"]/div[2]/input
    Page should contain     Transfer Complete!
    Capture element screenshot     //*[@id="rightPanel"]     ${OUTPUTDIR}/checking_trnfr.png

Transfer Funds to Savings account
    Click element      //*[@id="leftPanel"]/ul/li[3]/a
    Input text      //*[@id="amount"]       50
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Select from list by value       //*[@id="toAccountId"]          ${n_save_acc}
    Click button        //*[@id="transferForm"]/div[2]/input
    Page should contain     Transfer Complete!
    Capture element screenshot     //*[@id="rightPanel"]    ${OUTPUTDIR}/savings_trnfr.png
