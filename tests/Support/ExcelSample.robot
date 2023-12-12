*** Settings ***

Documentation           Test suite for CRT starter.
Library                 QWeb
Library                 ../../resources/make_excel.py
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers
Resource    ../../resources/common.robot

*** Variables ***

${FILENAME}        StoredValues.xlsx

*** Test Cases ***

Test
    make_excel   ${OUTPUT_DIR}${/}${FILENAME}
    add_value  ${OUTPUT_DIR}${/}${FILENAME}  Ordernumber    123
    add_value  ${OUTPUT_DIR}${/}${FILENAME}  OppoNumber    1234343