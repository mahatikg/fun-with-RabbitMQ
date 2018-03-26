

# fun-with-RabbitMQ
A first attempt at setting up a simple message broker with a basic rails application. 
This application utilizes the bunny gem and will require the user to run run a bundle install or update after pulling the repo. 

To interact with this application:
- clone this repo and cd into appForm
- Run rails s in the terminal 
- Navigate to http://localhost:3000/submissions


# Next Steps
At present this code currently is only functional from the front end. While the data is being sent to and retrieved from a cloudAMQP queue, the email element of this application is not working as expected. Therefore, below is an outline of the next few steps in the development cycle 
- debugg mailer to determine how to properly execute emailing with the appropiate data beiing recieved from the message
- refactor code 
- build out the front end to be a far more user-friendly form with more data to be captured
- deploy to heroku 

# Next Phase MVP
Ideally this entire mini project would be more elegantly build as either a python flask API and react front end. 
Being entirely unfamiliar with the AMQP messagining protocol system, I chose to use very simple RoR as I felt debugging would be the most straight forward. 
I intend to return to this application in the next few weeks to make a more comprehensive and streamlined application with a fanout exchange




