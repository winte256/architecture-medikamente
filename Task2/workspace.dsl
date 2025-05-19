workspace {

    model {
        user = person "Patient" {
            description "Клиент медицинского центра"
        }
        receptionist = person "Receptionist" {
            description "Сотрудник ресепшена"
        }
        doctor = person "Doctor" {
            description "Медицинский специалист"
        }
        cashier = person "Cashier" {
            description "Кассир"
        }
        accountant = person "Accountant" {
            description "Бухгалтер"
        }
        warehouse = person "Warehouse Keeper" {
            description "Сотрудник склада"
        }
        admin = person "Administrator" {
            description "Системный администратор"
        }

        medSystem = softwareSystem "Medikamente Information System" {
            description "Единая система для автоматизации процессов компании"

            crm = container "CRM" {
                description "CRM для хранения и обработки данных о пациентах, записях, оплатах"
                technology "Java + PostgreSQL"
            }
            paymentGateway = container "Payment Gateway" {
                description "Платёжный шлюз для обработки платежей"
                technology "Java"
            }
            biLake = container "Data Lake" {
                description "Озеро данных для BI/ML/AI"
                technology "ClickHouse, S3"
            }
            monitoring = container "Monitoring & Audit" {
                description "Система мониторинга, аудита и алертинга"
                technology "ELK, VictoriaMetrics"
            }
            webPortal = container "Web Portal" {
                description "Веб-портал для записи пациентов и работы сотрудников"
                technology "React"
            }
            mobileApp = container "Mobile App" {
                description "Мобильное приложение для пациентов"
                technology "Flutter"
            }

            // Взаимодействия пользователей с системой
            user -> webPortal "Запись на приём, просмотр своих данных"
            user -> mobileApp "Запись на приём, просмотр своих данных"
            receptionist -> webPortal "Работа с записями пациентов"
            doctor -> webPortal "Просмотр и ведение медицинских карт"
            cashier -> webPortal "Проверка оплаты"
            accountant -> webPortal "Просмотр финансовых данных"
            warehouse -> webPortal "Учёт ТМЦ"
            webPortal -> crm "Работа с данными пациентов, запись, оплата"
            mobileApp -> crm "Работа с данными пациентов, запись, оплата"
            crm -> paymentGateway "Передача информации о платеже"
            paymentGateway -> crm "Статус оплаты"
            crm -> biLake "Передача обезличенных данных для BI/ML"
            crm -> monitoring "Логирование доступа, аудит"
            monitoring -> admin "Оповещения о несанкционированном доступе"

        
        
            labApi = container "Laboratory API" {
                description "Внешняя лаборатория для интеграции анализов"
            }
            
            crm -> labApi "Запрос/получение результатов анализов"
        }

    }

    views {
        container medSystem {
            include *
            autolayout lr
        }
        systemLandscape {
            include *
            autolayout lr
        }
    }
}
