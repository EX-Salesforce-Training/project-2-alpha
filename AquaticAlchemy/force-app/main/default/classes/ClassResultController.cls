/*    Name: ClassResultController 
 //    Author: Andreology
 //    Created: 05/08/2021
 //    Updated: 05/08/2021
 //    Description: server-side Controller class for ClassDetail Lightning Component which will be on Class Listing Page. 
*/
public with sharing class ClassResultController {
    public ClassResultController() {

    }
    @AuraEnabled(cacheable=true) 
    public static List<Class__c> GetAllClasses() {
        List<Class__c> allClassAvailable = new List<Class__c>();
        allClassAvailable = [SELECT Name, Class_Instructor__c, Capacity__c, Class_Price__c, Class_Time__c, Class_Type__c, Day__c, Instructor__C,
                                    InstructorEmail__C, InstructorName__C, InstructorPhone__C, Level__c, Start_Date__c
                                FROM Class__c LIMIT 20
                            ];
        return allClassAvailable;
        
    }
}