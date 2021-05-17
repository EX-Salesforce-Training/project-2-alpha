({
    CarouselHelper : function(component) {
        
        let method = component.get("c.GetEvents");
        
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.events", response.getReturnValue());
                let eventlist = component.get("v.events");
                if(eventlist.length > 0){
                	component.set("v.eventsAvailable", true);
                }
            }
            
        })
        $A.enqueueAction(method);
        
        
    }
})