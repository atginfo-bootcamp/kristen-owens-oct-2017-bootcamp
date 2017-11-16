public with sharing class Business {
	
	private static String businessName = 'ATG';
	private String locationName;
	private String address;
	private String phoneNumber;
	private List<Employee> employees;

	public Business(String locationName,
						String address,
						String phoneNumber) {

		this.locationName = locationName;
		this.address = address;
		this.phoneNumber = phoneNumber;

		this.employees = new List<Employee>();
	}

	public void addEmployees(Employee employee) {
		// add a list of employees to a Business
		// by calling other addEmployees method - DRY!
		addEmployees(new List<Employee>{employee});
	}

	public void addEmployees(List<Employee> employees) {
		// add a list of employees to a Business
		this.employees.addAll(employees);
	}

	public List<Employee> getEmployeesFromLocation(Business location) {
		return location.employees;
	}

	public Employee getEmployeeFromId(Integer employeeId) {
		// if an employee with this Id is not found, return null
		

		Employee employee;
		for(Employee currEmployee : employees) {
			if(employeeId == currEmployee.getEmployeeId()) {
				return currEmployee;
			}
		}
		return employee;
		
	}

	public void removeEmployeeFromLocation(Integer employeeId) {

	}

	public void printLocationInfo() {
		System.debug(businessName + ' is a business in ' + locationName);
		System.debug('It has ' + employees.size() + ' employees.');
		System.debug('It is located at ' +  address + ' and its phone number is ' + phoneNumber);
		System.debug('This is a list of its employees: ' + employees);
	}

	public static Boolean transferEmployee(Business fromLoc, Business toLoc, Integer employeeId) {
		// work on this last - bonus
		return false;
	}

}