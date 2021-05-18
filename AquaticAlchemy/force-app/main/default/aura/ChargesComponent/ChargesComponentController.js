({
    getChargesList : function(component, event, helper) {
        helper.getCharges(component);
    },
    handleSubmit : function(component, event, helper) {
        helper.submitButton(component);
    },
    handleComponentEvent : function(component, event, helper) {
        helper.updateSelected(component, event);
    },
    handleDelete : function(component, event ,helper){
        helper.deleteButton(component);
    }
    
})