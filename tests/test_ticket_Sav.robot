from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time

# Paramètres utilisateur
SNOW_USERNAME = "altst004"
SNOW_PASSWORD = "Automatisation@2023"

# URL cible
url = "https://bouyguestelecomltt3.service-now.com/u_savftth.do?sys_id=c012e2df838d1a105985bfa6feaad3b4&sysparm_record_target=u_savftth&sysparm_record_row=4&sysparm_record_rows=7&sysparm_record_list=u_techstage%3DTraitement_IG%5EORDERBYstate"

# Setup navigateur Chrome
options = Options()
options.add_argument("--start-maximized")
driver = webdriver.Chrome(options=options)

try:
    # Accès à la page
    driver.get(url)

    # Authentification (ServiceNow standard)
    time.sleep(3)  # Attente pour le chargement

    username_input = driver.find_element(By.ID, "user_name")
    password_input = driver.find_element(By.ID, "user_password")
    login_button = driver.find_element(By.ID, "sysverb_login")

    username_input.send_keys(SNOW_USERNAME)
    password_input.send_keys(SNOW_PASSWORD)
    login_button.click()

    # Attendre le chargement de la page après connexion
    time.sleep(5)

    # Accès au shadow DOM et au champ "Assigned to"
    # JS pour explorer et accéder au champ dans le shadowRoot
    shadow_element_script = '''
        const root1 = document.querySelector('now-record-form-connected');
        const shadow1 = root1.shadowRoot;
        const assignedField = shadow1.querySelector('sn-record-picker[name="assigned_to"]');
        const shadow2 = assignedField.shadowRoot;
        const inputField = shadow2.querySelector('input');
        inputField.value = "Altst004";
        inputField.dispatchEvent(new Event('input', { bubbles: true }));
        return true;
    '''
    driver.execute_script(shadow_element_script)

    print("Champ 'Assigned to' rempli avec succès.")

    # Attente pour voir le résultat
    time.sleep(10)

finally:
    driver.quit()
