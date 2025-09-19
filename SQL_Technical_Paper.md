# SQL 

## ACID

ACID stands for Atomicity, Consistency, Isolation, and Durability.
ACID mechanism ensures reliable transaction processing in database systems. These properties ensure data integrity despite system failures, concurrency, or errors.

* Atomicity
Atomicity ensures that a transaction is all-or-nothing. Either every operation executes successfully, or none are applied.
Ex: Money transfer: Debit and credit must both occur, or neither.

* Consistency
Consistency maintains database validity. Transactions transform data from one valid state to another, enforcing rules like constraints, triggers, and cascades.
Ex: Account balance cannot drop below zero if constraints disallow it.

* Isolation
Isolation ensures concurrent transactions execute as if they were serial. It prevents dirty reads, non-repeatable reads, and phantom reads through isolation levels (Read Uncommitted, Read Committed, Repeatable Read, Serializable).

* Durability
Durability guarantees that committed transactions persist even after crashes, using logs, checkpoints, or write-ahead logging.
Example: After a power outage, completed transfers remain recorded.

## CAP Theorem

CAP stands for Consistency, Availability, and Partition Tolerance.
It states that a system can follow only two of the three properties simultaneously.

* Consistency - Availability
* Consistency - Partition Tolerance
* Availability - Partition Tolerance

**Consistency**: Every read receives the most recent write or an error. All nodes reflect the same data at a given time.

Ex: In a banking system, all replicas must show the same account balance after a transaction.

**Availability**: Every request receives a non-error response, even if some nodes fail. The system remains operational.

Ex: An e-commerce site continues processing orders even if a replica is offline.

**Partition Tolerance**: The system continues functioning despite network partitions or communication failures.

Ex: Nodes in different data centers can still operate if a network link breaks.

## Joins
Joins are used to merge multiple tables to access data simultaneously from different tables.

Types of Joins:-
* Cross Join
* Inner Joins
* Outer Joins
* Natural Joins
* Self Joins

**Cross Joins**: Returns the Cartesian product of two tables every row of the first table with every row of the second.

It is also known as **cartesion joins**.

**Inner Joins**: Returns only data with matching values in both tables based on a join condition.

It is also known as **equi joins**.

To achieve inner joins relations between table is mandatory.

**Outer Joins**: Returns matched data plus unmatched data from one or both tables.

Types of outer joins:

* Left Outer Joins
* Right Outer Joins
* Full Outer Joins

**Left Outer Joins**: It is use to access all data from the left table, matched data from the right.

**Right Outer Joins**: It is use to access all data from the right table, matched rows from the left.

**Full Outer Joins**: It is use to access all data when there is a match or unmatched from left and right tables.

**Natural Join**: Automatically joins tables using columns with the same name and compatible data types. When do not find any common column attribute present in both table it act as **Cross Joins**.

**Self Join**: Joins a table with itself to compare data within the same table.

## Aggregations, Filters in queries

**Aggregations**: A functions which simultaneously perform tasks on every column rows and resulting in single output is know as Aggregation.

Types of Aggregation:
* MAX()
* MIN()
* SUM()
* AVG()
* COUNT()

**Filters in Queries**: Filters restrict rows before or after aggregation.

We use Where clause and Having clause for filtering.

**WHERE**: Filters before aggregation and can not use aggregate functions directly.

**HAVING**: Filters after aggregation and used with GROUP BY for aggregate conditions.

## Normalization
Normalization is the process of structuring a relational database to reduce data redundancy and improve data integrity. It organizes tables and relationships by applying a series of rules called Normal Forms.

Advantage of normalization
* Eliminate duplicate data.
* Ensure logical data storage.
* Simplify maintenance and updates.
* Enhance query efficiency.
* Improves data consistency.

Types of normalization:
* 1NF – First Normal Form
* 2NF – Second Normal Form
* 3NF – Third Normal Form
* 4NF – Fourth Normal Form

**1NF**

Each table cell contains a single value (atomic).

 No repeating groups or arrays.

**2NF**

* Must be in 1NF.

* Remove partial dependency: non-key columns depend on the whole primary key, not part of it.

**3NF**

