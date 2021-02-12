# Ryan McGregor Project 1 - Apple  Incorporated Database System

## Project Description

The goal of this project was to design a Database Management system that reflects the Apple production chain. The project also had to be able to track an Apple product through out the production chain and each product had to have it's own "Product History". 

## Technologies Used

* T-SQL
* SQL

## Features

### Ready
* Easy to use T-SQL Procedures.
* Create a number of Apple Products at a given Production Houses.
* Show matching Production Houses,WareHouses,Distributors,Sub-Distribtors, etc.
* Move Products down the Production Chain.
* Time stamp functionality.
* Check Product History.
* Send Product back through Production Chain.
* Able to purchase a product.

### To be added later
* Creating a number of different Apple Products at the same time.
* Adding more data to the database.
* Indexes to improve query performance.
* Adding a Customer table to keep track of different Customers.
* Incorporating SSIS to allow data to come from external files.

## Usage
To test out the project yourself, follow the steps below.

### Clone the repository
Click the green code button next to the add file button. Make sure you are under the "HTTPS" tab and click on the clipboard on the right of the link to the repository.

![Screenshot](Pics\GitClone.png)

After you have copied the link, open Command Prompt and traverse to the directory you wish to use the repository in. Type in Git Clone [Link] into the command prompt.

### Using the AppleInc database backup file.
Open File Explorer on your computer and go to where you cloned the repository on your computer and extract the files from the AppleInc zip file. This is where the AppleInc Database backup file is.

Open another File Explorer window and navigate to the Microsoft SQL Server folder. You're going to be navigating through the directory to find the Bckup folder for your database instance. Open the Database instance folder that you wish to use. Then open the MSSQL Folder. Finally open the Backup Folder.

Copy the .bak folder from the cloned repository and paste it into the Backup folder you just navigated to.

Close both File Explorer windows.

Open up Microsoft SQL Server Management Studio and for the server type use Database Engine. Enter your database name and choose your choice of authentication.

Once logged into your server instance, right click on the Databases folder in the Object Explorer pane. Click on Restore Database.

In the Restore Database window under the Source section, click the Device radio button and press the button on the right. This will open the Select Backup Devices window.

In the Select Backup Devices window, click on the add button. This takes you to the Backup folder in your database.

Locate the AppleInc.bak file,select it, and press ok in the Locate Backup File window.

Press ok in the Select Backup Devices Window.

Make sure the database properly restores and then click ok in the Restore Database Window.







