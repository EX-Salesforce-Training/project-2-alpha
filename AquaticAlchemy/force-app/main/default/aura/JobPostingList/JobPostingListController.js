///////////////////////////////////////////////////////////////
//
// Name: JobPostingList.js
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/13/21
// Description: Javascript controller that helps call an Aura controller method for database querying.
//
///////////////////////////////////////////////////////////////

({
    doInit : function(component, event, helper) {
        let method = component.get("c.getPosts");
        
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){                
                component.set("v.records", response.getReturnValue());
            } else{
                console.log("error: " + response.getState());
                console.log("error: " + response.getReturnValue());
                
            }
        });
        $A.enqueueAction(method);

    }
})