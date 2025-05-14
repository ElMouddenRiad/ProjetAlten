*** Settings ***
Library    SeleniumLibrary
resource  ../resources/variables.robot

*** Keywords ***
Ouvrir le navigateur ServiceNow
    Open Browser    ${SERVICENOW_URL}    ${BROWSER}
    Maximize Browser Window

Se connecter à ServiceNow
    Wait Until Element Is Visible    id=user_name    timeout=15s
    Input Text    id=user_name    ${SNOW_USERNAME}
    Input Text    id=user_password    ${SNOW_PASSWORD}
    Click Button    id=sysverb_login


Naviguer Vers Lien Ticket Spécifique
    [Documentation]    Navigue vers une URL spécifique du ticket ServiceNow pour consultation ou modification.
    Go To    https://bouyguestelecomltt3.service-now.com/u_savftth.do?sys_id=06245107830f92105985bfa6feaad368&sysparm_record_target=u_savftth&sysparm_record_row=4&sysparm_record_rows=7&sysparm_record_list=u_techstage%3DTrt_Usine%5EORDERBYstate
    Sleep    5s