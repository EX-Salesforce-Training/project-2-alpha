public with sharing class ClassRegistrationTriggerHandler {
    public ClassRegistrationTriggerHandler() {

    }
    public static void HandleAfterInsert(List<Class_Registration__c> registrations) {
        //go through new registration 
        List<OrderItem> orderItems = new List<OrderItem>();
        orderItems = [SELECT OrderId, Product2Id, TotalPrice FROM OrderItem];
        List<Order> orders = [SELECT Id, Name, AccountId FROM Order];

        for (Integer i = 0; i < registrations.size(); i++) {
            //if an order exists 
            Class_Registration__c currRegistration = registrations.get(i);
            Id accId = currRegistration.Account__c;
            Id classId = currRegistration.Class__c;
            Id productId = GetProductId(classId);
            Class__c curr_class = [SELECT Id, class_price__c FROM Class__c WHERE Id=:classId];
            string stringPrice = curr_class.Class_Price__c;
            stringPrice = stringPrice.replace('$', '');
            Decimal price = Decimal.valueOf(stringPrice);

            Id priceBookId = GetPriceBook2Id(); 
            Id priceBookEntrId = GetPriceBookEntryId(priceBookId, productId);
            if (orders.size() > 0) {
                boolean found = false;
                boolean nvrFound = true;
                 for(integer x = 0; x < orders.size(); x++) {
                    if(orders.get(x).AccountId == accId && !found){
                        System.debug('PRINTING ACCOUNTiD ' + orders.get(x).AccountId);
                        System.debug('CHECKING ACCid ' + accId);
                       OrderItem classProduct = new OrderItem();
                        classProduct.Product2Id = productId;
                        classProduct.OrderId = orders.get(x).Id;
                        classProduct.UnitPrice = price;
                        classProduct.Quantity = 1.0;
                        //need pricebook id 
                        classProduct.PricebookEntryId = priceBookEntrId;
                        insert classProduct;
                        found = true;
                        nvrFound = false;
                    }
                 }
                 if (nvrFound) {
                     
                        System.debug('inside not found CHECKING ACCid ' + accId);
                     System.debug('inside nvrFound');
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
                 }
            }else {
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
            }
            
        }
        
    }
    public static Id GetPriceBookEntryId(Id priceBookId, Id productId) {
        PriceBookEntry entry = [SELECT Id, Pricebook2Id, Product2Id FROM PriceBookEntry WHERE Pricebook2Id=:priceBookId AND Product2Id=:productId];
        return entry.Id;
    }
    public static Id GetPriceBook2Id() {
        PriceBook2 priceBook = [SELECT id, isActive, isStandard FROM pricebook2 WHERE isActive=true];
        return priceBook.Id;
    }
    public static Id GetProductId(Id classId) {
        Class__c product = [SELECT Product__c, Id FROM Class__c WHERE Id=:classId];
        return product.Product__c;
    }
}