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
          component.set('v.instructorId', instr_id);
          component.set('v.instructorDetailsClicked', "true");
     },
     handleCloseInstructorDetails : function(component, event, helper) {
          component.set('v.instructorDetailsClicked', "false");
     },
     handleCloseRegistrationPopUp : function(component, event, helper) {
          component.set('v.registrationBttnClicked', "false");
     },
     handleRegistrationPopUp : function(component, event, helper) {
          let src = event.getSource();
          let classId = src.get('v.value');
          component.set('v.classId', classId);
          component.set('v.registrationBttnClicked', "true");
     }, 
     navigateToAllDetails : function(component, event, helper) {
          let serv = component.find("navigation_service");
          let src = event.getSource();
          let classId = src.get('v.value');
          let page_reference = {
               type:"standard__component",
               attribute: {
                    componentName: "c__ClassOverview"
               },
               state: {
                    "c__classId": classId
               }
          };
          component.set("v.page_reference", page_reference);
          serv.navigate(page_reference);
     }
})