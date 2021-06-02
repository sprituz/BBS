CREATE  TRIGGER tI_POST BEFORE INSERT ON POST for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- INSERT trigger on POST 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* USER_INFO  POST on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000e90b", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="POST"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM USER_INFO
      WHERE
        /* %JoinFKPK(:%New,USER_INFO," = "," AND") */
        :new.ID = USER_INFO.ID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert POST because USER_INFO does not exist.'
      );
    END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/

CREATE  TRIGGER tD_POST AFTER DELETE ON POST for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- DELETE trigger on POST 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* POST  Reply on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ccbc", PARENT_OWNER="", PARENT_TABLE="POST"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="PostID" */
    SELECT count(*) INTO NUMROWS
      FROM Reply
      WHERE
        /*  %JoinFKPK(Reply,:%Old," = "," AND") */
        Reply.PostID = :old.PostID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete POST because Reply exists.'
      );
    END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/

CREATE  TRIGGER tU_POST AFTER UPDATE ON POST for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- UPDATE trigger on POST 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* POST  Reply on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001ea32", PARENT_OWNER="", PARENT_TABLE="POST"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="PostID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.PostID <> :new.PostID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Reply
      WHERE
        /*  %JoinFKPK(Reply,:%Old," = "," AND") */
        Reply.PostID = :old.PostID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update POST because Reply exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* USER_INFO  POST on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="POST"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="ID" */
  SELECT count(*) INTO NUMROWS
    FROM USER_INFO
    WHERE
      /* %JoinFKPK(:%New,USER_INFO," = "," AND") */
      :new.ID = USER_INFO.ID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update POST because USER_INFO does not exist.'
    );
  END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/


CREATE  TRIGGER tI_Reply BEFORE INSERT ON Reply for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- INSERT trigger on Reply 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* USER_INFO  Reply on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001dfda", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM USER_INFO
      WHERE
        /* %JoinFKPK(:%New,USER_INFO," = "," AND") */
        :new.ID = USER_INFO.ID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reply because USER_INFO does not exist.'
      );
    END IF;

    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* POST  Reply on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="POST"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="PostID" */
    SELECT count(*) INTO NUMROWS
      FROM POST
      WHERE
        /* %JoinFKPK(:%New,POST," = "," AND") */
        :new.PostID = POST.PostID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reply because POST does not exist.'
      );
    END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/

CREATE  TRIGGER tU_Reply AFTER UPDATE ON Reply for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- UPDATE trigger on Reply 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* USER_INFO  Reply on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001dc8b", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="ID" */
  SELECT count(*) INTO NUMROWS
    FROM USER_INFO
    WHERE
      /* %JoinFKPK(:%New,USER_INFO," = "," AND") */
      :new.ID = USER_INFO.ID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reply because USER_INFO does not exist.'
    );
  END IF;

  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* POST  Reply on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="POST"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="PostID" */
  SELECT count(*) INTO NUMROWS
    FROM POST
    WHERE
      /* %JoinFKPK(:%New,POST," = "," AND") */
      :new.PostID = POST.PostID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reply because POST does not exist.'
    );
  END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/


CREATE  TRIGGER tI_TODO BEFORE INSERT ON TODO for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- INSERT trigger on TODO 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* USER_INFO  TODO on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000e6ba", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="TODO"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM USER_INFO
      WHERE
        /* %JoinFKPK(:%New,USER_INFO," = "," AND") */
        :new.ID = USER_INFO.ID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert TODO because USER_INFO does not exist.'
      );
    END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/

CREATE  TRIGGER tU_TODO AFTER UPDATE ON TODO for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- UPDATE trigger on TODO 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* USER_INFO  TODO on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000ee88", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="TODO"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
  SELECT count(*) INTO NUMROWS
    FROM USER_INFO
    WHERE
      /* %JoinFKPK(:%New,USER_INFO," = "," AND") */
      :new.ID = USER_INFO.ID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update TODO because USER_INFO does not exist.'
    );
  END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/


CREATE  TRIGGER tD_USER_INFO AFTER DELETE ON USER_INFO for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- DELETE trigger on USER_INFO 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* USER_INFO  Reply on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00028041", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM Reply
      WHERE
        /*  %JoinFKPK(Reply,:%Old," = "," AND") */
        Reply.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete USER_INFO because Reply exists.'
      );
    END IF;

    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* USER_INFO  POST on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="POST"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM POST
      WHERE
        /*  %JoinFKPK(POST,:%Old," = "," AND") */
        POST.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete USER_INFO because POST exists.'
      );
    END IF;

    /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
    /* USER_INFO  TODO on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="TODO"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM TODO
      WHERE
        /*  %JoinFKPK(TODO,:%Old," = "," AND") */
        TODO.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete USER_INFO because TODO exists.'
      );
    END IF;


-- ERwin Builtin Tue Dec 15 07:44:57 2020
END;
/

CREATE  TRIGGER tU_USER_INFO AFTER UPDATE ON USER_INFO for each row
-- ERwin Builtin Tue Dec 15 07:44:57 2020
-- UPDATE trigger on USER_INFO 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* USER_INFO  Reply on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002f01f", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="Reply"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="ID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ID <> :new.ID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Reply
      WHERE
        /*  %JoinFKPK(Reply,:%Old," = "," AND") */
        Reply.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update USER_INFO because Reply exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* USER_INFO  POST on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="POST"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="ID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ID <> :new.ID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM POST
      WHERE
        /*  %JoinFKPK(POST,:%Old," = "," AND") */
        POST.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update USER_INFO because POST exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Tue Dec 15 07:44:57 2020 */
  /* USER_INFO  TODO on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="USER_INFO"
    CHILD_OWNER="", CHILD_TABLE="TODO"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ID <> :new.ID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM TODO
      WHERE
        /*  %JoinFKPK(TODO,:%Old," = "," AND") */
        TODO.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update USER_INFO because TODO exists.'
      );
    END IF;
  END IF;

