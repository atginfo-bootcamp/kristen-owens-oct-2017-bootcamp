public with sharing class AccountListControllerExt {

	private final Account account;
    public List<Product2> products { get; set; }
    public List<Account> accounts { get; set; }

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public AccountListControllerExt(ApexPages.StandardController stdController) {
        this.account = (Account)stdController.getRecord();
        String accountId = ApexPages.currentPage().getParameters().get('id');
        
        products = [
            SELECT Name, ProductCode, Family, Description
            FROM Product2
        ];

        accounts = [
            SELECT Name, Type, Industry, Phone
            FROM Account
        ];

    }

    

}