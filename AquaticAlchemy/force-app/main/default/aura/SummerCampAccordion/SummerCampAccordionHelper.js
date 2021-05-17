///////////////////////////////////////////////////////////////
//
// Name: SummerCampAccordionHelper.js
// Author: David Serrano, Salesforce Developer
// Created: 05/13/21
// Updated: 05/14/21
// Description: Javascript helper that handles the logic behind the initialization call to the Apex Aura Controller.
//
///////////////////////////////////////////////////////////////

({
    initArticles : function(component){
        console.log("initArticles called");
        let method = component.get("c.getArticles");
        method.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                component.set("v.articles", method.getReturnValue());
                
            }
        });
        $A.enqueueAction(method);
        
        let action = component.get("c.getCampSchedules");
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                component.set("v.schedules", action.getReturnValue());
                
            }
        });
        $A.enqueueAction(action);
    }
    
})