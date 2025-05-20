*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Login
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
Logout
    Click element      //*[@id="leftPanel"]/ul/li[8]/a
    Close Browser