
CREATE TABLE [customer] (
	[customer_id] INT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255),
	[email] NVARCHAR(255),
	[national_id] INT,
	[address] NVARCHAR(255),
	[phone] INT,
	PRIMARY KEY([customer_id])
);
GO

CREATE TABLE [product] (
	[product_id] INT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255),
	[price] NUMERIC,
	[stockQ] INT,
	PRIMARY KEY([product_id])
);
GO

CREATE TABLE [order] (
	[order_id] INT NOT NULL IDENTITY UNIQUE,
	[order_date] DATETIME,
	[customer_id] INT,
	[total_amount] INT,
	[status] NVARCHAR(255),
	PRIMARY KEY([order_id])
);
GO

CREATE TABLE [order_item] (
	[orderitem_id] INT NOT NULL IDENTITY UNIQUE,
	[quantity] NUMERIC,
	[product_id] INT,
	[order_id] INT,
	PRIMARY KEY([orderitem_id])
);
GO

CREATE TABLE [payment] (
	[payment_id] INT NOT NULL IDENTITY UNIQUE,
	[amount] NUMERIC,
	[payment_date] NVARCHAR(255),
	[status] NVARCHAR(255),
	[customer_id] INT,
	[order_id] INT,
	PRIMARY KEY([payment_id])
);
GO

ALTER TABLE [payment]
ADD FOREIGN KEY([customer_id]) REFERENCES [customer]([customer_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [order]
ADD FOREIGN KEY([customer_id]) REFERENCES [customer]([customer_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [order_item]
ADD FOREIGN KEY([order_id]) REFERENCES [order]([order_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [order_item]
ADD FOREIGN KEY([product_id]) REFERENCES [product]([product_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [payment]
ADD FOREIGN KEY([order_id]) REFERENCES [order]([order_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO