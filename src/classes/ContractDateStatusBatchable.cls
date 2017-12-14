// Database.executeBatch(new InstanceOfClassImplementingBatchableInterface(), Integer batchSize);

global class ContractDateStatusBatchable implements Database.Batchable<sObject>, Schedulable {
	
	String query;
	
	global ContractDateStatusBatchable() {
		query = 'SELECT Id, StartDate, EndDate, Date_Status__c FROM Contract';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		System.debug('ContractDateStatusBatchable has started');
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Contract> contracts) {
		
		List<Contract> contractsToUpdate = new List<Contract>();
		System.debug('Execution has begun');
		for(Contract ct : contracts) {

			if( Date.today() < ct.StartDate ) {
				if( ct.Date_Status__c != 'Upcoming') {
					ct.Date_Status__c = 'Upcoming';
					contractsToUpdate.add(ct);
					System.debug('Updating contract ' + ct.Id + ' to Date Status \'Upcoming\'');
				}
			}

			if( ct.StartDate <= Date.today() && Date.today() <= ct.EndDate ) {
				if( ct.Date_Status__c != 'Active') {
					ct.Date_Status__c = 'Active';
					contractsToUpdate.add(ct);
					System.debug('Updating contract ' + ct.Id + ' to Date Status \'Active\'');
				}
			}

			if( ct.EndDate < Date.today() ) {
				if( ct.Date_Status__c != 'Expired') {
					ct.Date_Status__c = 'Expired';
					contractsToUpdate.add(ct);
					System.debug('Updating contract ' + ct.Id + ' to Date Status \'Expired\'');
				}
			}

		}

		if(contractsToUpdate.size() > 0) {
			update contractsToUpdate;
			System.debug('Updating contracts: ' + contractsToUpdate);
		}
		System.debug('Execution has finished');
	}
	
	global void finish(Database.BatchableContext BC) {
		System.debug('ContractDateStatusBatchable is finished processing all batches.');
	}

	global void execute(SchedulableContext sc) {
		System.debug('Executing scheduled ContractDateStatusBatchable');
		database.executebatch(new ContractDateStatusBatchable());
	}
	
}