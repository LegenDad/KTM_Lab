### JOIN

```mysql
SELECT * from orders
inner JOIN customers on
orders.customerid = customers.customerid;
```

```mysql
select * from customersb c
left outer join ordersb o 
ON c.customerid=o.customerid
order by c.customerid;
```

```mysql
SELECT o.employeeid, e.employeeid, o.orderid, e.lastname, e.firstname
FROM ordersb o 
RIGHT OUTER JOIN employees e 
ON o.employeeid = e.employeeid
ORDER BY o.orderid;
```

```mysql
SELECT c.CustomerID, o.CustomerID, c.CustomerName, o.OrderID
FROM CustomersB c
FULL OUTER JOIN Orders o ON c.CustomerID=o.CustomerID
ORDER BY c.CustomerName;
```

```mysql
select *
from sales s
where exists(
select *
from vip_clients v
where s.companyname= v.name);
```

```mysql
select *
from sales s
where exists(
select *
from vip_clients v
where s.companyname= v.name);
```

```mysql
select
s.companyname,
s.productcategory,
count(distinct s.orderid) OrderCount,
sum(s.saleamount) as TotalSales
from sales s
left semi join vip_clients v on (s.companyname= v.name)
group by
s.companyname,
s.productcategory;
```
