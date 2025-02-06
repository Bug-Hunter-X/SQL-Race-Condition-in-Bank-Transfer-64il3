The following SQL query is prone to a race condition:

```sql
BEGIN TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1 AND balance >= 100;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT TRANSACTION;
```

This code attempts to transfer 100 from account 1 to account 2.  However, if another transaction modifies `account1`'s balance between the `SELECT` and the `UPDATE`, the transfer might fail or lead to an incorrect balance.

For example:

1. Transaction 1 starts.
2. Transaction 2 deducts 50 from `account1`.
3. Transaction 1 checks `account1`'s balance (which is now 50).
4. Transaction 1 proceeds with the update, which fails because the condition (`balance >= 100`) is no longer met.
5. Transaction 1 rolls back.

The problem is that the `WHERE` clause only checks the balance *once*, at the start of the transaction. It does not reflect any changes made by concurrent transactions. This is a subtle concurrency issue that is not immediately obvious.