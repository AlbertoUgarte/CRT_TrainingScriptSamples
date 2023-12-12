*** Settings ***

Documentation           Test suite for CRT starter.
Library                 QWeb
Library                 make_excel.py
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers


*** Variables ***

${FILENAME}        StoredValues.xlsx

*** Test Cases ***

Test
    make_excel   ${OUTPUT_DIR}${/}${FILENAME}
    add_value  ${OUTPUT_DIR}${/}${FILENAME}  Ordernumber    123
    add_value  ${OUTPUT_DIR}${/}${FILENAME}  OppoNumber    1234343