public with sharing class Employee {
	
	private static Integer nextEmployeeIdNumber = 1;

	private final Integer EMPLOYEEID;
	private String title;
	private String firstName;
	private String lastName;
	private Date hireDate;
	private String status;
	private Datetime statusDate;

	public Employee(String title, String firstName, String lastName) {
		// Implement this!
		this.hireDate = Date.today();
		this.status = 'Active';
		this.statusDate = Datetime.now();

		this.EMPLOYEEID = nextEmployeeIdNumber;
		nextEmployeeIdNumber = nextEmployeeIdNumber	+ 1;

		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;

	}

	public Integer getEmployeeId() {
		return EMPLOYEEID;
	}

	public void printEmployeeInfo() {
		
		String name = firstName + ' ' + lastName;

		System.debug('This employee\'s name is ' + name + '.');
		System.debug(name + ' is an ' + title + '.');
		System.debug(name + ' was hired on ' + hireDate);
		System.debug(name + ' is an ' + status + ' employee as of ' + statusDate);
		System.debug(name + '\'s Employee ID is ' + EMPLOYEEID + '.');
	}
}