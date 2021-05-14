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
        allClassAvailable = [SELECT Id, Name, Capacity__c, Class_Price__c, Class_Time__c, Class_Type__c, Day__c, Class_Instructor__C,
                                    InstructorEmail__C, InstructorName__C, InstructorPhone__C, Level__c, Start_Date__c
                                FROM Class__c LIMIT 20
                            ];
        return allClassAvailable;
    }
    /*
    @AuraEnabled(cacheable=true)
    public static list<Class__c> GetFilteredClasses(String level, String price, String instructor, String day){
        //Using Dynamic SOQL 
        List<Class__c> filteredClasses = new List<Class__c>();
        String querySelectClasses = 'SELECT Id, Capacity__c, Name, Capacity__c, Class_Image__c, Class_Instructor__c, Class_Price__c,';
        queryClasses = queryClasses + 'Class_Type__C, Day__c, Class_Time__c, InstructorEmail__c, InstructorName__c,';
        queryClasses = queryClasses + 'Level__c, Start_Date__c FROM Class__c';
        String queryWhereClause = ' WHERE Class_Instructor__c != NULL';
        
        if(String.isNotBlank(level) && location != 'Any') {
            if(level == 'Beginner') {
                String intro = 'Intro to Splash';
                String rippple101 = 'Ripple 101';
                String rippple201 = 'Ripple 201
                String wave101 = 'Wave 101';
                String wave201 = 'Wave 201';
                String surf101 = 'Surf 201';
                queryWhereClause = QueryWhereClause + ' AND (Level__C = :intro OR 
                                                             Level__C = :rippple101 OR
                                                             Level__c = :rippple201 OR 
                                                             Level__C = :wave101 OR 
                                                             Level__c = :wave201 OR
                                                             Level__c = :surf101
                                                             )';
            }else if (level == 'Intermediate'){
                String rippple301 = 'Ripple 301';
                String rippple401 = 'Ripple 401
                String wave301 = 'Wave 301';
                String wave401 = 'Wave 401';
                String surf301 = 'Surf 301';
                String surf401 = 'Surf 401';
                queryWhereClause = QueryWhereClause + ' AND (Level__C = :rippple301 OR
                                                             Level__c = :rippple401 OR 
                                                             Level__C = :wave301 OR 
                                                             Level__c = :wave401 OR
                                                             Level__c = :surf401 OR
                                                             Level__c = :surf301
                                                             )';
            }else {
                String rippple501 = 'Ripple 501
                String wave501 = 'Wave 501';
                String surf501 = 'Surf 501';
                queryWhereClause = QueryWhereClause + ' AND (Level__C = :rippple501 OR
                                                             Level__C = :wave501 OR 
                                                             Level__c = :surf501 OR
                                                             )';

            }
        }
         if(String.isNotBlank(price) && price != 'Any') {
            queryWhereClause = QueryWhereClause + ' AND Class_Price__c = :price';
        }
         if(String.isNotBlank(instructor) && instructor != 'Any') {
            queryWhereClause = QueryWhereClause + ' AND Class_Instructor__c = :instructor';
        }
         if(String.isNotBlank(day) && day != 'Any') {
            queryWhereClause = QueryWhereClause + ' AND Day__c = :day';
        }
        queryClasses = queryClasses + QueryWhereClause;
        filteredClasses = Database.query(queryClasses);
        return filteredClasses;
                               
    }
    */
}