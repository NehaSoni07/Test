DROP VIEW IF EXISTS vw_ingredient_curr_state;
CREATE VIEW vw_ingredient_curr_state 
AS 
  SELECT id_ingredient, 
         ingredient_name, 
         price, 
         time_stamp, 
         deleted 
  FROM   (SELECT id_ingredient, 
                 ingredient_name, 
                 price, 
                 time_stamp, 
                 deleted, 
                 Row_number() 
                   OVER( 
                     PARTITION BY ingredient_name 
                     ORDER BY time_stamp DESC) rtc 
          FROM   ingredients 
          WHERE  deleted = 0) temp 
  WHERE  rtc = 1 
  ORDER BY ingredient_name
