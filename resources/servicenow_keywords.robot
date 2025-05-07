*** Settings ***
Library    SeleniumLibrary
resource  ../resources/variables.robot
Library    ../libraries/servicenow/navigation.py
Library    ../libraries/servicenow/champs.py

*** Keywords ***
Ouvrir le navigateur ServiceNow
    Open Browser    ${SERVICENOW_URL}    ${BROWSER}
    Maximize Browser Window

Se connecter à ServiceNow
    Wait Until Element Is Visible    id=user_name    timeout=15s
    Input Text    id=user_name    ${SNOW_USERNAME}
    Input Text    id=user_password    ${SNOW_PASSWORD}
    Click Button    id=sysverb_login

Naviguer à la création du ticket IU
    Cliquer Sur Bouton All
    Rechercher Et Selectionner Creer Iu

Remplir les champs du ticket IU
    Remplir Champs Obligatoires Iu