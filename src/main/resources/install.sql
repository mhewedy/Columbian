/*install on mysql database using the command:*/
/*mysql -u root -p columbian < /path/to/this/file*/

/*create tables*/

create table SUPPLIERS
  (SUP_ID integer NOT NULL,
  SUP_NAME varchar(40) NOT NULL,
  STREET varchar(40) NOT NULL,
  CITY varchar(20) NOT NULL,
  STATE char(2) NOT NULL,
  ZIP char(5),
  PRIMARY KEY (SUP_ID));

create table COFFEES
  (COF_NAME varchar(32) NOT NULL,
  SUP_ID int NOT NULL,
  PRICE numeric(10,2) NOT NULL,
  SALES integer NOT NULL,
  TOTAL integer NOT NULL,
  PRIMARY KEY (COF_NAME),
  FOREIGN KEY (SUP_ID) REFERENCES SUPPLIERS (SUP_ID));

/*populate tables*/

insert into SUPPLIERS values(49,  'Superior Coffee', '1 Party Place', 'Mendocino', 'CA', '95460');
insert into SUPPLIERS values(101, 'Acme, Inc.', '99 Market Street', 'Groundsville', 'CA', '95199');
insert into SUPPLIERS values(150, 'The High Ground', '100 Coffee Lane', 'Meadows', 'CA', '93966');
insert into SUPPLIERS values(456, 'Restaurant Supplies, Inc.', '200 Magnolia Street', 'Meadows', 'CA', '93966');
insert into SUPPLIERS values(927, 'Professional Kitchen', '300 Daisy Avenue', 'Groundsville', 'CA', '95199');

insert into COFFEES values('Colombian',          101, 7.99, 0, 0);
insert into COFFEES values('French_Roast',       49,  8.99, 0, 0);
insert into COFFEES values('Espresso',           150, 9.99, 0, 0);
insert into COFFEES values('Colombian_Decaf',    101, 8.99, 0, 0);
insert into COFFEES values('French_Roast_Decaf', 049, 9.99, 0, 0);

/*create stored procedures*/

DELIMITER //
create procedure SHOW_SUPPLIERS()
  begin
    select SUPPLIERS.SUP_NAME, COFFEES.COF_NAME
    from SUPPLIERS, COFFEES
    where SUPPLIERS.SUP_ID = COFFEES.SUP_ID
    order by SUP_NAME;
  end//
DELIMITER ;

DELIMITER //
create procedure GET_SUPPLIER_OF_COFFEE(IN coffeeName varchar(32), OUT supplierName varchar(40))
  begin
    select SUPPLIERS.SUP_NAME into supplierName
      from SUPPLIERS, COFFEES
      where SUPPLIERS.SUP_ID = COFFEES.SUP_ID
      and coffeeName = COFFEES.COF_NAME;
    select supplierName;
  end//
DELIMITER ;

DELIMITER //
create procedure RAISE_PRICE(IN coffeeName varchar(32), IN maximumPercentage float, IN newPriceInput numeric(10,2), OUT newPriceOutput numeric(10,2))
  begin
    main: BEGIN
      declare maximumNewPrice numeric(10,2);
      declare oldPrice numeric(10,2);
      select COFFEES.PRICE into oldPrice
        from COFFEES
        where COFFEES.COF_NAME = coffeeName;
      set maximumNewPrice = oldPrice * (1 + maximumPercentage);
      if (newPriceInput > maximumNewPrice)
        then set newPriceOutput = maximumNewPrice;
      end if;
      if (newPriceOutput <= oldPrice)
        then set newPriceOutput = oldPrice;
        leave main;
      end if;
      update COFFEES
        set COFFEES.PRICE = newPriceOutput
        where COFFEES.COF_NAME = coffeeName;
      select newPriceOutput;
    END main;
  end
//
DELIMITER ;