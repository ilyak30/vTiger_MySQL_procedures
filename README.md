# vTiger_MySQL_procedures
vTiger's MySQL procedures and functions

Routine name : set_pdfmaker_view_as_source_userid
Type : PROCEDURE
Definer : root@localhost
Security type : DEFINER

Parameters : 

Parameters 	
Direction 	Name 	            Type 	Length/Values 	Options
	in        v_source_userid   INT     3              UNSIGNED ZERO FILLED
  in        v_userid          INT     3              UNSIGNED ZERO FILLED
  
======================

BEGIN 
  DECLARE finished INT(2);
  DECLARE v_templateid, v_userid_dest, v_is_active, v_is_default, v_sequence INTEGER(5); 

  DECLARE cur_source_data CURSOR FOR SELECT templateid, v_userid as userid, is_active, is_default, sequence FROM vtiger_pdfmaker_userstatus WHERE userid=v_source_userid;

    DECLARE CONTINUE HANDLER  FOR NOT FOUND SET finished = 1;

DELETE FROM vtiger_pdfmaker_userstatus  WHERE userid = v_userid;

  OPEN cur_source_data;

loop1:
  LOOP
   FETCH cur_source_data INTO v_templateid, v_userid_dest, v_is_active, v_is_default, v_sequence;
        IF finished = 1 THEN
            LEAVE loop1;
        END IF;
INSERT INTO vtiger_pdfmaker_userstatus (templateid, userid, is_active, is_default, sequence)   VALUES (v_templateid, v_userid_dest, v_is_active, v_is_default, v_sequence);

  END LOOP loop1;
  CLOSE cur_source_data;

COMMIT;
END

