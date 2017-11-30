public with sharing class MyAccountController {
	
	//final must be given a value in definition or constructor only
	//value cannot be changed
	private final Account account;

	// on loading the VF page, this constructor will be invoked
	public MyAccountController() {
		// just to verify that this is called:
		System.debug('MyAccountController()');

		// you can access query parameters from the URL!
		// getParameters is a map of all the query parameters in the url
		// so just .get() the id!
		String accountId = ApexPages.currentPage().getParameters().get('id');

		// want to see?
		System.debug('getParameters map: ' + ApexPages.currentPage().getParameters());

		account = [SELECT Id, Name, Type FROM Account WHERE Id = :accountId];
	}

	public Account getAccount() {
		return account;
	}

	// PageReference is used when redirecting user. Refresh but don't change page
	public PageReference save() {
		update account;
		return null;
	}

}