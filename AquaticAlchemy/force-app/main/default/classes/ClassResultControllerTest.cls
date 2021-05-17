@isTest
public with sharing class ClassResultControllerTest {
    
    public ClassResultControllerTest() {

    }

    @isTest public static void GetAllClasses(){
        Class_Instructor__c testInstructor = GetNewClassInstructor();
        ClassResultController testingController = new ClassResultController();
        
        List<Class__c> classes = new List<Class__c>();
        test.startTest();
        insert testInstructor;
        
        for(Integer i = 0; i < 20; i++) 
          classes.add(GetNewClass(testInstructor.Id));
        
        
        insert classes;
        List<Class__c> checkClassesMade = new List<Class__c>();
        checkClassesMade = ClassResultController.GetAllClasses();
        test.stopTest();
        
        
        System.assertEquals(checkClassesMade.size(), 20);

    }

    public static Class_Instructor__c GetNewClassInstructor() {
        Class_Instructor__c tempInstructor = new Class_Instructor__c();
        tempInstructor.Name = 'Test ' + Math.Random() * 10;
        return tempInstructor;
    }

    public static Class__c GetNewClass(Id id) {
        Class__c tempClass = new Class__c();
        tempClass.Capacity__c = 3;
        tempClass.Class_Price__c = '$150';
        tempClass.Class_Time__c = Time.newInstance(0, 30, 0, 0);
        tempClass.Class_Type__c = 'Semi-Private';
        tempClass.Day__c = 'Monday';
        tempClass.Start_Date__c = System.today();
        tempClass.Class_Instructor__c = id;
        return tempClass;
    }

}