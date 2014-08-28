# WARNING

This app was born from a hackfest, so basically any bad practice
that can be done in code was 100% done. Proceed at your own risk. 

## Harvest username and passwords

Currently the app takes you harvest credentials. The credentials are
encrypted with a salt, but whoever has access to the salt can decrypt it.
How much do you trust me?

# Running the app

`rails s`

# Limitations

Some of these limitations make the app suck, but it's not something that
I really spent a hole lot of time on.

* It only works with Pivotal Tracker at this point (since it was written in Dec '13)
* Only stories that were started, finished, or where a task was completed will show up.
  * You cannot enter time for a day that doesn't have any stories that show up.
  * You cannot view hours and notes entered in harvest for a day that does
    not have any tracker stories that show up.
* You can only view the current billing period, so if you want to
  enter time for the last day of the period, but a day later, your SOL.
