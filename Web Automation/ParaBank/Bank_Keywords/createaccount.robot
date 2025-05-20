*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${main_acc} =   0000

*** Keywords ***
Create Account
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
    Capture page screenshot     ${OUTPUTDIR}/user_details.png
    Click Button                //*[@id="customerForm"]/table/tbody/tr[13]/td[2]/input
    Capture page screenshot     ${OUTPUTDIR}/account.png
    Close Browser
