namespace yashdb.constants;
using { Currency } from '@sap/cds/common';

type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}

type AmountT : Decimal(10, 2) @(
    Semantic.amount.currencyCode: 'CURRENCY_code',
    sap.unit : 'CURRENCY_code',
);

aspect Amount : {
    CURRENCY : Currency;
    GROSS_AMOUNT : AmountT @(title: 'Gross Amount');
    NET_AMOUNT : AmountT @(title: 'Net Amount');
    TAX_AMOUNT : AmountT @(title: 'Tax Amount');
}

type PhoneNumber : String(30)@assert.format : '^\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$';

type EmailAddress : String(30)@assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

// datatype for more reuseability
type Guid : String(32);

// aspects are used to add the same column again and again in the multiple tables
aspect address {
    HOUSENO : Int16;
    STREET  : String(80);
    CITY    : String(20);
    COUNTRY : String(20);
}
