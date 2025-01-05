using CatalogService as service from '../../srv/CatalogService';
annotate service.BusinessPartnerSet with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'NODE_KEY',
                Value : NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'BP_ROLE',
                Value : BP_ROLE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'EMAIL_ADDRESS',
                Value : EMAIL_ADDRESS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ADDRESS_GUID_NODE_KEY',
                Value : ADDRESS_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PHONE_NUMBER',
                Value : PHONE_NUMBER,
            },
            {
                $Type : 'UI.DataField',
                Label : 'FAX_NUMBER',
                Value : FAX_NUMBER,
            },
            {
                $Type : 'UI.DataField',
                Label : 'WEB_ADDRESS',
                Value : WEB_ADDRESS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'BP_ID',
                Value : BP_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'COMPANY_NAME',
                Value : COMPANY_NAME,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : BP_ROLE,
        },
        {
            $Type : 'UI.DataField',
            Value : EMAIL_ADDRESS,
        },
        {
            $Type : 'UI.DataField',
            Value : ADDRESS_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : PHONE_NUMBER,
        }
    ],
    UI.SelectionFields :  [
        EMAIL_ADDRESS,
        BP_ID
    ]
);

annotate service.BusinessPartnerSet with {
    ADDRESS_GUID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'AddressSet',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : ADDRESS_GUID_NODE_KEY,
                ValueListProperty : 'NODE_KEY',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'CITY',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'POSTAL_CODE',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'STREET',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'BUILDING',
            },
        ],
    }
};

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

    }
);


