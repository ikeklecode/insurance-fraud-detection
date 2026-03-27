-- 1. Volume total de sinistres et taux de fraude global
-- Utilisation du CASE WHEN car FraudFound contient 'Yes' ou 'No'
SELECT 
    COUNT(*) AS total_sinistres,
    SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) AS total_fraudes,
    ROUND((SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS taux_fraude_pourcentage
FROM claims;

-- 2. Analyse du risque de fraude par marque de véhicule (Top 5 des plus risquées)
SELECT 
    Make AS marque_vehicule,
    COUNT(*) AS nb_sinistres,
    SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) AS nb_fraudes,
    ROUND((SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS taux_fraude
FROM claims
GROUP BY Make
HAVING COUNT(*) > 100 -- On écarte les marques avec très peu de volume pour avoir une stat fiable
ORDER BY taux_fraude DESC
LIMIT 5;

-- 3. Typologie de la fraude selon le contrat d'assurance de base
SELECT 
    BasePolicy AS type_contrat,
    COUNT(*) AS volume_sinistres,
    SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) AS nb_fraudes,
    ROUND((SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS taux_fraude
FROM claims
GROUP BY BasePolicy
ORDER BY taux_fraude DESC;

-- 4. Analyse de la fraude selon le profil démographique du conducteur
SELECT 
    Sex AS sexe,
    MaritalStatus AS statut_marital,
    COUNT(*) AS nb_sinistres,
    SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) AS nb_fraudes,
    ROUND((SUM(CASE WHEN FraudFound = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS taux_fraude
FROM claims
GROUP BY Sex, MaritalStatus
ORDER BY taux_fraude DESC;