CREATE TABLE flowers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  soil_type VARCHAR(32),
  light_level VARCHAR(32),
  season VARCHAR(32)
);

INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('azalea','acidic','full sun','summer');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('rhododendron','acidic','partial shade','spring');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('camellias','acidic','partial shade','winter');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('hydrangea','acidic','full sun','spring');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('iris','alkaline','full sun','spring');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('daylily','alkaline','full sun','summer');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('lavender','alkaline','full sun','summer');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('hosta','alkaline','partial shade','summer');


