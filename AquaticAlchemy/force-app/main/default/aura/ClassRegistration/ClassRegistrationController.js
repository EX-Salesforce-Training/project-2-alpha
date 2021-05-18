({
    handleRegistration : function(component, event, helper) {
        component.set('v.registeredSuccesfully', "true");
        console.log("INSIDE HANDLEREGISTARTION " + component.get('v.registeredSuccesfully'));
    }
})