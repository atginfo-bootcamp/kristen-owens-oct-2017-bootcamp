trigger LeadTrigger on Lead (before insert, after update) {
	
	/*
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
	*/

	// This is the most common way to choose what code you call and when
	if(Trigger.isBefore && Trigger.isInsert) {
		LeadTriggerHelper.beforeInsert(Trigger.new);
	}

	else if(Trigger.isAfter && Trigger.isUpdate) {
		LeadTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap);
	}

}