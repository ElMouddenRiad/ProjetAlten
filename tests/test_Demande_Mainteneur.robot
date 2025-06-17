*** Settings ***
Resource    ../resources/Demande_mainteneur_Keyword.robot
Library    ../libraries/DDI Ali/ShadowDDI_InterventionMainteneur.py
Suite Setup    Ouvrir le navigateur ServiceNow


*** Test Cases ***
Test DDI Complet
    [Documentation]    Simule une demande d'information 
    Se connecter à ServiceNow
    Sleep    time_=10

    Cliquer Sur Bouton All
    Sleep    time_=10
    Rechercher Et Selectionner Ticket SAV Ouverts
    Sleep    time_=10
    Naviguer Vers Lien Ticket Spécifique
    Sleep    time_=10
    Forcer Raz Et Mettre Ticket Actif
    Sleep    time_=10
    Affecter Ticket
    Sleep    time_=10
    cliquer bouton save
    Sleep    time_=10
    Clicker Boutton Demande Intervention
    Sleep    time_=10
    Remplir Champ Source Tag
    Sleep    time_=10
    Remplir Champ Type Intervention
    Sleep    time_=10
    Clicker Bouton Prender RDV Immediat
    Sleep    time_=10
    Choisir Rdv Jplus2 Apres Midi
    Sleep    time_=10
    cliquer_bouton_Reserver_RDV
    Sleep    time_=10
    cliquer_bouton_Modifier_RDV
    Sleep    time_=10


