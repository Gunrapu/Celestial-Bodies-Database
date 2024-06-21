#!/bin/bash

# Define PostgreSQL command based on the condition
if [[ $1 == "test" ]]; then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Function to insert teams into the teams table
insert_teams() {
  # Loop through each unique team in games.csv and insert into teams table
  cat -A games.csv | cut -d ',' -f 3,4 | tail -n +2 | tr ',' '\n' | sort -u | while read -r team_name; do
    # Trim leading/trailing whitespace from team_name
    team_name=$(echo "$team_name" | xargs)
    
    # Insert team_name into teams table if it doesn't already exist
    $PSQL "INSERT INTO teams (name) SELECT TRIM('$team_name') WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = TRIM('$team_name'));"
  done
}

# Function to insert game data into the games table
insert_games() {
  # Debug: Print number of lines in games.csv
  echo "Number of lines in games.csv: $(wc -l games.csv)"

  # Loop through each line in games.csv (excluding the header)
  tail -n +2 games.csv | while IFS=',' read -r year round winner opponent winner_goals opponent_goals; do
    # Debug: Print each variable
    echo "Inserting: $year, $round, $winner, $opponent, $winner_goals, $opponent_goals"

    # Trim leading/trailing whitespace from variables
    year=$(echo "$year" | xargs)
    round=$(echo "$round" | xargs)
    winner=$(echo "$winner" | xargs)
    opponent=$(echo "$opponent" | xargs)
    winner_goals=$(echo "$winner_goals" | xargs)
    opponent_goals=$(echo "$opponent_goals" | xargs)

    # Debug: Print SQL queries
    echo "SELECT queries:"
    echo "SELECT team_id FROM teams WHERE name = TRIM('$winner');"
    echo "SELECT team_id FROM teams WHERE name = TRIM('$opponent');"

    # Query to get team IDs from the teams table
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = TRIM('$winner');")
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = TRIM('$opponent');")

    # Debug: Print retrieved IDs
    echo "Retrieved IDs: winner_id=$winner_id, opponent_id=$opponent_id"

    # Insert data into the games table using variables (with proper quoting)
    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
           VALUES ('$year', '$round', '$winner_id', '$opponent_id', '$winner_goals', '$opponent_goals');"
  done
}

# Call the function to insert teams
insert_teams

# Call the function to insert game data
insert_games

# Count the number of rows in the teams table
teams_count=$($PSQL "SELECT COUNT(*) FROM teams;")

# Count the number of rows in the games table
games_count=$($PSQL "SELECT COUNT(*) FROM games;")

# Print the number of rows
echo "Number of rows in teams table: $teams_count"
echo "Number of rows in games table: $games_count"
