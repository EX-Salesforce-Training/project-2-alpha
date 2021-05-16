public with sharing class ClassRegistrationTriggerHandler {
    public ClassRegistrationTriggerHandler() {

    }
    public static void HandleAfterInsert(List<Class_Registration__c> registrations) {
        //go through new registration 
        List<OrderItem> orderItems = new List<OrderItem>();
        orderItems = [SELECT OrderId, Product2Id, TotalPrice FROM OrderItem];
        List<Order> orders = [SELECT Id, AccountId FROM Order];

        for (Integer i = 0; i < registrations.size(); i++) {
            //if an order exists 
            Class_Registration__c currRegistration = registrations.get(i);
            Id accId = currRegistration.Account__c;
            Id classId = currRegistration.Class__c;
            Id productId = GetProductId(classId);
            Class__c curr_class = [SELECT Id, class_price__c FROM Class__c WHERE Id=:classId];
            string stringPrice = curr_class.Class_Price__c;
            stringPrice = stringPrice.replace('$', '');
            System.debug('CHECKING $$$ '+ stringPrice);
            Decimal price = Decimal.valueOf(stringPrice);

            Id priceBookId = GetPriceBook2Id(); 
            System.debug('CEHCKING ' + priceBookId + ' ' + productId);
            Id priceBookEntrId = GetPriceBookEntryId(priceBookId, productId);
            system.debug('CHECKING PRICE BOOK ID ' + pricebookEntrId);
            if (orders.size() == 0) {
                System.debug('craeting new order and adding entry');
                    Order newOrder = new Order();
                    newOrder.AccountId =  accId;
                    newOrder.Status = 'Draft';
                    newOrder.EffectiveDate = System.today();
                    newOrder.Pricebook2Id = priceBookId;
                    insert newOrder;
                    OrderItem classProduct = new OrderItem();
                    //need product id 
                    classProduct.Product2Id = productId;
                    classProduct.OrderId = newOrder.Id;
                    classProduct.UnitPrice = price;
                    classProduct.Quantity = 1.0;
                    //need pricebook id 
                    classProduct.PricebookEntryId = priceBookEntrId;
                    insert classProduct;
            }else {
                for(integer x = 0; x < orders.size(); x++) {
                    if(orders.get(x).AccountId == accId){
                        //add to order
                        System.debug('inside if');
                    }
                }
            }
        }
        
    }
    public static Id GetPriceBookEntryId(Id priceBookId, Id productId) {
        PriceBookEntry entry = [SELECT Id, Pricebook2Id, Product2Id FROM PriceBookEntry WHERE Pricebook2Id=:priceBookId AND Product2Id=:productId];
        System.debug('CHECKING WHAT ENTRY HAS ' + entry.Id);
        return entry.Id;
    }
    public static Id GetPriceBook2Id() {
        PriceBook2 priceBook = [SELECT id, isActive, isStandard FROM pricebook2 WHERE isActive=true];
        return priceBook.Id;
    }
    public static Id GetProductId(Id classId) {
        Class__c product = [SELECT Product__c, Id FROM Class__c WHERE Id=:classId];
         System.debug('CHECKING WHAT Product ID HAS ' + product.Product__c);
         System.debug('CHECKING WHAT class ID ID HAS ' + product.Id);
        return product.Product__c;
    }
}