/*    Name: ClassResultController 
     Author: Andreology
     Created: 05/08/2021
     Updated: 05/08/2021
     Description: CLient-side Controller class for ClassDetail Lightning Component which will be on Class Listing Page. 
*/
({
	RetreiveAllClasses : function(component, event, helper) {
		helper.RetreiveAllClassesHelper(component);
          let checking = helper.FetchCurrentAccountId(component, event, helper);
          
	},
     HandleInstructorDetailsPopUp : function(component, event, helper) {
          let src_event = event.getSource();
          let instr_id = src_event.get('v.value');
          component.set('v.instructorId', instr_id);
          component.set('v.instructorDetailsClicked', "true");
     },
     HandleRegistrationPopUp : function(component, event, helper) {
          let src = event.getSource();
          let classId = src.get('v.value');
          component.set('v.classId', classId);
          component.set('v.registrationBttnClicked', "true");
     }, 
     HandleClassDetailsPopUp : function(component, event, helper) {
          let src_event = event.getSource();
          let class_id = src_event.get('v.value');
          component.set('v.classId', class_id);
          component.set('v.classDetailsClicked', true);
     },
     HandleCloseClassDetails : function(component, event, helper) {
          component.set("v.classDetailsClicked", false);
     },
     HandleCloseInstructorDetails : function(component, event, helper) {
          component.set("v.instructorDetailsClicked", false);
     },
     HandleCloseRegistrationPopUp : function(component, event, helper) {
          component.set('v.registrationBttnClicked', "false");
         
     },
     HandleClassFilterChange : function(component, event, helper) {
          helper.handleClassFilterChange(component, event, helper);
     }
})