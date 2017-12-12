public with sharing class AnimalGod {
	
	public static void handlesAnimals() {

		Dog myDog = new Dog();
		Fish myFish = new Fish();

		doAnimalStuff(myDog, 'apples, yum');
		doAnimalStuff(myFish, 'bubbles');

	}

	private static void doAnimalStuff(Animal animal, String typeOfFood) {

		animal.speak();
		animal.eat( typeOfFood );

	}

}