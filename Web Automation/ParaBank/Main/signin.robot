*** Settings ***
Library    SeleniumLibrary
Library    Dialogs
*** Variables ***
#-/-/---------------------------------------------------------------------\-\-#
##--list of locators of bank site--##
${url} =    https://parabank.parasoft.com/parabank/index.htm
${f_n} =    //*[@id="customer.firstName"]
${l_n} =    //*[@id="customer.lastName"]
${add} =    //*[@id="customer.address.street"]
${cty} =    //*[@id="customer.address.city"]
${st} =     //*[@id="customer.address.state"]
${zip} =    //*[@id="customer.address.zipCode"]
${ph} =     //*[@id="customer.phoneNumber"]
${ssn} =    //*[@id="customer.ssn"]
${user} =   //*[@id="customer.username"]
${pswd} =   //*[@id="customer.password"]
${cnf_pswd} =   //*[@id="repeatedPassword"]
#-\-\---------------------------------------------------------------------/-/-#
${main_acc} =   0000
${n_check_acc} =    0000
${n_save_acc} =     0000
${loan_acc} =   0000
#/////////////////////////////////////////////////////////////////////////////#
##--variable data from random data generator sites--##
${f_name} =    a
${l_name} =    a
${street} =    a
${city} =    a
${state} =    a
${pin} =    1
${mobile} =    23
${S_N} =    45
${user_id} =    a
${pswrd} =    a
#////////////////////////////////////////////////////////////////////////////#

*** Test Cases ***
Getting User Name
    Open Browser                    https://www.behindthename.com/random/       edge
    Maximize Browser Window
    Wait until page contains        Random Name Generator
    Wait until page contains element        //*[@id="menucell1"]
    Select From List By Value       //*[@id="body-inner"]/center/form/table[1]/tbody/tr[2]/td[2]/select[1]      1
    Click element                   css=#body-inner > center > form > div:nth-child(1) > input

    Wait until page contains        Your random name is
    ${name_a} =  Get text           //*[@id="body-inner"]/center/div[1]/a
    Set Global Variable    ${f_name}   ${name_a}

    Click link                      //*[@id="pageheading-nav"]/a[1]
    ${name_b} =  Get text           //*[@id="body-inner"]/center/div[1]/a
    Set Global Variable    ${l_name}   ${name_b}

Getting User details
    Go to                           https://www.worldnamegenerator.com/
    Wait until page contains        BASIC INFORMATION
    #getting varible data from fake data generator site
    ${Sc_N} =    Get text        //*[@id="main"]/div/div[1]/div/div[1]/div[2]/table/tbody/tr[6]/td[2]/b
    Set Global Variable    ${S_N}  ${Sc_N}
    ${ad_ln} =   Get Text       //*[@id="main"]/div/div[1]/div/table[1]/tbody/tr[2]/td[2]/b
    Set Global Variable    ${street}  ${ad_ln}
    ${cit} =     Get Text       //*[@id="main"]/div/div[1]/div/table[1]/tbody/tr[3]/td[2]/b
    Set Global Variable    ${city}  ${cit}
    ${stt} =   Get Text         //*[@id="main"]/div/div[1]/div/table[1]/tbody/tr[5]/td[2]/b
    Set Global Variable    ${state}    ${stt}
    ${z_cd} =     Get Text      //*[@id="main"]/div/div[1]/div/table[1]/tbody/tr[6]/td[2]/b
    Set Global Variable    ${pin}  ${z_cd}
    ${phn} =  Get Text          //*[@id="main"]/div/div[1]/div/table[1]/tbody/tr[8]/td[2]/b
    Set Global Variable    ${mobile}   ${phn}
    ${u_id} =   Get Text        //*[@id="main"]/div/div[1]/div/table[6]/tbody/tr[2]/td[2]/b
    Set Global Variable    ${user_id}  ${u_id}
    ${psd} =   Get Text         //*[@id="main"]/div/div[1]/div/table[6]/tbody/tr[3]/td[2]/b
    Set Global Variable    ${pswrd}    ${psd}
    Close Browser

Create Bank Account
    [Tags]    New_Primary_Account
    Open Browser    ${url}  edge
    Maximize Browser Window
    Wait Until Page Contains Element        //*[@id="headerPanel"]
    #creating new account
    Click link      //*[@id="loginPanel"]/p[2]/a
    Wait Until Page Contains            Signing up is easy!
    #filling required details
    Input Text      ${f_n}        ${f_name}         #first name
    Input Text      ${l_n}        ${l_name}         #last name
    Input Text      ${add}        ${street}         #address
    Input Text      ${cty}        ${city}           #City
    Input Text      ${st}         ${state}          #state
    Input Text      ${zip}        ${pin}            #pin code
    Input Text      ${ph}         ${mobile}         #ph number
    Input Text      ${ssn}        ${S_N}            #SSN
    Input Text      ${user}       ${user_id}        #user id
    Input Text      ${pswd}       ${pswrd}          #pswrd
    Input Text      ${cnf_pswd}   ${pswrd}          #pswrd
    Capture page screenshot     user_details.png
    Click Button                //*[@id="customerForm"]/table/tbody/tr[13]/td[2]/input
    Capture page screenshot     account.png
    Close Browser

