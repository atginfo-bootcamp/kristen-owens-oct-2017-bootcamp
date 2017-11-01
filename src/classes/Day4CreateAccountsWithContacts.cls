public with sharing class Day4CreateAccountsWithContacts {

	public static void createAccountsAndContacts(Integer numberAccts) {

		// Create Accounts with Contacts associated to them
		// Create Accounts first, then Contacts

		// Loop 'numberAccts' number of times to create 'numberAccts' Accounts
		List<Account> allAccts = new List<Account>();
		List<Contact> allCts = new List<Contact>();

		for(Integer i = 0; i < numberAccts; i++) {

			System.debug('Creating Account #' + (i + 1));
			Account acct = createAccount( i + 1 );
			allAccts.add(acct);
			// allAccts.add(createAccounts( i + 1 )); IS IDENTICAL TO LINE ABOVE

		}

		// Insert Accounts in bulk (initially not, to experience limits)
		insert allAccts;

		// Create 2 Contacts for each Account
		for(Account acct : allAccts) {
			allCts.add(createContact(acct.Id, 1));
			allCts.add(createContact(acct.Id, 2));
		}
		// Insert Contacts in bulk		
		insert allCts;

 		// Query Accounts and subquery Contacts

		// Loop through Accounts and Contacts

		// Print Account Name and all Contacts for each Account

	}

	public static Account createAccount(Integer acctNameSuffix) {

		// Account name must be 'myAccount-'#
		Account newAcct = new Account(Name = 'My Account-' + acctNameSuffix);
		System.debug('Account: ' + newAcct);

		return newAcct;

	}

	public static Contact createContact(Id acctId, Integer ctNumber) {

		Contact newCt = new Contact(
			FirstName = 'First: ' + ctNumber,
			LastName = 'Last: ' + ctNumber,
			AccountId = acctId
		);
		System.debug('Contact: ' + newCt);
		return newCt;

	}

	public static void queryAndPrintAccountsWithContacts() {

		List<Account> queriedAccts = [
			SELECT Name, Id, 
				(SELECT FirstName, LastName, Name, Id
				FROM Contacts)
			FROM Account
			WHERE Name LIKE 'My Account-%'
		];

		for(Account acct : queriedAccts) {
			System.debug('acct: ' + acct.Name);
			// list of Contacts = acct.RELATIONSHIPNAME
			for(Contact ct : acct.Contacts) {
				System.debug('ct: ' + ct.Name);
			}

		}

	}

}