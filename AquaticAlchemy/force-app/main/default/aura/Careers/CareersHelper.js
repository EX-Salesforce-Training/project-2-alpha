/*
///////////////////////////////////////////////////////////////
//
// Name: CareersHelper.js
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/15/21
// Description: Javascript helper to handle the logic behind opening and closing the application modal.
//
/////////////////////////////////////////////////////////////// 
*/

({
    displayApplicationModal : function(component, event) {
        let bool = component.get("v.applying");
        component.set("v.applying", !bool);
        
        let position = event.getParam("position");
        component.set("v.position", position);
        
        let jobId = event.getParam("jobId");
        component.set("v.jobId", jobId);
	},
    
    closeApplicationModal : function(component, event){
        let bool = component.get("v.applying");
        component.set("v.applying", !bool);

	}
})