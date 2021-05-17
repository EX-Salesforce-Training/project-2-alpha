///////////////////////////////////////////////////////////////
//
// Name: CampScheduleHelper.js
// Author: David Serrano, Salesforce Developer
// Created: 05/14/21
// Updated: 05/14/21
// Description: Javascript helper to handle the logic behind calling the Apex Aura controller to retreive
// day schedules.
//
///////////////////////////////////////////////////////////////

({
	initDaySchedule : function(component) {
		let method = component.get("c.getDaySchedules");
        console.log("campId: " + component.get("v.schedule.Id"));
        method.setParam("campId", component.get("v.schedule.Id"));
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
            	component.set("v.daySchedules", method.getReturnValue());
                console.log("return: " + method.getReturnValue());
            }
        });
        $A.enqueueAction(method);
	}
})