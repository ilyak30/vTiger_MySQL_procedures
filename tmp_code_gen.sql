BEGIN
DECLARE exit_flag1                                                               INT DEFAULT 0;
  DECLARE v_leadid                                                              INTEGER(5);
  DECLARE v_code VARCHAR(200);
DECLARE cur1 CURSOR FOR
SELECT concat_ws('', l.firstname, ' ', l.lastname, '/', cf_839, '/', leadnumperfrom, 'px-', leadnumperto, 'px', cf_829, '/', '/', cf_835, '/', leadlengthfrom, '-', leadlengthto, '/', round(cf_837)) 'code', l.leadid
FROM
  ESSvTiger6.vtiger_leaddetails l, ESSvTiger6.vtiger_leadscf lcf, ESSvTiger6.vtiger_crmentity c
WHERE
  l.leadid = lcf.leadid
  AND l.leadid = c.crmid
  AND c.deleted = 0
  AND c.presence = 1
  AND converted = 0;

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET exit_flag1 = 1;

  OPEN cur1;

loop1:
LOOP
FETCH cur1 INTO  v_code, v_leadid;
  IF exit_flag1 THEN
    LEAVE loop1;
  END IF;

UPDATE ESSvTiger6.vtiger_leaddetails
SET
  leadcode = v_code
WHERE
  leadid = v_leadid;
END LOOP loop1;
  CLOSE cur1;

END
