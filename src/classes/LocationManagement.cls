public with sharing class LocationManagement {
	
	/*
	Advanced method - come back to
	public static void createLocationWithEmployees(Integer numLocations, Integer numEmployeesEach) {

		List<Business__c> locations = new List<Business__c>();
		List<Employee__c> employees = new List<Employee__c>();

	}*/

	/*Just for creating data
	public static void createLocationWithEmployees() {
		//Business__c newLocation = createLocation('Missoula', '216 W Main Street\nMissoula, MT, 59801', '(406)205-4899');
		//insert newLocation;

		//List<Employee__c> employees = new List<Employee__c>();

		//employees.add(createEmployee(newLocation, 'Kristen', 'Owens', 'Other', 'Active'));
		//employees.add(createEmployee(newLocation, 'Leslie', 'Knope', 'Mistress', 'Active'));
		//insert employees;

		Business__c newLocation = createLocation('St. Louis', '123 S Main Street\nSt. Louis, MO 59801', '(406)205-4899');
		insert newLocation;

		List<Employee__c> employees = new List<Employee__c>();

		employees.add(createEmployee(newLocation, 'James', 'Owens', 'Other', 'Active'));
		insert employees;

	}*/

	public static void queryAndLogData() {
		Business__c locationWithEmployees = getLocationWithEmployees('a001I000003FZiE');
		List<Employee__c> employeesById = getEmployeesByLocationId('a001I000003FZiE');
		List<Employee__c>  employeesByName = getEmployeesByLocationName('Missoula');

		System.debug('employeesById: ' + employeesById);
		System.debug('employeesByName: ' + employeesByName);
		System.debug('locationWithEmployees: ' + locationWithEmployees);
		System.debug('locationWithEmployees - subquery: ' + locationWithEmployees.Employees__r);
	}

	public static Business__c createLocation(String locationName, String address, String phoneNumber ) {
		return createLocation('Advanced Technology Group', locationName, address, phoneNumber);
	}

	public static Business__c createLocation(String businessName, String locationName, String address, String phoneNumber ) {
		
		Business__c location = new Business__c();

		location.Business_Name__c = businessName;
		location.Name = locationName;
		location.Address__c = address;
		location.Phone_Number__c = phoneNumber;

		return location;

	}

	public static Employee__c createEmployee(Business__c location, String firstName, String lastName, String title, String status) {
		
		Employee__c employee = new Employee__c();

		employee.Business_Location__c = location.Id;
		employee.First_Name__c = firstName;
		employee.Last_Name__c = lastName;
		employee.Title__c = title;
		employee.Status__c = status;

		employee.Hire_Date__c = Date.today();
		employee.Status_Date__c = Datetime.now();

		return employee;

	}

	public static Business__c getLocationWithEmployees(Id locationId) {

		Business__c locationsWithEmployees = [
			SELECT Business_Name__c, Name, Address__c, Phone_Number__c, 
				(SELECT Business_Location__c, 
					First_Name__c, 
					Last_Name__c, 
					Title__c, 
					Status__c, 
					Hire_Date__c, 
					Status_Date__c
				FROM Employees__r)
			FROM Business__c
			WHERE Id = :locationId
		];

		return locationsWithEmployees;

	}

	public static List<Employee__c> getEmployeesByLocationId(Id locationId) {

		List<Employee__c> employees = [
			SELECT Business_Location__c, 
					First_Name__c, 
					Last_Name__c, 
					Title__c, 
					Status__c, 
					Hire_Date__c, 
					Status_Date__c
			FROM Employee__c
			WHERE Business_Location__c = :locationId
		];

		return employees;

	}

	public static List<Employee__c> getEmployeesByLocationName(String locationName) {

		List<Employee__c> employees = [
			SELECT Business_Location__c, 
					First_Name__c, 
					Last_Name__c, 
					Title__c, 
					Status__c, 
					Hire_Date__c, 
					Status_Date__c
			FROM Employee__c
			WHERE Business_Location__r.Name = :locationName
		];

		return employees;

	}

	/* DRY, Dammit!
	public static Employee__c transferEmployeeLocation(String employeeId, Id targetLocationId) {

		Employee__c employee = [SELECT Business_Location__c, 
					First_Name__c, 
					Last_Name__c, 
					Title__c, 
					Status__c, 
					Hire_Date__c, 
					Status_Date__c
			FROM Employee__c
			WHERE Name = :employeeId
		];

		employee.Business_Location__c = targetLocationId;

		update employee;
		return employee;

	}*/

	public static List<Employee__c> getEmployeeByEmployeeId(String employeeId) {

		List<Employee__c> employees = [
			SELECT Business_Location__c, 
					First_Name__c, 
					Last_Name__c, 
					Title__c, 
					Status__c, 
					Hire_Date__c, 
					Status_Date__c
			FROM Employee__c
			WHERE Name = :employeeId
		];

		return employees;

	}

	public static Employee__c transferEmployeeLocation(String employeeId, Id targetLocationId) {

		if(!getEmployeeByEmployeeId(employeeId).isEmpty()) {
			Employee__c employee = getEmployeeByEmployeeId(employeeId)[0];
			employee.Business_Location__c = targetLocationId;

			update employee;
			return employee;
		}

		return null;
	}

	public static void updateStatusDateOnStatusChange(List<Employee__c> employees, Map<Id, Employee__c> oldEmployeeMap) {

		for(Employee__c employee : employees) {
			Employee__c oldEmployee = oldEmployeeMap.get(employee.Id);
			
			if(employee.Status__c != oldEmployee.Status__c) {
				employee.Status_Date__c = Datetime.now();
			}
			
		}

	}

}