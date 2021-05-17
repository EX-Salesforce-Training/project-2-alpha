({
    handleStartFilter : function(component, event, helper) {
        let classLevels = [{label:'Any', value:'Any'},
                             {label:'Beginner', value:'Beginner'},
                             {label:'Intermediate', value:'Intermediate'},
                             {label:'Advanced', value:'Advanced'}
                            ];
        component.set('v.classLevels', classLevels);
        let classPrices = [{label:'Any', value:'Any'},
                           {label:'$75', value:'$75'},
                           {label:'$150', value:'$150'},
                           {label:'$200', value:'$200'}
                          ];
        component.set('v.classPrices', classPrices); 
        //redo to be dynamic
        let classInstructors = [{label:'Any', value:'Any'},
                           {label:'Andy Gomez', value:'Andy Gomez'},
                           {label:'Jackie Chan', value:'Jackie Chan'}
                          ];
        component.set('v.classInstructors', classInstructors);
        let classDays = [{label:'Any', value:'Any'},
                           {label:'Sunday', value:'Sunday'},
                           {label:'Monday', value:'Monday'},
                           {label:'Tuesday', value:'Tuesday'},
                           {label:'Wednesday', value:'Wednesday'},
                           {label:'Thursday', value:'Thursday'},
                           {label:'Friday', value:'Friday'},
                           {label:'Saturday', value:'Saturday'}
                          ];
        component.set('v.classDays', classDays);       
    },
    handleFilterOptionSelected : function(component, event, helper) {
      
        let filter_event = component.getEvent('registeredFilterEvent');
        console.log("CHECKING LEVEL "  + component.get('v.levelSelected'));
        console.log("CHECKING PRICE "  + component.get("v.priceSelected"));
        console.log("CHECKING INSTR "  + component.get("v.instructorSelected"));
        console.log("CHECKING DAY "  + component.get("v.daySelected"));
        filter_event.setParams({
            "levelFilter": component.get("v.levelSelected"),
            "priceFilter":component.get("v.priceSelected"),
            "instructorFilter":component.get("v.instructorSelected"),
            "dayFilter":component.get("v.daySelected")

        });
        filter_event.fire();
    }
})
