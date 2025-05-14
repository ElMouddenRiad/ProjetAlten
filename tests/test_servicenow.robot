*** Settings ***
Resource    ../resources/servicenow_keywords.robot
Library     ../libraries/shadow1.py
Suite Setup   Ouvrir le navigateur ServiceNow
#Suite Teardown    Fermer le navigateur

*** Test Cases ***
Création et vérifications d’un ticket sur ServiceNow
    [Documentation]    Simule la création d’un ticket LTT ServiceNow et vérifie l’ensemble des éléments requis.
    Se connecter à ServiceNow
    Sleep    time_=10
    #Remplir champ global search    créer QT
    Cliquer Sur Bouton All
    Sleep    time_=10
    Rechercher Et Selectionner Ticket SAV Ouverts
    Sleep    time_=10
    Naviguer Vers Lien Ticket Spécifique
    Sleep    time_=10
    Remplir Champ Assigned To
    Sleep    time_=10
    cliquer bouton save
    Sleep    time_=10
    cliquer bouton request for information
    Sleep    time_=10
    traiter popup information
    Sleep    time_=10
    verifier etat et etape technique
    Sleep    time_=10
