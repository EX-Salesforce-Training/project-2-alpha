///////////////////////////////////////////////////////////////
//
// Name: OnePageApplicationHelper.js
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/15/21
// Description: Javascript helper to handle the logic of switching the component being displayed.
// The logic involves turning on the boolean correlating to the component to be displayed. 
// The rest of the booleans are then turned off.
//
///////////////////////////////////////////////////////////////

({
    changeDisplay : function(component, event){
        let clicked = event.getSource().get("v.label");
        let bool;
    	
        console.log(clicked);
        
        switch(clicked){
            case "Home":
                bool = component.get("v.homePage");
                console.log(clicked+": "+bool);
                if(bool == true){
                    return;
                }
                bool = true;
                component.set("v.homePage", bool);
                component.set("v.campPage", !bool);
                component.set("v.accountPage", !bool);
                component.set("v.classesPage", !bool);
                component.set("v.careerPage", !bool);
                break;
            case "Summer Camp":
                bool = component.get("v.campPage");
                console.log(clicked+": "+bool);
                if(bool == true){
                    return;
                }
                bool = true;
                component.set("v.homePage", !bool);
                component.set("v.campPage", bool);
                component.set("v.accountPage", !bool);
                component.set("v.classesPage", !bool);
                component.set("v.careerPage", !bool);
                
                break;
            case "Swim League":
                bool = component.get("v.leaguePage");
                console.log(clicked+": "+bool);
                if(bool == true){
                    return;
                }
                bool = true;
                component.set("v.homePage", !bool);
                component.set("v.campPage", !bool);
                component.set("v.accountPage", bool);
                component.set("v.classesPage", !bool);
                component.set("v.careerPage", !bool);
                break;
            case "Classes":
                bool = component.get("v.classesPage");
                console.log(clicked+": "+bool);
                if(bool == true){
                    return;
                }
                bool = true;
                component.set("v.homePage", !bool);
                component.set("v.campPage", !bool);
                component.set("v.accountPage", !bool);
                component.set("v.classesPage", bool);
                component.set("v.careerPage", !bool);
                break;
            case "Careers":
                bool = component.get("v.careerPage");
                console.log(clicked+": "+bool);
                if(bool == true){
                    return;
                }
                bool = true;
                component.set("v.homePage", !bool);
                component.set("v.campPage", !bool);
                component.set("v.accountPage", !bool);
                component.set("v.classesPage", !bool);
                component.set("v.careerPage", bool);
                break;
            case "Account":
                bool = component.get("v.accountPage");
                console.log(clicked+": "+bool);
                if(bool == true){
                    return;
                }
                bool = true;
                component.set("v.homePage", !bool);
                component.set("v.campPage", !bool);
                component.set("v.accountPage", bool);
                component.set("v.classesPage", !bool);
                component.set("v.careerPage", !bool);
                break;
        }
        
    }

})