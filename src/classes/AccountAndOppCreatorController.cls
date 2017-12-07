public with sharing class AccountAndOppCreatorController {
	
	public Account account { get; set; }
	public Contact contact { get; set; }
	public Opportunity opportunity { get; set; }
	public Boolean rendered { get; set; }
	public Account createdAccount { get; set; }
	public Contact createdContact { get; set; }
	public Opportunity createdOpportunity { get; set; }

	public AccountAndOppCreatorController() {
		
		initializeData();
		rendered = false;

	}

	public void initializeData(){
		
		this.account = new Account();
		this.contact = new Contact();
		this.opportunity = new Opportunity();

		opportunity.StageName = 'Needs Analysis';
		opportunity.CloseDate = Date.Today().addDays(30);

	}

	public PageReference createData() {
		try {
			
			if ( account.AccountNumber == null || account.Type == null ) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'You are missing a required field on Account!'));
				return null;
			} else if ( opportunity.Type == null ) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'You are missing a required field on Opportunity!'));
				return null;
			} else if ( contact.FirstName == null ) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'You are missing a required field on Contact!'));
				return null;
			} else {
				insert account;

				contact.AccountId = account.Id;
				opportunity.AccountId = account.Id;
				if( opportunity.Name == null ) {
					opportunity.Name = account.Name;
				}

				insert contact;
				insert opportunity;

				createdAccount = account;
				createdContact = contact;
				createdOpportunity = opportunity;

				rendered = true;
				initializeData();

				ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, 'Your data has been created successfully!'));

			}

		}
		catch(Exception ex) {
			ApexPages.addMessages(ex);
			return null;
		}

		return null;
	}

}