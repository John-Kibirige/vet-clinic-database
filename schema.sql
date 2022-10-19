/* Database schema to keep the structure of entire database. */
 create table animals(
    id integer generated always as identity,
    name varchar(50),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);