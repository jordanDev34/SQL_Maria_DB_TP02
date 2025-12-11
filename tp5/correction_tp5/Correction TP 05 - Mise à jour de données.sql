-- Utilisation de la base de données compta2
USE COMPTA2;

-- a. Mettez en minuscules la désignation de l’article dont l’identifiant est 2
UPDATE article
SET designation = lower(designation)
WHERE id = 2;

-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
UPDATE article
SET designation = upper(designation)
WHERE prix > 10;

-- c. Baissez de 10% le prix de tous les articles qui n’ont pas fait l’objet d’une commande.
UPDATE article
SET prix = prix * 0.9
WHERE id NOT IN (
    SELECT distinct id_art
    FROM compo
);

-- d. Une erreur s’est glissée dans les commandes concernant Française d’imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE compo
SET qte = qte * 2
WHERE id_bon IN (
    SELECT bon.id
    FROM bon, fournisseur
    WHERE bon.id_fou = fournisseur.id
    AND nom = 'Française d''Imports'
);

-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme substring et position.
UPDATE article
SET designation = substring(designation, 1, position('(' IN designation) -1)
WHERE position('(' IN designation) > 0;