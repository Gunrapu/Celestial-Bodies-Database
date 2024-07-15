-- SQL commands to set up the database
-- Create the database
CREATE DATABASE number_guess_game;
-- Use the database
\c number_guess_game
-- Create the tables
CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(22) UNIQUE NOT NULL, games_played INT DEFAULT 0, best_game INT DEFAULT 0);

