*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}      https://restful-api.dev/objects
${HEADERS}       Create Dictionary    Content-Type=application/json

*** Test Cases ***
Update Object with PATCH
    [Documentation]    Test updating an object using PATCH request
    [Tags]    PATCH    API
    Create Session    mySession    ${BASE_URL}
    ${object_id}    Set Variable    7
    ${payload}    Create Dictionary    name=Apple MacBook Pro 16 (Updated Name)
    ${response}    Patch Request   mySession  /${object_id}  json=${payload}  headers=${HEADERS}
    Log To Console  ${response.json()}
    Should Be Equal As Strings  ${response.status_code}  200
    ${response_body}    Convert To Dictionary  ${response.json()}
    Dictionary Should Contain Key  ${response_body}  id
    Dictionary Should Contain Key  ${response_body}  name
