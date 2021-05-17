public class ChargesController {
    @AuraEnabled
    public static List<Charge__c> getCharges(String acctString){
        id acct = id.valueOf(acctString);
        Return [SELECT Account__c, Amount__c, Name, Notes__c FROM Charge__c WHERE Account__c =: acct];
    }
}