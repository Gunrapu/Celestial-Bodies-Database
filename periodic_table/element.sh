#!/bin/bash

# PSQL command template
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# Main function to handle input and call ELEMENT function
MAIN() {
  if [[ -z $1 ]]; then
    echo "Please provide an element as an argument."
  else
    ELEMENT $1
  fi
}

# ELEMENT function to retrieve element information from the database
ELEMENT() {
  INPUT=$1

  # Check if input is not a number (assuming it's a symbol or name)
  if [[ ! $INPUT =~ ^[0-9]+$ ]]; then
    # Retrieve atomic number based on symbol or name
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$INPUT' OR name='$INPUT';" | tr -d '[:space:]')
  else
    # Retrieve atomic number directly if input is a number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$INPUT;" | tr -d '[:space:]')
  fi

  # Check if atomic number is found in the database
  if [[ -z $ATOMIC_NUMBER ]]; then
    echo "I could not find that element in the database."
  else
    # Retrieve various properties of the element
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')
    TYPE=$($PSQL "SELECT type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;" | tr -d '[:space:]')

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi
}

# Entry point of the program
PROGRAM() {
  MAIN $1
}

# Call the main program with the first argument passed to the script
PROGRAM $1