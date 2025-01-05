namespace yash.db;

using { cuid, managed, temporal, Currency } from '@sap/cds/common';
using { yashdb.constants as common } from './constants';

context master {
    entity businesspartner {
        key NODE_KEY: common.Guid @(title : '{i18n>PARTNER_GUID}');
        BP_ROLE: String(2) @(title : '{i18n>ROLE}');
        EMAIL_ADDRESS: String(103) @(title : '{i18n>EMAIL_ADDRESS}');
        ADDRESS_GUID: Association to address @(title : '{i18n>ADDRESS_GUID}');
        PHONE_NUMBER: String(32) @(title : '{i18n>PHONE_NO}');
        FAX_NUMBER: String(32) @(title : '{i18n>FAX_NUMBER}');
        WEB_ADDRESS: String(44) @(title : '{i18n>WEB_ADDRESS}');
        BP_ID: String(32) @title : '{i18n>BP_ID}';
        COMPANY_NAME: String(250) @(title : '{i18n>COMPANY_NAME}');
    }

    entity address {
        key NODE_KEY : common.Guid;
        CITY: String(50) @title : '{i18n>CITY}';
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING: String(128);
        COUNTRY: String(44) @title : '{i18n>COUNTRY}';
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE: Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    entity product {
        key NODE_KEY: common.Guid @title : '{i18n>PRODUCT_GUID}';
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32);
        DESCRIPTION: localized String(255) @title : '{i18n>PRODUCT_NAME}';
        SUPPLIER_GUID: Association to one businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_UNIT: String(2);
        WEIGHT_MEASURE: Decimal(5, 2);
        CURRENCY_CODE: String(4);
        PRICE : Decimal(5, 2);
        WIDTH : Decimal(5, 2);
        HEIGHT : Decimal(5, 2);
        DEPTH : Decimal(5, 2);
        DIM_UNIT: String(2);
    }

    entity employees : cuid {
        nameFirst : String(40);
        nameMiddle : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        sex: common.Gender;
        language: String(2);
        phoneNumber: common.PhoneNumber;
        email: common.EmailAddress;
        loginName: String(12);
        Currency: Currency;
        salaryAmount: common.AmountT;
        accountNumber: String(16);
        bankId: String(8);
        bankName: String(64);
    }
    
}

context transaction {
    entity purchaseorder : common.Amount{
        key NODE_KEY : common.Guid @title : '{i18n>PO_ID}';
        PO_ID: String(40);
        PARTNER_GUID: Association to master.businesspartner;
        LIFECYCLE_STATUS: String(1);
        OVERALL_STATUS: String(1) @title : '{i18n>OVERALL_STATUS}';
        Items : Association to many poitems on Items.PARENT_KEY = $self;

    }

    entity poitems : common.Amount {
        key NODE_KEY: common.Guid;
        PARENT_KEY: Association to purchaseorder;
        PO_ITEM_POS : Integer;
        PRODUCT_GUID: Association to master.product;

    }
}