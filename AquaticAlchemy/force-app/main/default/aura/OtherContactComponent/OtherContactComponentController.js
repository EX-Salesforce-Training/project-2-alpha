({
	handleButtonClick : function(component, event, helper) {
        let checkEvent = component.getEvent("contactButton");
		checkEvent.setParam("ContactShowing", true);
        checkEvent.setParam("ContactNotShowing", false);
        checkEvent.fire();
        console.log("Did it!");
        let contactEvent = component.getEvent("contactSelected");
        contactEvent.setParam("Contact", component.get("v.contactID"));
        contactEvent.fire();
        console.log("Did it Again!")
	}
})