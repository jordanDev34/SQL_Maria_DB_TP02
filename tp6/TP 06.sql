-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande d'avril 2019
DELETE FROM compo
WHERE ID_BON IN (
    SELECT bon.ID 
    FROM bon 
    WHERE DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30'
);


-- b. Supprimer dans la table bon tous les bons de commande d'avril 2019.
DELETE FROM bon
WHERE DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30'