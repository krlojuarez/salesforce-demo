@isTest
private class CaseSubjectTriggerHandlerTest {
    @isTest
    static void setsSubjectToDemoValueOnInsert() {
        Case c = new Case(
            Origin = 'Phone',
            Status = 'New',
            Subject = 'Original Subject'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case insertedCase = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals('Demo of copilot', insertedCase.Subject);
    }
}
