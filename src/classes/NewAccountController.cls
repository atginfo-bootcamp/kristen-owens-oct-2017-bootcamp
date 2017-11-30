public with sharing class NewAccountController {
	
	public Account account { get; private set; }

	public NewAccountController() {
		String accountId = ApexPages.currentPage().getParameters().get('id');
		// remember ternary statements?
		account = accountId == null 
				? new Account() 
				: [SELECT Id, Name, Type, Phone, Industry
					FROM Account
					WHERE Id = :accountId];
	}

	public PageReference save() {

		// if you don't handle your exceptions, it's called "puking" haha
		try {
			upsert account;
			// if you want to specify an external id, do:
			// upsert account someExternalId;
		} catch(Exception ex) {
			ApexPages.addMessages(ex);
			return null;
		}
		// then you can add a "finally" block that will execute no matter what

		// after save, redirect to record page
		PageReference redirectSuccess = new ApexPages.StandardController(account).view();
		return redirectSuccess;
	}

}