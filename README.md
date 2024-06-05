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
