({
    myAction : function(component, event, helper) {
        var action = component.get("c.checkMethod");
        action.setCallback(this,function(response){  
            let account = response.getReturnValue();
            component.set("v.userAccount", account.Id);
            component.set("v.contact", account.Primary__c);
            let primary = component.get("v.contact");
            console.log("Contact is: " + account.Primary__c);
        });
        
        $A.enqueueAction(action);
    },
    getContacts : function(component, event, helper) {
        console.log("Here");
        var method = component.get("c.getAccociatedContact");
        method.setParams({account : component.get("v.userAccount")})
        method.setCallback(this,function(response){
            console.log("Here2");
            let contactList = response.getReturnValue();
            component.set("v.otherContacts", contactList);
            console.log("First in list: " + contactList);
            console.log("Here3");
        });
        $A.enqueueAction(method);
    },
    handleButtonEvent : function(component, event, helper){
        console.log("Did it here too")
        let contactShowing = event.getParam("ContactShowing");
        let contactNotShowing = event.getParam("ContactNotShowing");
		component.set("v.contactNotShowing", contactNotShowing);
        component.set("v.contactView", contactShowing);
        console.log("Contact Not Showing: " + contactNotShowing);
    },
    setContact : function(component, event){
        let contact = event.getParam("Contact");
        console.log("Contact Selected: " + contact );
        component.set("v.contactSelected", contact);
    }

})