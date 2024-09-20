# WindowsAPI-Hashing-Calculator

Calculate-ApiHash Function: This function takes the name of the API and calculates its hash by applying the given formula. The final hash value is returned for later use.

Check-HashCollision Function: This function checks if a hash has already been calculated for another API. If a collision is found (i.e. the same hash is already associated with another API name), a red alert message will be displayed.

Multiple API Input: The $APIsToHash variable contains a list of APIs that you want to hash. You can add or remove names as needed.

Collision Detection: For each API, the script calculates the hash and checks whether that hash has already been assigned to another API in the table. If a collision is detected, the script will inform you.
