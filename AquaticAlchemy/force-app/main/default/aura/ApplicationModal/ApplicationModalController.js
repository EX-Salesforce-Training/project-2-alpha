/*
///////////////////////////////////////////////////////////////
//
// Name: ApplicatinModalController.js
// Author: David Serrano, Salesforce Developer
// Created: 05/12/21
// Updated: 05/13/21
// Description: Javascript controller to handle on click events.
//
///////////////////////////////////////////////////////////////
*/

({
	cancelAction : function(component, event, helper) {
		helper.closeModal(component, event);
	},
    
    submitAction : function(component, event, helper){
        helper.applicationSubmitted(component, event);
    }
})