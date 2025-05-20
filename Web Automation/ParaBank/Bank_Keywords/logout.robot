*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Log out
    Click element      //*[@id="leftPanel"]/ul/li[8]/a
    Close Browser