*** Settings ***
Resource                        ../../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Test Cases ***
Entering A Lead
    [tags]                      Lead                        Git Repo Exercise
    Login
    Evaluate                    random.seed()               random
    ${exampleFirstName}=        Convert To String           name1
    ${randomstring}=            Generate Random String      length=3-5                  chars=0123456789
    ${FirstName}=               Format String               {}{}                        ${exampleFirstName}    ${randomstring}
    ${LastName}=                Set Variable                Smith
    ${FullName}=                Format String               {} {}                       ${FirstName}           ${LastName}
    Set Suite Variable          ${FullName}
    LaunchApp                   Sales
    ClickText                   Leads
    VerifyText                  Recently Viewed             timeout=120s
    ClickText                   New                         anchor=Import
    VerifyText                  Lead Information
    UseModal                    On                          # Only find fields from open modal dialog
    Picklist                    Salutation                  Ms.
    TypeText                    First Name                  ${FirstName}
    TypeText                    Last Name                   ${LastName}
    Picklist                    Lead Status                 Working
    TypeText                    Phone                       +12234567858449
    TypeText                    Company                     Growmore
    TypeText                    Title                       Manager
    TypeText                    Email                       tina.smith@gmail.com
    TypeText                    Website                     https://www.growmore.com/
    ClickText                   Lead Source
    ClickText                   Advertisement
    ClickText                   Save                        partial_match=False
    UseModal                    Off
    ClickText                   Details                     delay=2
    VerifyText                  Ms. ${FullName}
    VerifyText                  Manager                     #anchor=3
    VerifyText                  Phone                       +12234567858449
    VerifyText                  Growmore
    ClickText                   Leads
    VerifyText                  ${FullName}
    VerifyText                  Manager
    VerifyText                  Growmore

Delete Tina Smith's Lead
    [tags]                      Lead                        Git Repo Exercise
    LaunchApp                   Sales
    ClickText                   Leads
    VerifyText                  Recently Viewed             timeout=120s
    Wait Until Keyword Succeeds                             1 min                       5 sec                  ClickText          ${FullName}
    ClickText                   Show more actions
    ClickText                   Delete
    ClickText                   Delete                        delay=2
