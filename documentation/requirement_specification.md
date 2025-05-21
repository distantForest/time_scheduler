# Requirement Specification with RTM
The purpose of this project is to create a complete component that manages the execution of functions (implemented as standard C-functions) according to a predefined time schedule. The component is referred as Time Scheduler component in the project.

## Functional Requirements

### 1. Component Functionality

**1.1 The component shall repeatedly execute a predefined C-function at a predetermined time interval, referred to as a period.**  
- **Acceptance Criteria**: The C-function should execute every X milliseconds without failure.  
- **Verification**: Unit Test  
- **Status**: Completed
  

**1.2 Each C-function managed by the component shall be linked to a specific time period. The C-function is referred to as a period function.**  
- **Acceptance Criteria**: The system correctly maps functions to specific periods in configuration.  
- **Verification**: Configuration Validation, Functional Test  
- **Status**: Completedd  

**1.3 In case of overlap, the scheduler shall prioritize period functions based on predefined priorities.**  
- **Acceptance Criteria**: The scheduler correctly handles overlaps and executes functions in the correct order.  
- **Verification**: Functional Test, Scheduler Test  
- **Status**: Completed  

**1.4 If a period function’s execution exceeds its assigned period length:**  
  - **1.4.1 The function shall be allowed to complete.**  
  - **1.4.2 The next execution shall start at the subsequent period.**  
  - **1.4.3 Such cases shall be logged as period misses.**  
- **Acceptance Criteria**: Function completes before the next execution cycle begins.  
- **Verification**: Timing Test, System Test  
- **Status**: Completed  

### 2. Integration and Configuration

**2.1 The component shall interface with a Nios® II processor via Avalon® interfaces.**  
- **Acceptance Criteria**: Avalon interface correctly handles data exchange with the Nios II processor.  
- **Verification**: Hardware Interface Test  
- **Status**: Completed  

**2.2 The component shall allow configuration of the following parameters in Quartus Platform Designer:**  
  - **2.2.1 The number of periods the component will handle.**  
  - **2.2.2 The priority for each period.**  
  - **2.2.3 The time interval for each period.**  
- **Acceptance Criteria**: All configuration parameters can be set via Quartus Platform Designer.  
- **Verification**: Configuration Test  
- **Status**: Completed  

## Documentation requirements.

### 1. All component documentation should be managed in Github.

**1.1 The documentation shall be formatted in markup language Markdown.**

**1.2 A structured standard report shall be created in MS Word document format docx.**
- **1.2.1 The name of the report Igor_Parchakov_exjobb_B.docx**
- **1.2.2 Max 30 pages.**



## Delivery requirements.


---

## Requirements Traceability Matrix (RTM)

| Requirement ID | Description                                                                           | Status      | Verification Method     | Test Results | PR Links |
|----------------|---------------------------------------------------------------------------------------|-------------|-------------------------|--------------|----------|
| 1.1            | The component shall repeatedly execute a C-function at a predetermined time interval. | Not Started | Unit Test               | Pending      | #20      |
| 1.2            | Each C-function shall be linked to a specific time period.                            | Not Started | Functional Test         | Pending      | #21      |
| 1.3            | Scheduler prioritizes period functions based on predefined priorities.                | Not Started | Functional Test         | Pending       | #22      |
| 1.4.1          | Function shall complete even if it exceeds the period length.                         | Not Started | Timing Test             | Pending       | #23      |
| 2.1            | The component shall interface with a Nios II processor via Avalon interfaces.         | Not Started | Hardware Interface Test | Pending       | #24      |
| 2.2.1          | The number of periods the component will handle must be configurable.                 | Not Started | Configuration Test      | Pending      | #25      |

---
