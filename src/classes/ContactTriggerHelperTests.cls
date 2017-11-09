@isTest
private class ContactTriggerHelperTests {
	
	private static void stageData(Integer numAccounts, String accountName) {
		
		/*
		Create new accounts based on numAccounts parameter
		Set up Account fields (populate Name etc.)
		Insert Accounts to the database
		Query Accounts from DB
		Loop through and create Contacts for each Account (populate AccountId)
		Insert all Contacts to the database
		*/

		List<Account> accounts = new List<Account>();

		for( Integer i = 0; i < numAccounts; i++) {
			Account acct = new Account();
			acct.Name = accountName + ' ' + (i+1);
			// What other fields?
			accounts.add(acct);
		}

		if( accounts.size() > 0) {
			insert accounts;
		}

		List<Account> insertedAccounts = [
			SELECT Name // What other fields?
			FROM Account
			// WHERE what?
		];

		List<Contact> contacts = new List<Contact>();
		Integer i = 1;
		for(Account acct : accounts) {
			Contact ct = new Contact();
			ct.FirstName = 'Test';
			ct.LastName = 'Contact '+ i;
			ct.AccountId = acct.Id;
			// What other fields?
			contacts.add(ct);
			++i;
		}

	}

	@isTest static void contactTriggerTest() {


	}
	
}