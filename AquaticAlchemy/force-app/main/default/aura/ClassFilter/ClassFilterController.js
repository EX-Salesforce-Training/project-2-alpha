({
    handleStartFilter : function(component, event, helper) {
        let classLevels = [{label:'Any', Value:'Any'},
                             {label:'Beginner', Value:'Beginner'},
                             {label:'Intermediate', Value:'Intermediate'},
                             {label:'Advanced', Value:'Advanced'}
                            ];
        component.set('v.classLevels', classLevels);
        let classPrices = [{label:'Any', Value:'Any'},
                           {label:'$75', Value:'$75'},
                           {label:'$150', Value:'$150'},
                           {label:'$200', Value:'$200'}
                          ];
        component.set('v.classPrices', classPrices); 
        //redo to be dynamic
        let classInstructors = [{label:'Any', Value:'Any'},
                           {label:'Andy Gomez', Value:'Andy Gomez'},
                           {label:'Jackie Chan', Value:'Jackie Chan'}
                          ];
        component.set('v.classInstructors', classInstructors);
        let classDays = [{label:'Any', Value:'Any'},
                           {label:'Sunday', Value:'Sunday'},
                           {label:'Monday', Value:'Monday'},
                           {label:'Tuesday', Value:'Tuesday'},
                           {label:'Wednesday', Value:'Wednesday'},
                           {label:'Thursday', Value:'Thursday'},
                           {label:'Friday', Value:'Friday'},
                           {label:'Saturday', Value:'Saturday'}
                          ];
        component.set('v.classDays', classDays);       
    },
    handleFilterOptionSelected : function(component, event, helper) {
        let filter_event = component.getEvent('ClassFilterEvent');
        filter_event.setParams({
            "levelFilter": component.get('v.levelSelected'),
            "priceFilter":component.get('v.priceSelected'),
            "instructorFilter":component.get('v.instructorSelected'),
            "dayFilter":component.get('v.daySelected')

        });
        filter_event.fire();
    }
})
