[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/zSalocin/RFID-Presence-Tracker-Project/blob/main/README.md)   [![pt-br](https://img.shields.io/badge/lang-pt--br-green.svg)](https://github.com/zSalocin/RFID-Presence-Tracker-Project/blob/main/README_PT-BR.md)

# RFID Presence Tracker Project

**This project is still in development and testing phase. Use it at your own risk as it may still contain instabilities or limitations.**

## Description
The RFID Presence Tracker project is a Windows application that integrates with an Esp8266 device equipped with an RFID reader. The aim of the application is to record individuals' presence based on the information read by the RFID reader and compare it with a reference table.

## Features
- Reading data from Esp8266 via Wi-fi communication.

- Comparing the read data with information in a table (such as an Excel spreadsheet).

- Recording presence based on the found matches.

- User-friendly interface for interaction with the application.

## Requirements
- Device running Windows OS.

- Esp8266 device with an RFID reader and Wi-fi communication capability.

- Reference spreadsheet (Excel) containing the information to be compared (information should be in text format).

## Environment Setup

- Make a backup of the spreadsheet.

- Clone the project repository.

- Upload the code to the Esp8266 to activate the RFID reader (not yet available).

- Ensure that the Windows device is correctly connected to the Esp8266 that will perform the RFID reading.

- Open the application on the Windows device.

- Import the reference spreadsheet containing the comparison data.

- Start reading from the RFID reader.

- The application will compare the read data with the information in the table and record the presence.

## License
This project is distributed under the MIT license.




