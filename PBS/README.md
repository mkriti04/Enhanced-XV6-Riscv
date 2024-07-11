### OSN Monsoon 2023 mini project 3
### xv6 revisited and concurrency

## 1. Modified Priority Based Scheduler in xv-6.
# Key Components:
   - I assumed that highest number of times which is scheduled will be done further when dynamic priority is same.
   - My code is passing for all the usertests(except manywrites, commented the manywrites test code).
   - For preemption considered yiled.
i. **Relative Burst Index (RBI):**
   - RBI is calculated based on the formula `(3 * rtime - stime - wtime) * 50 / (rtime + wtime + stime + 1)`.
   - It is used as a metric to determine the priority of a process.

ii. **Static Priority (SP):**
   - Each process has a static priority (`staticpriority`).
   - The dynamic priority (`dynamic_priority`) is calculated as the minimum of `staticpriority + rbi` and 100.

iii. **Scheduler (`scheduler` function):**
   - The scheduler iterates through all processes, calculates RBI, updates dynamic priorities, and selects the process with the highest dynamic priority.
   - It considers additional criteria (number of times scheduled and creation time) to break ties.

iv. **`update_time` Function:**
   - This function is responsible for updating the runtime, waiting time, and sleeping time for each process.

v. **`set_priority` System Call:**
   - A system call to set the static priority of a process. It also updates RBI and may yield the CPU if the priority is increased.

# Analysis:

i. **RBI and Dynamic Priority:**
   - RBI takes into account the runtime, waiting time, and sleeping time of a process. This provides a more comprehensive metric for dynamically adjusting priorities based on recent behavior.
   - The dynamic priority, calculated as the minimum of `staticpriority + rbi` and 100, ensures that priorities do not exceed 100.

ii. **Scheduler Effectiveness:**
   - The scheduler selects the process with the highest dynamic priority, considering additional factors to break ties. This approach aims to balance fairness and responsiveness.
   - The scheduler may lead to a more equitable distribution of CPU time among processes by considering both static and dynamic factors.

iii. **`update_time` Function:**
   - The function ensures that the runtime, waiting time, and sleeping time are continuously updated for each process. This information is crucial for the accurate calculation of RBI and dynamic priority.

iv. **`set_priority` System Call:**
   - The system call allows for the manual adjustment of a process's static priority. If the new priority is higher than the current one, it may trigger a yield to ensure that higher-priority processes get a chance to execute.

# Conclusion:

The combination of static priority and RBI in the dynamic priority calculation, along with the scheduler's tie-breaking mechanisms, provides a balanced approach to process scheduling. The system seems designed to adapt to changing process behavior and respond to explicit user instructions through the `set_priority` system call. The continuous update of time-related metrics ensures that the scheduler has accurate information to make informed decisions. The effectiveness of this scheduling algorithm depends on the specific workload and requirements of the operating system.

