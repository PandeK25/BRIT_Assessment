*** Settings ***
Documentation  Below test is for verifying UI test case
Library    SeleniumLibrary

*** Variables ***
${URL}            https://www.britinsurance.com/
${SEARCH_TERM}    IFRS 17
${SEARCH_BOX}     css=div.component--header__search > button
${SEARCH_BOX_EXPANDED}     css=div.component--header__navigation.search > div.header--search > input[type=search]
${RESULT_TITLES}  css=div.component--header__navigation.search > div.header--search.active > div > div
${COOKIE_ACCEPT}  css=#CybotCookiebotDialogBodyButtonsWrapper > button:nth-child(4)

*** Test Cases ***
Verify Search Results For IFRS 17
    Set Library Search Order    SeleniumLibrary   Selenium2Library
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    ${STATUS}   Run Keyword And Return Status    Wait Until Page Contains Element    ${COOKIE_ACCEPT}
    Run Keyword If    '${STATUS}'=='${True}'   Click Element   ${COOKIE_ACCEPT}
    Wait Until Element Is Visible    ${SEARCH_BOX}    10s
    Reload Page
    Sleep   10s
    Execute Javascript   $('div.component--header__search > button').click();
#    Click Element   ${SEARCH_BOX}
    Input Text    ${SEARCH_BOX_EXPANDED}    ${SEARCH_TERM}
    Wait Until Element Is Visible    ${RESULT_TITLES}    10s
    ${results}    Get WebElements    ${RESULT_TITLES}
    ${len}   Get length   ${results}
    Should Be True    ${len} == 5    Expected 5 results but got ${len}
    Should Contain    ${results}[0].text    Interim results for the six months ended 30 June 2022
    Close Browser
