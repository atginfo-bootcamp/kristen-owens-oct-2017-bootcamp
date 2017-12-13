public with sharing class Fish implements Animal {
	public Fish() {
		
	}

	public void speak() {
		System.debug('The fish says bubblebubblebubble');
	}

	public void eat(String typeOfFood) {
		System.debug('The fish eats dirt?');
	}

	public void die() {
		System.debug('The fish does indeed die');
	}
}