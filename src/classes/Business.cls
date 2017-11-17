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
		
		for(Employee currEmployee : employees) {
			if(employeeId == currEmployee.getEmployeeId()) {
				return currEmployee;
			}
		}
		return null;
		
	}

	public Boolean removeEmployeeFromLocation(Integer employeeId) {

		for(Integer i = 0; i < employees.size(); ++i) {
			if(employeeId == employees.get(i).getEmployeeId()) {
				employees.remove(i);
				return true;
			}
		}
		return false;

	}

	public void printLocationInfo() {
		System.debug(businessName + ' is a business in ' + locationName);
		System.debug('It has ' + employees.size() + ' employees.');
		System.debug('It is located at ' +  address + ' and its phone number is ' + phoneNumber);
		System.debug('These are all of its employees:'); 
		if(employees.size() > 0) {	
			for(Employee employee : employees) {
				employee.printEmployeeInfo();
			}
		} else {System.debug('NO EMPLOYEES FOUND');}
	}

	public static Boolean transferEmployee(Integer employeeId, Business fromLoc, Business toLoc) {
		
		Employee employee = fromLoc.getEmployeeFromId(employeeId);
		if(employee != null) {
			fromLoc.removeEmployeeFromLocation(employeeId);
			toLoc.addEmployees(employee);
			employee.setStatus('TRANSFERED');
			return true;
		}
		return false;

	}

}