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