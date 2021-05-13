/*    Name: ClassResultController 
     Author: Andreology
     Created: 05/08/2021
     Updated: 05/08/2021
     Description: CLient-side Controller class for ClassDetail Lightning Component which will be on Class Listing Page. 
*/
({
	RetreiveAllClasses : function(component, event, helper) {
		helper.RetreiveAllClassesHelper(component);
	},
     handleInstructorDetails : function(component, event, helper) {
          let src_event = event.getSource();
          let instr_id = src_event.get('v.value');
          console.log("checking", instr_id)
          component.set('v.instructorId', instr_id);
          component.set('v.instructorDetailsClicked', "true");
     },
     handleCloseInstructorDetails : function(component, event, helper) {
          component.set('v.instructorDetailsClicked', "false");
     }
})