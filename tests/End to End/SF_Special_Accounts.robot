*** Settings ***
Resource                      ../../resources/common.robot
Resource                      ../../resources/End to End/accounts.robot
Resource                    SF_SalesProcess.robot

Suite Setup                   Open Browser          about:blank                 ${BROWSER}
Suite Teardown                Close All Browsers

*** Test Cases ***

Create an Account and Delete using Arguments
    Login
    New Account with Mandatory Arguments        My second account    Customer
    Verify Account with Optional Arguments      https://gogo.nl
    Delete Account with Mandatory Arguments     My second account
    #Call Keyword from another test
    Delete Tina
