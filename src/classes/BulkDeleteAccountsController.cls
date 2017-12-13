public with sharing class BulkDeleteAccountsController {
	
	public List<AccountWrapper> accountWrappers { get; set; }
	public Boolean selectAll { get; set; }
	public String prefix { get; set; }
	public Integer numAccts { get; set; }

	public BulkDeleteAccountsController() {
		// Query Accounts
		initializeAccountWrappers();
		this.selectAll = false;
	}

	// method to query account
	public void initializeAccountWrappers() {
		List<Account> accounts = [
			SELECT Id, Name, Type
			FROM Account
			ORDER BY CreatedDate DESC
		];
		
		accountWrappers = new List<AccountWrapper>();
		for(Account account : accounts) {
			accountWrappers.add(new AccountWrapper(account));
		}

	}

	/* REFACTORED into toggleSelectAll
	public Boolean getSelectAll() {
		return selectAll;
	}

	public void setSelectAll(Boolean selectAll) {
		this.selectAll = selectAll;
		for(AccountWrapper wrapper : accountWrappers) {
			wrapper.isChecked = selectAll;
		}
	}*/

	public PageReference toggleSelectAll() {
		for(AccountWrapper wrapper : accountWrappers) {
			wrapper.isChecked = selectAll;
		}
		return null;
	}

	public PageReference deleteSelectedAccounts() {
		List<Account> accountsToDelete = new List<Account>();
		for (AccountWrapper wrapper : accountWrappers) {
			if (wrapper.isChecked) {
				accountsToDelete.add(wrapper.account);
			}
		}

		try {
			delete accountsToDelete;
		}
		catch (Exception ex) {
			ApexPages.addMessages(ex);
			System.debug(ex);
		}

		initializeAccountWrappers();
		return null;
	}

	public PageReference createAccounts() {

		if(prefix.length() < 1) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Account must have a Prefix!'));
			return null;
		}
		
		prefix += ' ';
		List<Account> accounts = new List<Account>();
		if(numAccts < 1) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Number of accounts created must be positive!'));
			return null;
		}

		try {

			for(Integer i = 0 ; i < numAccts ; i++) {
				Account acct = new Account(Name=prefix+(i+1));
				accounts.add(acct);
			}

			insert accounts;

		}
		catch (Exception ex) {
			ApexPages.addMessages(ex);
			return null;
		}

		initializeAccountWrappers();

		prefix = null;
		numAccts = null;
		return null;

	}

	// An Inner Class!
	public class AccountWrapper {
		
		public Boolean isChecked { get; set;}
		public Account account { get; set; }

		public AccountWrapper(Account account) {

			this.isChecked = false;
			this.account = account;

		}

	}

}