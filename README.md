# Downlink
A sample site for CraftQuest's course _Flexible Twig Templates with Craft_.

## Installation

Before following along with the course, you need to make sure you have the sample site running locally. Here are the steps:

1. Clone the repository locally. 
    ```bash
    git clone git@github.com:CraftQuest/downlink.git
    ```
2. In the project root, install the dependencies with Composer. 
    ```bash
    composer install
    ```
3. Create an `.env` file based on the `.env.example` file. 
    ```bash
    cp .env.example .env
    ```
4. Set up your localhosting to run the site. This will depend on what you use but the instructions below are for [Craft Nitro 2](https://getnitro.sh).
    ```bash
    nitro add
   ```
    Follow the prompts to setup the site. You'll want to use a database and a current version of PHP. This site runs Craft 3.6+.
5. Import the starter database
    ```bash
   nitro db import db/downlink--2021-03-02-200340--v3.6.7.sql
   ```
6. Check that the site is running at the hostname you specified when setting up Nitro.
   
## Control Panel

To access the Control Panel, visit [yourhostname]/admin.
* Username: admin
* Password: password
 
## Resources
