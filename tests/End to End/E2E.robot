*** Settings ***
Resource                    ../../resources/common.robot
Suite Setup                 Setup Browser
Suite Teardown              End suite
Resource                    ../../resources/variable.robot
Library    FakerLibrary

*** Variables ***
${FILE_PATH}  Set Variable          ${CURDIR}${/}..${/}..${/}resources${/}data${/}Test Sample PDF.pdf
# ${loan_amount}=           25,000
*** Test Cases ***
E2E broker flow
    [tags]                  E2E
    Appstate                Home
    Evaluate                random.seed()               random
    ${exampleFirstName}=    Generate Random String      length=3-9                  chars=abcdefghijklmnopqrstuvwxyz
    ${randomstring}=        Generate Random String      length=3-5                  chars=0123456789
    # ${FirstName}=           Format String               {}                          ${exampleFirstName}
    ${FirstName}=            FakerLibrary.first_name
    Set Suite Variable        ${FirstName}
    ${LastName}=            Format String               {}                          ${exampleFirstName}         ${randomstring}
    ${FullName}=            Format String               {} {}                       ${FirstName}                ${LastName}
    Set Suite Variable      ${FullName}

    ClickText               Get rate estimate           parent=DIV
    ClickText               Personal loan
    VerifyText              Rate Estimate
    ClickText               Please select               anchor=Loan term
    ClickText               3 Years
    TypeText                Loan amount                 ${loan_amount}
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

    # ClickText             Get rate
    ClickElement            //div[@aria-label\="Broker fee"]//input
    WriteText               40.00
    ClickCheckbox           My client requests Latitude provide them with a personalised rate offer based on their Credit Score obtained from a Credit Reporting Body. My client understands this is an indicative rate offer subject to them completing a full application form and acceptance by Latitude.    on
    ClickText               Get rate
    VerifyText              Start Applicatio
    VerifyText              Great news!
    VerifyText              ${FirstName} may be eligible for a Latitude Personal Loan


    #Start Apllication page


    VerifyText              Repayment
    VerifyText              Weekly                      anchor=Repayment frequency
    VerifyText              % p.a.                      anchor=Indicative rate
    VerifyText              25,000.00                   anchor=Loan amount          recognition_mode=vision
    VerifyText              3 Years                     anchor=Loan term
    VerifyText              Unsecured                   anchor=Secured or Unsecured loan
    VerifyText              Variable                    anchor=Variable or Fixed loan
    VerifyText              Variable                    anchor=Variable or Fixed loan
    Scroll to               Broker Fee

    VerifyText              40.00                       anchor=Broker Fee           recognition_mode=vision
    VerifyText              395.00                      anchor=Loan establishment fee                           recognition_mode=vision
    VerifyText              13.00                       anchor=Loan administration fee (monthly)                recognition_mode=vision

    ClickText               Secured Vs Unsecured Loan
    VerifyText              What is secured loan?
    ClickText               close
    ClickText               Variable Vs Fixed Loan
    VerifyText              Fixed vs Variable loan
    ClickText               close
    ClickText               Fees & charges
    VerifyText              Fees and charges
    ClickText               close
    ClickText               Start Application

    #Employment page
    VerifyText              Employment
    VerifyText              Employment Details
    ${applicationID}=     GetText           //div[@data-style-field-name\="genesis__Application__r_Name"]
    Log To Console                   ${applicationID}
    ClickText               Please select               anchor=Current employment status
    ClickText               Permanent – Full time
    TypeText                Current employer name       xyz
    ClickText               Please select               anchor=Time at current employment
    ClickText               3 - 5 months
    ClickText               Please select               anchor=Previous employment status                       delay=2
    ClickText               Permanent – Full time       anchor=Please select
    # DropDown              Previous employment status                              Permanent – Full time


    ClickText               Please select               anchor=Time at previous employer
    ClickText               6 - 11 months
    ClickText               Monthly                     anchor=Primary income frequency                         delay=5
    # ClickText               Monthly                     partial_match=false    
    PressKey                 ${EMPTY}                   {ENTER}                 
    ClickElement            //div[@aria-label\="Your primary income after tax"]//input
    PressKey                //div[@aria-label\="Your primary income after tax"]//input                          {CONTROL + A + BACKSPACE}
    # TypeText              Weekly primary income (after tax)                       Qentinel                    clear_key={BACKSPACE}
    TypeText                Monthly primary income (after tax)                      40,000.00

    # ${num1}=              Set Variable                ${173633.33}
    # ${num2}=              Set Variable                ${13}
    # ${mysum}=             Set Variable                ${${num1} + ${num2}}
    # ${myprod}=            Set Variable                ${${num1} * ${num2}}
    # ${amountNumber}=      GetText                     //span[@class\="total_montly_expenses_amount"]
    # ${variable_without_character}=                    Replace String              ${amountNumber}             $                  ${EMPTY}
    # ${variable_without_character}=                    Replace String              ${variable_without_character}                  ,    ${EMPTY}
    # Should Be Equal As Strings                        ${variable_without_character}                           ${num1}

    ClickElement            //input[@name\="Do you receive any additional income?"][@value\="Yes"]
    ClickText               Please select               anchor=Income Source
    Clicktext               Investment
    ClickElement            //div[@aria-label\="Amount"]//input
    WriteText               300.00
    ClickElement            //input[@name\="Do you foresee any adverse changes to your current financial circumstances?"][@value\="Yes"]
    ClickElement            //div[@aria-label\="How much will your financial situation reduce by?"]//input
    WriteText               100.00
    ClickText               Continue

    #Expenses Page

    VerifyText              Expenses
    VerifyText              Living situation & expenses
    VerifyInputElement      //div[@aria-label\="Residential Status"]//input
    #anchor=Residential status                          recognition_mode=vision
    TypeText                Share of monthly rent/mortgage                          100
    ClickText               Please select               anchor=Relationship status
    ClickText               Single
    ClickText               Please select               anchor=Number of dependants
    ClickText               3
    ClickText               //div[@aria-label\="CS Household Expense Check"]//input[@value\="Yes, all"]
    ClickElement            //input[@name\="Does the applicant own any investment properties?"][@value\="Yes"]
    ClickElement            //div[@aria-label\="Share of monthly investment property?"]//input
    WriteText               100.00
    ClickElement            //div[@aria-label\="Share of monthly investment property ?"]//input
    WriteText               50.00
    ClickElement            //div[@aria-label\="Share of monthly non-essential spending?"]//input
    WriteText               55.00
    #credit card
    ClickText               Yes                         anchor=Does the applicant have any credit or store cards?
    ClickText               Please select               anchor=Financial institution
    ClickText               Bank of SA
    ClickElement            //div[@aria-label\="What is the combined credit limit of your cards?"]//input
    WriteText               1000.00
    ClickElement            //div[@aria-label\="What is the total balance owing on your credit cards?"]//input
    WriteText               5000.00
    ClickElement            //div[@data-style-field-name\="To_be_paid_out__c"]//input
    #other loan
    ClickText               Yes                         anchor=Does applicant have any other loans (including personal or auto)?
    ClickText               Please select               anchor=Loan type
    ClickText               Auto loan
    ClickText               Please select               anchor=Financial institution
    ClickText               Bank of SA
    ClickElement            //div[@aria-label\="Balance owing on this loan"]//input
    WriteText               300.00
    ClickText               Please select               anchor=Repayment frequency
    ClickText               MONTHLY                     anchor=Please Select
    ClickElement            //div[@aria-label\="Repayment Amount"]//input
    WriteText               100.00
    ClickElement            //div[@data-style-field-name\="Eligible_for_Debt_Consolidation__c"]//input
    ClickText               Continue

    #Application Confirm


    VerifyText              Application Confirm
    VerifyText              Please review ${FirstName}'s loan
    VerifyText              Loan details
    VerifyText              $25,000.00
    VerifyText              3 Years
    VerifyText              24.24% p.a.
    VerifyText              Fixed
    VerifyText              $395.00
    VerifyText              $13.00
    VerifyText              $40.00
    VerifyText              $253.52
    VerifyText              WEEKLY
    ClickText               Continue

    #Consent
    VerifyText              Consent
    VerifyText              Broker notes for the application assessment team
    ClickCheckbox    The customer has read, understood and consents to all points below:    on
    ClickText    Submit
    # Id Verification 
    VerifyText    Id Verification                       
    ClickText    Medicare                        anchor=ID type
    ClickText    Driver’s licence
    TypeText    Drivers Licence Number *    354352646
    ClickText                        Please select                        anchor=State of Issue
    ClickText    NSW
    TypeText    Card Number *    3254342534
    ClickText    Continue
    # Income Verification
    VerifyText    Income Verification
    #VerifyText    Income documents upload
    ClickText    Upload documents
    UploadFile    Add Files   ${FILE_PATH}

    
   
    





