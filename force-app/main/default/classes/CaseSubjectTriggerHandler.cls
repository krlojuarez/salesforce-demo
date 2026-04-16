public with sharing class CaseSubjectTriggerHandler {

    public static void beforeInsert(List<Case> newCases) {
        for (Case c : newCases) {
            c.Subject = appendStatus(c.Subject, c.Status);
        }
    }

    public static void beforeUpdate(List<Case> newCases, Map<Id, Case> oldMap) {
        for (Case c : newCases) {
            Case oldCase = oldMap.get(c.Id);
            String baseSubject = stripStatusSuffix(c.Subject, oldCase.Status);
            c.Subject = appendStatus(baseSubject, c.Status);
        }
    }

    private static String appendStatus(String subject, String status) {
        String suffix = ' - ' + status;
        if (String.isBlank(subject)) {
            return status;
        }
        if (!subject.endsWith(suffix)) {
            return subject + suffix;
        }
        return subject;
    }

    private static String stripStatusSuffix(String subject, String oldStatus) {
        if (String.isBlank(subject) || String.isBlank(oldStatus)) {
            return subject;
        }
        String suffix = ' - ' + oldStatus;
        if (subject.endsWith(suffix)) {
            return subject.removeEnd(suffix);
        }
        return subject;
    }
}
