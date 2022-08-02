SELECT ood.organization_code                                                                  "Emp de Faturamento(Code)"
     , rctl.warehouse_id                                                                      "Emp de Faturamento(ID)"
     , ood.organization_name                                                                  "Emp de Faturamento" 
     , (SELECT a.registration_number 
          FROM xxapps_org_registration_numbers_v a 
         WHERE a.organization_id = rctl.warehouse_id
           AND a.registration_code = 'CNPJ')                                                  "Emp de Faturamento(CNPJ)"
     , (SELECT a.registration_number 
          FROM xxapps_org_registration_numbers_v a 
         WHERE a.Organization_Id = rctl.warehouse_id
           AND a.registration_code = 'IE')                                                    "Emp de Fat.(Insc. Est.)"    
     , oola.customer_production_line                                                          "Emp Produtora(Code)"   
     , (SELECT organization_id
          FROM org_organization_definitions
         WHERE organization_code = oola.customer_production_line)                             "Emp Produtora(ID)" 
     , (SELECT organization_name
          FROM org_organization_definitions
         WHERE organization_code = oola.customer_production_line)                             "Emp Produtora"       
     , rct.customer_trx_id                                                                    "ID Único da Nota"          
     , rct.trx_number                                                                         Nota  
     , rct.global_attribute3                                                                  "Serie da Nota"
     , jbcte.electronic_inv_access_key                                                        "Chave de Acesso"
     , orf.description                                                                         Transportadora
     , wnd.attribute2                                                                         Placa         
     , null                                                                                   "Guia de Trafego"
     , hp.party_number                                                                        "Reg de Exerc. do Cli."
     , rctl.line_number                                                                       "Linha da Nota"  
     , rct.trx_date                                                                           "DT de Emissão Nota"   
     , aps.due_date                                                                           "DT de Vencimento"
     , rtt.name                                                                               "Condição de Pagamento"
     , xocged.grp_eco_hdr_id                                                                  "Cod. Grupo Econômico"
     , xocged.name                                                                            "Grupo Econômico"
     , abcr.codigo_interno                                                                    "Cod. Parceiro"
     , hp.party_id          
     , hp.party_name                                                                          "Razao Cliente"
     , abcr.nome_cliente                                                                      Cliente
     , abcr.cnpj                                                                              CNPJ
     , abcr.endereco||', '||abcr.endereco_1||', '||abcr.bairro                                Endereco
     , abcr.cep                                                                               CEP
     , abcr.global_attribute3                                                                 Telefone      
     , (SELECT customer_class_code
          FROM hz_cust_accounts 
         WHERE party_id = hp.PARTY_ID
           AND status = 'A')                                                                 "Tipo de Cliente"
     , (SELECT hg.geography_element3_id
          FROM hz_geographies hg
             , hz_geography_identifiers hgi
         WHERE hg.geography_id = hgi.geography_id
           AND hgi.identifier_subtype = 'IBGE'
           AND hgi.identifier_type = 'CODE'
           AND hg.geography_type = 'CITY'
           AND UPPER(hg.geography_name) = UPPER(abcr.cidade)
           AND UPPER(hg.GEOGRAPHY_ELEMENT2) = UPPER(abcr.uf) )                                "Cod. da Cid. Fat."
     , abcr.cidade                                                                            "Cidade Faturada"
     , (SELECT hg.geography_element2_id
          FROM hz_geographies hg
             , hz_geography_identifiers hgi
         WHERE hg.geography_id = hgi.geography_id
           AND hgi.identifier_subtype = 'IBGE'
           AND hgi.identifier_type = 'CODE'
           AND hg.geography_type = 'STATE'
           AND UPPER(hg.geography_name) = UPPER(abcr.uf))                                     "Cod. UF Faturada"
     , abcr.uf                                                                                "UF Faturada"
     , (SELECT DISTINCT ascr.cidade
          FROM apps.xxapps_ar_ship_cust_rel ascr
         WHERE ascr.customer_id = rct.ship_to_customer_id
           AND ascr.site_use_id = rct.ship_to_site_use_id)                                    "Cidade de Entrega"
     , (SELECT DISTINCT ascr.uf
          FROM apps.xxapps_ar_ship_cust_rel ascr
         WHERE ascr.customer_id = rct.ship_to_customer_id
           AND ascr.site_use_id = rct.ship_to_site_use_id)                                    "UF de Entrega"        
     , (SELECT hgi.identifier_value 
          FROM apps.hz_geographies hg
             , apps.hz_geography_identifiers hgi
         WHERE hg.geography_id = hgi.geography_id
           AND hgi.identifier_subtype = 'IBGE'
           AND hgi.identifier_type = 'CODE'
           AND hg.geography_name = (SElECT DISTINCT ascr.cidade
                                      FROM apps.xxapps_ar_ship_cust_rel ascr
                                     WhERE ascr.customer_id = rct.ship_to_customer_id
                                       AND ascr.site_use_id = rct.ship_to_site_use_id) 
           AND hg.object_version_number = 1
           AND hg.geography_element2 = (SELECT DISTINCT ascr.uf
                                          FROM apps.xxapps_ar_ship_cust_rel ascr
                                         WHERE ascr.customer_id = rct.ship_to_customer_id
                                           AND ascr.site_use_id = rct.ship_to_site_use_id)  ) IBGE               
     
     , EXTRACT(MONTH FROM rct.trx_date)                                                       "Mes de Emissão"
     , EXTRACT(YEAR FROM rct.trx_date)                                                        "Ano de Emissão"          
     , TO_CHAR(rct.trx_date, 'MM/YYYY')                                                       "Período de Emissão"        
     ,  rct.cust_trx_type_id                                                                  "Cod Tp de Op. Fiscal"
     ,  ctt.name                                                                              "Tp de Op. Fiscal"        
     , rctl.global_attribute1                                                                 CFOP               
     , (SELECT jbap.cfo_description 
          FROM jl_br_ap_operations jbap
         WHERE jbap.cfo_code = rctl.global_attribute1)                                        "Descrição do CFOP"
     , msib.segment1                                                                          "Cod do Produto"
     , msib.description                                                                       Produto  
     , mic.CATEGORY_CONCAT_SEGS                                                               NCM
     , rctl.UOM_CODE                                                                          UOM     
     , (SELECT DESCRIPTION
          FROM FND_FLEX_VALUES_VL
         WHERE FLEX_VALUE_SET_ID = 1018812
           AND FLEX_VALUE_MEANING = msib.attribute14)                                         Controle
     , msib.attribute3                                                                        "Classificação ANDA"             
     , rctl.unit_selling_price                                                                "Valor Unitário"
     , rctl.quantity_invoiced                                                                 "QTD Faturada"
     , rctl.unit_selling_price * rctl.quantity_invoiced                                       "Valor da Nota"
     , rct.invoice_currency_code                                                              Moeda             
     , CASE 
         WHEN rct.invoice_currency_code = 'USD'
           THEN to_number (rctl.attribute12)
         ELSE 1
       END                                                                                    "Fator de Conversão Faturamento"        
     , TO_DATE(to_char(trunc(rct.trx_date,'MON')), 'DD/MM/YYYY')                              Referência
   , (SELECT NVL(lines.tax_rate, 0) 
        FROM apps.ra_customer_trx_lines_all lines
           , apps.zx_lines zl
       WHERE lines.customer_trx_line_id = zl.TRX_LINE_ID
         AND lines.customer_trx_id = zl.trx_id
         AND zl.tax = 'ICMS_C' 
         AND lines.customer_trx_line_id = rctl.customer_trx_line_id
         AND lines.customer_trx_id      = rctl.customer_trx_id)                               ICMS                    
     , (SELECT NVL(lines.tax_rate, 0)
          FROM apps.ra_customer_trx_lines_all lines
             , apps.zx_lines zl
         WHERE lines.customer_trx_line_id = zl.TRX_LINE_ID
           AND lines.customer_trx_id = zl.trx_id
           AND zl.tax = 'PIS_C' 
           AND lines.customer_trx_line_id = rctl.customer_trx_line_id
           AND lines.customer_trx_id      = rctl.customer_trx_id)                             PIS                
     , (SELECT NVL(lines.tax_rate, 0)
          FROM apps.ra_customer_trx_lines_all lines
             , apps.zx_lines zl
         WHERE lines.customer_trx_line_id = zl.TRX_LINE_ID
           AND lines.customer_trx_id = zl.trx_id
           AND zl.tax = 'COFINS_C' 
           AND lines.customer_trx_line_id = rctl.customer_trx_line_id
           AND lines.customer_trx_id      = rctl.customer_trx_id)                             Cofins             
     , null                                                                                   Frete            
     , wnd.fob_code                                                                           "CIF/FOB"  
     , ooha.header_id                                                                         "ID OM" 
     , xoclp.proposal_number                                                                  "NR Prop de Crédito"
     , xoclp.operation                                                                        "Op de Crédito"
     , ooha.order_number                                                                      "Número do Pedido"
     , NVL(rct.attribute3, rct.attribute4)                                                    "Versão do Pedido"
     , oola.ORIG_SYS_LINE_REF                                                                 "Referência do Pedido"
     , oola.line_number                                                                       "Num Linha do Pedido"  
     , rctl.reason_code                                                                       "Motivo da Devolução"
     , ooha.ordered_date                                                                      "DT do Pedido"
     , TRUNC(oola.schedule_ship_date)                                                         "DT de Previsao"                                 
     , oola.ordered_quantity * oola.unit_selling_price                                        "Val Total do Pedido"
     , rct.invoice_currency_code                                                              "Val Moeda do Pedido"
     , oola.attribute12                                                                       "Ptax Pedido"                         
     , ctt.name                                                                               "Tipo Titulo"         
     , oola.attribute3                                                                        "Código do Vededor"
     , (SELECT rsa.name
          FROM apps.ra_salesreps_all rsa
         WHERE rsa.salesrep_id = replace(replace(replace(oola.attribute3,'/'),':'), ' '))     Vendedor        
     , oola.attribute5                                                                        Supervisor        
     , oola.attribute7                                                                        Gerente
     , (SELECT rsa.name
          FROM apps.ra_salesreps_all rsa
         WHERE rsa.salesrep_id  = oola.salesrep_id
           AND rsa.ORG_ID = 82)                                                               Regional
     , rctl.attribute3                                                                        "Comissão Vendedor"
  FROM apps.ra_customer_trx_all          rct
     , apps.ra_customer_trx_lines_all    rctl
     , apps.org_organization_definitions ood
     , apps.oe_order_headers_all         ooha
     , apps.oe_order_lines_all           oola
     , apps.xxapps_ar_bill_cust_rel      abcr
     , apps.mtl_system_items_b           msib
     , apps.ra_cust_trx_types_all        ctt
     , Hz_parties                        hp
     , ra_terms_tl                       rtt
     , jl_br_customer_trx_exts           jbcte
     , xxapps_om_ctrl_lim_proposal       xoclp
     , xxapps_om_crll_gr_ec_lin          xocgel
     , xxapps_om_crll_gr_ec_hdr          xocged
     , apps.mtl_parameters               mp
     , apps.ar_payment_schedules_all     aps
     , apps.mtl_item_categories_v        mic
     , apps.wsh_new_deliveries_v         wnd
     , apps.wsh_carriers                 wc
     , apps.org_freight                  orf
 WHERE rct.customer_trx_id            = rctl.customer_trx_id
   AND rct.org_id                     = rctl.org_id
   AND rct.status_trx                 = 'OP'
   AND rctl.warehouse_id              = ood.organization_id
   AND rct.sold_to_customer_id        = ooha.sold_to_org_id
   AND rct.interface_header_attribute1 = ooha.order_number
   AND rctl.inventory_item_id         = oola.inventory_item_id
   AND ooha.header_id                 = oola.header_id
   AND rctl.interface_line_attribute6 = oola.line_id
   AND rct.sold_to_customer_id        = abcr.customer_id
   AND rct.BILL_TO_SITE_USE_ID        = abcr.site_use_id
   AND rctl.inventory_item_id         = msib.inventory_item_id
   AND rctl.warehouse_id              = msib.ORGANIZATION_ID
   AND rctl.line_type                 = 'LINE'
   AND rct.cust_trx_type_id           = ctt.cust_trx_type_id
   AND ctt.type                       = 'INV'
   AND ctt.post_to_gl                 = 'Y'
   AND ctt.org_id                     = rct.org_id
   AND hp.party_id                    = abcr.party_id
   AND rct.term_id                    = rtt.term_id (+)
   AND rtt.language                   = 'PTB'
   AND rct.customer_trx_id            = jbcte.CUSTOMER_TRX_ID(+)
   AND ooha.attribute1                = xoclp.proposal_id(+)
   AND abcr.customer_id               = xocgel.customer_id(+)
   AND xocgel.grp_eco_hdr_id          = xocged.grp_eco_hdr_id(+)
   AND NVL(ood.organization_name,'YYY')    NOT LIKE '%DISCRETA%'
   AND mp.organization_id             = rctl.warehouse_id    
   AND aps.customer_trx_id (+)        = rctl.customer_trx_id 
   AND mic.category_set_name          =  'FISCAL_CLASSIFICATION'
   AND mic.inventory_item_id          =  rctl.inventory_item_id
   AND mic.organization_id            =  rctl.warehouse_id
   AND wnd.delivery_id                =  rct.interface_header_attribute3 (+)
   AND wc.carrier_id                  =  wnd.carrier_id (+)
   AND orf.organization_id            =  rctl.warehouse_id (+)
   AND orf.freight_code               =  wc.freight_code