///////////////////////////////////////////////////////////////
//
// Name: SummerCampAccordionController.js
// Author: David Serrano, Salesforce Developer
// Created: 05/13/21
// Updated: 05/14/21
// Description: Javascript controller to help handle the initialization call.
//
///////////////////////////////////////////////////////////////

({
	doInit : function(component, event, helper) {
		helper.initArticles(component);
	}
})