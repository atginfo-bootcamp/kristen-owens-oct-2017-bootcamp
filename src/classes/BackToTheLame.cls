public with sharing class BackToTheLame {
	
	// F is for "Future" and for "Fire and Forget!"
	public static void execute() {

		System.debug('We are going back to the future!');

		goDoSomeWorkInTheFuture();

		System.debug('We are back from the future');

	}

	@Future
	// could also say: @Future(callOut=true), necessary if you make an http call out in the method
	public static void goDoSomeWorkInTheFuture() {

		System.debug('We are in the FUTURE!!');

	}

}