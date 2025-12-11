-- Désactiver le mode "safe update" pour permettre les suppressions multiples
SET SQL_SAFE_UPDATES = 0;

-- a. Suppression des lignes dans la table 'compo' pour les bons de commande d'avril 2019
DELETE FROM compo
WHERE ID_BON IN (
   SELECT bon.ID 
   FROM bon 
   WHERE MONTH(bon.date_cmde) = 4 AND YEAR(bon.date_cmde) = 2019
);

-- b. Suppression des bons de commande d'avril 2019 dans la table 'bon'
DELETE FROM bon
WHERE MONTH(bon.date_cmde) = 4 AND YEAR(bon.date_cmde) = 2019;