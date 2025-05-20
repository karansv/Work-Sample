This folder conatain the test scripts developed using Selenium Webdriver which performs automation of opensource banking site 'Parabank'. 
Here I have followed two methodolagies to perform the automation.
  1. Using a single testscript file which contains the complete code for all the test cases. Not suitable for realtime projects.
  2. Using a structured folder which is widely used on realtime projects. 
        i) This uses a master script file which calls keywords for all the test cases. 
       ii) Each test case will have its own script stored as keyword. These Keyword files are directly called in master script.
      iii) Use of this structured format will help developers to update the script easily and different developers can work on 
           different scripts parallelly and commit changes to script which will save time for deployment.
