///////////////////////////////////////////////////////////////
//
// Name: JobPostingItemHelper.js
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/12/21
// Description: Javascript helper to help fire the event that opens up the Application Modal.
//
///////////////////////////////////////////////////////////////

({
	fireEvent : function(component) {
        let applyEvent = $A.get("e.c:ApplyClicked");
        let position = component.get("v.postId.Name");
        console.log(" " + position);
        let jobId = component.get("v.postId.Id");
        console.log(" " + jobId.toString());
        applyEvent.setParams({"position" : position, "jobId" : jobId});
        applyEvent.fire();
	}
})