Login to site
    [Tags]    Login
    Set Selenium Speed      1 seconds
    Open Browser    ${url}      edge
    Maximize Browser Window
    Wait Until Page Contains Element        //*[@id="headerPanel"]
    #logging in with user id created in above step
    Input text          //*[@id="loginPanel"]/form/div[1]/input         ${user_id}
    Input text          //*[@id="loginPanel"]/form/div[2]/input         ${pswrd}
    Click button        //*[@id="loginPanel"]/form/div[3]/input
    Capture page screenshot         loggin.png
    Click element              //*[@id="leftPanel"]/ul/li[2]/a     #acc overview
    Wait until page contains        Accounts Overview
    Click element              //*[@id="leftPanel"]/ul/li[2]/a
    Wait until page contains        Accounts Overview
    Wait until page contains element        //*[@id="accountTable"]/tbody/tr[1]/td[1]/a
    Click element               //*[@id="accountTable"]/tbody/tr[1]/td[1]/a   #main acc
    #Execute manual step         Is the result coming as expected?
    Wait until page contains element        css=#accountId
    ${mn_acc} =  Get text       //*[@id="accountId"]
    Set global variable     ${main_acc}      ${mn_acc}

Create a new checking account
    [Tags]    New_Checkings_Account
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
    Capture element screenshot     //*[@id="rightPanel"]       new_account_checking.png
    Wait until page contains element        css=#accountId
    ${c_acc} =  Get text     //*[@id="accountId"]
    Set global variable     ${n_check_acc}      ${c_acc}

Create a new savings account
    [Tags]    New_Savings_Account
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
    Capture element screenshot     //*[@id="rightPanel"]       new_account_savings.png
    Wait until page contains element        css=#accountId
    ${s_acc} =  Get text     //*[@id="accountId"]
    Set global variable     ${n_save_acc}      ${s_acc}

Transfer Funds to Checking account
    [Tags]    Checking_Fund_Transfer
    Click element      //*[@id="leftPanel"]/ul/li[3]/a
    Input text      //*[@id="amount"]       50
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Select from list by value       //*[@id="toAccountId"]          ${n_check_acc}
    Click button        //*[@id="transferForm"]/div[2]/input
    Page should contain     Transfer Complete!
    Capture element screenshot     //*[@id="rightPanel"]     checking_trnfr.png

Transfer Funds to Savings account
    [Tags]    Savings_Fund_Transfer
    Click element      //*[@id="leftPanel"]/ul/li[3]/a
    Input text      //*[@id="amount"]       50
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Select from list by value       //*[@id="toAccountId"]          ${n_save_acc}
    Click button        //*[@id="transferForm"]/div[2]/input
    Page should contain     Transfer Complete!
    Capture element screenshot     //*[@id="rightPanel"]    savings_trnfr.png

Bill Payment
    [Tags]    Bill_payment
    Click element       //*[@id="leftPanel"]/ul/li[4]/a
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[1]/td[2]/input       ${f_name}
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[2]/td[2]/input       ${street}
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[3]/td[2]/input       ${city}
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[4]/td[2]/input       ${state}
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[5]/td[2]/input       ${pin}
    Input text          name:payee.phoneNumber      ${mobile}
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[8]/td[2]/input       1245    #acc num -biller
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[9]/td[2]/input       1245
    Input text          //*[@id="billpayForm"]/form/table/tbody/tr[11]/td[2]/input      100
    Select from list by value       //*[@id="billpayForm"]/form/table/tbody/tr[13]/td[2]/select         ${main_acc}
    Click button        //*[@id="billpayForm"]/form/table/tbody/tr[14]/td[2]/input
    Page should contain     Bill Payment Complete
    Capture element screenshot     //*[@id="rightPanel"]       billpayment.png

Apply for Loan
    [Tags]    Loan
    Click element       //*[@id="leftPanel"]/ul/li[7]/a
    Input text          //*[@id="amount"]           1000
    Input text          //*[@id="downPayment"]      500
    Select from list by value       //*[@id="fromAccountId"]        ${main_acc}
    Click Button        //*[@id="requestLoanForm"]/form/table/tbody/tr[4]/td[2]/input
    Page should contain     Congratulations, your loan has been approved.
    Capture element screenshot     //*[@id="rightPanel"]       loan.png
    Click link          css=#newAccountId
    Wait until page contains element        css=#accountId
    ${ln_acc} =  Get text     //*[@id="accountId"]
    Set global variable     ${loan_acc}      ${ln_acc}
Accounts overview
    [Tags]    Accounts_Overview
    Click element      //*[@id="leftPanel"]/ul/li[2]/a     #overview of all available accounts
    Capture element screenshot        //*[@id="rightPanel"]       all_account_blnc.png

Log out
    Click element      //*[@id="leftPanel"]/ul/li[8]/a
    Close Browser
