public with sharing class Employee {
	
	private static Integer nextEmployeeIdNumber = 1;

	private final Integer EMPLOYEE_ID;
	private String title;
	private String firstName;
	private String lastName; // {get; set {statusDate = Datetime.now}}
							// special way to allow getting and setting of private properties
	private Date hireDate;
	private String status;
	private Datetime statusDate;

	public Employee(String title, String firstName, String lastName) {
	
		this.hireDate = Date.today();
		this.status = 'Active';
		this.statusDate = Datetime.now();

		this.EMPLOYEE_ID = nextEmployeeIdNumber;
		nextEmployeeIdNumber = nextEmployeeIdNumber	+ 1;

		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;

	}

	public Integer getEmployeeId() {
		return EMPLOYEE_ID;
	}

	public String getStatus() {
		return status;
	}

	public Datetime getStatusDate() {
		return statusDate;
	}

	public void setStatus(String status) {
		this.status = status;
		this.statusDate = Datetime.now();
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void printEmployeeInfo() {
		
		String name = firstName + ' ' + lastName;

		System.debug('This employee\'s name is ' + name + '.');
		System.debug(name + ' is an ' + title + '.');
		System.debug(name + ' was hired on ' + hireDate);
		System.debug(name + ' is an ' + status + ' employee as of ' + statusDate);
		System.debug(name + '\'s Employee ID is ' + EMPLOYEE_ID + '.');
	}

}