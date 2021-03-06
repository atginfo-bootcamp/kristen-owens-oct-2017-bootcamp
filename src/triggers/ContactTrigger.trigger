// When contact is created, updated, or deleted, update field on Account
// After context is generally most common - it's already in the database.

trigger ContactTrigger on Contact (after insert, after update, after delete) {

	if(Trigger.isAfter && Trigger.isInsert) {
		ContactTriggerHelper.handleAfterInsert(Trigger.new);
	}

	else if(Trigger.isAfter && Trigger.isUpdate) {
		ContactTriggerHelper.handleAfterUpdate(Trigger.new, Trigger.oldMap);
	}
	/*
	else if(Trigger.isAfter && Trigger.isDelete) {
		ContactTriggerHelper.handleAfterDelete(Trigger.old);
	}
	*/
}