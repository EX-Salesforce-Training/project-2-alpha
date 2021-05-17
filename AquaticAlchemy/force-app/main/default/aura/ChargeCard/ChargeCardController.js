({
    onCheck: function(component, event) {
        let checkCmp = component.find("checkbox");
        let resultCmp = component.find("checkResult");
        resultCmp.set("v.value", ""+checkCmp.get("v.value"));
        let chargeSelected = component.get("v.chargeID")
        let checkEvent = component.getEvent("checkboxEvent");
        checkEvent.setParam("Charge", chargeSelected);
        checkEvent.setParam("Selected", checkCmp.get("v.value"));       
        checkEvent.fire();
    }
})