// #To invoke: Day3ListsAndLoops.executeMe();

public with sharing class Day3ListsAndLoops {

	public static void executeMe() {

			String myName = 'Kristen';
			
			//Create new empty list called names
			//THIS IS THE PREFERRED WAY TO INITIALIZE
			List<String> names = new List<String>();

			//Create new list with default values
			List<String> students = new List<String>{'student1', 'student2'};
			//Alternate syntax for creating a new array (list) WITH 20 EMPTY SPACES
			String[] employees = new String[20];

			names.add('The Hound');
			names.add('Cersei');
			names.add('Geoffrey');
			names.add('Ilyn Payne');
			names.add('The Red Woman');

			System.debug('names: ' + names);

			names.remove(3); //Remove item at index 3 (Ilyn Payne)

			System.debug('names again, after Ilyn Payne removed: ' + names);

			names.size(); // 3
			// names.remove(names.size()); will receive runtime error. 0 indexed language
			names.remove(names.size() - 1); // will remove last item in list

			System.debug('names once more, after removing names.size() - 1: ' + names);

			//Sets are similar to lists, with no repeated values
			Set<String> uniqueNames = new Set<String>();

			uniqueNames.add('Kristen');
			uniqueNames.add('Kristen');
			uniqueNames.add('Kristen');
			uniqueNames.add('Kristen');
			uniqueNames.add('Kristen');

			System.debug('uniqueNames: ' + uniqueNames);

			Integer uniqueNamesSize = uniqueNames.size();

			System.debug('uniqueNamesSize: ' + uniqueNamesSize);
			System.debug('uniqueNames size: ' + uniqueNames.size());


	}

	// To invoke, call Day3ListsAndLoops.executeLoops();
	public static void executeLoops() {
		// Apex for loops take 3 arguments: index variable, conditon, counter variable

		// Basic for loops
		for(Integer i = 0; i < 10; i++) {
			System.debug('i: ' + i);
		}

		List<String> names = new List<String>();
		names.add('Kristen1');
		names.add('Kristen2');
		names.add('Kristen3');

		for(Integer i = 0; i < names.size(); i++ ) {
			System.debug('name number' + i + ': ' + names.get(i));
			System.debug('name number' + i + ': ' + names[i]);
		}

		// Advanced for loop
		for(String name : names) {
			System.debug('name: ' + name);
		}

	}

	// To invoke, call Day3ListsAndLoops.querySobjects();
	public static void createNewAccount() {

		Account acct = new Account();
		acct.Name = 'atg';

		System.debug('my Account before insert: ' + acct);
		insert acct;
		System.debug('my Account after insert: ' + acct);
		
		Account newAcct = new Account();
		newAcct.Name = 'atg in the twilight zone';
		newAcct.Type = 'Technology Partner';
		insert newAcct;

	}

	public static void updateExistingAccount() {

		List<Account> queriedAccounts = [
			SELECT Name, Type, Id 
			FROM Account 
			WHERE Name = 'Advanced Technology Group' 
			LIMIT 1
		];
		System.debug('queriedAccounts: ' + queriedAccounts);

		IF(queriedAccounts.size() > 0) {

			//Account acct = queriedAccounts[0];
			//acct.Name = 'Advanced Technology Group';
			//System.debug('new name? ' + acct);
			//update acct;
			//System.debug('new name after insert: ' + acct);

			queriedAccounts[0].Name = 'ATG';
		}

	}

	public static void updateAccountTypeOnEveryAccount() {
		// Query all accounts
		// Print accounts to console
		// Loop through accounts
		// Update Type to Other
		// Print accounts to console
		// Update accounts
		// Print accounts to console

		List<Account> allAccounts = [
			SELECT Name, Type, Id
			FROM Account
		];

		System.debug('All accounts: ' + allAccounts);
		for(Account acct : allAccounts) {
			acct.Type = 'Other';
		}

		System.debug('All accounts with new Type: ' + allAccounts);
		update allAccounts;

	}

}