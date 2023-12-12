*** Settings ***
Library                     QForce
Library                     String
Library                     ExcelLibrary
Library                     OperatingSystem

*** Variables ***
${uatLoginUrl}              https://sympleloans--latuat.sandbox.my.site.com/latitudeBroker/s/login/
${uatUserName}              tanusriBroker@yopmail.com
${uatPassword}              Pass@2550
${uatHomeUrl}               https://sympleloans--latuat.sandbox.my.site.com/latitudeBroker/s/
${browser}                  chrome


*** Keywords ***
Setup Browser
    Open Browser            about:blank                 ${BROWSER}
    SetConfig               LineBreak                   ${EMPTY}                    #\ue000
    SetConfig               DefaultTimeout              20s                         #sometimes salesforce is slow
End suite
    Close All Browsers

Login
    [Documentation]         Login to Salesforce instance
    GoTo                    ${uatLoginUrl}
    TypeText                Username                    ${uatUserName}              delay=1
    TypeText                Password                    ${uatPassword}
    ClickText               Log In

Home
    [Documentation]         Navigate to homepage, login if needed
    GoTo                    ${uatHomeUrl}
    ${login_status} =       IsText                      Broker Portal Log In
    Run Keyword If          ${login_status}             Login
    ClickText               Home
    # VerifyTitle           Home | Salesforce

Quote Creation
    [Documentation]         Quote Creation without DL in Debt consolidation
    GoTo                    ${uatHomeUrl}
    Run Keyword             Home
    Evaluate                random.seed()               random
    ${exampleFirstName}=    Generate Random String      length=3-9                  chars=abcdefghijklmnopqrstuvwxyz
    ${randomstring}=        Generate Random String      length=3-5                  chars=0123456789
    ${FirstName}=           Format String               {}                          ${exampleFirstName}
    ${LastName}=            Format String               {}                          ${exampleFirstName}         ${randomstring}
    ${FullName}=            Format String               {} {}                       ${FirstName}                ${LastName}
    Set Suite Variable      ${FullName}
    ClickText               Get rate estimate           parent=DIV
    ClickText               Personal loan
    VerifyText              Rate Estimate
    ClickText               Please select               anchor=Loan term
    ClickText               3 Years
    TypeText                Loan amount                 25,000
    ClickText               Please select               anchor=Loan purpose
    ClickText               Debt consolidation
    TypeText                First name                  ${FirstName}
    TypeText                Last name                   ${LastName}
    TypeText                DD                          07
    TypeText                MM                          08
    TypeText                YYYY                        1957
    ClickText               Female
    TypeText                Email address               ${FullName}@mailsac.com
    TypeText                Mobile number               76 498 756
    ClickCheckbox           Applicant does not have a driver's licence              on
    ClickText               Please select               anchor=Residential status
    ClickText               Own a home - with a mortgage
    TypeText                Home address                112 Willsmere Road, Kew VIC, Australia
    ClickText               112 Willsmere Road, Kew VIC, Australia
    ClickText               Yes
    ClickElement            //div[@aria-label\="Broker fee"]//input
    WriteText               40.00
    ClickCheckbox           My client requests Latitude provide them with a personalised rate offer based on their Credit Score obtained from a Credit Reporting Body. My client understands this is an indicative rate offer subject to them completing a full application form and acceptance by Latitude.    on
    ClickText               Get rate
    VerifyText              Great news!
    VerifyText              ${FirstName} may be eligible for a Latitude Personal Loan

Application Creation
    [Documentation]         Application Creation without DL in Debt consolidation
    GoTo                    ${uatHomeUrl}
    Run Keyword             Quote Creation
    ClickText               Start Application
    VerifyText              Employment Details
