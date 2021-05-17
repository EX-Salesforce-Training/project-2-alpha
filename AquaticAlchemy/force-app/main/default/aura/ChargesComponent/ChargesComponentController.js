({
    getChargesList : function(component, event, helper) {
        helper.getCharges(component);
    },
    handleClick : function(component, event, helper) {
        helper.submitButton(component);
    },
    handleComponentEvent : function(component, event, helper) {
        helper.updateSelected(component, event);
    }
    
})