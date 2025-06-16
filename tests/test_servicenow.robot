*** Settings ***
Resource    ../resources/servicenow_keywords.robot
Suite Setup    Ouvrir le navigateur ServiceNow
#Suite Teardown    Fermer le navigateur

*** Test Cases ***
Création et vérifications d’un ticket sur ServiceNow
    [Documentation]    Simule la création d’un ticket LTT ServiceNow et vérifie l’ensemble des éléments requis.
    Se connecter à ServiceNow
    Sleep    time_=5
    Naviguer à la création du ticket IU
    Sleep    time_=5
    ${url_ticket}=    Remplir les champs du ticket IU
    Sleep    time_=5

DDI
    #Aller à l'URL du Ticket    ${url_ticket}
    #Aller à l'URL du Ticket    https://bouyguestelecomltt3.service-now.com/now/nav/ui/classic/params/target/u_savftth.do%3Fsys_id%3D5ead0f5b838aa2105985bfa6feaad3c0%26sysparm_view%3D
    #Se connecter à ServiceNow
    #Sleep    time_=5
    Forcer Raz et Mettre Le Ticket Actif
    Sleep    time_=5
    Affecter Ticket à l'utilisateur    Altst004 ALTST004
    Sleep    time_=5
    Lancer Demande Information
    Sleep    time_=5
    Verification envoi SMS