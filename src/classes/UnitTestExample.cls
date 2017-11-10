@isTest
private class UnitTestExample {
	
	@isTest static void test_method_one() {
		// Query for all Leads with Title King

		List<Lead> kingsList = [SELECT Name, Title FROM Lead WHERE Title = 'King'];
		// System.assert(kingsList != null, 'Sorry yo, your code don\'t work');

		String idealTitle = 'King';
		for(Lead king : kingsList) {
			System.assertEquals(king.Title, idealTitle, 'It\'s good to be king!');			
		}

		String unidealTitle = 'Queen';
		for(Lead king : kingsList) {
			System.assertNotEquals(king.Title, unidealTitle, 'It\'s bad to be queen!');			
		}

	}
	
	@isTest static void test_method_two() {
		// Implement test code
	}
	
}