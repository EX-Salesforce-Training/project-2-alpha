public class ChargesController {
    @AuraEnabled
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
    }
}