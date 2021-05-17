///////////////////////////////////////////////////////////////
//
// Name: CampScheduleController.js
// Author: David Serrano, Salesforce Developer
// Created: 05/14/21
// Updated: 05/14/21
// Description: Javascript controller to help handle the component initialization.
//
///////////////////////////////////////////////////////////////
({
	doInit : function(component, event, helper) {
		helper.initDaySchedule(component);
	}
})