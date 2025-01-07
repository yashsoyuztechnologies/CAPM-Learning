using {
    yash.db.master,
    yash.db.transaction
} from '../db/data-model';

service CatalogService @(path : 'CatalogService') {

    @Capabilities : {Deletable}
    entity BusinessPartnerSet as projection on master.businesspartner;
    // @readonly
    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    function getOrderStatus() returns POs;
    entity POs 
    @(
        odata.draft.enabled : true,
        Common.DefaultValuesFunction : 'getOrderStatus'
    ) as projection on transaction.purchaseorder{
        *, 
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'O' then 'Open'
            when 'X' then 'Rejected'
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'D' then 'Delivered' end as OverallStatus : String(10),
        case OVERALL_STATUS
            when 'N' then 0
            when 'O' then 0
            when 'X' then 1
            when 'P' then 2
            when 'A' then 2
            when 'D' then 3 end as ColorCoding : Integer
    } actions{
        @cds.odata.bindingparameter.name : '_boost'
        @Common.SideEffects : {
            TargetProperties : ['_boost/GROSS_AMOUNT']
         }
        action boost() returns POs;
        function largestOrder() returns POs;
    };
    entity POItems as projection on transaction.poitems;

}