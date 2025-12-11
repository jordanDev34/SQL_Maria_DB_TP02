-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT *
FROM ARTICLE
ORDER BY DESIGNATION ASC;
-- ORDER BY DESIGNATION;

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT *
FROM ARTICLE
ORDER BY PRIX DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM ARTICLE
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT *
FROM ARTICLE
WHERE DESIGNATION LIKE '%sachet%';


-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM ARTICLE
WHERE LOWER(DESIGNATION) LIKE '%sachet%'; -- collation _general_ci => _bin
-- WHERE UPPER(DESIGNATION) LIKE '%SACHET%'; -- collation _general_ci => _bin

-- f. Listez les articles avec les informations fournisseur correspondantes.
-- Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT *
FROM ARTICLE
JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
ORDER BY FOURNISSEUR.NOM ASC, ARTICLE.PRIX DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT *
FROM ARTICLE
JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
WHERE FOURNISSEUR.NOM = 'Dubois & Fils';

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(ARTICLE.PRIX)
FROM ARTICLE
INNER JOIN FOURNISSEUR ON FOURNISSEUR.ID = ARTICLE.ID_FOU
WHERE FOURNISSEUR.NOM = 'Dubois & Fils';

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT FOURNISSEUR.NOM as Fournisseur, AVG(ARTICLE.PRIX) as prix_article_moyen
FROM ARTICLE
JOIN FOURNISSEUR ON FOURNISSEUR.ID = ARTICLE.ID_FOU
GROUP BY FOURNISSEUR.NOM;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT *
FROM BON
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT B.*
FROM BON AS B
JOIN COMPO AS C ON B.ID = C.ID_BON
JOIN ARTICLE AS A ON A.ID = C.ID_ART
WHERE A.DESIGNATION LIKE '%boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT BON.NUMERO, FOURNISSEUR.NOM
FROM BON
INNER JOIN FOURNISSEUR ON BON.ID_FOU = FOURNISSEUR.ID
INNER JOIN COMPO ON COMPO.ID_BON = BON.ID
INNER JOIN ARTICLE ON ARTICLE.ID = COMPO.ID_ART
WHERE DESIGNATION LIKE '%boulon%';

-- m. Calculez le prix total de chaque bon de commande
SELECT BON.ID AS bon_id, SUM(ARTICLE.PRIX * COMPO.QTE) as TOTAL
FROM BON
INNER JOIN COMPO ON COMPO.ID_BON = BON.ID
INNER JOIN ARTICLE ON ARTICLE.ID = COMPO.ID_ART
GROUP BY BON.ID
ORDER BY BON.ID;

-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT BON.ID as id_bon, BON.NUMERO, SUM(COMPO.QTE) as nb_article
FROM BON
INNER JOIN COMPO ON COMPO.ID_BON = BON.ID
GROUP BY BON.ID, BON.NUMERO;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT BON.NUMERO, SUM(COMPO.QTE) as nb_total_art
FROM BON
INNER JOIN COMPO ON COMPO.ID_BON = BON.ID
GROUP BY BON.NUMERO
HAVING nb_total_art > 25;


-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT BON.NUMERO AS numero_commande, SUM(COMPO.QTE * ARTICLE.PRIX) as prix_total
FROM BON
INNER JOIN COMPO ON COMPO.ID_BON = BON.ID
INNER JOIN ARTICLE ON ARTICLE.ID = COMPO.ID_ART
-- WHERE BON.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30';
WHERE MONTH(BON.DATE_CMDE) = 4 AND YEAR(BON.DATE_CMDE) = 2019
GROUP BY numero_commande;