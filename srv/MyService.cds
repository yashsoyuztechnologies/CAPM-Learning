using { yash.cds.CDSView } from '../db/CDSView';
using { yash.db.master } from '../db/data-model';

service MyService @(path: 'MyService') {

    function pokemon(name: String(20)) returns String;
    entity ProductOrdersSet as projection on CDSView.ProductOrders{
        *, PO_ORDERS
    };

    entity ReadEmployeeSrv as projection on master.employees;
}