-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament;

CREATE TABLE players(
    id SERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE matches(
    id SERIAL PRIMARY KEY,
    winner_id INT NOT NULL,
    loser_id INT NOT NULL
);

CREATE VIEW standing AS
SELECT players.id, players.name, SUM(CASE WHEN players.id = winner_id THEN 1 ELSE 0 END) AS wins, COUNT(matches.id) AS counts
FROM players LEFT JOIN matches
ON players.id = winner_id OR players.id = loser_id
GROUP BY players.id
ORDER BY wins DESC, players.id, players.name;