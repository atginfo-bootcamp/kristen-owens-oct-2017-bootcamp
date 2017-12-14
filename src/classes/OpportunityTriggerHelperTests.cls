@isTest
private class OpportunityTriggerHelperTests {
	


	@isTest static void accountWithNoContactsInsert() {
		Account account = createAccount(true);

		Account accountBeforeInsert = [SELECT Id, (SELECT Id FROM Contacts) FROM Account LIMIT 1];
		System.assert(accountBeforeInsert.Contacts.size()== 0, accountBeforeInsert.Contacts.size());

		Opportunity oppClosedWonOnInsert = createOpportunity(account.Id, 'Closed Won', true);

		Account accountAfterInsert = [SELECT Id, (SELECT Id FROM Contacts), (SELECT Id FROM Contracts) FROM Account LIMIT 1];
		System.assert(accountAfterInsert.Contacts.size() == 1, accountAfterInsert.Contacts.size());
		System.assert(accountAfterInsert.Contacts[0].Name == '', accountAfterInsert.Contacts[0].Name);


	}

	@isTest static void accountWithNoContactsUpdate() {
		Account account = createAccount(true);

		Account accountBeforeUpdate = [SELECT Id, (SELECT Id FROM Contacts) FROM Account LIMIT 1];
		System.assert(accountBeforeUpdate.Contacts.size()== 0, accountBeforeUpdate.Contacts.size());

		Opportunity oppCloseWinOnUpdate = createOpportunity(account.Id, 'Prospecting', true);

		oppCloseWinOnUpdate.StageName = 'Closed Won';
		update oppCloseWinOnUpdate;

		Account accountAfterUpdate = [SELECT Id, (SELECT Id FROM Contacts), (SELECT Id FROM Contracts) FROM Account LIMIT 1];
		System.assert(accountAfterUpdate.Contacts.size() == 1, accountAfterUpdate.Contacts.size());
		System.assert(accountAfterUpdate.Contacts[0].Name == '', accountAfterUpdate.Contacts[0].Name);

	}

	@isTest static void accountWithContactsInsert() {
		Account account = createAccount(true);
		Contact contact = createContact(account.Id, true);

		Account accountBeforeInsert = [SELECT Id, (SELECT Id FROM Contacts) FROM Account LIMIT 1];
		System.assert(accountBeforeInsert.Contacts.size()== 1, accountBeforeInsert.Contacts.size());

		Opportunity oppClosedWonOnInsert = createOpportunity(account.Id, 'Closed Won', true);

		Account accountAfterInsert = [SELECT Id, (SELECT Id FROM Contacts), (SELECT Id FROM Contracts) FROM Account LIMIT 1];
		System.assert(accountAfterInsert.Contacts.size() == 1, accountAfterInsert.Contacts.size());
		System.assert(accountAfterInsert.Contacts[0].Name == '', accountAfterInsert.Contacts[0].Name);

	}

	@isTest static void accountWithContactsUpdate() {
		Account account = createAccount(true);
		Contact contact = createContact(account.Id, true);

		Account accountBeforeUpdate = [SELECT Id, (SELECT Id FROM Contacts) FROM Account LIMIT 1];
		System.assert(accountBeforeUpdate.Contacts.size()== 1, accountBeforeUpdate.Contacts.size());

		Opportunity oppCloseWinOnUpdate = createOpportunity(account.Id, 'Prospecting', true);

		oppCloseWinOnUpdate.StageName = 'Closed Won';
		update oppCloseWinOnUpdate;

		Account accountAfterUpdate = [SELECT Id, (SELECT Id FROM Contacts), (SELECT Id FROM Contracts) FROM Account LIMIT 1];
		System.assert(accountAfterUpdate.Contacts.size() == 1, accountAfterUpdate.Contacts.size());
		System.assert(accountAfterUpdate.Contacts[0].Name == '', accountAfterUpdate.Contacts[0].Name);

	}		
	
	@isTest static void test_method_two() {
		// Implement test code
	}

	static Account createAccount(Boolean doInsert) {
		Account account = new Account(Name = 'Test Acct');
		if(doInsert){insert account;}
		return account;
	}

	static Opportunity createOpportunity(Id accountId, String stageName, Boolean doInsert) {
		Opportunity opportunity = new Opportunity(Name = 'Test Opp', CloseDate = System.today(), StageName = stageName, AccountId = accountId);
		if(doInsert){insert opportunity;}
		return opportunity;
	}

	static Contact createContact(Id accountId, Boolean doInsert) {
		Contact contact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = accountId);
		if(doInsert){insert contact;}
		return contact;
	}
	
}