*** Settings ***
Resource                ../resources/common.robot
Test Teardown           Close All Excel Documents
Suite Setup             Setup Browser
Suite Teardown          End Suite
*** Variables ***
${excel_worksheet}     ${CURDIR}/../resources/StoredValues.xlsx

*** Test Cases ***
   
Update Excel Spreadsheet
    [Documentation]     Update data to an excel sheet and save changes
    [Tags]              excel      update

    # Open existing workbook
    ${document}=        Open Excel Document    ${excel_worksheet}    products

    # Create new unique product id
    ${new_id}=          Generate Random String    length=6    chars=[NUMBERS]
    ${new_id_2}=          Generate Random String    length=6    chars=[NUMBERS]
    ${new_id_3}=          Generate Random String    length=6    chars=[NUMBERS]
    ${new_id_4}=          Generate Random String    length=6    chars=[NUMBERS]


    # If you also need to Read data from the Excel file use this code Below i.e. to Get the current product id
    # ${current_id}=      Read Excel Cell    row_num=2    col_num=1    sheet_name=Sheet
    # ${1_current_id}=      Read Excel Cell    row_num=3    col_num=1    sheet_name=Sheet
    # ${2_current_id}=      Read Excel Cell    row_num=2    col_num=2    sheet_name=Sheet
    # ${3_current_id}=      Read Excel Cell    row_num=3    col_num=2    sheet_name=Sheet

    # Write data to the excel
    Write Excel Cell    row_num=2    col_num=1    value=${new_id}    sheet_name=Sheet
    Write Excel Cell    row_num=3    col_num=1    value=${new_id}    sheet_name=Sheet
    Write Excel Cell    row_num=2    col_num=2    value=${new_id}    sheet_name=Sheet
    Write Excel Cell    row_num=3    col_num=2    value=${new_id}    sheet_name=Sheet

    # Check that new value was updated to excel
    # ${updated_id}=      Read Excel Cell    row_num=2    col_num=2    sheet_name=Sheet
    # Should Be Equal As Strings    ${new_id}    ${updated_id}

    # Save changes to excel and commit to git
    Save Excel Document  ${excel_worksheet}
    Move File         ${excel_worksheet}          ${OUTPUT DIR}   
