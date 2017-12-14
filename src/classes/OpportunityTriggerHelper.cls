// Anders 
public with sharing class OpportunityTriggerHelper {

	// After Insert helper method
	public static void handleAfterInsert(List<Opportunity> newOpportunities){
		insertIsClosedWon(newOpportunities);
	}

	// After Update helper method
	public static void handleAfterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities){
		changedToClosedWon(newOpportunities, oldOpportunities);
	}

	//Method for finding Closed Won opptys and sending those opptys to the createContracts method
	public static void insertIsClosedWon(List<Opportunity> insertedOpportunities){
		System.debug('Inserted Opportunities ' + insertedOpportunities);

		List<Opportunity> oppsToCreateContracts = new List<Opportunity>();
		for(Opportunity opp : insertedOpportunities){
			if(opp.StageName == 'Closed Won'){
				oppsToCreateContracts.add(opp);
			}
		}

		if(oppsToCreateContracts.size() > 0){
			System.debug('Opps To Create Contracts - Insert ' + oppsToCreateContracts);
			createContracts(oppsToCreateContracts);
		}
	}

	public static void changedToClosedWon(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities){
		List<Opportunity> oppsToCreateContracts = new List<Opportunity>();

		System.debug('Changed To Closed Won - New Values ' + newOpportunities);
		System.debug('Changed To Closed Won - Old Values ' + oldOpportunities);

		for(Opportunity opp : newOpportunities){
			if(opp.StageName == 'Closed Won' && opp.StageName != oldOpportunities.get(opp.Id).StageName){
				oppsToCreateContracts.add(opp);
			}
		}

		if(oppsToCreateContracts.size() > 0){
			System.debug('Opps To Create Contracts - Update ' + oppsToCreateContracts);
			createContracts(oppsToCreateContracts);
		}
	}


	public static void createContracts(List<Opportunity> validOpportunities){

		List<Contract> contractsToInsert = new List<Contract>();

		for(Opportunity opp : validOpportunities){
			Contract contract = new Contract();

			contract.AccountId = opp.AccountId;
			contract.StartDate = System.today();
			contract.ContractTerm = 12;

			contractsToInsert.add(contract);
		}

		if(contractsToInsert.size() > 0){
			System.debug('Contracts To Insert ' + contractsToInsert);
			insert contractsToInsert;
			System.debug('Contracts After Insert '+ contractsToInsert);

			createContactRole(contractsToInsert);
		}
	}

	public static void createContactRole(List<Contract> contractList){

		System.debug('Contract List Initial ' + contractList);

		Set<Id> accountIdSet = new Set<Id>();
		for(Contract cont : contractList){
			accountIdSet.add(cont.AccountId);
		}

		List<Account> accountList = [SELECT Id, (SELECT Id, AccountId FROM Contacts) FROM Account WHERE Id IN :accountIdSet];

		System.debug('SOQL Query Results ' + accountList);

		Map<Id, Id> accountContactIdMap = new Map<Id, Id>();
		Set<Contact> newContactSet = new Set<Contact>();

		for(Account acct : accountList){
			if(acct.Contacts.size() > 0){
				accountContactIdMap.put(acct.Id, acct.Contacts[0].Id);
				System.debug('Account Added in spot 1');
			}else{
				Contact contact = new Contact();
				contact.FirstName = 'My Little';
				contact.LastName = 'Pony';
				contact.AccountId = acct.Id;

				newContactSet.add(contact);
			}
		}

		System.debug('New Contact Set ' + newContactSet);
		if(newContactSet.size() > 0){
			insert new List<Contact>(newContactSet);

			for(Contact cont : newContactSet){
				accountContactIdMap.put(cont.AccountId, cont.Id);
				System.debug('Account added in spot 2');
			}
		}

		List<ContractContactRole> contactRoleList = new List<ContractContactRole>();
		for(Contract contract : contractList){
			ContractContactRole contactRole = new ContractContactRole();

			System.debug('Contact ID ' + accountContactIdMap.get(contract.AccountId));

			contactRole.ContactId = accountContactIdMap.get(contract.AccountId);
			contactRole.ContractId = contract.Id;
			contactRole.Role = 'Other';
			contactRole.isPrimary = TRUE;


			contactRoleList.add(contactRole);
		}

		if(contactRoleList.size() > 0){
			insert contactRoleList;
		}


	}

}

