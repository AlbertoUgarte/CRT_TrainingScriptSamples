*** Settings ***
Resource                ../resources/common.robot
Test Teardown           Close All Excel Documents
Suite Setup             Setup Browser
Suite Teardown          End Suite
*** Variables ***
${excel_worksheet}     ${CURDIR}/../resources/StoredValues.xlsx

*** Test Cases ***
# Verify Products
#     [Documentation]     Read product names from excel sheet and verify that those can be found from a webshop page
#     [Tags]              excel    products    verify


#     # Open existing workbook
#     ${document}=        Open Excel Document    ${excel_worksheet}    products

#     # Start reading values from the second row, max number needs to be provided with offset
#     ${product_names}=   Read Excel Column    col_num=1    max_num=6    row_offset=1    sheet_name=Sheet
   

Update Product Id
    [Documentation]     Update product id to an excel sheet and save changes
    [Tags]              excel    products    update
    GoTo                ${webshop}
    VerifyText          Find your spirit animal

    # Open existing workbook
    ${document}=        Open Excel Document    ${excel_worksheet}    products

    # Create new unique product id
    ${new_id}=          Generate Random String    length=6    chars=[NUMBERS]

    # Get the current product id
    ${current_id}=      Read Excel Cell    row_num=2    col_num=1    sheet_name=Sheet
    ${1current_id}=      Read Excel Cell    row_num=3    col_num=1    sheet_name=Sheet
    ${2current_id}=      Read Excel Cell    row_num=2    col_num=2    sheet_name=Sheet
    ${3current_id}=      Read Excel Cell    row_num=3    col_num=2    sheet_name=Sheet

    # Write new product id to the excel
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
    #Commit And Push     ${excel_worksheet}     ${git_branch}