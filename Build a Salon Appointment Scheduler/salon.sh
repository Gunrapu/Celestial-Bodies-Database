#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?"

SERVICE_MENU() {
    if [[ $1 ]]; 
    then
        echo -e "\n$1"
    fi

    LIST_SERVICES=$($PSQL "SELECT * FROM services")
    echo "$LIST_SERVICES" | while read SERVICE_ID BAR SERVICE
    do
        ID=$(echo $SERVICE_ID | sed 's/ //g')
        NAME=$(echo $SERVICE | sed 's/ //g')
        echo "$ID) $SERVICE"
    done
    read SERVICE_ID_SELECTED
    case $SERVICE_ID_SELECTED in
        [1-5]) APPOINTMENT_MENU $SERVICE_ID_SELECTED ;;
        *) SERVICE_MENU "I could not find that service. What would you like today?" ;;
    esac
}

APPOINTMENT_MENU() {
    SERVICE_ID_SELECTED=$1  # Assign service selection to local variable

    # Get service name based on selection
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")

    # Check if service name is empty (no matching service found)
    if [[ -z $SERVICE_NAME ]]; 
    then
        SERVICE_MENU "Service not found. Please select a valid service."
        return
    fi

    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; 
    then
        # Send back to services menu
        SERVICE_MENU
    else
        # Get customer info
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE

        # Retrieve customer name based on phone number
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # If customer doesn't exist, prompt for new customer name and insert into database
        if [[ -z $CUSTOMER_NAME ]]; 
        then
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            # Insert new customer into database
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        fi

        # Retrieve customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # Check if CUSTOMER_ID is empty after retrieval
        if [[ -z $CUSTOMER_ID ]]; 
        then
            SERVICE_MENU "Failed to retrieve customer ID. Please try again."
            return
        fi

        # Continue with appointment scheduling
        # Get appointment time
        echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed 's/ //g'), $(echo $CUSTOMER_NAME | sed 's/ //g')?"
        read SERVICE_TIME

        # Validate appointment time format (HH:MM)
        if [[ ! $SERVICE_TIME =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; 
        then
            SERVICE_MENU "Invalid time format. Please enter time in HH:MM format."
            return
        fi

        # Insert appointment into appointments table
        SAVED_TO_TABLE_APPOINTMENTS=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

        if [[ $SAVED_TO_TABLE_APPOINTMENTS == "INSERT 0 1" ]]; 
        then
            echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed 's/ //g') at $SERVICE_TIME, $CUSTOMER_NAME."
        else
            echo -e "\nFailed to save appointment. Please try again."
        fi
    fi
}

SERVICE_MENU
