public class ClassRosterTriggerHandler {
	
    //Adds a charge to the account associated with a list of students
    public static void AutoAddCharge(List<Class_Roster__c> newStudents) {
        List<Charge__c> chargesToAdd = new List<Charge__c>();
        Map<Class_Roster__c, Contact> contactMap = GetStudentToContactMap(newStudents);
        Map<Class_Roster__c, Account> accountMap = GetStudentToAccountMap(newStudents, contactMap);
        Map<Class_Roster__c, Class__c> classMap = GetStudentToClassMap(newStudents);
        
        for (Class_Roster__c student : newStudents) {
            Integer classCharge = GetClassCharge(classMap.get(student));
            String chargeName = GenerateChargeName(classMap.get(student), contactMap.get(student));
            Charge__c linkedCharge = CreateLinkedCharge(accountMap.get(student), classCharge, chargeName);
            chargesToAdd.add(linkedCharge);
        }
        
        Insert chargesToAdd;
    }
    
    //Given a class, will reformat the price string into an integer
    @testVisible
    private static Integer GetClassCharge(Class__c studentClass) {
        if (studentClass == null) return 0;
        
        Integer charge = Integer.valueOf(studentClass.Class_Price__c.substring(1));
        return charge;
    }
    
    //Given a class and contact, will generate a charge name in the form of Swim Lessons - {class type} (first name)'
    @testVisible
    private static String GenerateChargeName(Class__c swimClass, Contact contact) { 
        if (swimClass == null || contact == null) return 'Error charge.';
        return 'Swim Lessons - ' + swimClass.Class_Type__c + ' (' + contact.FirstName + ')';
    }
    
    //Given an account, charge amount and charge name, will create a new charge and link it to the account
    @testVisible
    private static Charge__c CreateLinkedCharge(Account acc, Integer amount, String chargeName) {
        if (acc == null || amount <= 0) return null;
        
        Charge__c newCharge = new Charge__c();
        newCharge.Amount__c = amount;
        newCharge.name = chargeName;
        
        //Link charge to account
        newCharge.Account__c = acc.Id;
        
        return newCharge;
    }
    
    //Maps students on a roster to their respective class
    @testVisible
    private static Map<Class_Roster__c, Class__c> GetStudentToClassMap(List<Class_Roster__c> students) { 
        if (students == null) return null;
        
        //Retrieve all possible class Id's
        Set<Id> classSet = new Set<Id>();
        for (Class_Roster__c student : students) {
            classSet.add(student.Class__c);
        }
        List<Class__c> possibleClasses = [SELECT Class_Price__c, Class_Type__c FROM Class__c WHERE id IN :classSet];
        
        //Map students to classes
        Map<Class_Roster__c, Class__c> classMap = new Map<Class_Roster__c, Class__c>();
        for (Class_Roster__c student : students) {
            for (Class__c aClass : possibleClasses) {
                if (student.Class__c == aClass.Id) {
                    classMap.put(student, aClass);
                    break;
                }
            }
        }
        return classMap;
    }
    
    //Maps students on a roster to their contact object information
    @testVisible
    private static Map<Class_Roster__c, Contact> GetStudentToContactMap(List<Class_Roster__c> students) {
        if (students == null) return null;
        
        //Retrieve all possible contact Id's
        Set<Id> contactSet = new Set<Id>();
        for (Class_Roster__c student : students) {
            contactSet.add(student.Contact__c);
        }
        List<Contact> possibleContacts = [SELECT accountId, firstname FROM Contact WHERE id IN :contactSet];
        
        //Map students to contacts
        Map<Class_Roster__c, Contact> contactMap = new Map<Class_Roster__c, Contact>();
        for (Class_Roster__c student : students) {
            for (Contact contact : possibleContacts) {
                if (student.Contact__c == contact.Id) {
                    contactMap.put(student, contact);
                    break;
                }
            }
        }
        
        return contactMap;
    }
    
    //Maps students on a roster to their associated account
    @testVisible
    private static Map<Class_Roster__c, Account> GetStudentToAccountMap(List<Class_Roster__c> students, Map<Class_Roster__c, Contact> contactMap) {
        if (students == null) return null;
        
        //Retrieve all possible account Id's
        Set<Id> accountSet = new Set<Id>();
        for (Contact contact : contactMap.values()) {
            accountSet.add(contact.AccountId);
        }
        List<Account> possibleAccounts = [SELECT id FROM Account WHERE id IN :accountSet];
        
        //Map students to accounts
        Map<Class_Roster__c, Account> accountMap = new Map<Class_Roster__c, Account>();
        for (Class_Roster__c student : students) {
            for (Account account : possibleAccounts) {
                if (contactMap.get(student).accountId == account.Id) {
                    accountMap.put(student, account);
                    break;
                }
            }
        }
        return accountMap;
    }
}