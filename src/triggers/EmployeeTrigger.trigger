trigger EmployeeTrigger on Employee__c (before update) {

	if(Trigger.isBefore && Trigger.isUpdate) {
		LocationManagement.updateStatusDateOnStatusChange(Trigger.new, Trigger.oldMap);
	}

}