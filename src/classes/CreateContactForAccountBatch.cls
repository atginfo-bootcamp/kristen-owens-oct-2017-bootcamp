// Database.executeBatch(new InstanceOfClassImplementingBatchableInterface(), Integer batchSize);

global class CreateContactForAccountBatch implements Database.Batchable<sObject> {
	
	String query;

	global CreateContactForAccountBatch() {
		query = 'SELECT Id, Name, Type FROM Account';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Account> accounts) {
		System.debug('Executing has begun');
		System.debug('Account names: ' + accounts);

		List<Contact> contacts = new List<Contact>();

		for(Account acct : accounts) {
			contacts.add(
				new Contact(FirstName = 'Lil', LastName = 'Kim', AccountId = acct.Id)
			);
			System.debug('Creating contact for account: ' + acct.Name + ', Id: ' + acct.Id);
		}

		insert contacts;
		System.debug('Execution is finished');

	}
	
	global void finish(Database.BatchableContext BC) {
		System.debug('Finished processing all batches.');
	}
	
}