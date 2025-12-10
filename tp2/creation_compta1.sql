CREATE TABLE fournisseur (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(25) NOT NULL
);

CREATE TABLE article (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    ref VARCHAR(13) NOT NULL,
    designation VARCHAR(255) NOT NULL,
    prix DECIMAL(7,2) NOT NULL,
    id_fou INT(11) NOT NULL,

    CONSTRAINT fk_art_fou 
        FOREIGN KEY (id_fou) REFERENCES fournisseur(id)
);

CREATE TABLE bon (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    numero INT(11) NOT NULL,
    date_cmde DATETIME NOT NULL,
    delai INT(11) NOT NULL,
    id_fou INT(11) NOT NULL,

    CONSTRAINT fk_bon_fou 
        FOREIGN KEY (id_fou) REFERENCES fournisseur(id)
);

CREATE TABLE compo (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    id_art INT(11) NOT NULL,
    id_bon INT(11) NOT NULL,
    qte INT(11) NOT NULL,
    
    CONSTRAINT fk_compo_art 
        FOREIGN KEY (id_art) REFERENCES article(id),

    CONSTRAINT fk_compo_bon 
        FOREIGN KEY (id_bon) REFERENCES bon(id)
);
