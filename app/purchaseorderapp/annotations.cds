using CatalogService as service from '../../srv/CatalogService';
annotate service.POs with @(
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.BP_ID
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Label: 'Boost',
            Inline: true
        },
        {
            $Type: 'UI.DataField',
            Value: OverallStatus,
            Criticality: ColorCoding,
        }
    ],
    UI.HeaderInfo:{
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ID
        },
        Description : {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME
        }

    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label: 'More Info',
            Facets: [
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Addition Data',
                    Target: '@UI.Identification'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label : 'Pricing Data',
                    Target: '@UI.FieldGroup#MoreInfo1'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label : 'Status Data',
                    Target: '@UI.FieldGroup#MoreInfo2'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        }
    ],
    UI.FieldGroup #MoreInfo1 : {
        Label : 'Price Info',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            }
        ]
    },
    UI.FieldGroup #MoreInfo2 : {
        Label : 'Status',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            }
        ]
    }
);

annotate service.POItems with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type: 'UI.DataField',
            Value : PO_ITEM_POS
        },
        Description : {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION,
        },
    }
);

annotate service.POs with {
    PARTNER_GUID@(
        Common.Text : PARTNER_GUID.COMPANY_NAME,
        Common.ValueList.entity : Service.BusinessPartnerSet
    )
};

annotate service.POItems with {
    PRODUCT_GUID@(
        Common.Text : PRODUCT_GUID.DESCRIPTION,
        Common.ValueList.entity : Service.ProductSet
    )
};



@cds.odata.valuelist
annotate service.BusinessPartnerSet with@(
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME
        }
    ]
);

@cds.odata.valuelist
annotate service.ProductSet with@(
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION
        }
    ]
);