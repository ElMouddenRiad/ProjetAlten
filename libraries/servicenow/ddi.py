from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from utils import get_driver, get_wait
from navigation import switch_to_main_iframe
from selenium.webdriver.support.ui import Select
import time

def aller_à_lien_ticket(url):
    driver = get_driver()
    driver.get(url)

def forcer_raz_et_mettre_ticket_actif():
    driver = get_driver()
    wait = get_wait()

    #switch_to_main_iframe()

    # Forcer RAZ
    label_raz = wait.until(
        lambda d: d.find_element(By.CSS_SELECTOR, "#label\\.ni\\.u_savftth\\.u_force_raz")
    )
    driver.execute_script("arguments[0].scrollIntoView(true);", label_raz)
    time.sleep(0.5)
    label_raz.click()

    # statut "Active"
    select_statut = wait.until(
        lambda d: d.find_element(By.CSS_SELECTOR, "#u_savftth\\.state")
    )
    Select(select_statut).select_by_visible_text("Active")

    # étape technique "Trt Usine"
    select_techstage = wait.until(
        lambda d: d.find_element(By.CSS_SELECTOR, "#u_savftth\\.u_techstage")
    )
    Select(select_techstage).select_by_visible_text("Trt Usine")

    # "Enregistrer"
    bouton_enregistrer = wait.until(
        lambda d: d.find_element(By.CSS_SELECTOR, "#sysverb_update_and_stay")
    )
    bouton_enregistrer.click()


def affecter_ticket(login="Altst004 ALTST004"):
    driver = get_driver()
    wait = get_wait()

    assigned_to_input = wait.until(
        lambda d: d.find_element(By.CSS_SELECTOR, "#sys_display\\.u_savftth\\.assigned_to")
    )
    assigned_to_input.clear()
    assigned_to_input.send_keys(login)
    time.sleep(1)
    assigned_to_input.send_keys(Keys.TAB)

    time.sleep(1)

    bouton_enregistrer = driver.find_element(By.CSS_SELECTOR, "#sysverb_update_and_stay")
    bouton_enregistrer.click()

def cliquer_sur_demande_information():
    driver = get_driver()
    wait = get_wait()
    #switch_to_main_iframe()
    bouton_demande = wait.until(
        lambda d: d.find_element(By.CSS_SELECTOR, "#u_ticketsav_infoRequest")
    )
    driver.execute_script("arguments[0].scrollIntoView(true);", bouton_demande)
    time.sleep(0.5)
    bouton_demande.click()

def remplir_motif_et_worknote():
    driver = get_driver()
    wait = get_wait()

    select_elem = wait.until(lambda d: d.find_element(By.ID, "ddi_reason"))

    # motif "Refaire les tests du N1"
    Select(select_elem).select_by_value("refaire_les_tests_du_n1")

    # Work Note : "TEST DDI"
    textarea = wait.until(lambda d: d.find_element(By.ID, "dialog_comments"))
    textarea.clear()
    textarea.send_keys("TEST DDI")


def confirmer_demande_information():
    driver = get_driver()
    wait = get_wait()

    wait.until(lambda d: d.find_element(By.ID, "dialog_buttons"))

    bouton_ok = wait.until(lambda d: d.find_element(By.ID, "ok_button"))

    driver.execute_script("arguments[0].scrollIntoView(true);", bouton_ok)
    time.sleep(0.5)
    bouton_ok.click()

def verifier_etat_et_etape_technique():
    driver = get_driver()
    wait = get_wait()

    #switch_to_main_iframe()

    # recuperer l'état et étape technique
    etat_select_elem = wait.until(lambda d: d.find_element(By.ID, "u_savftth.state"))
    etape_elem = wait.until(lambda d: d.find_element(By.ID, "u_savftth.u_techstage"))

    etat_select = Select(etat_select_elem)
    etat_label = etat_select.first_selected_option.text.strip().lower()

    etape_value = etape_elem.get_attribute("value").strip().lower()

    print(f"[DEBUG] État visible (label) : {etat_label}")
    print(f"[DEBUG] Étape technique : {etape_value}")

    # anglais ou français
    assert any(x in etat_label for x in ["freezed", "gelé"]), "L'état n'est pas 'gelé/Freezed'"
    assert "attente_client_ddi" in etape_value, "Étape technique incorrecte"



def verifier_envoi_sms():
    driver = get_driver()
    wait = get_wait()

    #switch_to_main_iframe()

    wait.until(lambda d: d.find_element(By.ID, "sn_form_inline_stream_entries"))
    ul = driver.find_element(By.CSS_SELECTOR, "#sn_form_inline_stream_entries > ul.activities-form")
    elements_li = ul.find_elements(By.CSS_SELECTOR, "li.h-card")

    contenu_global = ""
    for li in elements_li:
        try:
            # acitivtés (work notes)
            metadata = li.find_element(By.CSS_SELECTOR, ".sn-card-component-time").text.lower()
            if "work notes" in metadata:
                # Extraire le texte du bloc de contenu
                bloc = li.find_element(By.CSS_SELECTOR, ".sn-card-component_summary")
                contenu = bloc.text.strip().lower()
                contenu_global += contenu + "\n"
        except Exception as e:
            continue  # Ignore les cartes non conformes

    print("[DEBUG] Contenu global des notes de travail :")
    print(contenu_global)

    if "l'envoi du sms a été effectué avec succès" in contenu_global:
        print("[INFO] ✅ SMS envoyé avec succès")
    elif "le sms ftth - ddi - demande d'information n'a pas été envoyé" in contenu_global:
        print("[AVERTISSEMENT] ⚠️ SMS non envoyé")
    else:
        print("[AVERTISSEMENT] ⚠️ Aucun message relatif au SMS trouvé")



def recuperer_numero_ticket():
    driver = get_driver()
    wait = get_wait()
    #switch_to_main_iframe()

    numero_elem = wait.until(lambda d: d.find_element(By.ID, "u_savftth.number"))
    numero = numero_elem.get_attribute("value")
    print(f"Numéro du ticket : {numero}")
    return numero
