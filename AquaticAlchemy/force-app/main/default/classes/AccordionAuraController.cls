///////////////////////////////////////////////////////////////
//
// Name: AccordionAuraController.cls
// Author: David Serrano, Salesforce Developer
// Created: 05/13/21
// Updated: 05/14/21
// Description: Apex Aura controller to return lists of necessary data, such as Knowledge Articles, Public Events, and Camp Day Schedules.
//
/////////////////////////////////////////////////////////////// 

public class AccordionAuraController {
    
    @AuraEnabled
    public static List<Knowledge__kav> getArticles(){
        List<Knowledge__kav> articles = [SELECT Question__c, Answer__c FROM Knowledge__kav WHERE RecordTypeId='0125e000000YMw1AAG' LIMIT 10 ];

        return articles;
    }
    
    @AuraEnabled
    public static List<Public_event__c> getCampSchedules(){
        List<Public_event__c> campEvent = [SELECT Id,
                                           Name,
                                           Camp_Size__c,
                                           Age_Group__c,
                                           Swim_Level__c,
                                           StartDateTime__c,
                                           EndDateTime__c,
                                           Description__c,
                                           StartDateString__c,
                                           EndDateString__c
                                           FROM Public_event__c WHERE Summer_Camp__c=true LIMIT 3 ];
        

        for(Public_event__c e:campEvent){
            if(e.StartDateTime__c != NULL  && e.EndDateTime__c != NULL){
                e.StartDateString__c = e.StartDateTime__c.format('MMM dd, yyyy');
                e.EndDateString__c = e.EndDateTime__c.format('MMM dd, yyyy');
            }
        }
    
        
        return campEvent;
    }
    
    @AuraEnabled
    public static List<Camp_Day__c> getDaySchedules(Id campId){
        List<Camp_Day__c> daySchedules = [SELECT Name,
                                          Start_Time__c,
                                          End_Time__c, 
                                          Start_Time_String__c,
                                          End_Time_String__c,
                                          Activities__c
                                          FROM Camp_Day__c WHERE Public_Event__c=:campId ORDER BY Start_Time__c ASC LIMIT 5] ;
        
        for(Camp_Day__c d:daySchedules){
            if(d.Start_Time__c != NULL  && d.End_Time__c != NULL){
                d.Start_Time_String__c = d.Start_Time__c.format('hh:mm a');
                d.End_Time_String__c = d.End_Time__c.format('hh:mm a');
            }
        }

        return daySchedules;
    }
    
    
}