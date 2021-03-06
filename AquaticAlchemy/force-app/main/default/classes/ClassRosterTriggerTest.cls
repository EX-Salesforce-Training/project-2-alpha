@isTest
public class ClassRosterTriggerTest {
	
    @testSetup
    private static void TestSetupClass() {
        //Generate and insert accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 151; i++) {
            Account account = new Account();
            account.name = 'test account ' + (i + 1);
            accounts.add(account);
        }
        System.debug(accounts);
        Insert accounts;
        
        //Generate and insert contacts
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 151; i++) {
            Contact contact = new Contact();
            contact.firstname = 'name';
            contact.lastname = 'test ' + (i + 1);
            contact.AccountId = accounts.get(i).Id;
            contacts.add(contact);
        }
        Insert contacts;
        
        User u = [SELECT id FROM User WHERE lastname = 'Muller' LIMIT 1];
        //Generate and insert classes
        List<Class__c> classes = new List<Class__c>();
        for (Integer i = 0; i < 151; i++) {
            Class__c newClass = new Class__c();
            newClass.Start_Date__c = System.now();
            newClass.Class_Time__c = Time.newInstance(2, 16, 0, 0);
            newClass.Day__c = 'Monday';
            newClass.Capacity__c = 4;
            newClass.Class_Price__c = '$75';
            newClass.Class_Type__c = 'Group';
            newClass.Instructor__c = u.Id;
            classes.add(newClass);
        }
        Insert classes;
        
        //Generate and insert students
        List<Class_Roster__c> students = new List<Class_Roster__c>();
        for (Integer i = 0; i < 151; i++) {
            Class_Roster__c newStudent = new Class_Roster__c();
        	newStudent.Class__c = classes.get(i).Id;
        	newStudent.Contact__c = contacts.get(i).Id;
            students.add(newStudent);
        }
        Insert students;
    }
    
    @isTest
    private static void TP_GetStudentToClassMap() {
        Map<Class_Roster__c, Class__c> classMap = ClassRosterTriggerHandler.GetStudentToClassMap([SELECT Class__c FROM Class_Roster__c]);
        
        System.assert(classMap.size() == 151);
    }
    
    @isTest 
    private static void TN_GetStudentToClassMap() {
        Map<Class_Roster__c, Class__c> classMap = ClassRosterTriggerHandler.GetStudentToClassMap(null);
        
        System.assert(classMap == null);
    }
    
    @isTest
    private static void TP_GetStudentToAccountMap() {
        List<Class_Roster__c> students = [SELECT Contact__c FROM Class_Roster__c];
        Map<Class_Roster__c, Contact> contactMap = ClassRosterTriggerHandler.GetStudentToContactMap(students);
        Map<Class_Roster__c, Account> accountMap = ClassRosterTriggerHandler.GetStudentToAccountMap(students, contactMap);
        
        System.assert(accountMap.size() == 151);
    }
    
    @isTest
    private static void TN_GetStudentToAccountMap() {
        List<Class_Roster__c> students = [SELECT Contact__c FROM Class_Roster__c];
        Map<Class_Roster__c, Contact> contactMap = ClassRosterTriggerHandler.GetStudentToContactMap(students);
        Map<Class_Roster__c, Account> accountMap = ClassRosterTriggerHandler.GetStudentToAccountMap(null, contactMap);
        
        System.assert(accountMap == null);
    }
    
    @isTest
    private static void TP_GetClassCharge() {
        Integer charge = ClassRosterTriggerHandler.GetClassCharge([SELECT Class_Price__c FROM Class__c LIMIT 1]);
        
        System.assert(charge == 75);
    }
    
    @isTest
    private static void TP_GenerateChargeName() {
        Contact contact = [SELECT firstname FROM Contact LIMIT 1];
        Class__c aClass = [SELECT Class_Type__c FROM Class__c LIMIT 1];
        String chargeName = ClassRosterTriggerHandler.GenerateChargeName(aClass, contact);
        
        System.assertEquals('Swim Lessons - Group (name)', chargeName);
    }
    
    @isTest
    private static void TP_CreateLinkedCharge() {
        Account account = [SELECT id FROM Account LIMIT 1];
        Integer amount = 100;
        String chargeName = 'Sample';
        Charge__c newCharge = ClassRosterTriggerHandler.CreateLinkedCharge(account, amount, chargeName);
        
        System.assert(newCharge.Account__c == account.Id);
        System.assert(newCharge.Amount__c == amount);
        System.assert(newCharge.Name == chargeName);
    }
    
    @isTest
    private static void TP_AutoAddCharge() {
        Class__c newClass = [SELECT name FROM Class__c LIMIT 1];
        Contact contact = [SELECT name, accountId FROM Contact LIMIT 1];
        
        Class_Roster__c newStudent = new Class_Roster__c();
        newStudent.Class__c = newClass.Id;
        newStudent.Contact__c = contact.Id;
        
        Insert newStudent;
        
        Account acc = [SELECT name FROM Account WHERE id =: contact.accountId];
        Charge__c charge = [SELECT account__c FROM Charge__c WHERE account__c =: acc.Id LIMIT 1];
        
        System.assert(acc.id == charge.account__c);
    }
    
    @isTest
    private static void TB_AutoAddCharge() {
        List<Charge__c> existingCharges = [SELECT account__c FROM Charge__c];
        
        List<Class_Roster__c> students = new List<Class_Roster__c>();
        List<Class__c> classes = [SELECT id FROM Class__c];
        List<Contact> contacts = [SELECT id FROM Contact];
        for (Integer i = 0; i < 151; i++) {
            Class_Roster__c newStudent = new Class_Roster__c();
        	newStudent.Class__c = classes.get(i).Id;
        	newStudent.Contact__c = contacts.get(i).Id;
            students.add(newStudent);
        }
        
        Insert students;
        List<Charge__c> charges = [SELECT account__c FROM Charge__c];
        
        System.assertEquals(151, charges.size() - existingCharges.size());
        for (Charge__c charge : charges) {
            System.assert(charge.account__c != null);
        }
    }
}