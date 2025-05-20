*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Apply Loan
    Click element       //*[@id="leftPanel"]/ul/li[7]/a
    Input text          //*[@id="amount"]           500
    Input text          //*[@id="downPayment"]      200
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Click Button        //*[@id="requestLoanForm"]/form/table/tbody/tr[4]/td[2]/input
    Page should contain     Congratulations, your loan has been approved.
    Capture element screenshot     //*[@id="rightPanel"]       ${OUTPUTDIR}/loan.png
    Get all links
    Click link          css=#newAccountId
    Wait until page contains element        css=#accountId
    ${ln_acc} =  Get text     //*[@id="accountId"]
    Set global variable     ${loan_acc}      ${ln_acc}
