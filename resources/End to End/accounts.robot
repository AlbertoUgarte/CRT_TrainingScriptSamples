*** Settings ***
Library                       QForce
Library                       String

*** Keywords ***

New Account with Mandatory Arguments
    [Arguments]               ${account_name}    ${type} 
    LaunchApp                 Accounts
    ClickText                 New

    UseModal                  On                              # Only find fields from open modal dialog
    TypeText                  Account Name                    ${account_name}    anchor=Type    delay=2
    ClickText                 Type
    ClickText                 ${type}
    #PickList                  Type                            ${type}
    TypeText                  Website                         https://gogo.nl
    TypeText                  Description                     Default value
    ClickText                 Save                            partial_match=False
    UseModal                  Off

Verify Account with Optional Arguments
    [Arguments]               ${website}=${EMPTY}    ${description}=Default value
    ClickText                 Details                anchor=News    delay=1

    VerifyText                My second account
    VerifyText                Customer
    VerifyText                ${website}
    VerifyText                ${description}

Delete Account with Mandatory Arguments
    [Arguments]               ${account_name}
    ClickText                 Accounts

    ClickText                 Accounts
    TypeText                  Search this list...             ${account_name}\n
    ClickCheckbox             Select item 1    on
    UseTable                  Item Number
    ClickCell                 r1c5
    ClickText                 Delete
    UseModal                  On
    ClickText                 Delete
    VerifyText                deleted