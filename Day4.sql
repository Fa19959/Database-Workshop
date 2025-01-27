
Declare @x int =100 -- if we declare varible we dont want to use DB becuase we are work on memory , EXEPT if the varible bring value from table here we should use DB

use iti

declare @x int =( select avg(st_age) from Student) -- if i run this alone it will show me problem we should run together 

select @x


select * from Instructor
select * from Student

Declare @f int
select @f = St_Age from Student where St_Id=3
select @f 
--------------------------------------------------------------------------------------------------------------------------

--if we assign 100 and the select statement did not return a result --> for example there is no student with number 15
-- it will take the last value that we assign which is 100

Declare @f int =100
select @f = St_Age from Student where St_Id=15
select @f

--if the select statement return array -->means number of values so the variable will take or save the last value in array 
--here is your problem--> you did not check select statment what it will return so for that you will prepare varibels to hold the values :( 
------------------------------------------------------------------------------------------------------------------------------------------
Declare @f int, @name varchar(20)
select @f = St_Age, St_Fname from Student where St_Id=900
select @f  -- this will lead me to error ! why ? becuase we use select for assign & display and this is not allowed (use for one purpose only )


--Check here 
--------------------------------------------------------------------------------------------------------------------------
Declare @f int, @name varchar(20)
select @f = St_Age,@name=St_Fname from Student where St_Id=3
select @f,@name
---------------------------------------------------------------------------------------------------------------------------
--here it will show me the last value in array or table 
Declare @f int
select  @f = St_Age from Student where St_Address ='alex'
select @f

-- table (x int) -->we should use one dimensional array of integer ( we make table on memory )--> it will end with the end of query 
-------------------------------------------------------------------------------------------------------------------------
Declare @t table(x int) --X is the name of the column 
insert into @t
select  St_Age from Student where St_Address ='alex' --insert based on select 
select * from @t
------------------------------------------------------------------------------------------------------------------------------
--we can use count on array
Declare @t table(x int)
insert into @t
select  St_Age from Student where St_Address ='alex'
select count(*) from @t
----------------------------------------------------------------------------------------------------------------------------------
--2 Dimensional -->2 columns
Declare @t table(x int, n varchar(20))
insert into @t
select  St_Age, St_Fname from Student where St_Address ='alex'
select * from @t
-------------------------------------------------------------------------------------------------------------------------------------
declare @z int
update Student set St_Fname ='ALI', @z=St_Age
where St_Id=4
select @z --is the age of the name that I updated  
----------------------------------------------------------------------------------------------------------------------------------------
--I want to use top on varible 
select top (3)* from student

declare @x int =6
select top(@x)* from student -- it will show me first 8
-----------------------------------------------------------------------------------------------------------------------------------------
declare @col varchar(20)='*', @t varchar(20)='student'
select @col from @t --	I cannot use variable with from becuase its varchar not table

select 'select * from student'   --the output of this is string

--if we replace select with execute -->dynamic query  let us search about it 
execute( 'select * from student')-- it will take string then convert it to query 

declare @col varchar(20)='*',@t varchar(20)='Student'
execute ('select '+ @col+' from '+@t) --> same as select * from student  


declare @col varchar(20)='*',@t varchar(20)='Instructor'
execute ('select '+ @col+' from '+@t)

declare @col varchar(20)='Ins_Name',@t varchar(20)='Instructor'
execute ('select '+ @col+' from '+@t)
----------------------------------------------------------------------------------------------------------------------------
--Global Var-----

Select @@servername
select @@version

update Student set st_age+=1 -- this will show us message of how many rows affected 
select @@ROWCOUNT   --here will show us the result rather than the message 

update Student set st_age+=1
select @@ROWCOUNT
select @@ROWCOUNT -- it will show us 1 the last one of select @@ROWCOUNT


update Student set st_age+=1
go 
select @@error 

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--control of flow 
--if ( we can do if for the result of the query not query itself ) how ?
--begin end 
--if exists     if not exists
--while  continu break 
--choose , waitfor --> this is for you to search :)


Declare @x int =90
If @x>0 --we can add and , OR more condition
Select 'x>0'
else 
Select 'x<0'

