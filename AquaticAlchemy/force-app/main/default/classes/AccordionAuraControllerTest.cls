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
            Public_Event__c e = new Public_Event__c(Name='Camp'+i, Summer_Camp__c=true, RecordTypeId='0125e000000YN3eAAG', StartDateTime__c=Datetime.now(), EndDateTime__c=Datetime.now()); 
            campList.add(e);
        }
        insert campList;
        
        List<Public_Event__c> generatedList = AccordionAuraController.getCampSchedules();
        
        // checking the getCampSchedules only returns three summer camp events as it has a limit on how many to return
        system.assertEquals(3, generatedList.size());
        
        // query public events for a list of camp events to obtain the id
        campList = [SELECT Id FROM Public_Event__c WHERE Summer_Camp__c=true];
        List<Camp_Day__c> dayList = new List<Camp_Day__c>();
        Map<Id,Integer> dayAmounts = new Map<Id,Integer>();

        // generate day schedules for each given camp
        for(Public_Event__c e:generatedList){
            // generating random number between 1-5 to create a varied amount of day schedules for each camp
            Integer randomNumber = Integer.valueof((Math.random() * 4))+1;
            dayAmounts.put(e.Id, randomNumber);
            for(Integer i = 0; i < randomNumber; i++){
                Camp_Day__c c = new Camp_Day__c(Name='Day '+1, Public_Event__c=e.Id, Start_Time__c=Datetime.now(), End_Time__c=Datetime.now());
                dayList.add(c);
            }

        }
        insert dayList;

        // check that for each camp, the appropriate amount of day schedules are returned
        for(Public_Event__c e:generatedList){
            Integer days = dayAmounts.get(e.Id);
            List<Camp_Day__c> generatedDayList = AccordionAuraController.getDaySchedules(e.Id);
            system.assertEquals(days, generatedDayList.size());
        }

    }

}