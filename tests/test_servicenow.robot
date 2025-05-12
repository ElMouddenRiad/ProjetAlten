*** Settings ***
Library    SeleniumLibrary   
Resource    ../resources/servicenow_keywords.robot
Library    ../libraries/shadow1.py
Suite Setup    Ouvrir le navigateur ServiceNow
#Suite Teardown    Fermer le navigateur

*** Test Cases ***
Création et vérifications d’un ticket sur ServiceNow
    [Documentation]    Simule la création d’un ticket LTT ServiceNow et vérifie l’ensemble des éléments requis.
    Se connecter à ServiceNow
    #Remplir champ global search    créer QT
    Sleep    time_=10
    Cliquer Sur Bouton All
    Sleep    time_=10
    Rechercher Et Selectionner Creer QT

    Sleep    time_=20
    Remplir Champs Obligatoires QT
    Sleep    time_=30
