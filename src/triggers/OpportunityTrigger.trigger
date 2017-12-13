trigger OpportunityTrigger on Opportunity (after insert, after update) {

	if(trigger.isInsert && trigger.isAfter) {
		OpportunityTriggerHelper.handleAfterInsert(trigger.New);
	}

	if(trigger.isUpdate && trigger.isAfter) {
		OpportunityTriggerHelper.handleAfterUpdate(trigger.New);		
	}

}