*** Settings ***
Library     RequestsLibrary

Library    Collections

*** Variables ***
${base_url}         https://lms-backend-service.herokuapp.com/lms
${programId}        9965

*** Test Cases ***
Delete_ProgramValid
    create session  mysession   ${base_url}         verify=true
    ${response} =   Delete Request  mysession   /deletebyprogid/${programId}

#    log to console  ${response.status_code}
#    log to console  ${response.content}
#    log to console  ${response.headers}

    #VALIDATIONS
#    ${status_code}=     Convert To String    ${response.status_code}
#    Should Be Equal    ${status_code}   200

    ${body} =           Convert To String       ${response.content}
    Should Contain    ${body}       ENTITY_DOES_NOT_EXIST

    ${contentTypeValue} =       get from dictionary     ${response.headers}     Content-Type
    Should Be Equal         ${contentTypeValue}     application/json



