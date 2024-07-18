-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS moon;
DROP TABLE IF EXISTS planet;
DROP TABLE IF EXISTS star;
DROP TABLE IF EXISTS galaxy;
DROP TABLE IF EXISTS planet_type;

-- Create galaxy table
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  distance_from_earth NUMERIC,
  has_life BOOLEAN
);

-- Create star table
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  galaxy_id INT REFERENCES galaxy(galaxy_id) ON DELETE CASCADE,
  is_spherical BOOLEAN,
  age_in_millions_of_years INT NOT NULL,
  temperature INT
);

-- Create planet_type table
CREATE TABLE planet_type (
  planet_type_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  description TEXT
);

-- Create planet table
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  star_id INT REFERENCES star(star_id) ON DELETE CASCADE,
  planet_type_id INT REFERENCES planet_type(planet_type_id) ON DELETE SET NULL,
  has_life BOOLEAN,
  distance_from_star NUMERIC
);

-- Create moon table
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  planet_id INT REFERENCES planet(planet_id) ON DELETE CASCADE,
  diameter INT,
  has_water BOOLEAN
);

-- Insert data into galaxy table
INSERT INTO galaxy (name, description, distance_from_earth, has_life)
VALUES 
  ('Milky Way', 'Our galaxy', 0, TRUE),
  ('Andromeda', 'Nearest spiral galaxy', 2537000, FALSE),
  ('Triangulum', 'Spiral galaxy', 3000000, FALSE),
  ('Messier 87', 'Elliptical galaxy', 53000000, FALSE),
  ('Whirlpool', 'Interacting grand-design spiral galaxy', 23000000, FALSE),
  ('Sombrero', 'Unbarred spiral galaxy', 29000000, FALSE);

-- Insert data into star table
INSERT INTO star (name, galaxy_id, is_spherical, age_in_millions_of_years, temperature)
VALUES 
  ('Sun', 1, TRUE, 4600, 5778),
  ('Sirius', 2, TRUE, 242, 9940),
  ('Alpha Centauri A', 1, TRUE, 4550, 5790),
  ('Betelgeuse', 1, TRUE, 10, 3500),
  ('Vega', 3, TRUE, 455, 9602),
  ('Rigel', 4, TRUE, 8, 12000);

-- Insert data into planet_type table
INSERT INTO planet_type (name, description)
VALUES 
  ('Terrestrial', 'Rocky planets'),
  ('Gas Giant', 'Large planets with thick atmospheres'),
  ('Ice Giant', 'Large planets with icy compositions'),
  ('Dwarf Planet', 'Small celestial bodies');

-- Insert data into planet table
INSERT INTO planet (name, star_id, planet_type_id, has_life, distance_from_star)
VALUES 
  ('Earth', 1, 1, TRUE, 1),
  ('Mars', 1, 1, FALSE, 1.5),
  ('Jupiter', 1, 2, FALSE, 5.2),
  ('Saturn', 1, 2, FALSE, 9.5),
  ('Neptune', 1, 3, FALSE, 30),
  ('Uranus', 1, 3, FALSE, 19.8),
  ('Mercury', 1, 1, FALSE, 0.4),
  ('Venus', 1, 1, FALSE, 0.7),
  ('Proxima Centauri b', 3, 1, FALSE, 0.05),
  ('Proxima Centauri c', 3, 1, FALSE, 1.5),
  ('TRAPPIST-1d', 5, 1, FALSE, 0.02),
  ('TRAPPIST-1e', 5, 1, FALSE, 0.029);

-- Insert data into moon table
INSERT INTO moon (name, planet_id, diameter, has_water)
VALUES 
  ('Moon', 1, 3474, FALSE),
  ('Phobos', 2, 22, FALSE),
  ('Deimos', 2, 12, FALSE),
  ('Ganymede', 3, 5268, FALSE),
  ('Titan', 4, 5150, TRUE),
  ('Europa', 3, 3122, TRUE),
  ('Callisto', 3, 4820, FALSE),
  ('Io', 3, 3643, FALSE),
  ('Enceladus', 4, 504, TRUE),
  ('Mimas', 4, 396, FALSE),
  ('Hyperion', 4, 270, FALSE),
  ('Iapetus', 4, 1469, FALSE),
  ('Triton', 5, 2706, FALSE),
  ('Oberon', 6, 1523, FALSE),
  ('Titania', 6, 1578, FALSE),
  ('Miranda', 6, 471, FALSE),
  ('Ariel', 6, 1158, FALSE),
  ('Umbriel', 6, 1169, FALSE),
  ('Charon', 9, 1212, FALSE),
  ('Nix', 9, 49, FALSE);