Must be in 2NF.

Remove transitive dependency: non-key attributes depend only on the primary key, not on other non-key attributes.

**4NF**

Must be in BCNF (Boycc-codd Normal form).

Eliminate multi-valued dependencies (independent multi-valued facts stored in the same table).

## Indexes

An index is a database structure that speeds up data retrieval on a table at the cost of additional storage and maintenance.

It works like a book index, allowing the database engine to locate rows quickly without scanning the entire table.

Types of Indexes:-

**Primary Index**

Created automatically on a table’s primary key.

Ensures uniqueness and fast lookups.

**Unique Index**

Guarantees all values in the indexed column are unique.

Example: CREATE UNIQUE INDEX idx_email ON users(email);

**Clustered Index**

Reorders the physical data rows to match the index order.

Only one clustered index per table (e.g., primary key in SQL Server).

**Non-Clustered Index**

Maintains a separate structure with pointers to data rows.

Multiple non-clustered indexes allowed.

Example: CREATE INDEX idx_name ON employees(last_name);

**Composite (Multi-Column) Index**

Index on two or more columns.

Example: CREATE INDEX idx_city_state ON customers(city, state);

**Full-Text Index**

Optimized for searching large text fields.

Example: searching within articles or documents.

**Bitmap Index**

Uses bitmaps for columns with low cardinality (few distinct values).

Often used in data warehouses.

## Transactions

A transaction is a sequence of one or more SQL operations (e.g., INSERT, UPDATE, DELETE) executed as a single logical unit of work.

A transaction ensures data integrity and consistency, even in the event of errors or system failures.

**Advantages**

* Maintains data integrity during concurrent access.
* Supports error recovery.
* Provides predictable results for critical operations (e.g., financial transfers).

## Locking mechanism

A lock is a database control that restricts simultaneous access to data to maintain consistency and integrity during concurrent transactions.

Locks prevent conflicts like lost updates, dirty reads, or inconsistent results.

Types of Locks

**Shared Lock (S Lock)**: Allows multiple transactions to read a resource but not modify it.

Example: SELECT ... under READ COMMITTED.

**Exclusive Lock (X Lock)**: Grants one transaction exclusive rights to read and write.

Blocks other reads/writes until released.

Example: UPDATE or DELETE operations.

**Update Lock**: Prevents deadlocks during updates.

Acquired when a transaction intends to change a row.

**Intent Locks**: Signals intent to acquire a shared or exclusive lock on lower-level resources (e.g., a row inside a table).

Types: Intent Shared (IS), Intent Exclusive (IX).

**Row-Level Lock**: Locks only the specific rows being modified.

High concurrency; minimal blocking.

**Table-Level Lock**: Locks the entire table.

Simpler but can reduce concurrency.

**Page/Block-Level Lock**: Locks a disk page (group of rows).

Balance between row-level and table-level.

## Database Isolation Levels
Isolation ensures that transactions running at the same time do not interfere with each other, preserving data consistency and the ACID properties.

Different isolation levels balance data accuracy against concurrency/performance.

**Read Uncommitted**

* Allows reading uncommitted changes (dirty reads).
* Fastest but least safe.

**Read Committed**
* Each read sees only committed data.
* Prevents dirty reads but allows non-repeatable reads.
* Default in Oracle and SQL Server.

**Repeatable Read**
* Ensures same rows read within a transaction remain unchanged.
* Prevents dirty and non-repeatable reads.

**Serializable**
* Highest isolation; transactions behave as if executed sequentially.
* Prevents dirty, non-repeatable, and phantom reads.

Choose level based on application needs:
* Analytics/Reporting → Read Committed/Repeatable Read
* Financial Transfers → Serializable.

## Triggers

A trigger is a stored database object that automatically executes (fires) in response to specific events on a table or view.
Events can be INSERT, UPDATE, or DELETE operations.

**Advantages**
* Automates repetitive tasks.
* Enforces complex constraints not possible with simple checks.
* Improves consistency across tables.

**Disadvantages**
* Can add hidden complexity, making debugging harder.
* May impact performance on high-volume transactions.
* Improper design can cause recursive trigger loops.
