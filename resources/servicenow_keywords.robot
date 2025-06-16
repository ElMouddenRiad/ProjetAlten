*** Settings ***
Library    SeleniumLibrary
resource  ../resources/variables.robot
Library    ../libraries/servicenow/navigation.py
Library    ../libraries/servicenow/champs.py
Library    ../libraries/servicenow/ddi.py

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
    ${url}=    Remplir Champs Obligatoires IU
    RETURN    ${url}

Aller à l'URL du Ticket
    [Arguments]    ${url}
    Aller À Lien Ticket    ${url}

Forcer Raz et Mettre Le Ticket Actif
    Forcer Raz et Mettre Ticket Actif
    
Affecter Ticket à l'utilisateur
    [Arguments]    ${login}=altst004
    Affecter Ticket    ${login}
    
Lancer Demande Information
    Cliquer Sur Demande Information
    Remplir Motif Et Worknote
    Confirmer Demande Information

Verification envoi SMS
    Verifier Etat Et Etape Technique
    Verifier Envoi Sms
    Recuperer Numero Ticket