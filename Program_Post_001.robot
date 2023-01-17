*** Settings ***
Library     RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    os


*** Variables ***
${base_url}         https://lms-backend-service.herokuapp.com/lms

*** Test Cases ***
Post_ProgramValid
    create session  mysession   ${base_url}         verify=true
    ${programNameActual}=       Convert To String            Jan23-Test1-SDET-900A01C1233
    Log To Console    ${programNameActual}

    ${body}=            Create Dictionary    programName=${programNameActual}    programDescription=SQLAgain    programStatus=Active    creationTime=2023-01-15T18:43:22.620+00:00      lastModTime=2023-01-15T18:43:22.620+00:00
    Log To Console    ${body}
    ${header}=          Create Dictionary    Content-Type=application/json
    ${response}=        Post Request         mysession   /saveprogram    data=${body}        headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}
#    log to console  ${response.headers}

    #VALIDATIONS
    ${status_code}=     Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}   201

    ${response_body} =           Convert To String       ${response.content}
#    Should Contain    ${response_body}       ENTITY_DOES_NOT_EXIST

    ${contentTypeValue} =       get from dictionary     ${response.headers}     Content-Type
    Should Be Equal         ${contentTypeValue}     application/json

    Should Contain          ${response_body}    programId


    ${programId}=          Get Value From Json           ${response.json()}       programId
#    ${programNameResponse}=     Get Value From Json     ${response_body}        $.programName
    Log To Console      ${programId}
#    Should Be Equal     ${programNameResponse}         ${programNameActual}

