/* creating user table */
CREATE TABLE USERS 
(
  USERID NUMBER(10, 0) NOT NULL 
, FULLNAME VARCHAR2(30) NOT NULL 
, EMAIL VARCHAR2(30) NOT NULL 
, PASSWORD VARCHAR2(30) NOT NULL 
, CONSTRAINT USERS_PK PRIMARY KEY 
  (
    USERID 
  )
  ENABLE 
);

CREATE SEQUENCE users_id_seq;
 
CREATE TRIGGER user_on_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
  SELECT users_id_seq.nextval
  INTO :new.userid
  FROM dual;
END;/

/* Altering user table to add role column*/
alter table users 
add role varchar2(15) default 'customer' NOT NULL;

/* creating category table */
CREATE TABLE CATEGORIES 
(
  ID NUMBER(3) NOT NULL 
, PARENT_ID NUMBER(3) DEFAULT NULL 
, CATEGORY VARCHAR2(50) NOT NULL 
, PHOTO VARCHAR2(30 BYTE) 
, CONSTRAINT CATEGORIES_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

/* altering categories table to add foreign key to parent_id*/

ALTER TABLE CATEGORIES
ADD CONSTRAINT CATEGORIES_CATEGORIES_FK1 FOREIGN KEY
(
  PARENT_ID 
)
REFERENCES CATEGORIES
(
  ID 
)
ON DELETE CASCADE ENABLE;

/* create sequence for CATEGORIES table */
CREATE SEQUENCE CATEGORIES_SEQ;

/* create trigger for CATEGORIES table */
create or replace 
TRIGGER CATEGORY_ON_INSERT BEFORE INSERT ON CATEGORIES 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF :NEW.ID IS NULL THEN
      SELECT CATEGORIES_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;


CREATE TABLE PRODUCTS 
(
  PRODID NUMBER NOT NULL 
, PNAME VARCHAR2(40) NOT NULL 
, PCAT VARCHAR2(40) NOT NULL 
, PRICE NUMBER(15, 2) NOT NULL 
, DISC_PRICE NUMBER(15, 2) NOT NULL 
, REMARKS VARCHAR2(40) NOT NULL 
, DESCR CLOB NOT NULL
, CREATE_DATE timestamp default systimestamp NOT NULL
, PHOTO VARCHAR2(200) NOT NULL 
, PARENT_ID NUMBER NOT NULL  
,CONSTRAINT TABLE1_PK PRIMARY KEY 
  (
    PRODID 
  )commit;
  ENABLE 
);
CREATE SEQUENCE PRODUCTS_SEQ;
/* create trigger for CATEGORIES table */
create or replace 
TRIGGER PRODUCT_ON_INSERT BEFORE INSERT ON PRODUCTS 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF :NEW.PRODID IS NULL THEN
      SELECT PRODUCTS_SEQ.NEXTVAL INTO :NEW.PRODID FROM DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;



CREATE TABLE orders (
  order_id number(10) NOT NULL,
  orderdate timestamp default systimestamp NOT NULL,
  userid varchar2(30) NOT NULL,
  order_status varchar2(20) DEFAULT 'Pending' NOT NULL
) ;
 

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_PK PRIMARY KEY 
(
  ORDER_ID 
)
ENABLE;

ALTER TABLE PRODUCTS 
ADD (PARENT_ID NUMBER );

ALTER TABLE PRODUCTS
ADD CONSTRAINT PRODUCTS_CATEGORIES_FK1 FOREIGN KEY
(
  PARENT_ID 
)
REFERENCES CATEGORIES
(
  ID 
)
ENABLE;

