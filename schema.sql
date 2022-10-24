/* Database schema to keep the structure of entire database. */
 create table animals(
    id integer generated always as identity,
    name varchar(50),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species varchar(40),
    PRIMARY KEY (id),
);

-- Create a new table called owners 
CREATE TABLE owners(
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY(id)
)

-- Create species table
CREATE TABLE species(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	PRIMARY KEY(id)
)

-- Removing the species column from animals table
ALTER TABLE animals
DROP COLUMN species;

-- Add species_id column to the animals table 
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species (id);

-- Add owner_id which is a foreign key referencing the owners table to the animal table
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners (id);

/* Add join table for visits*/
-- create vets table 
CREATE TABLE vets(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
)

-- creating specializations table 
CREATE TABLE specializations(
	vet_id INT REFERENCES vets(id),
	species_id INT REFERENCES species(id)
)

-- creating visits table 
CREATE TABLE visits(
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
)

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


BEGIN;
SAVEPOINT before_adding_more;
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || 
generate_series(1,2500000), 'owner_' || 
generate_series(1,2500000) || 
'@mail.com';

/* ------------------------------ WEEK TWO -----------------------------------------*/

-- create a non clustered index for animal id on  visits table
CREATE INDEX animal_id_asc ON visits(animal_id ASC);

-- create a non clustered index for vet id on visits table 
CREATE INDEX vet_id_asc ON visits(vet_id ASC);