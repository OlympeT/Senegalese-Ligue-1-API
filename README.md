## Senegalese Ligue 1 Championship via API

# Introduction
Get information from the Senegalese championship

# Overview
Things that the developers should know about

# Authentication
No authentication needed

# Error Codes
User can expect error with malformed request

# Rate limit
No limit of requests

# Get calendar & scores of games of the last championship
```
/api/v1/calendar
```

# Get all the teams
```
/api/v1/teams
```

# Get the ranking of the last championship
```
/api/v1/ranking
``` 
# Get deatails of a team by id
```
/api/v1/team/:id
``` 

## Installation Hints

The easiest way is to use bundler to install the dependencies. To do so, you need to install the bundler gem if you haven't already done so

    gem install bundler

run bundler

    bundle

setup assets dependencies
    `yarn install`
    
setup database

    config/database.yml 
    
    rake db:create
    
    rake db:migrate
    
    rake db:seed
    
add object to database

    root_url/admin-foot
    login : otchibozo@gmail.com
    password : passer23
 
 # Admin possible action

 - Create manager  
 - Create a championship
 - Create teams
 - Generate the math calendar
 - Then proceed to update the score