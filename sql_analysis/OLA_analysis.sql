-- Database: MySQL
-- 
-- 1. DATA OVERVIEW & VALIDATION
-- ====================================================
-- Purpose:
-- These queries help in understanding the basic structure
-- and quality of the data before performing deeper analysis.
-- ====================================================

-- Retrieve all successful bookings

CREATE VIEW successful_bookings AS
SELECT *
FROM bookings
WHERE Booking_Status = 'Success';


-- Total number of cancelled rides by customers

CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT(*) AS total_cancelled_by_customers
FROM bookings
WHERE Booking_Status = 'cancelled by Customer';


-- Total number of cancelled rides by drivers

CREATE VIEW cancelled_rides_by_drivers AS
SELECT COUNT(*) AS total_cancelled_by_drivers
FROM bookings
WHERE Booking_Status = 'cancelled by Driver';


-- List all incomplete rides with reasons

CREATE VIEW incomplete_rides_details AS
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes';


-- ====================================================
-- 2. EXPLORATORY ANALYSIS
-- ====================================================
-- Purpose:
-- These queries explore patterns related to vehicle types,
-- ride distance, and customer ratings.
-- ====================================================

-- Average ride distance for each vehicle type

CREATE VIEW avg_ride_distance_by_vehicle AS
SELECT Vehicle_Type, AVG(Ride_Distance) AS avg_ride_distance
FROM bookings
GROUP BY Vehicle_Type;


-- Average customer rating for each vehicle type

CREATE VIEW avg_customer_rating_by_vehicle AS
SELECT Vehicle_Type, AVG(Customer_Rating) AS avg_customer_rating
FROM bookings
GROUP BY Vehicle_Type;


-- Maximum and minimum driver ratings for Prime Sedan rides

CREATE VIEW prime_sedan_driver_ratings AS
SELECT 
    MAX(Driver_Ratings) AS max_driver_rating,
    MIN(Driver_Ratings) AS min_driver_rating
FROM bookings
WHERE Vehicle_Type = 'Prime Sedan';


-- Retrieve all rides paid using UPI

CREATE VIEW upi_payment_rides AS
SELECT *
FROM bookings
WHERE Payment_Method = 'UPI';


-- ====================================================
-- 3. BUSINESS QUERIES & INSIGHTS
-- ====================================================
-- Purpose:
-- These queries answer business-focused questions related
-- to revenue generation, high-value customers, and operational
-- issues.
-- ====================================================

-- Total booking value of successfully completed rides

CREATE VIEW total_successful_booking_value AS
SELECT SUM(Booking_Value) AS total_revenue
FROM bookings
WHERE Booking_Status = 'Success';


-- Top 5 customers by number of rides

CREATE VIEW top_5_customers_by_rides AS
SELECT Customer_ID, COUNT(Booking_ID) AS total_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC
LIMIT 5;


-- Number of rides cancelled by drivers due to personal or car-related issues

CREATE VIEW driver_cancellations_personal_issues AS
SELECT COUNT(*) AS total_driver_cancellations
FROM bookings
WHERE Cancelled_Rides_by_Driver = 'Personal & Car related issue';


-- ====================================================
