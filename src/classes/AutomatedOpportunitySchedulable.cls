global class AutomatedOpportunitySchedulable implements Schedulable {
	global void execute(SchedulableContext sc) {
		
		Account account = [SELECT Id 
						FROM Account
						WHERE Name = 'Automated Opportunities'
						LIMIT 1];

		Opportunity opportunity = new Opportunity();
		opportunity.CloseDate = Date.today().addDays(1);
		opportunity.StageName = 'Qualification';
		opportunity.AccountId = account.Id;

		String name = (String)Datetime.now().format('dd/MM/yyyy -- HH:mm:ss');
		opportunity.Name = name;

		insert opportunity;
		System.debug('Opportunity name: ' + opportunity.Name);
		System.debug('Opportunity id: ' + opportunity.Id);

		// ***Seconds*** Minutes Hours Day_of_month Month Day_of_week Optional_year
		//String cronString = '0 22 3 * * * *';
		//System.schedule(String_jobname, cronString, Object_schedulable_class);

	}
}