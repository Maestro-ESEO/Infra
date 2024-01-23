CREATE USER 'MaxenceB'@'%' IDENTIFIED BY 'N3twork';
CREATE USER 'EnzoH'@'%' IDENTIFIED BY 'N3twork';
CREATE USER 'MaximeD'@'%' IDENTIFIED BY 'N3twork';
CREATE USER 'CamilleG'@'%' IDENTIFIED BY 'N3twork';

CREATE DATABASE bddMaestro;

GRANT ALL PRIVILEGES ON bddMaestro.* TO 'MaxenceB'@'%';
GRANT ALL PRIVILEGES ON bddMaestro.* TO 'MaximeD'@'%';
GRANT ALL PRIVILEGES ON bddMaestro.* TO 'EnzoH'@'%';
GRANT ALL PRIVILEGES ON bddMaestro.* TO 'CamilleG'@'%';

FLUSH PRIVILEGES;