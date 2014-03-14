CREATE 
    TABLE Contacts (idx INTEGER NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT,
        firstname Varchar DEFAULT NULL,
        lastname Varchar DEFAULT NULL,
        phone Varchar DEFAULT NULL);

INSERT INTO Contacts(idx, firstname, lastname, phone) VALUES ('1', 'Bruce', 'Wayne', 'batphone');
INSERT INTO Contacts(idx, firstname, lastname, phone) VALUES ('2', 'jennie', 'wallflower', '867-5309');
INSERT INTO Contacts(idx, firstname, lastname, phone) VALUES ('3', 'john', 'Doe', '555-1212');
