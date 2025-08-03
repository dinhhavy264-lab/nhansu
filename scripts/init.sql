IF DB_ID('quanlynhansu') IS NULL
    CREATE DATABASE quanlynhansu;
GO

USE quanlynhansu;
GO

CREATE TABLE departments (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL UNIQUE,
    description NVARCHAR(500),
    location NVARCHAR(100),
    manager_id BIGINT NULL -- để định nghĩa trước cho bước sau
);
GO

CREATE TABLE employees (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(255) NOT NULL,
    last_name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    phone NVARCHAR(255) NOT NULL,
    salary DECIMAL(15,2) NOT NULL CHECK (salary > 0),
    hire_date DATE NOT NULL,
    position NVARCHAR(255),
    department_id BIGINT NOT NULL,
    status NVARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE', 'INACTIVE', 'TERMINATED')),
    CONSTRAINT fk_employee_department FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE CASCADE
);
GO

-- Thêm ràng buộc sau khi tạo xong bảng
ALTER TABLE departments
ADD CONSTRAINT fk_department_manager FOREIGN KEY (manager_id)
    REFERENCES employees(id);
GO

INSERT INTO departments (name, description, location)
VALUES 
    (N'Phòng Nhân sự', N'Quản lý thông tin nhân viên và tuyển dụng', N'Tầng 1'),
    (N'Phòng IT', N'Phát triển và bảo trì hệ thống phần mềm', N'Tầng 2'),
    (N'Phòng Kế toán', N'Quản lý tài chính và báo cáo', N'Tầng 3');
GO

INSERT INTO employees (
    first_name, last_name, email, phone, salary,
    hire_date, position, department_id, status
)
VALUES
    (N'Nguyễn', N'Văn A', 'a.nguyen@example.com', '0123456789', 12000000, '2022-01-10', N'Nhân viên HR', 1, 'ACTIVE'),
    (N'Trần', N'Thị B', 'b.tran@example.com', '0987654321', 20000000, '2021-09-15', N'Quản lý IT', 2, 'ACTIVE'),
    (N'Lê', N'Văn C', 'c.le@example.com', '0911122233', 15000000, '2023-03-20', N'Kế toán viên', 3, 'ACTIVE');
GO
