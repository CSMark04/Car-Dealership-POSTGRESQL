CREATE TABLE "car" (
	"car_id" serial NOT NULL,
	"make" varchar(255) NOT NULL,
	"model" varchar(255) NOT NULL,
	"color" varchar(255) NOT NULL,
	"year" integer NOT NULL,
	CONSTRAINT "car_pk" PRIMARY KEY ("car_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "customer" (
	"customer_id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	"address" varchar(255) NOT NULL,
	"contact" integer NOT NULL,
	CONSTRAINT "customer_pk" PRIMARY KEY ("customer_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "parts" (
	"parts_id" serial NOT NULL,
	"part_name" varchar(255) NOT NULL,
	CONSTRAINT "parts_pk" PRIMARY KEY ("parts_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "parts_used" (
	"parts_used_id" serial NOT NULL,
	"parts_id" integer NOT NULL,
	"price" integer NOT NULL,
	"service_receipt_id" integer NOT NULL,
	CONSTRAINT "parts_used_pk" PRIMARY KEY ("parts_used_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "salesman" (
	"salesman_id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	CONSTRAINT "salesman_pk" PRIMARY KEY ("salesman_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "mechanic" (
	"mechanic_id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	CONSTRAINT "mechanic_pk" PRIMARY KEY ("mechanic_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "receipt" (
	"receipt_id" serial NOT NULL,
	"date" DATE NOT NULL,
	"car_id" integer NOT NULL,
	"customer_id" integer NOT NULL,
	"salesman_id" integer NOT NULL,
	CONSTRAINT "receipt_pk" PRIMARY KEY ("receipt_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "service_mechanic" (
	"service_mechanic_id" serial NOT NULL,
	"hours" integer NOT NULL,
	"mechanic_id" integer NOT NULL,
	"service_id" integer NOT NULL,
	CONSTRAINT "service_mechanic_pk" PRIMARY KEY ("service_mechanic_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "service" (
	"service_id" serial NOT NULL,
	"name" varchar(255) NOT NULL,
	"description" varchar(1200) NOT NULL,
	CONSTRAINT "service_pk" PRIMARY KEY ("service_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "service_receipt" (
	"service_receipt_id" serial NOT NULL,
	"date" DATE NOT NULL,
	"car_id" integer NOT NULL,
	"customer_id" integer NOT NULL,
	CONSTRAINT "service_receipt_pk" PRIMARY KEY ("service_receipt_id")
) WITH (
  OIDS=FALSE
);






ALTER TABLE "parts_used" ADD CONSTRAINT "parts_used_fk0" FOREIGN KEY ("parts_id") REFERENCES "parts"("parts_id");
ALTER TABLE "parts_used" ADD CONSTRAINT "parts_used_fk1" FOREIGN KEY ("service_receipt_id") REFERENCES "service_receipt"("service_receipt_id");



ALTER TABLE "receipt" ADD CONSTRAINT "receipt_fk0" FOREIGN KEY ("car_id") REFERENCES "car"("car_id");
ALTER TABLE "receipt" ADD CONSTRAINT "receipt_fk1" FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id");
ALTER TABLE "receipt" ADD CONSTRAINT "receipt_fk2" FOREIGN KEY ("salesman_id") REFERENCES "salesman"("salesman_id");

ALTER TABLE "service_mechanic" ADD CONSTRAINT "service_mechanic_fk0" FOREIGN KEY ("mechanic_id") REFERENCES "mechanic"("mechanic_id");
ALTER TABLE "service_mechanic" ADD CONSTRAINT "service_mechanic_fk1" FOREIGN KEY ("service_id") REFERENCES "service"("service_id");


ALTER TABLE "service_receipt" ADD CONSTRAINT "service_receipt_fk0" FOREIGN KEY ("car_id") REFERENCES "car"("car_id");
ALTER TABLE "service_receipt" ADD CONSTRAINT "service_receipt_fk1" FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id");




--- FUNCTIONS TO INPUT DATA



-- Adds a Car

CREATE OR REPLACE PROCEDURE addCar (
    _make varchar(255),
    _model varchar(255),
    _color varchar(255),
    _year int4
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO car
        (make, model, color,"year")
    VALUES
        (_make, _model, _color, _year);
END;
$$



-- Adds a customer
CREATE OR REPLACE PROCEDURE addCustomer (
    _first_name varchar(255),
    _last_name varchar(255),
    _address varchar(255),
    _contact int4
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO customer
    (first_name, last_name, address, contact)
    VALUES 
        (_first_name, _last_name, _address, _contact);
END;
$$


-- Adds a mechanic
CREATE OR REPLACE PROCEDURE addMechanic (
    _first_name varchar(45),
    _last_name varchar(45)
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO mechanic 
        (first_name, last_name)
    VALUES
        (_first_name, _last_name);
END;
$$


-- Adds parts
CREATE OR REPLACE PROCEDURE addParts (
    _part_name varchar(255)
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO parts
    (part_name)
    VALUES 
        (_part_name);
END;
$$



-- Adds parts_used 
CREATE OR REPLACE PROCEDURE addParts_used (
    _parts_id int4,
    _price int4,
    _service_receipt_id int4
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO parts_used
    (parts_id, price, service_receipt_id)
    VALUES 
        (_parts_id, _price, _service_receipt_id);
END;
$$




-- Adds receipt
CREATE OR REPLACE PROCEDURE addReceipt ( 
    _date date,
    _car_id int4,
    _customer_id int4,
    _salesman_id int4

)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO receipt 
    ("date",car_id,customer_id,salesman_id)
    VALUES 
        (_date, _car_id, _customer_id, _salesman_id);
END;
$$





-- Adds Salesmans
CREATE OR REPLACE PROCEDURE addSalesman (
    _first_name varchar(255),
    _last_name varchar(255)
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO salesman
    (first_name, last_name)
    VALUES 
        (_first_name, _last_name);
END;
$$



-- adds a Service 
CREATE OR REPLACE PROCEDURE addService (
    _name varchar(255),
    _description varchar(1200)
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO service
        ("name", description)
    VALUES
        (_name, _description);
END;
$$





-- Adds Service Mechanic 
CREATE OR REPLACE PROCEDURE addServiceMechanic (
    _hours int4,
    _mechanic_id int4,
    _service_id int4
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO service_mechanic 
        (hours, mechanic_id,service_id)
    VALUES
        (_hours, _mechanic_id, _service_id);
END;
$$






-- Adds a service receipt  
CREATE OR REPLACE PROCEDURE addService_receipt (
    _date date,
    _car_id int4,
    _customer_id int4
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO service_receipt
        ("date", car_id, customer_id)
    VALUES
        (_date, _car_id, _customer_id);
END;
$$









--- CALLING THE FUCTIONS TO FILL DATA BASE 

-- cars

CALL addCar('BMW','M4', 'rainbow', 2500);

CALL addCar('Tesla','Model 3', 'red', 2022);

--customers

CALL addCustomer('George', 'The Eagle Eye3', '123 Billionaire Lane', 123456789)

CALL addCustomer('Lucas', 'Lang', '101 Coding Lane', 123456789)

--mechanics

CALL addMechanic('Jerry', 'Springer');

CALL addMechanic('Terry', 'Thomas');

-- parts

CALL addParts('Tires')

CALL addParts('Windows')

--parts_used

CALL addParts_used (1, 123, 1 );

CALL addParts_used (2,155,1)

--receipt 

CALL addReceipt ('2022-07-19',1,1,1)

CALL addReceipt ('2021-08-22',2, 2, 2)

--salesmans 

CALL addSalesman('Mark', 'The Goat')

CALL addSalesman('Victor','TOPG')

--service 

CALL addService('Oil Change', 'An Oil Change is the act of removing the used oil in your engine and replacing it with new, clean oil. Over time, oil breaks down and gets dirty. These factors make oil much less slippery and less effective at their job of lubricating engine parts.');

CALL addService('Tire Rotation', 'Rotating the tire position')

--service-mechanic 

CALL addservicemechanic (4,1,1)

CALL addservicemechanic (5,2,1)

--service_receipt

CALL addservice_receipt ('2012-03-21', 1, 1)

CALL addservice_receipt ('2015-04-22', 2, 1)
