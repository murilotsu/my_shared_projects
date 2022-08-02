SELECT DISTINCT
       CASE
         WHEN mol.locator_id = 2497 THEN 'ARV'
         WHEN mol.locator_id = 1656 THEN 'OLG'
         WHEN mol.locator_id = 1317 THEN 'OLG'
         WHEN mol.locator_id = 1436 THEN 'OLG'
         WHEN mol.locator_id = 1316 THEN 'OLG'
         WHEN mol.locator_id = 1737 THEN 'OLG'
         WHEN mol.locator_id = 2337 THEN 'TLC'
         WHEN mol.locator_id = 4074 THEN 'TLC'
         WHEN mol.locator_id = 2036 THEN 'TLC'
         WHEN mol.locator_id = 2885 THEN 'TLC'
         WHEN mol.locator_id = 2017 THEN 'TLC'
         WHEN mol.locator_id = 271 THEN 'TLC'
         WHEN mol.locator_id = 2057 THEN 'TLC'
         WHEN mol.locator_id = 521 THEN 'TLC'
         WHEN mol.locator_id = 5850 THEN 'LGM'
         WHEN mol.locator_id = 2517 THEN 'LGM'
         WHEN mol.locator_id = 1876 THEN 'LGM'
         WHEN mol.locator_id = 1877 THEN 'LGM'
         WHEN mol.locator_id = 1916 THEN 'LGM'
         WHEN mol.locator_id = 2058 THEN 'LGM'
         WHEN mol.locator_id = 2825 THEN 'INT'
         WHEN mol.locator_id = 6193 THEN 'INT'
         WHEN mol.locator_id = 2795 THEN 'FTX'
         WHEN mol.locator_id = 9596 THEN 'MTT'
         ELSE mol.organization_code
       END as production_unit, 
       CASE 
         WHEN mol.locator_id = 26 THEN 'CTO'
         WHEN mol.locator_id = 27 THEN 'PNO'
         WHEN mol.locator_id = 28 THEN 'QRO'
         WHEN mol.locator_id = 29 THEN 'RNO'
         WHEN mol.locator_id = 76 THEN 'CTO'
         WHEN mol.locator_id = 77 THEN 'PNO'
         WHEN mol.locator_id = 78 THEN 'QRO'
         WHEN mol.locator_id = 126 THEN 'CTO'
         WHEN mol.locator_id = 127 THEN 'PNO'
         WHEN mol.locator_id = 128 THEN 'QRO'
         WHEN mol.locator_id = 201 THEN 'CTO'
         WHEN mol.locator_id = 202 THEN 'PNO'
         WHEN mol.locator_id = 203 THEN 'QRO'
         WHEN mol.locator_id = 251 THEN 'CTO'
         WHEN mol.locator_id = 252 THEN 'PNO'
         WHEN mol.locator_id = 253 THEN 'QRO'
         WHEN mol.locator_id = 301 THEN 'CTO'
         WHEN mol.locator_id = 302 THEN 'PNO'
         WHEN mol.locator_id = 303 THEN 'QRO'
         WHEN mol.locator_id = 351 THEN 'CTO'
         WHEN mol.locator_id = 352 THEN 'PNO'
         WHEN mol.locator_id = 353 THEN 'QRO'
         WHEN mol.locator_id = 401 THEN 'CTO'
         WHEN mol.locator_id = 402 THEN 'PNO'
         WHEN mol.locator_id = 403 THEN 'QRO'
         WHEN mol.locator_id = 451 THEN 'CTO'
         WHEN mol.locator_id = 452 THEN 'PNO'
         WHEN mol.locator_id = 453 THEN 'QRO'
         WHEN mol.locator_id = 576 THEN 'SNO'
         WHEN mol.locator_id = 501 THEN 'CTO'
         WHEN mol.locator_id = 502 THEN 'CTO'
         WHEN mol.locator_id = 503 THEN 'QRO'
         WHEN mol.locator_id = 587 THEN 'SNO'
         WHEN mol.locator_id = 596 THEN 'SNO'
         WHEN mol.locator_id = 605 THEN 'SNO'
         WHEN mol.locator_id = 614 THEN 'SNO'
         WHEN mol.locator_id = 623 THEN 'SNO'
         WHEN mol.locator_id = 632 THEN 'SNO'
         WHEN mol.locator_id = 641 THEN 'SNO'
         WHEN mol.locator_id = 650 THEN 'SNO'
         WHEN mol.locator_id = 659 THEN 'SNO'
         ELSE mol.organization_code
       END as invoicing_unit,
       CASE
         WHEN mol.locator_id = 2497 THEN 'ARM: ANDALI RIO VERDE'
         WHEN mol.locator_id = 1656 THEN 'ARM: ONNO'
         WHEN mol.locator_id = 1317 THEN 'ARM: ONNO'
         WHEN mol.locator_id = 1436 THEN 'ARM: ONNO'
         WHEN mol.locator_id = 1316 THEN 'ARM: ONNO'
         WHEN mol.locator_id = 1737 THEN 'ARM: ONNO'
         WHEN mol.locator_id = 2337 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 4074 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 2036 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 2885 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 2017 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 271 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 2057 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 521 THEN 'ARM: CUBATAO'
         WHEN mol.locator_id = 5850 THEN 'ARM: SAO FRANCISCO DO SUL'
         WHEN mol.locator_id = 2517 THEN 'ARM: SAO FRANCISCO DO SUL'
         WHEN mol.locator_id = 1876 THEN 'ARM: SAO FRANCISCO DO SUL'
         WHEN mol.locator_id = 1877 THEN 'ARM: SAO FRANCISCO DO SUL'
         WHEN mol.locator_id = 1916 THEN 'ARM: SAO FRANCISCO DO SUL'
         WHEN mol.locator_id = 2058 THEN 'ARM: SAO FRANCISCO DO SUL'
         WHEN mol.locator_id = 2825 THEN 'ARM: INTERMARITIMA'
         WHEN mol.locator_id = 6193 THEN 'ARM: INTERMARÍTIMA'
         WHEN mol.locator_id = 2795 THEN 'ARM: FERTIMAXI'
         WHEN mol.locator_id = 9596 THEN 'ARM: MIRITITUBA'
         ELSE mol.organization_name
       END as production_unit_name,        
       mol.padded_concatenated_segments as item_code,
       mol.item_description as item_description,
       msi.attribute13 as general_description,
       msi.attribute2 as item_type,
       mol.lot as lot,
       mol.subinventory_code as subinventory,
       mol.locator_id as locator,
       mil.description as locator_description,
       mol.total_qoh as actual_stock,
       mol.primary_uom_code as UOM,
       (SELECT NVL(TRUNC(SUM(unit_cost),2),0)
          FROM xxapps.xxapps_gmf_lot_costs_v
         WHERE inventory_item_id = msi.inventory_item_id
           AND organization_id = mol.organization_id
           AND lot_number = mol.lot) as cost_brl
       
FROM mtl_onhand_lot_v mol 
LEFT OUTER JOIN mtl_item_locations mil
     ON mol.locator_id = mil.inventory_location_id
LEFT OUTER JOIN mtl_system_items msi
     ON mol.inventory_item_id = msi.inventory_item_id