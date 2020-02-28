# 基础

### 1、连接池 `pool.query()` vs `pool.getConnection()` 

`pool.query` 是 `pool.getConnection()`, `connection.query()` 和 `connection.release()`的简写形式，每一个 `pool.query` 都会使用一个新的连接，并且串行执行



唯一需要使用 `pool.getConnection` 的场景是执行事务，需要使用一个连接串行执行多个sql

> https://github.com/mysqljs/mysql/issues/1668

### 正排索引 vs 倒排索引
- 正排索引：按id找文章
- 倒排索引：按文章内容找id

### 什么是`Binlog`
MySQL 的二进制日志，它记录了所有的 DDL 和 DML 语句（除了数据查询语句select、show等），以事件形式记录，还包含语句所执行的消耗的时间，MySQL的二进制日志是事务安全型的。binlog 的主要目的是复制和恢复。

主从结构通过Binlog同步，不会加锁，会数据不一致