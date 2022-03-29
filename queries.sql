/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered is TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is TRUE;
SELECT * from animals WHERE name <> 'Gabumon';
SELECT * from animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

-- PROJECT #2 QUERIES

BEGIN;
UPDATE animals
SET species = 'unpsecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT DELETE_ROWS;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO DELETE_ROWS;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

-- QUERIES TO ANSWER PROJECT #2 QUESTIONS

-- How many animals are there? // 10
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape? // 2
SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals? //15.55
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals? // neutered
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
-- pokemon(min 11.0, max 17.0) digimon(min 5.7, max 45.0)
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
-- pokemon(3.0) digimon(0)
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;
