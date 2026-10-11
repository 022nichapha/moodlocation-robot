*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Set Selenium Speed    0.2 seconds
Test Setup        Open App
Test Teardown     Close All Browsers

*** Variables ***
${BASE_URL}             https://moodlocation.vercel.app/
${BROWSER}              Chrome

# Locators
${LOGIN_LINK}           xpath=//a[contains(normalize-space(.),'เข้าสู่ระบบ')]
${EMAIL_INPUT}          xpath=//input[@placeholder='example@mail.com']
${PASSWORD_INPUT}       xpath=//input[@placeholder='••••••••']
${LOGIN_BUTTON}         xpath=//form//button[contains(normalize-space(.),'เข้าสู่ระบบ')]

${MOOD_STRESSED_BTN}    xpath=//*[self::button or @role='button'][contains(normalize-space(.),'เครียด')]
${MOOD_HAPPY_BTN}       xpath=//*[self::button or @role='button'][contains(normalize-space(.),'มีความสุข')]

${SEARCH_NEARBY_BTN}    xpath=(//*[contains(normalize-space(.),'ค้นหาสถานที่ใกล้ฉัน')])[last()]
${REVIEW_BTN_FIRST}     xpath=(//*[self::button or self::a][contains(normalize-space(.),'ดูรูปภาพและรีวิว')])[1]
${REVIEW_BTN_SECOND}    xpath=(//*[self::button or self::a][contains(normalize-space(.),'ดูรูปภาพและรีวิว')])[2]

${BACK_INDEX_2}         xpath=(//button)[3]
${BACK_CATEGORY}        xpath=//*[self::button or self::a][contains(normalize-space(.),'กลับไปเลือกประเภท')]
${BACK_MOOD}            xpath=//*[self::button or self::a][contains(normalize-space(.),'กลับไปเลือกอารมณ์')]

*** Keywords ***
Open App
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --start-maximized
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    options=${options}
    Go To    ${BASE_URL}
    Set Selenium Implicit Wait    2 seconds
    Wait Until Page Contains Element    xpath=//body    15 seconds

JS Click
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    15 seconds
    ${element}=    Get WebElement    ${locator}
    Execute JavaScript    arguments[0].scrollIntoView({block: 'center'}); arguments[0].click();    ARGUMENTS    ${element}

Safe JS Click
    [Arguments]    ${locator}    ${timeout}=3s
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${locator}    ${timeout}
    IF    ${status}
        ${element}=    Get WebElement    ${locator}
        Execute JavaScript    arguments[0].scrollIntoView({block: 'center'}); arguments[0].click();    ARGUMENTS    ${element}
    END

Login To App
    ${email}=           Get Environment Variable    MOOD_EMAIL    ${EMPTY}
    ${password}=        Get Environment Variable    MOOD_PASSWORD    ${EMPTY}

    Should Not Be Empty    ${email}       กรุณากำหนด MOOD_EMAIL ใน Terminal
    Should Not Be Empty    ${password}    กรุณากำหนด MOOD_PASSWORD ใน Terminal

    JS Click    ${LOGIN_LINK}

    Wait Until Page Contains Element    ${EMAIL_INPUT}    10 seconds
    Clear Element Text    ${EMAIL_INPUT}
    Input Text    ${EMAIL_INPUT}    ${email}
    Clear Element Text    ${PASSWORD_INPUT}
    Input Text    ${PASSWORD_INPUT}    ${password}

    JS Click    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${MOOD_STRESSED_BTN}    15 seconds

Search Mood
    [Arguments]    ${mood_locator}
    JS Click    ${mood_locator}

    Wait Until Page Contains Element    ${SEARCH_NEARBY_BTN}    15 seconds
    JS Click    ${SEARCH_NEARBY_BTN}

    Wait Until Page Contains Element    ${REVIEW_BTN_FIRST}    15 seconds

Open Place Details
    # ลองกดปุ่มรีวิวอันที่สอง ถ้าไม่มีให้กดอันแรกแทน
    ${has_second}=    Run Keyword And Return Status    Page Should Contain Element    ${REVIEW_BTN_SECOND}
    IF    ${has_second}
        JS Click    ${REVIEW_BTN_SECOND}
    ELSE
        JS Click    ${REVIEW_BTN_FIRST}
    END

    Sleep    1 second

    # ย้อนกลับแบบยืดหยุ่น (จะไม่พังถ้าบางปุ่มไม่มีอยู่จริง)
    Safe JS Click    ${BACK_INDEX_2}    2s
    Safe JS Click    ${BACK_CATEGORY}   2s
    Safe JS Click    ${BACK_MOOD}       2s

*** Test Cases ***
TC_2_0_001: เลือกอารมณ์เครียดและค้นหาสถานที่
    [Documentation]    เลือกอารมณ์เครียด ค้นหาสถานที่ และเปิดรายละเอียด
    Login To App
    Search Mood    ${MOOD_STRESSED_BTN}
    Open Place Details

TC_2_0_002: เปลี่ยนอารมณ์เป็นมีความสุขและค้นหาสถานที่
    [Documentation]    เปลี่ยนจากอารมณ์เครียดเป็นมีความสุขและค้นหาสถานที่
    Login To App
    Search Mood    ${MOOD_STRESSED_BTN}

    # ย้อนกลับเพื่อเลือกอารมณ์ใหม่
    Safe JS Click    ${BACK_CATEGORY}   2s
    Safe JS Click    ${BACK_MOOD}       2s

    Search Mood    ${MOOD_HAPPY_BTN}
    Open Place Details