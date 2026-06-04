# Module 2

# Zoe Rochelle
# Programming for Security Professionals
# Professor Lang
# 06/03/2026

## ToDo ##
# 1. open the file "accounts.txt"
# 2. open a file named "secure_accounts.txt" for writing your output to.
# 3. read the username / password pair on each line of the "accounts.txt" file.
# 4. 'cryptographically hash' each password using the SHA265 functions provided in Python's "hashlib" library
#  - use a 'salt' created by reversing the order of the characters in the user's username
# 5. write out to the "secure_accounts.txt" file the resulting username and SHA256 hash value pairs of credentials

import hashlib
import json

def write_to_file(file_name, mode, data = "", JSON = False):
    if JSON:
        with open(file_name, mode, encoding="utf-8") as file:
            json_obj = json.dumps(data)
            file.write(json_obj)
    else:
        with open(file_name, mode, encoding="utf-8") as file:
            file.write(data)

def read_file(file_name, JSON = False):
    if JSON:
        with open(file_name, "r", encoding="utf-8") as file:
            json_str = json.loads(file.read())
            return json_str

    with open(file_name, "r", encoding="utf-8") as file:
        return file.read()


def setup():

    ## create_accounts_file
    data = (
        "administrator    admin\n"
        "helpdesk         pa$$word\n"
        "test             test\n"
        "cypherpunk       cypherpunk\n"
        "caesar           julius\n"
        "trithemius       polymath\n"
        "vigenere         blase"
    )
    write_to_file("accounts.txt", "w", data)

    ## create empty secure_accounts file
    write_to_file("secure_accounts.txt", "w", '[]')


def get_hash(user_str, pw_str):

    ## create salt by reversing the user name
    salt_str = user_str[::-1]

    ## convert the strings to bytes, we can only hash bytes
    salt_bytes = salt_str.encode('utf-8')
    pw_bytes = pw_str.encode('utf-8')

    ## object location
    pw_hash = hashlib.sha256(salt_bytes + pw_bytes)

    ## object contents - converts the binary to a hex-string
    pw_hex = pw_hash.hexdigest()

    ## return the salt and the pw in hexidecimal
    return salt_bytes.hex(), pw_hex


## we can simulate a verification, like loging into a website, by checking an input against a stored user/pw
## by running the hash function again, we should get the same result
def simulate_verification(attempted_user, attempted_pw):

    attempted_credentials = get_hash(attempted_user, attempted_pw)
    
    json_obj_lst = read_file("secure_accounts.txt", JSON = True)

    ## if the user exists, then try to match the password
    for account in json_obj_lst:
        if attempted_user == account["user"]:
            if account["pw"] == attempted_credentials[1]:
                print(f"Successful Login: {attempted_user}")
                return

    print("Username not found or Password incorrect")


if __name__ == "__main__":

    print("running...")

    setup()

    ## retrieve the file
    accounts = read_file("accounts.txt")
    accounts_dict = {}

    ## organize the accounts into a dict
    for line in accounts.splitlines():
        user, pw = line.split()
        accounts_dict[user] = pw

    ## for each user and password
    ## convert and store
    for user in accounts_dict.keys():
        pw = accounts_dict[user]

        salt_hex, pw_hex = get_hash(user, pw)

        ## open the secure accounts file
        json_obj = read_file("secure_accounts.txt", JSON = True)

        ## append the newly secured user and password
        json_obj.append({"user": user, "pw": pw_hex, "salt": salt_hex})

        ## write out to file
        write_to_file("secure_accounts.txt", "w", json_obj, JSON = True)

    print("complete\n")

    ## should fail
    simulate_verification("helpdesk", "blah")

    ## should succeed
    simulate_verification("trithemius", "polymath")
