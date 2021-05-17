/*
///////////////////////////////////////////////////////////////
//
// Name: ApplicatinModalHelper.js
// Author: David Serrano, Salesforce Developer
// Created: 05/12/21
// Updated: 05/13/21
// Description: Javascript helper to handle the logic after an on click event.
// Also fires a toast to let the user know their application was cancelled or submitted successfully.
//
///////////////////////////////////////////////////////////////
*/

({
	closeModal : function(component, event) {
        let cancelledEvent = component.getEvent("ApplicationCancelledEvent");
        cancelledEvent.fire();
        
        let exampleToast = $A.get("e.force:showToast");
        exampleToast.setParams({"message":"Application Cancelled"});
        exampleToast.fire();
    },
    
    applicationSubmitted : function(component, event){
        let submittedEvent = component.getEvent("CloseModalEvent");
        submittedEvent.setParams({"cancelled" : false});
        submittedEvent.fire();
        
        let exampleToast = $A.get("e.force:showToast");
        exampleToast.setParams({"message":"Application Submitted"});
        exampleToast.fire();
    }
    
})