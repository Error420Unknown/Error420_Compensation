CREATE TABLE IF NOT EXISTS `compensation_codes` (
   id INT AUTO_INCREMENT PRIMARY KEY,
   code VARCHAR(50) NOT NULL,
   type VARCHAR(20) NOT NULL,
   item VARCHAR(50) NULL,
   amount INT NULL,
   vehicle_model VARCHAR(50) NULL,
   vehicle_plate VARCHAR(20) NULL,
   vehicle_mods TEXT NULL,
   created_by VARCHAR(50) NOT NULL,
   claimed_by VARCHAR(50) NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);