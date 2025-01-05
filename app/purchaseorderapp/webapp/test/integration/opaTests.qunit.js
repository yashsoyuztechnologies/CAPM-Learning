sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/po/purchaseorderapp/test/integration/FirstJourney',
		'com/po/purchaseorderapp/test/integration/pages/BusinessPartnerSetList',
		'com/po/purchaseorderapp/test/integration/pages/BusinessPartnerSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, BusinessPartnerSetList, BusinessPartnerSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/po/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBusinessPartnerSetList: BusinessPartnerSetList,
					onTheBusinessPartnerSetObjectPage: BusinessPartnerSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);