({
	ClearFieldsHelper : function(component) {
        component.find("name").set("v.value","");
        component.find("description").set("v.value","");
        component.find("activitydate").set("v.value","");
        component.find("endtime").set("v.value","");
        component.find("subject").set("v.value","");
        component.find("isallday").set("v.value","");
        
        let successToast = $A.get("e.force:showToast");
        successToast.setParams({"type":"success","message":"Event Created"});
		successToast.fire();
		
	}
})