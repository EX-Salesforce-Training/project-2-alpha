/*
///////////////////////////////////////////////////////////////
//
// Name: CareersController.js
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/15/21
// Description: Javascript controller to help handle component and application events.
//
///////////////////////////////////////////////////////////////
*/

({
	handleApplyEvent : function(component, event, helper) {
		helper.displayApplicationModal(component, event);
	},
    
    handleCancelledApplication : function(component, event, helper){
        helper.closeApplicationModal(component, event);
    }
})