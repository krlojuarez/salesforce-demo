@IsTest
private class AccountHelperTest {

    @TestSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
    }

    @IsTest
    static void testGetAccounts() {
        List<Account> results = AccountHelper.getAccounts(10);
        System.assertEquals(5, results.size(), 'Expected 5 accounts');
    }

    @IsTest
    static void testCreateAccount() {
        Account newAcc = AccountHelper.createAccount('Demo Account');
        System.assertNotEquals(null, newAcc.Id, 'Account should have been inserted');
        System.assertEquals('Demo Account', newAcc.Name, 'Account name should match');
    }
}
