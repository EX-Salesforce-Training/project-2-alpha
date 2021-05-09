({
	RetreiveAllClassesHelper : function(component, event, helper)  {
		var action = component.get('c.GetAllClasses');
		action.setCallback(this, function(response) {
			var responseData = response.getReturnValue();
			component.set('v.classListing', responseData); 
			component.set('v.classesAvailable', true); 
		});

		$A.enqueueAction(action, false);
	}
})