({
    getOrderItems : function(component, event, helper) {
        
        let method = component.get("c.GetOrderItems");
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.items", response.getReturnValue());
            }  
        })
        $A.enqueueAction(method);
    },
    getOrders : function(component, event, helper) {
        
        let method = component.get("c.GetOrders");
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.orders", response.getReturnValue());
            }  
        })
        $A.enqueueAction(method);
    }
    
})