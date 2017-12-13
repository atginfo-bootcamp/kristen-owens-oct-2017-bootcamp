trigger OpportunityTrigger on Opportunity (after insert, after update) {

	if(trigger.isInsert && trigger.isAfter) {
		OpportunityTriggerHelper.handleAfterInsert( Trigger.New);
	}

	if(trigger.isUpdate && trigger.isAfter) {
		OpportunityTriggerHelper.handleAfterUpdate( Trigger.New, Trigger.oldMap);		
	}

}