*** Settings ***
Documentation    Tests the complete flow of all the functionalities.
Resource    ../Bank_Keywords/userdata.robot
Resource    ../Bank_Keywords/createaccount.robot
Resource    ../Bank_Keywords/secondary_acc.robot
Resource    ../Bank_Keywords/Bill.robot
Resource    ../Bank_Keywords/loan.robot
Resource    ../Bank_Keywords/fund_trnsfr.robot
Resource    ../Bank_Keywords/access.robot
Resource    ../Bank_Keywords/acc_ovrw.robot
*** Test Cases ***
Should be able to get user details
    [Documentation]    Gets the random user details from websites and stores it as variable.
    [Tags]    User_Data
    User data
Creating Primary Account
    [Documentation]    Testing the New Account opening function and Log in functionality.
    [Tags]    Primary_account
    Create Account
Login
    [Documentation]     Logging in to site with the id created before.
    [Tags]  Login
    access.Login
Creating Checking Account (Secondary Account)
    [Documentation]    Testing the Checkings Account opening functions for all the available account types for the existing client.
    [Tags]    Checkings_Account
    secondary_acc.Create a new checking account
Creating Savings Account (Secondary Account)
    [Documentation]    Testing the Savings Account opening functions for all the available account types for the existing client.
    [Tags]    Savings_Account
    secondary_acc.Create a new savings account
Transferring Funds to Checking Account
    [Documentation]     Transferring Funds to Checkings account from Primary account.
    [Tags]    Fund_Transfer (To Checkings)
    fund_trnsfr.Transfer Funds to Checking account
Transferring Funds to Savings Account
    [Documentation]     Transferring Funds to Savings account from Primary account.
    [Tags]    Fund_Transfer (To Savings)
    fund_trnsfr.Transfer Funds to Savings account
Bill Payment
    [Documentation]    Checking the bill payment function.
    [Tags]    Billing
    Bill Payment
Apply Loan
    [Documentation]    Checking the Loan functionality.
    [Tags]    Loan
    Apply Loan
Accounts overview
    [Documentation]    Checking Accounts overview of all available accounts.
    [Tags]    Accounts_overview
    Accounts overview
Log Out
    [Documentation]    Testing Logout function.
    [Tags]    Logout
    access.Logout