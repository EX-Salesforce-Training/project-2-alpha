({
    getCharges : function(component, event, helper) {
        let method = component.get("c.getCharges");
        let accountID = component.get("v.accountID");
        method.setParams({acctString: accountID});
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.chargesList", response.getReturnValue());
                let chargesList = component.get("v.chargesList"); 
                function mapFalses() {
                    let mapOfFalses = new Map();
                    for (var i = 0; i < chargesList.length; i++) {
                        mapOfFalses.set(chargesList[i].Id , false);
                    }
                    return mapOfFalses;
                }
                let falsesmap = mapFalses();
                component.set("v.checkifTrue", falsesmap);
            }
            
            console.log("Checking getState" + response.getState());
            console.log("Checking ReturnValue" + response.getReturnValue());
        })
        $A.enqueueAction(method);
    },
    submitButton : function(component) {
        let method = component.get("c.UpdateCharges");
        let accountID = component.get("v.accountID");
        method.setParams({acctString: accountID});
        method.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.chargesList", response.getReturnValue());
            }
            console.log("Checking getState" + response.getState());
            console.log("Checking ReturnValue" + response.getReturnValue());
        })
        $A.enqueueAction(method);
    },
    updateSelected : function(component, event) {
        let charge = event.getParam("Charge");
        let selected = event.getParam("Selected");
        let myMap = component.get("v.checkifTrue");
        console.log("Before " + myMap.get(charge));
        myMap.set(charge, selected);
        console.log("After " + myMap.get(charge));
    }
    
})