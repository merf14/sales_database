-- Триггер на добавление пользователя. Проверяет правильность заполнения данных.

CREATE OR REPLACE FUNCTION add_customer()
RETURNS TRIGGER AS 
$$
BEGIN
	IF NEW.customer_id IS NULL THEN
    	RAISE EXCEPTION 'id cannot be null';
    END IF;
	IF NEW.name IS NULL THEN
    	NEW.name='Guest';
    END IF;
	IF char_length(NEW.name)<3 THEN
    	RAISE EXCEPTION 'name must have 3 letters or more';
    END IF;
	IF NEW.name NOT SIMILAR TO '([A-Z])%' THEN
		RAISE EXCEPTION 'name must begin with capital letter';
	END IF;
	IF NEW.name NOT SIMILAR TO '([A-Z])([a-z]{2,})' THEN
		RAISE EXCEPTION 'name must contain only letters';
	END IF;
	IF NEW.address IS NULL THEN
    	RAISE EXCEPTION 'address cannot be null';
    END IF;
	IF NEW.phone_number IS NULL THEN
    	RAISE EXCEPTION 'phone number cannot be null';
    END IF;
	IF NEW.phone_number NOT SIMILAR TO '+([0-9]{10,15})' THEN
    	RAISE EXCEPTION 'phone number does not match e164 format';
    END IF;
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER customer_update
	AFTER INSERT ON Customers
	FOR EACH ROW
	EXECUTE FUNCTION add_customer();


