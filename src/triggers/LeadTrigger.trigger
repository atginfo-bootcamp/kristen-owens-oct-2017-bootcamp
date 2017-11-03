trigger LeadTrigger on Lead (before insert, before update, before delete, 
	after insert, after update, after delete, after undelete) {

	// Trigger.isInsert is a boolean value - a variable

	System.debug('Trigger.isInsert: ' + Trigger.isInsert);
	System.debug('Trigger.isUpdate: ' + Trigger.isUpdate);
	System.debug('Trigger.isDelete: ' + Trigger.isDelete);
	System.debug('Trigger.isUndelete: ' + Trigger.isUndelete);

	System.debug('Trigger.isBefore: ' + Trigger.isBefore);
	System.debug('Trigger.isAfter: ' + Trigger.isAfter);

	List<Lead> leads = Trigger.new; // is a new List<sObject> i.e. for this trigger it is a List<Lead>
	Map<Id, Lead> leadsMap = Trigger.newMap; // is a new Map<Id, sObject> i.e. a Map<Id, Lead>
	// RECALL: Records have NO ID before insert! Trigger.new will not have IDs, Trigger.newMap will be NULL

	List<Lead> oldLeads = Trigger.old; // is a List<sObject> with the values from before the trigger ran
	Map<Id, Lead> oldLeadsMap = Trigger.oldMap; // is a Map<Id, sObject> with the values from before the trigger ran
	// On insert will be NULL. On update will always be populated. On undelete ?

	System.debug('Trigger.new: ' + Trigger.new);
	System.debug('Trigger.newMap: ' + Trigger.newMap);
	System.debug('Trigger.old: ' + Trigger.old);
	System.debug('Trigger.oldMap: ' + Trigger.oldMap);

	// Most common way to choose what code you call and when
	if(Trigger.isBefore && Trigger.isInsert) {
		// Call code to do stuff before insert
		// Call helper methods, saved in helper classes. This is the most common way to interact with triggers.
		
		// Change first lead title to King.
		// NO DML needed in Before context (will error).
		// Performs this change between record creation in SF UI and insertion into DB
		leads[0].Title = 'King';

		// Remember - can't query record in this context because it doesn't exist yet in DB
	}

	else if(Trigger.isAfter && Trigger.isUpdate) {
		// Call code to do stuff after update
		// Call helper methods, saved in helper classes. This is the most common way to interact with triggers.
	
		// In the After context, the record is "immutable" or not editable
		// leads[0].Title = 'King'; will fail!
		// to edit in the After context create a new instance, then push with DML

	}

}