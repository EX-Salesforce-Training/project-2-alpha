public class ChargesController {
    @AuraEnabled
<<<<<<< HEAD
    public static List<Charge__c> getCharges(String acctString){
        id acct = id.valueOf(acctString);
        Return [SELECT Account__c, Amount__c, Name, Notes__c FROM Charge__c WHERE Account__c =: acct];
=======
    public static void SubmitAction(List<Order> toBeUpdated){
        List<Order> finalList = [SELECT ID, Status, Name FROM Order WHERE id=: toBeUpdated];
        for(Order o : finalList){
            o.Status = 'Activated';
        }
        update finalList;
    }
    @AuraEnabled
    public static void updateCharges(List<ID> toBeRemoved){
        List<OrderItem> doomed = [SELECT Id FROM OrderItem WHERE id=: toBeRemoved ];
        delete doomed;
>>>>>>> a96e256ef6ce40ea37f40dcaf758bb5b485bb466
    }
}