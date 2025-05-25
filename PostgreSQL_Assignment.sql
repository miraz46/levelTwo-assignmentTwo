-- Active: 1747656060588@@127.0.0.1@5432@conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


CREATE TABLE species (
    species_id  SERIAL PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(150),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes VARCHAR(100)
);

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings
WHERE location ILIKE '%Pass%'; 

-- Problem 4
SELECT rangers.name, COUNT(*) AS total_sightings FROM sightings
JOIN "rangers" ON sightings.ranger_id = rangers.ranger_id
GROUP BY sightings.ranger_id, rangers.name
ORDER BY sightings.ranger_id ASC;

-- Problem 5
SELECT common_name FROM species
LEFT JOIN "sightings" on species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;

-- Problem 6
SELECT species.common_name, sightings.sighting_time,rangers.name FROM sightings
JOIN "species" on sightings.species_id = species.species_id
JOIN "rangers" ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC LIMIT 2;

-- Problem 7
UPDATE species
    SET conservation_status = 'Historic'
    WHERE species.discovery_date < '1800-01-01';

-- Problem 8
SELECT sighting_id,
    CASE 
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN ( SELECT DISTINCT ranger_id FROM sightings);


