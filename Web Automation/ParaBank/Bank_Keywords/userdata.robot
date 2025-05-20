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
${OUTPUTDIR} =  Result/Screenshots
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

*** Keywords ***
User data
#Getting User Name
    [Documentation]    Generating random user details from fake data generator sites.
    Open Browser                    https://www.behindthename.com/random/       edge
    Wait until page contains element        //*[@id="menucell1"]
    Select From List By Value       //*[@id="body-inner"]/center/form/table[1]/tbody/tr[2]/td[2]/select[1]      1
    Click element                   css=#body-inner > center > form > div:nth-child(1) > input

    Wait until page contains        Your random name is
    ${name_a} =  Get text           //*[@id="body-inner"]/center/div[1]/a
    Set Global Variable    ${f_name}   ${name_a}

    Click link                      //*[@id="pageheading-nav"]/a[1]
    ${name_b} =  Get text           //*[@id="body-inner"]/center/div[1]/a
    Set Global Variable    ${l_name}   ${name_b}
    Close Browser
#Getting User details
    Open Browser                    https://www.worldnamegenerator.com/     edge
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

