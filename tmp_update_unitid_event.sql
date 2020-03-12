BEGIN
DECLARE exit_flag1                                                    INT DEFAULT 0;
  DECLARE v_unitid                                                              INTEGER(5);
  DECLARE v_code VARCHAR(200);
   DECLARE v_activityid                                                              INTEGER(5);
  DECLARE v_unitid2                                                              INTEGER(5);
  DECLARE v_propertyid                                                              INTEGER(5);
  DECLARE v_subject VARCHAR(200);  
   
DECLARE cur1 CURSOR FOR
SELECT code, unitid from vtiger_units;
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET exit_flag1 = 1;

DELETE FROM temp_data;

OPEN cur1;

loop1:
LOOP
FETCH cur1 INTO  v_code, v_unitid;
  IF exit_flag1 THEN
    LEAVE loop1;
  END IF;
   -- INSERT INTO temp_data (col1, col2) VALUES 
   -- (v_code, v_unitid);
block2:
BEGIN DECLARE exit_flag2 INT DEFAULT 0;
DECLARE cur2 CURSOR FOR
select a.subject,a.activityid,a.unitid,a.propertyid from vtiger_activity a
where exists (select crmid from  vtiger_crmentity  where crmid=a.activityid and deleted=0 )
-- and a.eventstatus in ('Planned','Not Started', 'In Progress') 
 and a.activitytype in ('To Do Event','Dispatch', 'Delivery')
and subject like binary concat(v_code,' %') -- and subject not like '7A'
 and (unitid is null or unitid='')
order by subject;

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET exit_flag2 = 1;
	open cur2;
    loop2:
    LOOP
    fetch cur2 into v_subject,v_activityid,v_unitid2,v_propertyid;
      IF exit_flag2 THEN
    LEAVE loop2;
  END IF;
   INSERT INTO temp_data (col1, col2, col3, col4, col5, col6) VALUES 
    (v_code, v_unitid, v_subject, v_activityid, v_unitid2, v_propertyid);
    
    update vtiger_activity a set unitid=v_unitid
 where activityid=v_activityid;

      END LOOP loop2;
    close cur2;
end block2;
END LOOP loop1;
  CLOSE cur1;

END
