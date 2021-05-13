({
    handleStartFilter : function(component, event, helper) {
        let classLevels = [{label:'Any', Value:'Any'},
                             {label:'Beginner', Value:'Beginner'},
                             {label:'Intermediate', Value:'Intermediate'},
                             {label:'Advanced', Value:'Advanced'}
                            ];
        component.set('v.classLevels', classLevels);
    }
})
