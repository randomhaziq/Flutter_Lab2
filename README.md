Setup STEPS:

      1. Download the zip files into your local computer.
      2. Extract the Flutter_Lab2-main.zip fil and open the pawpal folder in IDE (vs code).
      3. Extract the pawpalHtdocs.zip and move the pawpal folder in this zip file into xampp/htdocs.
      4. Copy your ip address and put it in pawpal/lib/myconfig.dart.
      5. Make sure your Xampp or other is working and running.
      6. Create database of pawpal_db then import pawpal_db.sql file to create the tbl_users and tbl_pets.
      7. Use flutter pub get commands in the terminal to install dependencies.
      8. Run application in full screen.

API explainations:

      * submit_pet.php (add pets data)
        - receives pet data (pet name, type, category...)   
        - saves images (maximum of 3 per pet)
        - upload them into the database

      * get_my_pets.php (retrieve pets from database)
        - retrieve all pet listings from all users in the database
        - the information is used for to be display as a pet card (ListTile)

Sample JSON:

      { 
        'status' => 'success', 
        'message' => 'Pet submitted successfully', 
        'pet_id' => $pet_id
      }

      {
        'status' => 'failed', 
        'message' => 'Pet not added: ' . $conn->error
      }

      {
        'status' => 'failed',
        'message' => 'Invalid request'
      }

Screenshots:

  <img width="1919" height="916" alt="image" src="https://github.com/user-attachments/assets/db4b7484-4152-4b8f-b6a6-137fe4cc2f7d" />
  <img width="1919" height="910" alt="image" src="https://github.com/user-attachments/assets/516149cf-3eba-48a0-bc72-6099af150020" />
  <img width="1919" height="914" alt="image" src="https://github.com/user-attachments/assets/e0d3f797-e664-4142-b8a8-9697ae8cb731" />
  <img width="1919" height="910" alt="image" src="https://github.com/user-attachments/assets/17eae3b0-aee7-4f50-8549-5aa6fccd58dd" />



