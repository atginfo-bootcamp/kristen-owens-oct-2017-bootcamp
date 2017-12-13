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

	public static void handleAfterUpdate(List<Opportunity> opportunities) {
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
				Contact contact = acct.Contacts[1];
				existingContacts.add(contact);
			} else if(acct.Contacts.size() < 1) {
				Contact newContact = new Contact(FirstName='Joe', LastName='Schmo');
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

}