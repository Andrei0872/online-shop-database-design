-- drop table audit_offer;

/*
alter table "offer"
add discount number;

select *
from audit_offer;
*/

create table audit_offer (
  "db_name" varchar2(50),
  "user" varchar2(50),
  "event" varchar2(50),
  "occurred_at" timestamp
);

create or replace trigger offer_high_level_changes
	after alter on schema
begin
	insert into audit_offer
	values (sys.database_name, sys.login_user, sys.sysevent, systimestamp);
end;
/