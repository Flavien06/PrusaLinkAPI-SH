# PrusaLink API SH Script

## English

This Bash script allows you to control and monitor a Prusa 3D printer via the PrusaLink API. It can pause and resume prints, as well as display detailed information about the printer's status and current print job.

### Requirements

- Prusa printer connected to the network with PrusaLink configured.
- Valid PrusaLink API key.

### Installation

1. Copy the script to your `user` or `bin` directory:

    ```bash
    cp prusalink.sh ~/bin/prusalink.sh
    chmod +x ~/bin/prusalink.sh
    ```

2. Edit the `PRUSA_IP` and `PRUSALINK_APIKEY` variables in the script:

    ```bash
    PRUSA_IP="192.168.1.80"
    PRUSALINK_APIKEY="xxxx"
    ```

### Usage

- Pause the current print job:

    ```bash
    ~/bin/prusalink.sh pause
    ```

- Resume the paused print job:

    ```bash
    ~/bin/prusalink.sh resume
    ```

- Display detailed information:

    ```bash
    ~/bin/prusalink.sh info
    ```

- Wait for the current print job to finish and display a progress bar:

    ```bash
    ~/bin/prusalink.sh remaining
    ```

- Power on the printer (Need à power on script):

    ```bash
    ~/bin/prusalink.sh on
    ```

- Power off the printer (if safe) (Need à power off script):

    ```bash
    ~/bin/prusalink.sh off
    ```
  

### Example Output "prusalink.sh info"
```plaintext
Printer State (État de l'imprimante): PRINTING / EN COURS D'IMPRESSION
Progress (Progression) : 37 %

File Display [ID] Name: [8] 3D_printer_test_mini.bgcode

Time Printing (Temps d'impression): 56 minutes, 44 secondes
Time Remaining (Temps restant): 1 heures, 32 minutes, 0 secondes

Temp Nozzle (Température de la buse): 209.9 °C / 210 °C
Temp Bed (Température du plateau): 60 °C / 60 °C

Speed (Vitesse d'impression): 100 %
Flow (Flux d'impression): 95 %

Axis Z (Hauteur en z): 2.5 mm

Fan Hotend (Vitesse du ventilateur de l'extrudeur): 4804 tr/min
Status Fan Print (Vitesse du ventilateur l'impression): 4773 tr/min
```




## Français

Ce script Bash permet de contrôler et de surveiller une imprimante 3D Prusa via l'API PrusaLink. Il peut mettre en pause et reprendre les impressions, ainsi qu'afficher des informations détaillées sur l'état de l'imprimante et l'impression en cours.

### Pré-requis

- Imprimante Prusa connectée au réseau avec PrusaLink configuré.
- Clé API PrusaLink valide.

### Installation

1. Copiez le script dans votre répertoire `user` ou `bin` :

    ```bash
    cp prusalink.sh ~/bin/prusalink.sh
    chmod +x ~/bin/prusalink.sh
    ```

2. Modifiez les variables `PRUSA_IP` et `PRUSALINK_APIKEY` dans le script :

    ```bash
    PRUSA_IP="192.168.1.80"
    PRUSALINK_APIKEY="xxxx"
    ```

### Utilisation

- Mettre en pause l'impression en cours :

    ```bash
    ~/bin/prusalink.sh pause
    ```

- Reprendre l'impression en pause :

    ```bash
    ~/bin/prusalink.sh resume
    ```

- Afficher des informations détaillées :

    ```bash
    ~/bin/prusalink.sh info
    ```
    
- Afficher des informations détaillées :

    ```bash
    ~/bin/prusalink.sh remaining
    ```

 - Allumer l'imprimante (Besoin d'un script, prise connecter par exemple) :

    ```bash
    ~/bin/prusalink.sh on
    ```
    
 - Éteindre l'imprimante (Besoin d'un script, prise connecter par exemple) :

    ```bash
    ~/bin/prusalink.sh off
    ```

### Example avec "prusalink.sh info"
```plaintext
Printer State (État de l'imprimante): PRINTING / EN COURS D'IMPRESSION
Progress (Progression) : 37 %

File Display [ID] Name: [8] 3D_printer_test_mini.bgcode

Time Printing (Temps d'impression): 56 minutes, 44 secondes
Time Remaining (Temps restant): 1 heures, 32 minutes, 0 secondes

Temp Nozzle (Température de la buse): 209.9 °C / 210 °C
Temp Bed (Température du plateau): 60 °C / 60 °C

Speed (Vitesse d'impression): 100 %
Flow (Flux d'impression): 95 %

Axis Z (Hauteur en z): 2.5 mm

Fan Hotend (Vitesse du ventilateur de l'extrudeur): 4804 tr/min
Status Fan Print (Vitesse du ventilateur l'impression): 4773 tr/min
```
