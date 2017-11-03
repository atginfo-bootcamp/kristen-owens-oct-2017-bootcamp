public with sharing class ContactTriggerHelper {

	public static void handleAfterInsert(List<Contact> contacts){
		// If Contact has an assigned Account, update current_number_of_contacts__c on Account
		Map<Id, Account> accountMap = queryAccountsFromContacts(contacts);

		if(accountMap.size() > 0){

			List<Account> accounts = accountMap.values();
			updateAccountNumberOfContacts(accounts);

		}

	}

	public static void handleAfterUpdate(List<Contact> contacts, Map<Id, Contact> oldContactMap){
		// If assigned Account has changed, update current_number_of_contacts__c on both new and old Accounts
	
		/*
		Loop through contacts
		Check if accountId was changed:
			1. If oldMap = null and new != null, update new account
			2. If oldMap != null and new = null, update old account
			3. If oldMap != null and new != null && != oldMap, update both accounts
		*/
		Set<Id> accountIds = new Set<Id>();

		for(Contact contact : contacts){
			Contact oldContact = oldContactMap.get(contact.Id);
			
			if(contact.AccountId != oldContact.AccountId){
				
				if(contact.AccountId != NULL){
					accountIds.add(contact.AccountId);
				}
				
				if(oldContact.AccountId != NULL){
					accountIds.add(oldContact.AccountId);
				}
			}
		}

		Map<Id, Account> accountMap = queryAccounts(accountIds);
		List<Account> accounts = accountMap.values();
		updateAccountNumberOfContacts(accounts);

	
	}

	public static void handleAfterDelete(List<Contact> contacts){
		// If Contact has an assigned Account, update current_number_of_contacts__c on Account
	
	}

	private static Map<Id, Account> queryAccountsFromContacts(List<Contact> contacts){
		Set<Id> accountIds = new Set<Id>();

		for (Contact contact : contacts){
			if(contact.accountId != NULL){
				accountIds.add(contact.accountId);
			}
		}

		return queryAccounts(accountIds);
		
	}

	private static Map<Id, Account> queryAccounts(Set<Id> accountIds){
		List<Account> accounts = new List<Account>();
		
		if(!accountIds.isEmpty()){
			accounts = [
				SELECT Id, Name, Current_Number_of_Contacts_c__c,
					(SELECT Id FROM Contacts)
				FROM Account
				WHERE Id IN :accountIds
			];
		}

		Map<Id, Account> accountMap = new Map<Id, Account>(accounts);

		return accountMap;
	}

	private static void updateAccountNumberOfContacts(List<Account> accounts){
	for(Account account : accounts){
				account.Current_Number_of_Contacts_c__c = account.Contacts.size();
			}

			// SUPER IMPORTANT AND COOL
			// If you save a field value two places - i.e. in accounts and accountMaps
			// Updating one will update the other.
			// So, before updating, and without changing it,
			// accountMap will also be up to date when we change values in accounts
			update accounts;
	}

}