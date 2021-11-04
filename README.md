# Pewlett_Hackard_Analysis!
## Overview of the analysis
In this project we are using PostgreSQL and pgAdmin4 to analyze 6 big CSV files of Pewlett Hackard. We were provided a big sum of unfiltered data about employees, their titles, salaries, departments, department managers and each department employees. 

Those CSV files are relational, and the following diagram clearly shows their relationship.

![EmployeeDB](https://user-images.githubusercontent.com/89214854/140274349-f6557fe3-2a15-47e2-9737-a69a8756e767.png)


From those hundreds of thousands of rows of data, we are filtering out who is retiring and when. We are anticipating that the company will use this analysis in mapping out when to hire and to which department. Since they need more time to train a new department manager, we are also filtering our department manager's retirement dates.

By analyzing their data, we are also filtering out which titles are retiring and who will be eligible for mentorship program.

## Results
* Retirement titles:

  - By executing a query, we were able to filter all retirement titles of employees born between January 1, 1952, and December 31, 1995.
  - The table we created and saved as CSV got 133,776 rows, but as some employees are appearing with different titles, the number does not represent the correct number of retiring employees. We will get the actual number by finding unique titles below.
      
     ![retirement_titles](https://user-images.githubusercontent.com/89214854/140274454-e15441e5-a361-40a4-9bcf-db8e35ddd2b3.png)
 
    
* Unique titles:

  - By executing a query, we once again filtered retirement titles to find unique titles per an emp_no.
  - Our CSV table came back with 90.398 rows, and this shows the actual number of employees retiring soon.
      
      ![unique_titles](https://user-images.githubusercontent.com/89214854/140274515-57794dc3-4efa-45bf-8468-c2d1e16c6584.png)

    
* Retiring titles:

  - We also determined how many employees in each title category are retiring in the specified period.
  - Surprisingly, the largest number of retiring employees are with title of senior engineer (29,414), but only 2 managers retiring.
      
      ![retiring_titles](https://user-images.githubusercontent.com/89214854/140274590-6347f2ec-50fb-40fa-884a-1f78bc3aa082.png)


* Mentorship Eligibility:

  - In this analysis, we executed a query to filter out employees born between January 1, 1965, and December 31, 1965 (we used a data from 3 tables: employees, dep_emp and titles)
  - We were able to create a CSV table with 1,549 rows, showing the total number of employees that are eligible for mentorship program.
      
     ![mentorship_eligibilty](https://user-images.githubusercontent.com/89214854/140274636-76fd82f1-ecff-4cdb-8499-8385079b9bb1.png)
 

## Summary
   * The company is going to lose about 90,398 employees by retirement, where some high skill positions looks a large number of employees retiring. About 29,414 senior engineers are retiring and the company got a big shoe to fill.
   * There are 1,549 number of employees who can mentor the next generation of Pewlett Hackard employees. But, from our analysis we did not determine the titles of those who are eligible for mentorship, and we can't definitely say all departments will have enough mentors.

## Recommendations
   * Finally, we recommend PH to invest more in mentorship programs to fill the vacancies that are coming soon. There is a need for a special attention in looking for future vacancies that require highly skilled employees as it is always hard to find the best qualified candidate.

     
