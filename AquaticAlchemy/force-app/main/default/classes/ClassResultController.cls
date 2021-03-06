/*    Name: ClassResultController 
 //    Author: Andreology
 //    Created: 05/08/2021
 //    Updated: 05/17/2021
 //    Description: server-side Controller class for ClassDetail Lightning Component which will be on Class Listing Page. 
*/
public with sharing class ClassResultController {
    public ClassResultController() {

    }
    //method to retrieve all current classes with instructors and that are in draft status  inside DB
    @AuraEnabled(cacheable=true) 
    public static List<Class__c> GetAllClasses() {
        List<Class__c> allClassAvailable = new List<Class__c>();
        allClassAvailable = [SELECT Id, product_nombre__c, instr_nombre__c ,Name, Capacity__c, Class_Price__c, Class_Time__c, Class_Type__c, Day__c, Class_Instructor__C,
                                    InstructorEmail__C, InstructorName__C, InstructorPhone__C, Level__c, Start_Date__c, Product__c
                                FROM Class__c WHERE Class_Instructor__c != NULL AND isSummerCamp__c=false LIMIT 20
                            ];
        return allClassAvailable;
    }
    //method to get current account id 
    @AuraEnabled(cacheable=true)
    public static String GetAccountId() {
         Id userId = UserInfo.getUserId();
        Account userAcct = [SELECT Id, OwnerId FROM Account WHERE OwnerId=:userId LIMIT 1];
        return '' + userAcct.Id;
    }
    //method to retrieve filtered list of classes based on user input
    @AuraEnabled(cacheable=true)
    public static list<Class__c> GetFilteredClasses(String level, String price, String instructor, String day){
         //Using Dynamic SOQL 
        List<Class__c> filteredClasses = new List<Class__c>();
        String querySelectClasses = 'SELECT Id, isSummerCamp__c, product_nombre__c, instr_nombre__c, Capacity__c, Name, Class_Image__c, Class_Instructor__c, Class_Price__c,';
        querySelectClasses = querySelectClasses + 'Class_Type__C, Day__c, Class_Time__c, InstructorEmail__c, InstructorName__c,';
        querySelectClasses = querySelectClasses + 'Level__c, Start_Date__c FROM Class__c';
        String queryWhereClause =  ' WHERE Class_Instructor__c != NULL AND isSummerCamp__c=false';
        //check if input was provided
        if(String.isNotBlank(level) && level != 'Any') {
            if(level == 'Beginner') {
                String intro = 'Intro to Splash';
                String rippple101 = 'Ripple 101';
                String rippple201 = 'Ripple 201';
                String wave101 = 'Wave 101';
                String wave201 = 'Wave 201';
                String surf101 = 'Surf 201';
                queryWhereClause = QueryWhereClause + ' AND (Level__C = :intro OR  Level__C = :rippple101 OR Level__c = :rippple201 OR Level__C = :wave101 OR Level__c = :wave201 OR Level__c = :surf101)';
            }else if (level == 'Intermediate'){
                String rippple301 = 'Ripple 301';
                String rippple401 = 'Ripple 401';
                String wave301 = 'Wave 301';
                String wave401 = 'Wave 401';
                String surf301 = 'Surf 301';
                String surf401 = 'Surf 401';
                queryWhereClause = QueryWhereClause + ' AND (Level__C = :rippple301 OR Level__c = :rippple401 OR Level__C = :wave301 OR Level__c = :wave401 OR Level__c = :surf401 OR Level__c = :surf301 )';
            }else if (level == 'Advanced') {
                String rippple501 = 'Ripple 501';
                String wave501 = 'Wave 501';
                String surf501 = 'Surf 501';
                queryWhereClause = QueryWhereClause + ' AND (Level__C = :rippple501 OR Level__C = :wave501 OR Level__c = :surf501)';

            }
        }
         if(String.isNotBlank(price) && price != 'Any') {
            queryWhereClause = QueryWhereClause + ' AND Class_Price__c = :price';
        }
         if(String.isNotBlank(instructor) && instructor != 'Any') {
             System.debug('checking instruct name '+ instructor);
             Class_Instructor__c instr = [SELECT Id FROM Class_Instructor__c WHERE Name=:instructor];
             Id profId = instr.Id;
            queryWhereClause = QueryWhereClause + ' AND Class_Instructor__c = :profId';
        }
         if(String.isNotBlank(day) && day != 'Any') {
            queryWhereClause = QueryWhereClause + ' AND Day__c = :day';
        }
        //dynamic soql to query based on filter criteria
        querySelectClasses = querySelectClasses + QueryWhereClause;
        filteredClasses = Database.query(querySelectClasses);
        return filteredClasses;
                               
    }
    
}