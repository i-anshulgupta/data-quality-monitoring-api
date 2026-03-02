CREATE TABLE validation_rules (
    rule_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    column_name VARCHAR(100) NULL,
    rule_type VARCHAR(50) NOT NULL,
    threshold_value DECIMAL(15,4) NULL,
    comparison_operator varchar(5) NULL,
    custom_query TEXT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  
	INDEX idx_table_name (table_name)
);



CREATE TABLE validation_jobs (
    job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    job_status varchar(20) DEFAULT 'PENDING',
    total_rules INT DEFAULT 0,
    passed_rules INT DEFAULT 0,
    failed_rules INT DEFAULT 0,
    start_time TIMESTAMP NULL,
    end_time TIMESTAMP NULL,
    error_message TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE validation_results (
    result_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    job_id BIGINT NOT NULL,
    rule_id BIGINT NOT NULL,
    execution_status CHAR(4) NOT NULL,
    actual_value DECIMAL(20,6) NULL,
    threshold_value DECIMAL(20,6) NULL,
    comparison_operator VARCHAR(5) NULL,
    execution_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    failure_reason TEXT NULL,
    FOREIGN KEY (job_id) REFERENCES validation_jobs(job_id),
    FOREIGN KEY (rule_id) REFERENCES validation_rules(rule_id)
);