# Created by Sam Roach 1/20/2016

# Pull back time and current users name
command: "date +'%l:%M:%p' && finger $(whoami) | egrep -o 'Name: [a-zA-Z0-9 ]{1,}' | cut -d ':' -f 2 | xargs echo"

# Refresh every 12 Secounds
refreshFrequency: 12000

# Create some divs
render: (o) -> """
  <div class='container'>
    <div class='level2'>
      <span class='time'></span>
    </div>
    <div class='level2'>
      <span class='name'></span>
    </div>
  </div>
"""

update: (output, domEl) ->
  # Seperate both lines of output 
  rows = output.split('\n')

  # Grab only the first name
  names = rows[1].trim().split(' ')
  myname = names[0]

  # Break up time into arraw 0=Hours 1=Minutes 2=AM/PM
  times = rows[0].trim().split(':')
  hours = parseInt( times[0], 10 );

  # TODO: Clean up, but works for now
  message = 'Good night' if (times[2] == 'PM' && hours<13)
  message = 'Good evening' if (times[2] == 'PM' && hours<10)
  message = 'Good afternoon' if (times[2] == 'PM' && hours<5)
  message = 'Good afternoon' if (times[2] == 'PM' && hours==12)
  message = 'Good morning' if (times[2] == 'AM' && hours<13)
  message = 'Good night' if (times[2] == 'AM' && hours<4)
  message = 'Good night' if (times[2] == 'AM' && hours==12)

  # Show the time and welcome message
  $(domEl).find('.time').text hours + ':' + times[1]
  $(domEl).find('.name').text message + ', ' + myname + '.'

# Basic Style to center output 
style: """
  margin-top: 120px
  color: #fff
  font-family: Helvetica Neue
  width: 100%

  .level2
    padding: 0px 0px 0px 0px;
    text-align: center
    font-weight: bold
    text-shadow: 0 0 15px rgba(#000, 0.8)
    height: 230px;

  .name
    font-size: 60px

  .time
    font-size: 230px

  .container
    position: relative;
    width: 100%;

"""
