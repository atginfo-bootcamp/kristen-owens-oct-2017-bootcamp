public with sharing class Day5Maps {

	// Maps are the Apex equivalent of a dictionary
	// However, they are strongly typed - ONE type of data per key, value
	public static void example(String name) {

		// For review, this is the syntax of a list:
		List<String> namesList = new List<String>();
		namesList.add('Sid');
		namesList.add('Nancy');
		namesList.add('Bonnie');
		namesList.add('Clyde');
		
		Boolean foundName = false;
		for (String i : namesList) {
			if(i == name) {
				System.debug('Found name in namesList! Name: ' + name);
				foundName = true;
				break; // just like python
			}
		}
		if(!foundName) {
			System.debug('Name ' + name + ' not found in namesList :(');
		}

		// Map syntax:
		Map<String, String> namesMap = new Map<String, String>();
		namesMap.put('Sid', 'Sid Vicious');
		namesMap.put('Nancy', 'Nancy Whatever');
		namesMap.put('Bonnie', 'Bonnie Smith');
		namesMap.put('Clyde', 'Clyde Doe');

		if (namesMap.containsKey(name)) {
			System.debug('Found name in namesMap! Name: ' + name);
		} else {System.debug('Name ' + name + ' not found in namesMap :('); }

	}

	public static void associateContactsToAccounts() {
		
		/* These are some other ways:
		Map<Id, Account> acctMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);
		acctMap.putAll(acctList);
		*/

		List<Account> acctList = [
			SELECT Id, Name FROM Account];
		Map<Id, Account> acctMap = new Map<Id, Account>(acctList);

		List<Contact> ctList = [
			SELECT Id, FirstName, LastName, Name, AccountId FROM Contact
		];

		// loop through contacts
		// print contact name and acct name

		for (Contact ct : ctList) {
			if(acctMap.containsKey(ct.AccountId)) {
				System.debug('Contact ' + ct.Name + 
					' belongs to Account ' + acctMap.get(ct.AccountId).Name);
			}

		}

	}

}