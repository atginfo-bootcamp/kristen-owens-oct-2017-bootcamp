public with sharing class LeadTriggerHelper {
	
	public static void beforeInsert(List<Lead> leadsList) {

		// Call code to do stuff before insert
		// Call helper methods, saved in helper classes. This is the most common way to interact with triggers.
		
		// Change first lead title to King.
		// NO DML needed in Before context (will error).
		// Performs this change between record creation in SF UI and insertion into DB
		//leadsList[0].Title = 'King';

		// Remember - can't query record in this context because it doesn't exist yet in DB

		/*for(Lead lead : leadsList) {
			lead.Title = 'CEO';
		}*/

		hotLead(leadsList);

	}

	public static void afterUpdate(List<Lead> leadsList, Map<Id, Lead> oldLeadsMap) {

		// Call code to do stuff after update
		// Call helper methods, saved in helper classes. This is the most common way to interact with triggers.
	
		// In the After context, the record is "immutable" or not editable
		// leads[0].Title = 'King'; will fail!
		// to edit in the After context create a new instance, then push with DML

		//for(Lead lead : leadsList) {
		//	lead.Title = lead.Id;
		//}
		//update leadsList;

		hotLead(leadsList);

	}

	public static void hotLead(List<Lead> leadsList) {
		/*
		New method called hotLead in Lead trigger
		Query all Leads with Title from prior class (I used King).
		Add 5 more Leads to the list (not through existing King method so that they are not inserted yet)
		Make all Leads have a Rating of 'Hot'
		Upsert the entire list of leads
		**Verify**
		Remove 5 additional leads code
		Add in check to only update when needed
		*/

		// Query database for leads with title King
		// Create list named kingLeads
		List<Lead> kingLeads = [
			SELECT Title, Rating
			FROM Lead
			WHERE Title = 'King'
		];


		// Create 5 new leads with title King and rating Hot
		// Add them to list kingLeads
		/* DON'T DO THIS AH. RECURSIVE LOOP
		for(Integer i = 0; i < 5; i++) {
			Lead newLead = new Lead();
			newLead.LastName = 'Colyer' + i;
			newLead.Company = 'ATG';
			newLead.Title = 'King';
			newLead.Rating = 'Hot';

			kingLeads.add(newLead);
		}*/

		// Update rating on Trigger.new
		// Cannot perform DML on Trigger.new in Before context
		for(Lead currentLead : leadsList) {
			if(currentLead.Title == 'King') {
				//kingLeads.add(currentLead);
				currentLead.Rating = 'Hot';
			}
		}

		// Change rating of all kingLeads to Hot
		for(Lead currentLead : kingLeads) {
			if(currentLead.Rating != 'Hot') {
				currentLead.Rating = 'Hot';
			}
		}

		upsert kingLeads;

	}

}