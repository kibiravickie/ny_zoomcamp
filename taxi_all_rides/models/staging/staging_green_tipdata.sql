{{config(materialized='view')}}

select 

--identifiers
{{dbt_utils.surrogate_key(['"VendorID"','lpep_pickup_datetime'])}} as tripid,
cast("VendorID" as integer) as VendorID,
cast("RatecodeID" as integer) as RatecodeID,
cast("PULocationID" as integer ) as pickup_locationid,
cast("DOLocationID" as integer) as dropoff_locationid,

--timestamps
cast("lpep_pickup_datetime" as timestamp) as pickup_datetime,
cast("lpep_dropoff_datetime" as timestamp) as dropoff_datetime,

--tripinfo
cast("passenger_count" as integer) as passenger_count,
cast("trip_distance" as numeric) as trip_distance,
cast("trip_type" as integer) as trip_type,

--paymentinfo
cast("fare_amount" as numeric) as fare_amount,
cast("extra" as numeric) as extra,
cast("tip_amount" as numeric) as tip_amount,
cast("tolls_amount" as numeric) as tolls_amount,
cast("ehail_fee" as integer) as ehail_Fee,
cast("improvement_surcharge" as numeric) as improvement_surcharge,
cast("total_amount" as numeric) as total_amount,
cast("payment_type" as integer) as payment_type,

{{get_payment_type_description('payment_type')}} as payment_type_description,

cast("congestion_surcharge" as numeric) as congestion_surcharge

from {{source('staging', 'green_trips_data')}}
where "VendorID" is not null

{% if var('is_test_run', default=true)%}
   
   limit 100

{% endif %}
