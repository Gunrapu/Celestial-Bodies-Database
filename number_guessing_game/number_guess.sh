#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_CHECK=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")

if [[ -z $USER_CHECK ]]; then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."

  ADD_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, NULL) RETURNING id")
  USER_ID=$(echo $ADD_USER | awk '{print $1}')
  
  GAMES_PLAYED=0
else
  DB_USERNAME=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")
  USER_ID=$($PSQL "SELECT id FROM users WHERE username='$USERNAME'")
  
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
  
  echo "Welcome back, $DB_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo -e "Guess the secret number between 1 and 1000:"
G_NUMBER=$(($RANDOM % 1000 + 1))

read USER_INPUT
let COUNT=1

until [ $USER_INPUT -eq $G_NUMBER ]; do
  while [ $((USER_INPUT)) != $USER_INPUT ]; do
    echo "That is not an integer, guess again:"
    read USER_INPUT
  done

  if [ $USER_INPUT -gt $G_NUMBER ]; then
    echo "It's lower than that, guess again:"
  elif [ $USER_INPUT -lt $G_NUMBER ]; then
    echo "It's higher than that, guess again:"
  fi
  
  let COUNT++
  read USER_INPUT
done

echo "You guessed it in $COUNT tries. The secret number was $G_NUMBER. Nice job!"

INCREMENT_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played=$(($GAMES_PLAYED+1)) WHERE id=$USER_ID")

UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game=LEAST(COALESCE(best_game, $COUNT), $COUNT) WHERE id=$USER_ID AND (best_game>$COUNT OR best_game IS NULL)")
