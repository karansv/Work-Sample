*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Bill Payment
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
    Capture element screenshot     //*[@id="rightPanel"]       ${OUTPUTDIR}/billpayment.png

