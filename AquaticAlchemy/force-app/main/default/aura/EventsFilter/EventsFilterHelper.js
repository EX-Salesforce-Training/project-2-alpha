({
	FilterHelper : function(component) {
        
        let method = component.get("c.FilterEvents");
        let filterDate = new Date();
        filterDate = component.find("date").get("v.value");
        
        method.setParams( {filterCriteria : filterDate} );
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.events", response.getReturnValue());
            }
        })
		$A.enqueueAction(method);
	}
})