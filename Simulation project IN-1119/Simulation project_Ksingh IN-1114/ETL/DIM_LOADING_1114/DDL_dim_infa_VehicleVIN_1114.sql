use [Target_OCT19_KSingh]

drop table dim_infa_vehiclevin
CREATE TABLE dim_infa_vehiclevin(
	vehicle_key	int	Primary Key,
	[VehicleVINID] [float] ,
	[VehicleVIN] [nvarchar](255) ,
	[VehicleModelCode] [nvarchar](255) ,
	[VehicleModel] [nvarchar](255) ,
	[ModelCategory] [nvarchar](255) ,
	[ModelYear] [float] ,
	[DriveOrientation] [nvarchar](255) ,
	[Actualdeliveryeddate] [nvarchar](255) ,
	[Enabled] [float] ,
	[NearestServiceLocationID] [float] ,
	[FactoryGateDate] [nvarchar](255),
	[VehicleColor] [nvarchar](255) ,
	[VehicleTitle] [nvarchar](255) ,
	[LastOdometer] [float] ,
	[InventoryVehicle] [float] ,
	[NewUsed] [nvarchar](255) ,
	[Market] [nvarchar](255) ,
	[DeliveryRegion] [nvarchar](255) ,
	[OdometerType] [nvarchar](255) ,
	V_Start_date datetime,
	V_End_date datetime,
	DW_CREATED_DATE	date						DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)				Default suser_sname(),
	DW_UPDATED_DATE	date						DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)				Default suser_sname()
)