Declare @x int =90
If @x>0 
{ --here we don’t have this we use instead (begin , end)
   begin
      Select 'x>0'
      end 
else -- use if-else (nested if )

Select 'x<0'

-------------------------------------------------------------------------------------
--assume that you want to create table course 
create table course (
cis int,
cname varchar(30)
)
---------------------------------------
select * from sys.all_columns --sys--> schema.object it show us all meata data od DB
select * from sys.all_views
select * from sys.tables WHERE name='course' -- if its exist will show us if not it will show nothing for us 

if exists(select name from sys.tables where name='studs') -- true or false ما تهتم بناتج تهتم اذا كان موجود او لا
	select 'table is existed'
else
	create table studs
	(
	id int ,
	name varchar(20)
	)
	-------------------------------------------

	 delete from Department where Dept_Id=20 --> it will lead me to error -->connect to other table
	  


	  if not exists(select dept_id from Student where Dept_Id=20) -- is this id on student or not --(false) هنا مهتم بالخطأ 
	      if  not exists(select dept_id from Instructor where dept_id=20)
		       delete from Department 	where dept_id=20 

			   
	  if not exists(select dept_id from Student where Dept_Id=80)
	      if  not exists(select dept_id from Instructor where dept_id=80)
		       delete from Department 	where dept_id=80 

			   select * from  Department

------we can use begin try -------------عشان اعرف الخطأ من وين ---------------------------------
			   begin try -- to avoid error
	      delete from Department where dept_id=30
              end try
      begin catch
	select 'error'
        end catch

--- while  continue   break --عندناwhile نسوي فيها كل شي 
----------------------------------------------------------------------------
declare @x int=10
while @x<=20
	begin
		set @x+=1
		if @x=13
			continue
		if @x=15
			break
			select @x
	end
---------------------------------------------
--Function , scaler func 
-- in C# we write function like --> String getName(int id);
--be attention here its create not declear 
--تأخذ رقم الطالب وترجع اسمه
Create Function GetName(@id int) -- we can not pass parameter without using it (optinal to take , but it must return )
Returns varchar(20) -->return data type
Begin
Declare @name varchar(20) --if we write here 30 --> it will return 20 --> it will cut it 
Select @name=St_Fname from Student where St_Id=@id --لازم تستخدم البراميتر الي مررته 
Return @name --> return the value 
End 

---وين راحت ؟؟؟؟  
-------------------------------------------------------------------
alter Function GetName(@id int)   
Returns varchar(21) --> change here
Begin
Declare @name varchar(20) 
Select @name=St_Fname from student where St_Id=@id
Return @name 
End

select GetName(1)        --will think it as built in function (how to call the built-in func is different than user define)

select dbo.GetName(1)    -- that is why we should write the name of schema 

drop function GetName

-->Function is like table its as object -->we can script and take it to other DB 
-----------------------------------------
---Return table 

--Inline --> function ارسل لها رقم القسم وتطلع لي المدرسين ورواتبهم   
--error why? as
Create function Getist(@did int)
returns table  --> its different from return --> type of return type  
	as
	return
	(
	 select ins_name,salary*12        --function as create table in runtime so it must be the name of column is clear      
	 from Instructor
	 where Dept_Id=@did	
	)

-------------------------------------------
Create function Getist(@did int)
returns table  --> its different from return --> type of return type  
	as
	return
	(
	 select ins_name,salary*12 as TotalSal
	 from Instructor
	 where Dept_Id=@did	
	)
	-- all functions --> we write inside the body only select , not DML, DDL ,TCL,DQL,Permission

select dbo.Getist(20) --> error why ?

select * from Getist(20)      --> we dont have built in func return table 

select ins_name from Getist(20)

select sum(totalsal) from getist(10)

drop function Getist
-------------------------------------------------------------------------------------
--multistatment  -- return table or list  if we send first name --> return id with first name .....

create function GetStuds(@format varchar(20))
returns @t table
			(
			 id int,
			 sname varchar(20) -- يكون داخله هذه الاشياء 
			)
   as --- till here is the signture of function
	begin
		if @format='first'
			insert into @t
			select st_id,st_fname from Student
		else if @format='last'
			insert into @t
			select st_id,st_Lname from Student
		else if @format='fullname'
			insert into @t 
			select st_id,st_fname+' '+st_lname from Student
		return -- ما قدر احدد له --i cannot write @t becuase we dont know the option
	end

	drop function GetStuds

select * from getstuds('last')

--no message + with table in result 





-----------------------------------------------------------

