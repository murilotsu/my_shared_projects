SELECT distinct
      'SAÍDA'               TipoMovimento
     , ood.organization_code EmpresaFaturamento
     , ood.organization_name DescEmpresaFaturamento
     , ood.organization_code EmpresaProdutora
     , ood.organization_name DescEmpresaProdutora
     , rct.trx_number        NumeroNotaFiscal
     , to_char(ooh.order_number)      NumeroPedido
     , ool.line_number       NumeroLinha
     ,(select sum(ool1.ordered_quantity)
         from apps.oe_order_lines_all ool1
            , apps.ra_customer_trx_lines_all rcl1
            , apps.ra_customer_trx_all rct1
         where 1=1
         and ool1.header_id = ooh.header_id
         and ool1.line_id = rcl1.interface_line_attribute6
         and rcl1.customer_trx_id = rct1.customer_trx_id
         and rct1.status_trx<>'VD')    QuantidadeNegociada
     , ooh.ordered_date      DataPedido
     , cfc.customer_name     Parceiro
     , cfc.customer_number   CodigoParceiro
     , rct.trx_date          DataNegociacao
     , msi.segment1          CodigoProduto
     , msi.description       DescricaoProduto
     , (SELECT wdv.lot_number 
          FROM apps.wsh_deliverables_v wdv 
        WHERE 1=1 
          AND wdv.source_line_id = ool.line_id
          AND wdv.source_header_id = ooh.header_id
          and rownum = 1 
          GROUP BY wdv.lot_number)               LoteProduto
     , rcl.quantity_invoiced QuantidadeNotaFiscal
     , rcl.extended_amount   ValorUnitario
     , msi.attribute13       DescGenericaProduto
  FROM apps.ra_batch_sources_all         rbs
     , apps.ra_cust_trx_types_all        rtt
     , apps.mtl_system_items_b           msi
     , apps.cll_f255_ar_customers_v      cfc
     , apps.oe_transaction_types_tl      ott
     , apps.org_organization_definitions ood
     , apps.oe_order_headers_all         ooh
     , apps.oe_order_lines_all           ool
     , apps.ra_customer_trx_lines_all    rcl
     , apps.ra_customer_trx_all          rct
 WHERE 1=1
   AND rbs.batch_source_id        = rct.batch_source_id
   AND rtt.cust_trx_type_id       = rct.cust_trx_type_id
   AND cfc.site_use_id            = rct.ship_to_site_use_id
   AND cfc.customer_id            = rct.ship_to_customer_id
   AND UPPER(ott.name)         LIKE '%EMPR_ST%'
   AND ott.language               = 'PTB'
   AND ott.transaction_type_id    = ool.line_type_id
   AND ooh.order_number           = rcl.sales_order
   AND ooh.header_id              = ool.header_id
   AND ood.organization_id        = ool.ship_from_org_id
   AND ool.ship_from_org_id       = msi.organization_id
   AND ool.inventory_item_id      = msi.inventory_item_id
   AND ool.line_id                = rcl.interface_line_attribute6
   AND rcl.interface_line_context = 'ORDER ENTRY'
   AND msi.organization_id        = rcl.warehouse_id
   AND msi.inventory_item_id      = rcl.inventory_item_id
   AND rcl.line_type              = 'LINE'
   AND rcl.customer_trx_id        = rct.customer_trx_id
   and rct.status_trx <> 'VD'
   UNION ALL 
SELECT DISTINCT
      'ENTRADA'             TipoMovimento
     , ood.organization_code EmpresaFaturamento
     , ood.organization_name DescEmpresaFaturamento
     , ood.organization_code EmpresaProdutora
     , ood.organization_name DescEmpresaProdutora
     , to_char(cfi.invoice_num)       NumeroNotaFiscal
     , pha.segment1          NumeroPedido
     , pla.line_num          NumeroLinha
     , pla.quantity          QuantidadeNegociada
     , pha.creation_date     DataPedido
     , ass.vendor_name       Parceiro
     , ass.segment1          CodigoParceiro
      , cfi.invoice_date      DataNegociacao
     , msi.segment1          CodigoProduto
     , msi.description       DescricaoProduto
     , mln.lot_number        LoteProduto
     , CASE
            WHEN to_char(cfi.invoice_num) LIKE '%.01%'
            THEN -(cil.quantity)
            ELSE cil.quantity
     END as QuantidadeNotaFiscal
     , cil.unit_price        ValorUnitario
     , msi.attribute13       DescGenericaProduto
  FROM apps.mtl_system_items_b           msi
     , apps.po_headers_all               pha
     , apps.po_lines_all                 pla
     , apps.po_releases_all              pra
     , apps.po_line_locations_all        pll
     , apps.mtl_transaction_lot_numbers  mln
     , apps.mtl_material_transactions    mmt
     , apps.rcv_transactions             rts
     , apps.rcv_shipment_headers         rsh
     , apps.rcv_shipment_lines           rsl
     , apps.cll_f189_invoice_lines       cil
     , apps.ap_suppliers                 ass
     , apps.po_vendor_sites_all          pvs
     , apps.cll_f189_fiscal_entities_all cfe
     , apps.cll_f189_invoice_types       cft
     , apps.cll_f189_invoices            cfi
     , apps.hr_all_organization_units    hou
     , apps.org_organization_definitions ood
     , apps.mtl_parameters               mps
     , apps.cll_f189_entry_operations    ceo
 WHERE 1=1
   AND mln.transaction_id(+)    = mmt.transaction_id
   AND mln.inventory_item_id(+) = mmt.inventory_item_id
   AND mln.organization_id(+)   = mmt.organization_id
   AND mmt.rcv_transaction_id  = rts.transaction_id
   AND rts.shipment_header_id = rsl.shipment_header_id
   AND rts.shipment_line_id   = rsl.shipment_line_id
   AND rsh.shipment_header_id = rsl.shipment_header_id
   AND rsl.po_line_location_id = pll.line_location_id
   AND rsl.item_id = cil.item_id
   AND rsl.quantity_received = cil.quantity
   AND pha.po_header_id(+)     = pla.po_header_id
   AND pla.po_line_id(+)       = pll.po_line_id
   AND pra.po_release_id(+)    = pll.po_release_id
   AND pra.po_header_id(+)     = pll.po_header_id
   AND pll.line_location_id(+) = cil.line_location_id
   AND ass.vendor_id           = pvs.vendor_id
   AND pvs.vendor_site_id      = cfe.vendor_site_id 
   AND cfe.entity_id           = cfi.entity_id
   AND msi.organization_id     = cil.organization_id
   AND msi.inventory_item_id   = cil.item_id
   AND cil.organization_id     = cfi.organization_id
   AND cft.invoice_type_id     = cfi.invoice_type_id
   AND cil.invoice_id          = cfi.invoice_id
   AND cfi.operation_id        = ceo.operation_id
   AND cfi.organization_id     = ceo.organization_id
   AND hou.organization_id     = ood.operating_unit
   AND ood.organization_id     = mps.organization_id
   AND mps.organization_id     = ceo.organization_id
   AND pla.attribute2 = 'EMPRESTIMO'

   ORDER BY 1,6