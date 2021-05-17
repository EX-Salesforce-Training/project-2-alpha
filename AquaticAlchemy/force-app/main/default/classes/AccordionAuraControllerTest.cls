///////////////////////////////////////////////////////////////
//
// Name: AccordionAuraControllerTest.cls
// Author: David Serrano, Salesforce Developer
// Created: 05/16/21
// Updated: 05/16/21
// Description: Apex test class to run unit tests against the Accordion Aura Controller class.
//
/////////////////////////////////////////////////////////////// 

@isTest
public class AccordionAuraControllerTest {

    @isTest
    public static void loadKnowledgeArticlesTest() {
        List<Knowledge__kav> kList = new List<Knowledge__kav>();
        for(Integer i = 0; i < 10; i++){
            Knowledge__kav j = new Knowledge__kav(Title='Article'+i, RecordTypeId='0125e000000YMw1AAG', urlName='Article'+i);
            kList.add(j);
        }
        insert kList;
        
        List<Knowledge__kav> generatedList = AccordionAuraController.getArticles();
        
        system.assertEquals(kList.size(), generatedList.size());  
    }

    @isTest
    public static void loadCampSchedulesTest() {
        List<Public_Event__c> campList = new List<Public_Event__c>();

        for(Integer i = 0; i < 5; i++){
            Public_Event__c e = new Public_Event__c(Name='Camp'+i, Summer_Camp__c=true, RecordTypeId='0125e000000YN3eAAG'); 
            campList.add(e);
        }
        insert campList;
        
        List<Public_Event__c> generatedList = AccordionAuraController.getCampSchedules();
        
        system.assertEquals(3, generatedList.size());
        
        // query for public events to get their IDs properly 
        List<Camp_Day__c> dayList = new List<Camp_Day__c>();
        for(Public_Event__c e:generatedList){
            for(Intger i = 0; i < 5; i++){
                Camp_Day__c c = new Cap_Day__c(Name='Day '+1, Public_Event__c=e.Id);
                dayList.add(c);
            }
        }
        insert dayList;
        // pass in id to getDay

    }

}