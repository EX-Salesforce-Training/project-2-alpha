({
    onCheck: function(component, event) {
        let checkCmp = component.find("checkbox");
        let chargeSelected = component.get("v.orderProduct")
        let checkEvent = component.getEvent("checkboxEvent");
        checkEvent.setParam("Charge", chargeSelected);
        checkEvent.setParam("Selected", checkCmp.get("v.value"));       
        checkEvent.fire();
    }
})