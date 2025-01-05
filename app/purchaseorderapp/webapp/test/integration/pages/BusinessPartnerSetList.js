sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.po.purchaseorderapp',
            componentId: 'BusinessPartnerSetList',
            contextPath: '/BusinessPartnerSet'
        },
        CustomPageDefinitions
    );
});