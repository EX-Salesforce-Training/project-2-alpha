///////////////////////////////////////////////////////////////
//
// Name: OnePageApplicationController.js
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/15/21
// Description: Javascript controller to help handle an on click event on the navigation bar.
//
///////////////////////////////////////////////////////////////

({
    btnClicked : function(component, event, helper) {
		helper.changeDisplay(component, event);
	}
})