# vTiger_MySQL_procedures
vTiger's MySQL procedures and functions

Routine name : set_pdfmaker_view_as_source_userid
Type : PROCEDURE
Is deterministic :
Definer : root@localhost
Security type : DEFINER
SQL data access : NO SQL
Comment : 

Parameters : 

Parameters 	
Direction 	Name 	            Type 	Length/Values 	Options

  in        v_source_userid   INT     3              UNSIGNED ZERO FILLED
  
  in        v_userid          INT     3              UNSIGNED ZERO FILLED
  
======================

Routine name : updateUnitsStatus
Type : PROCEDURE
Is deterministic: 
Definer : root@localhost
Security type : DEFINER
SQL data access : MODIFIES SQL DATA
Comment : updateUnitsStatus regarding with Agreement changes

Parameters : 

=====================

Routine name : updateAgrCodeInConts
Type : PROCEDURE
Is deterministic : 
Definer : root@localhost
Security type : DEFINER
SQL data access : CONTAINS SQL
Comment : update agreements codes in contacts

Parameters : 

=====================

Routine name : tmp_update_unitid_event
Type : PROCEDURE
Is deterministic : 
Definer : root@localhost
Security type : DEFINER
SQL data access : CONTAINS SQL
Comment : 

Parameters : 

=====================

Routine name : tmp_code_gen
Type : PROCEDURE
Is deterministic : 
Definer : root@localhost
Security type : DEFINER
SQL data access : CONTAINS SQL
Comment : 

Parameters : 

=====================
