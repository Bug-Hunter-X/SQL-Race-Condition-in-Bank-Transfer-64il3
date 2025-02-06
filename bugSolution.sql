To solve the race condition, use row-level locking within a transaction.  This ensures that only one transaction can modify a particular row at a time:

```sql
BEGIN TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1 AND balance >= 100;
-- Check if the update was successful
IF @@ROWCOUNT = 1 THEN
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    COMMIT TRANSACTION;
ELSE
    ROLLBACK TRANSACTION;
END IF;
```

This version uses `@@ROWCOUNT` to verify that the first update was successful before committing. If the first `UPDATE` fails (because the balance is insufficient), the transaction rolls back, ensuring that the balance remains consistent.  Using row-level locks implicitly handled by the transaction ensures that the balance is not unexpectedly modified between the check and the update.