/* My obsolete code
public with sharing class OpportunityTriggerHelper {

	public OpportunityTriggerHelper() {
		
	}

	public static void handleAfterInsert(List<Opportunity> opportunities) {
		List<Opportunity> closedWonOpps = new List<Opportunity>();
		for(Opportunity opportunity : opportunities) {
			if(opportunity.StageName == 'Closed Won') {
				closedWonOpps.add(opportunity);
			}
		}

		Map<Id,Contract> contractsWithOppIds = createContracts(closedWonOpps);
		// need to separate into new class:
		// create list of contracts from map - insert
		// update opp with contract id
		// return list of contracts to create roles
		// insert contracts;

		//List<ContractContactRole> roles = createContractContactRoles(closedWonOpps, contracts);
		//insert roles;

	}

	public static void handleAfterUpdate(List<Opportunity> opportunities, Map<Id, Opportunity> oldOpportunityMap) {
		List<Opportunity> closedWonOpps = new List<Opportunity>();
		for(Opportunity opportunity : opportunities) {
			if(opportunity.StageName == 'Closed Won') {
				closedWonOpps.add(opportunity);
			}
		}

		Map<Id,Contract> contractsWithOppIds = createContracts(closedWonOpps);
		//insert contracts;
		// see handleAfterInsert notes

		//List<ContractContactRole> roles = createContractContactRoles(closedWonOpps, contracts);
		//insert roles;
	}

	public static Map<Id, Contract> createContracts(List<Opportunity> opportunities) {
		
		Map<Id, Contract> contractsWithOppIds = new Map<Id, Contract>();
		
		for(Opportunity oppty : opportunities) {
			Contract contract = new Contract();
			contract.AccountId = oppty.AccountId;
			contract.StartDate = Date.Today();
			contract.ContractTerm = 12;
			contract.Status = 'Draft';
			contractsWithOppIds.put(oppty.Id, contract);

		}

		System.debug('Contracts inserted: ' + contractsWithOppIds);
		return contractsWithOppIds;

	}

	public static List<ContractContactRole> createContractContactRoles(List<Opportunity> opportunities, List<Contract> contracts) {
		List<Account> accounts = queryAccountsWithContactsFromOpportunities(opportunities);
		List<Contact> newContacts = new List<Contact>();
		List<Contact> existingContacts = new List<Contact>();
		List<ContractContactRole> contactRoles = new List<ContractContactRole>();

		for(Account acct : accounts) {
			if(acct.Contacts.size() >= 1) {
				Contact contact = acct.Contacts[0];
				existingContacts.add(contact);
			} else if(acct.Contacts.size() < 1) {
				Contact newContact = new Contact(FirstName='Joe', LastName='Schmo', AccountId = acct.Id);
				newContacts.add(newContact);
			}

		}

		if(newContacts.size() >= 1) {
			insert newContacts;
		}

		List<Contact> allContacts = new List<Contact>(existingContacts);
		allContacts.addAll(newContacts);

		for(Contract contract : contracts) {
			for(Contact contact : allContacts) {
				if(contract.AccountId == contact.AccountId) {
					ContractContactRole role = new ContractContactRole(ContactId = contact.Id, Role = 'Decision Maker', ContractId = contract.Id);
				}
			}
		}

		return contactRoles;

	}

	public static List<Account> queryAccountsWithContactsFromOpportunities(List<Opportunity> opportunities) {
		List<Id> acctIds = new List<Id>();

		for(Opportunity oppty : opportunities) {
			acctIds.add(oppty.AccountId);
		}

		List<Account> queriedAccounts = [
			SELECT Id, Name, 
				(SELECT Id FROM Contacts)
			FROM Account
			WHERE Id IN :acctIds
		];

		return queriedAccounts;
	}

	public static void setOpportunityLookup(List<Contract> contractIds) {
		// hmmmmm.....
	}

}*/