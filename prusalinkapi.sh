#!/bin/bash
# Version 0.1 beta/test

PRUSA_IP="192.168.1.xx"
PRUSALINK_APIKEY="your.api.key"
###################################

STATUS_API_URL="http://$PRUSA_IP/api/v1/status"
JOB_API_URL="http://$PRUSA_IP/api/v1/job"

convertir_temps() {
    local secondes="$1"
    local jours=$((secondes / 86400))
    local reste=$((secondes % 86400))
    local heures=$((reste / 3600))
    reste=$((reste % 3600))
    local minutes=$((reste / 60))
    local secondes=$((reste % 60))

	if 	 [ "$jours" -eq 0 ] && [ "$heures" -eq 0 ] && [ "$minutes" -eq 0 ]; then
        echo "$secondes secondes"
	elif [ "$jours" -eq 0 ] && [ "$heures" -eq 0 ]; then
		echo "$minutes minutes, $secondes secondes"
	elif [ "$jours" -eq 0 ]; then
		echo "$heures heures, $minutes minutes, $secondes secondes"
	else
		echo "$jours jours, $heures heures, $minutes minutes, $secondes secondes"
	fi
}

pause_job() {
    local job_id="$1"
    curl -X PUT -H "X-Api-Key: $PRUSALINK_APIKEY" -s "http://$PRUSA_IP/api/v1/job/$job_id/pause"
}

resume_job() {
    local job_id="$1"
    curl -X PUT -H "X-Api-Key: $PRUSALINK_APIKEY" -s "http://$PRUSA_IP/api/v1/job/$job_id/resume"
}

show_help() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  pause       Pause the current print job."
    echo "  resume      Resume a paused print job."
    echo "  info        Show detailed information about the current print job and printer status."
    echo "  help        Show this help message."
}

get_info() {
    # Récupérer les données JSON de l'API de statut avec authentification
	status_response=$(curl -H "X-Api-Key: $PRUSALINK_APIKEY" -s $STATUS_API_URL)
	# Vérifier si la requête de statut a réussi
	if [ $? -ne 0 ]; then
	  echo "Failed to retrieve status data from the API."
	  exit 1
	fi

	# Récupérer les données JSON de l'API de job avec authentification
	job_response=$(curl -H "X-Api-Key: $PRUSALINK_APIKEY" -s $JOB_API_URL)
	# Vérifier si la requête de job a réussi
	if [ $? -ne 0 ]; then
	  echo "Failed to retrieve job data from the API."
	  echo "$job_response"
	  exit 1
	fi

	# Vérifier si la réponse de statut ou job est vide
	if [ -z "$status_response" ]; then
	  echo "Empty response from the status API."
	  exit 1
	elif [ -z "$job_response" ]; then
	  echo "Empty response from the job API."
	fi

	status_job_id=$(echo "$status_response" | jq -r '.job.id')
	status_progress=$(echo "$status_response" | jq -r '.job.progress')
	status_printer_state=$(echo "$status_response" | jq -r '.printer.state')

	# Traduire l'état de l'imprimante en français avec une structure case
	case "$status_printer_state" in
		"PRINTING")	status_printer_state_fr="EN COURS D'IMPRESSION"	;;
		"PAUSED")	status_printer_state_fr="EN PAUSE"				;;
		"IDLE")		status_printer_state_fr="ANNULÉ"				;;
		*)			status_printer_state_fr="$status_printer_state"	;;
	esac
}

get_more_info() {
	# Utiliser jq pour extraire et assigner les valeurs de l'API de statut à des variables
	status_time_remaining=$(echo "$status_response" | jq -r '.job.time_remaining')
	status_time_printing=$(echo "$status_response" | jq -r '.job.time_printing')
	status_temp_bed=$(echo "$status_response" | jq -r '.printer.temp_bed')
	status_target_bed=$(echo "$status_response" | jq -r '.printer.target_bed')
	status_temp_nozzle=$(echo "$status_response" | jq -r '.printer.temp_nozzle')
	status_target_nozzle=$(echo "$status_response" | jq -r '.printer.target_nozzle')
	status_axis_z=$(echo "$status_response" | jq -r '.printer.axis_z')
	status_flow=$(echo "$status_response" | jq -r '.printer.flow')
	status_speed=$(echo "$status_response" | jq -r '.printer.speed')
	status_fan_hotend=$(echo "$status_response" | jq -r '.printer.fan_hotend')
	status_fan_print=$(echo "$status_response" | jq -r '.printer.fan_print')
	job_file_display_name=$(echo "$job_response" | jq -r '.file.display_name')

	# Afficher les variables
	echo "Printer State (État de l'imprimante): $status_printer_state / $status_printer_state_fr"
	echo "Progress (Progression) : $status_progress %"
	echo " "
	echo "File Display [ID] Name: [$status_job_id] $job_file_display_name"
	echo " "
	echo "Time Printing (Temps d'impression): $(convertir_temps $status_time_printing)"
	echo "Time Remaining (Temps restant): $(convertir_temps $status_time_remaining)"
	echo " "
	echo "Temp Nozzle (Température de la buse): $status_temp_nozzle °C / $status_target_nozzle °C"
	echo "Temp Bed (Température du plateau): $status_temp_bed °C / $status_target_bed °C"
	echo " "
	echo "Speed (Vitesse d'impression): $status_speed %"
	echo "Flow (Flux d'impression): $status_flow %"
	echo " "
	echo "Axis Z (Hauteur en z): $status_axis_z mm"
	echo " "
	echo "Fan Hotend (Vitesse du ventilateur de l'extrudeur): $status_fan_hotend tr/min"
	echo "Status Fan Print (Vitesse du ventilateur l'impression): $status_fan_print tr/min"
}

get_info

case "$1" in
    "pause")
        echo "Printer State: $status_printer_state / $status_printer_state_fr ($status_progress %)"
		if [ -z "$status_job_id" ]; then
            echo "Empty response from the status API."
            exit 1
        fi
        if [ "$status_printer_state" != "PRINTING" ]; then
            echo "Cannot pause job. The printer is not currently printing."
            exit 1
        fi
        pause_job "$status_job_id"
        echo "Job with ID $status_job_id paused."
		get_info
		echo "Printer State: $status_printer_state / $status_printer_state_fr ($status_progress %)"
		sleep 5
        exit 0 ;;
    
    "resume")
        echo "Printer State: $status_printer_state / $status_printer_state_fr ($status_progress %)"
		if [ -z "$status_job_id" ]; then
            echo "Empty response from the status API."
            exit 1
        fi
        if [ "$status_printer_state" == "PRINTING" ]; then
            echo "Cannot resume job. The printer is already printing."
            exit 1
        fi
        resume_job "$status_job_id"
        echo "Job with ID $status_job_id resumed."
		get_info
		echo "Printer State: $status_printer_state / $status_printer_state_fr ($status_progress %)"
		sleep 5
        exit 0 ;;
		
    "help")
		show_help
        exit 0 ;;
		
    "info" | "telemetrie" )
		get_more_info
        exit 0 ;;
	*)
		show_help
		echo "" && echo "______________________________________" &&	echo ""
		get_more_info
        exit 0 ;; 
esac

exit 0
