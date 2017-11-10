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

		String fuzzyAcctName = accountName + '%';
		List<Account> insertedAccounts = [
			SELECT Name // What other fields?
			FROM Account
			WHERE Name LIKE :fuzzyAcctName
		];

		List<Contact> contacts = new List<Contact>();
		for(Account acct : insertedAccounts) {
			Integer numberOfContacts = (Integer)(Math.random()*4);
			for(Integer i = 0; i < numberOfContacts; i++) {
				Contact ct = new Contact();
				ct.LastName = 'Test Boid ' + i;
				ct.AccountId = acct.Id;
				contacts.add(ct);
			}
		}

		insert contacts;

	}

	@isTest static void afterInsertTriggerTest() {

		stageData(10, 'Seth');
		List<Account> accountsWithContacts = [
			SELECT Name, Current_Number_of_Contacts_c__c,
				(SELECT LastName, AccountId FROM Contacts)
			FROM Account
		];

		System.assertEquals(10, accountsWithContacts.size(), 'You did not create 10 accounts!');
		for(Account acct : accountsWithContacts) {
			System.assertEquals(acct.Contacts.size(), acct.Current_Number_of_Contacts_c__c, 'Current Number of Contacts is incorrect!');
		}
	}
	
}