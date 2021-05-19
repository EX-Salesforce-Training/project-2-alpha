({
    getCharges : function(component, event, helper) {
        let chargesList = component.get("v.orderProductList"); 
        if(chargesList.length === 0){
            console.log("ENTERED IF")
            component.set("v.nothingInList", true);
        }
        else{component.set("v.nothingInList", false);}
        console.log("OrderList: " + chargesList);
        function mapFalses() {
            let mapOfFalses = new Map();
            for (var i = 0; i < chargesList.length; i++) {
                mapOfFalses.set(chargesList[i].Id , false);
            }
            return mapOfFalses;
        }
        let falsesmap = mapFalses();
        component.set("v.checkifTrue", falsesmap);
    },
    deleteButton : function(component, event, helper) {
        console.log("deleteButton");
        let method = component.get("c.updateCharges");
        let trueFalseMap = component.get("v.checkifTrue");
        function getTrues() {
            var ordersWithTrue = [false];
            var i = 0;
            for (let myKey of trueFalseMap.keys()) {
                if(trueFalseMap.get(myKey) === true){
                    ordersWithTrue[i] = myKey;
                    i++;
                }               
            }
            return ordersWithTrue;
        }
        let finalList = getTrues();
        method.setParams({toBeRemoved: finalList});
        method.setCallback(component,
            function(response) {
                var state = response.getState();
                if (state === 'SUCCESS'){
                    // Refresh the view
                    // after data is updated
                    $A.get('e.force:refreshView').fire();
                } else {
                    console.log("error here");
                     // Handle the 'ERROR' or 'INCOMPLETE' state
                }
            }
        );
        $A.enqueueAction(method);
        
    },
    updateSelected : function(component, event) {
        let charge = event.getParam("Charge");
        let selected = event.getParam("Selected");
        let myMap = component.get("v.checkifTrue");
        console.log("Before " + myMap.get(charge));
        myMap.set(charge, selected);
        console.log("After " + myMap.get(charge));
        for (let myValue of myMap.values()) {
            if(myValue === true){
                component.set("v.allFalse", false)
                return;
            }
            
        }
        console.log("Here In US")
        component.set("v.allFalse", true);
    },
    submitButton : function(component) {
        console.log("In submit")
        let orderList = component.get("v.order");
        console.log("Order List: " + orderList);
        orderList.forEach(myFunction);
        function myFunction(item) {
   			item.Status = "Activated";
            console.log(item.Status);
        }
        let method = component.get("c.SubmitAction");
        method.setParams({toBeUpdated: orderList});
        method.setCallback(component,
                           function(response) {
                               var state = response.getState();
                               if (state === 'SUCCESS'){
                                   // Refresh the view
                                   // after data is updated
                                   $A.get('e.force:refreshView').fire();
                               } else {
                                   console.log("submit error");
                               }
                           }
                          );
        $A.enqueueAction(method);
    }
    
})