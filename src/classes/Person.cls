public class Person {
	
	// Class level properties

	private String name;
	private String email;
	private String gender;
	private Double weight;
	private Integer age;
	private final Boolean IS_DEAD;

	// Static variables are shared across all instances of class
	private static Boolean isHuman = TRUE;

	// constructor method
	public Person(String defaultName) {
		
		name = defaultName;
		IS_DEAD = FALSE;

	}

	public Person(String name, String email) {
		/* alternate syntax if you want to have argument name = property name:
		"this" refers to the parent class. Can use any time, only necessary
		if you use the same argument name at the class level and method level */

		this.name = name;
		this.email = email;
		IS_DEAD = FALSE;

	}

	public Person(String name, String email, Boolean IS_DEAD) {
		
		this.name = name;
		this.email = email;
		this.IS_DEAD = IS_DEAD;

	}

	/* terminology

	Person fred = new Person('Fred');
	
	Person is a type
	fred is an instance of Person
	new is the keyword to initialize the instance
	Person() is the constructor method to create the instance
	'Fred' is an argument to Person() */
	
	// other methods

	public void print() {
		System.debug('Person name: ' + name);
		System.debug('Person email: ' + email);
		System.debug('Person gender: ' + gender);
		System.debug('Person weight: ' + weight);
		System.debug('Person age: ' + age);
		System.debug('Person isDead: ' + IS_DEAD);
		System.debug('Person isHuman: ' + isHuman);

	/* static methods
	static methods can be called on the class instead of the instance,
	i.e. a static print method would be: Person.print();
	our current print method is not static: fred.print(); */

	}

	/* best practice: use "getters" and "setters" to edit class properties,
	and keep the properties themselves private */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}


	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}


	public String getGender(){
		return gender;
	}
	public void setGender(String gender){
		this.gender = gender;
	}


	public Double getWeight(){
		return weight;
	}
	public void setWeight(Double weight){
		this.weight = weight;
	}


	public Integer getAge(){
		return age;
	}
	public void setAge(Integer age){
		this.age = age;
	}


	public Boolean getIsDead(){
		return IS_DEAD;
	}


	public Boolean getIsHuman(){
		return isHuman;
	}
	public void setIsHuman(Boolean isHumanValue){
		isHuman = isHumanValue;
	} 

}