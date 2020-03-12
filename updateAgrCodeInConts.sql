BEGIN DECLARE exit_flag1                                                               INT DEFAULT 0;
  DECLARE v_contactid                                                              INTEGER(5);
  DECLARE v_agreement_code_cur, v_agreement_status, v_agreement_status_cur, v_agreement_code, v_agreement_type, v_agreement_type_cur   VARCHAR(64);
  DECLARE cur1 CURSOR FOR SELECT
  vc.contactid,vc2.cf_1143, cf_1155, cf_1153
FROM vtiger_contactdetails vc,
  vtiger_contactscf vc2,
     vtiger_crmentity vc1
WHERE vc.contactid = vc1.crmid AND vc.contactid=vc2.contactid 
AND vc1.deleted = 0;


  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET exit_flag1 = 1;
  -- 

  INSERT INTO proc_log (proc_name, comment) VALUES ('updateAgrCodeInConts', 'start');
  OPEN cur1;

loop1:
  LOOP
    FETCH cur1 INTO v_contactid, v_agreement_code_cur, v_agreement_status_cur,v_agreement_type_cur;
    IF exit_flag1 THEN
      LEAVE loop1;
    END IF;
     
    block2:
    BEGIN DECLARE exit_flag2 INT DEFAULT 0;
      declare cur2 CURSOR FOR SELECT
                                code,
                                va.agreement_status,
                                va.agreement_type
                              FROM vtiger_agreements va
                              WHERE va.agreementid IN (SELECT
                                  MAX(va.agreementid)
                                FROM vtiger_agreements va,
                                     vtiger_crmentity vc
                                WHERE vc.crmid = va.agreementid
                                AND vc.deleted = 0
                                AND (tenant_contact_1 = v_contactid
                                OR va.tenant_contact_2 = v_contactid
                                OR va.tenant_contact_3 = v_contactid
                                OR va.tenant_contact_4 = v_contactid
                                OR va.tenant_contact_5 = v_contactid
                                OR va.tenant_contact_6 = v_contactid
                                OR va.tenant_contact_7 = v_contactid
                                OR va.tenant_contact_8 = v_contactid));
      DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET exit_flag2 = 1;

      OPEN cur2;
      loop2:
         LOOP
              FETCH cur2 INTO v_agreement_code, v_agreement_status, v_agreement_type;
         IF exit_flag2 THEN
          LEAVE loop2;
          END IF;
        
        IF v_agreement_code_cur is NOT NULL AND (v_agreement_code_cur <> v_agreement_code or 
          v_agreement_status_cur <> v_agreement_status OR v_agreement_type_cur<>v_agreement_type) then
            UPDATE vtiger_contactscf
               SET
               cf_1155 = v_agreement_status, cf_1143 = v_agreement_code, cf_1153 = v_agreement_type
      WHERE
        contactid = v_contactid;
      INSERT INTO proc_log (proc_name, comment) VALUES ('updateAgrCodeInConts', v_contactid);
    -- INSERT INTO temp_data (col1, col2, col3, col4, col5) VALUES (v_contactid, v_agreement_status_cont, v_agreement_status, v_code, v_agreement_type);
    END IF;

    END LOOP loop2;
      CLOSE cur2;
    END block2;
  END LOOP loop1;
  CLOSE cur1;
INSERT INTO proc_log (proc_name, COMMENT)
  VALUES ('updateAgrCodeInConts', 'end');
-- SELECT *  FROM  temp_data;
END
