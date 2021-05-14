/*    Name: ClassResultHelper  
     Author: Andreology
     Created: 05/08/2021
     Updated: 05/08/2021
     Description: client-side Controller  helper class for ClassResultController Lightning Component which will be on Class Listing Page. 
*/
({
	RetreiveAllClassesHelper : function(component, event, helper)  {
		var action = component.get('c.GetAllClasses');
		action.setCallback(this, function(response) {
			if(response.getState() == "SUCCESS") {
				var responseData = response.getReturnValue();
				component.set('v.classListing', responseData); 
				
				component.set('v.classesAvailable', true); 
			}
			
		});

		$A.enqueueAction(action, false);
	},
	handleClassFilterChange : function(component, event, helper){ 
		let levelFilter = event.getParam('levelFilter');
		let priceFilter = event.getParam('priceFilter');
		let instructorFilter = event.getParam('instructorFilter');
		let dayFilter = event.getParam('dayFilter');
		
		//let action = component.get('c.getSearchedProperty');
	}
})
