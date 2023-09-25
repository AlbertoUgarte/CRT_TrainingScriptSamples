# Tip: Everything that starts with # is a guidance for you and will not get executed.


*** Settings ***

Documentation           Test suite for CRT starter.
Library                 QWeb
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

# Tip: The Settings section is where you define test suite level configuration.
#      Suite Setup and Teardown are actions that happen before and after a test suite run.
#      For first time users, we don't recommend to change them.
#      You may change chrome to firefox should you wish to test your application on Firefox.

*** Test Cases ***

Check the navigation menu items
    [Documentation]     Go to the shop homepage and verify the menu items.
    [Tags]              Products    Story
    GoTo                https://qentinelqi.github.io/shop/
    VerifyText          Products
    VerifyText          Our Story
    LogScreenshot
    VerifyText          Contact
