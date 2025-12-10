-- Utilisation de la base de données compta2
USE COMPTA2;

-- 1. Listez toutes les données concernant les articles
SELECT * FROM ARTICLE;

-- 2. Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT REF, DESIGNATION FROM ARTICLE
WHERE PRIX > 2;

-- 3. En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * FROM ARTICLE
WHERE PRIX >= 2 AND PRIX <= 6.25;

-- 4. En utilisant l'opérateur BETWEEN, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * FROM ARTICLE
WHERE PRIX BETWEEN 2 AND 6.25;

-- 5. Listez tous les articles, dans l'ordre des prix descendants, et dont le prix n'est pas compris entre 2 et 6.25 euros et dont le fournisseur est Française d'Imports
SELECT * FROM ARTICLE
WHERE PRIX NOT BETWEEN 2 AND 6.25
AND ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Française d''Imports')
ORDER BY PRIX DESC;

-- 6. En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la Française d'Imports ou Dubois et Fils
SELECT * FROM ARTICLE
WHERE ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Française d''Imports')
OR ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Dubois & Fils');

-- 7. En utilisant l'opérateur IN, réalisez la même requête que précédemment
SELECT * FROM ARTICLE
WHERE ID_FOU IN (
    SELECT ID FROM FOURNISSEUR WHERE NOM IN ('Française d''Imports', 'Dubois & Fils')
);

-- 8. En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne sont ni Française d'Imports, ni Dubois et Fils
SELECT * FROM ARTICLE
WHERE ID_FOU NOT IN (
    SELECT ID FROM FOURNISSEUR WHERE NOM IN ('Française d''Imports', 'Dubois & Fils')
);

-- 9. Listez tous les bons de commande dont la date de commande est entre le 01/02/2019 et le 30/04/2019
SELECT * FROM BON
WHERE DATE_CMDE BETWEEN '2019-02-01' AND '2019-04-30';
