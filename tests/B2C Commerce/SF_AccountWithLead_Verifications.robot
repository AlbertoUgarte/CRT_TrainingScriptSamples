*** Settings ***
Resource                      ../../resources/common.robot
Resource                      ../../resources/B2C Commerce/accounleads.resource

Suite Setup                   Open Browser          about:blank                 ${BROWSER}
Suite Teardown                Close All Browsers

*** Test Cases ***

Create an Account and Delete using grouped Keywords
    Logging
    New Account
    Verify Account
    Delete Account