trigger CaseSubjectTrigger on Case (before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        CaseSubjectTriggerHandler.beforeInsert(Trigger.new);
    } else if (Trigger.isBefore && Trigger.isUpdate) {
        CaseSubjectTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
}
