@isTest
private class CaseTriggerTest {

    @isTest
    static void insertAppendsSingleStatus() {
        Case c = new Case(Origin = 'Phone', Status = 'New', Subject = 'Review Process');

        Test.startTest();
        insert c;
        Test.stopTest();

        Case result = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals(
            'Review Process - New',
            result.Subject,
            'Subject should have status appended on insert'
        );
    }

    @isTest
    static void insertWithNullSubjectSetsStatusOnly() {
        Case c = new Case(Origin = 'Email', Status = 'New', Subject = 'Default');

        Test.startTest();
        insert c;
        Test.stopTest();

        Case result = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assert(
            result.Subject.endsWith(' - New'),
            'Subject should end with status when inserted'
        );
    }

    @isTest
    static void bulkInsertAppendsStatusToAll() {
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 200; i++) {
            cases.add(new Case(Origin = 'Web', Status = 'New', Subject = 'Subject ' + i));
        }

        Test.startTest();
        insert cases;
        Test.stopTest();

        List<Case> results = [SELECT Subject FROM Case WHERE Id IN :cases];
        System.assertEquals(200, results.size(), 'All 200 cases should be inserted');
        for (Case c : results) {
            System.assert(c.Subject.endsWith(' - New'), 'Each case subject should end with status');
        }
    }

    @isTest
    static void updateReplacesStatusSuffixOnStatusChange() {
        Case c = new Case(Origin = 'Phone', Status = 'New', Subject = 'Review Process');
        insert c;
        c = [SELECT Id, Subject, Status FROM Case WHERE Id = :c.Id];

        c.Status = 'Working';

        Test.startTest();
        update c;
        Test.stopTest();

        Case result = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals(
            'Review Process - Working',
            result.Subject,
            'Subject should replace old status suffix with new status on update'
        );
    }

    @isTest
    static void updateSubjectAndStatusAppendsNewStatus() {
        Case c = new Case(Origin = 'Phone', Status = 'New', Subject = 'Initial Topic');
        insert c;
        c = [SELECT Id, Subject, Status FROM Case WHERE Id = :c.Id];

        c.Subject = 'Updated Topic';
        c.Status = 'Escalated';

        Test.startTest();
        update c;
        Test.stopTest();

        Case result = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals(
            'Updated Topic - Escalated',
            result.Subject,
            'Changed subject should have new status appended on update'
        );
    }

    @isTest
    static void handlerBeforeInsertAppendsStatusDirectly() {
        List<Case> cases = new List<Case>{
            new Case(Origin = 'Phone', Status = 'New', Subject = 'Review Process')
        };

        Test.startTest();
        CaseSubjectTriggerHandler.beforeInsert(cases);
        Test.stopTest();

        System.assertEquals(
            'Review Process - New',
            cases[0].Subject,
            'Handler should append status to subject on insert'
        );
    }

    @isTest
    static void handlerBeforeInsertHandlesBulkRecords() {
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 200; i++) {
            cases.add(new Case(Origin = 'Web', Status = 'New', Subject = 'Subject ' + i));
        }

        Test.startTest();
        CaseSubjectTriggerHandler.beforeInsert(cases);
        Test.stopTest();

        for (Integer i = 0; i < cases.size(); i++) {
            System.assert(
                cases[i].Subject.endsWith(' - New'),
                'Handler should append status for record at index ' + i
            );
        }
    }
}
