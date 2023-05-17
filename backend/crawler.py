from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
import os
import shutil
import sys

# Setup webdriver
s=Service(ChromeDriverManager().install())

chrome_options = Options()

# Set the download directory (replace '/path/to/download/directory' with your directory)
chrome_options.add_experimental_option('prefs',  {
    "download.default_directory": 'C:\\Users\\SSAFY\\Desktop\\proj\\macro',
    "download.prompt_for_download": False,
    "download.directory_upgrade": True,
    "plugins.always_open_pdf_externally": True
    })

driver = webdriver.Chrome(service=s, options=chrome_options)

# Navigate to the login page
driver.get('https://soundraw.io/users/sign_in')

# Find the username and password fields (you'll need to inspect the page to find the right selectors)
username_field = driver.find_element(By.ID, 'email-sign-in')
password_field = driver.find_element(By.ID, 'password-sign-in')

# Enter your username and password
username_field.send_keys('fleur75921@gmail.com')
password_field.send_keys('a101ssafy')

# Find the login button and click it
login_button = driver.find_element(By.CSS_SELECTOR, 'input.btn.btn-yellow.w-100.text-font-semi-bold')
login_button.click()

# Wait for the login to complete (you may need to adjust this)
time.sleep(5)

# Check if you're logged in by looking for an element that's only present when you're logged in
# If you're not logged in, stop the script (you could also add code to retry the login)
if not driver.find_elements(By.ID, 'profile-btn'):
    print('Login failed')
    driver.quit()

if len(sys.argv) > 1:
    url = sys.argv[1]
    driver.get(url)
else:
    # Navigate to the download page (replace with the URL of the download page)
    driver.get('https://soundraw.io/edit_music?length=60&tempo=normal,high,low&mood=Epic')

# Wait for the login to complete (you may need to adjust this)
time.sleep(20)

# Find the download button (you'll need to inspect the page to find the right selector)
download_button = driver.find_element(By.CSS_SELECTOR, 'svg.fa-arrow-down')

# Click the download button
download_button.click()

# Wait for the download to start (you may need to adjust this)
time.sleep(60)

# Define your two directories
download_directory = 'C:\\Users\\SSAFY\\Desktop\\proj\\macro\\tmp'
destination_directory = 'C:\\Users\\SSAFY\\Desktop\\proj\\macro\\musics'

# Check if a file has been downloaded
while not os.listdir(download_directory):
    print('Waiting for download...')
    time.sleep(1)  # Wait for 1 second

# Get the name of the downloaded file
downloaded_file = os.listdir(download_directory)[0]

if len(sys.argv) > 2:
    new_name = f"{sys.argv[2]}.wav"
else:
    # Rename and move the file
    new_name = 'new_music.wav'  # Replace with the new name and extension
os.rename(os.path.join(download_directory, downloaded_file), os.path.join(download_directory, new_name))

# Check if a file with the same name already exists in the destination directory
counter = 1
base_name, extension = os.path.splitext(new_name)
while os.path.exists(os.path.join(destination_directory, new_name)):
    new_name = f"{base_name}_{counter}{extension}"  # Append a number to the filename
    counter += 1

# Rename the file in the download directory with the new name
os.rename(os.path.join(download_directory, f"{base_name}{extension}"), os.path.join(download_directory, new_name))

# Move the file
shutil.move(os.path.join(download_directory, new_name), os.path.join(destination_directory, new_name))

# Close the driver
driver.quit()

