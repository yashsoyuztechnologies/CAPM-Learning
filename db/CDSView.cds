namespace yash.cds;

using { yash.db.master, yash.db.transaction } from './data-model';

context CDSView {
    define view![POWorkList] as 
        select from transaction.purchaseorder{
            key PO_ID as ![PurchaseOrderNo],
            key Items.PO_ITEM_POS as ![Position] @(title: '{i18n>POSITION}'),
            PARTNER_GUID.BP_ID as ![VendorId],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            Items.GROSS_AMOUNT as ![GrossAmount] @(title: '{i18n>GROSS_AMOUNT}'),
            Items.NET_AMOUNT as ![NetAmount] @(title: '{i18n>GROSS_AMOUNT}'),
            Items.TAX_AMOUNT as ![TaxAmount] @(title: '{i18n>GROSS_AMOUNT}'),
            case OVERALL_STATUS
                when 'N' then 'New'
                when 'D' then 'Delivered'
                when 'p' then 'Pending'
                when 'A' then 'Approved'
                when 'R' then 'Rejected'
            end as ![Status],
            Items.PRODUCT_GUID.DESCRIPTION as ![Product],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]        
        };

    // View for the column name for the language specific 
    define view![ProductVH] as 
        select from master.product {
            @EndUser.label: [
                {
                    language: 'EN',
                    text: 'Producd Id' 
                },
                {
                    language: 'IT',
                    text: 'ID prodotto' 
                }
            ]
            PRODUCT_ID as ![ProductId],
            @EndUser.label: [
                {
                    language: 'EN',
                    text: 'Producd Name' 
                },
                {
                    language: 'IT',
                    text: 'Nome del prodotto' 
                }
            ]
            DESCRIPTION as ![ProductName]
        };

    define view![ItemsView] as 
        select from transaction.poitems {
            PARENT_KEY.PARTNER_GUID.NODE_KEY as![VendorId],
            PRODUCT_GUID.NODE_KEY as![ProductId],
            CURRENCY as![Currency],
            NET_AMOUNT as![NetAmount],
            TAX_AMOUNT as![TaxAmount],
            GROSS_AMOUNT as![GrossAmount],
            PARENT_KEY.OVERALL_STATUS as![Status]
        };

    define view ProductOrders as select from master.product
    mixin {
        PO_ORDERS : Association to ItemsView on PO_ORDERS.ProductId = $projection.ProductKey
    } into
    {
        NODE_KEY as![ProductKey],
        DESCRIPTION as![ProductName],
        PRICE as![Price],
        SUPPLIER_GUID.BP_ID as![SupplierId],
        SUPPLIER_GUID.COMPANY_NAME as![SupplierName],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
        // exposed association like we did in the abap
        PO_ORDERS 
    };

    // define view![CProductAnalytics] as select from PO_ORDERS {
    //     ProductName,
    //     Country,
    //     round(sum(PO_ORDERS.GrossAmount), 2) as![TotalPurchaseAmount]: Decimal(20, 3),
    //     PO_ORDERS.Currency
    // } group by ProductName, Country, PO_ORDERS.Currency
}

