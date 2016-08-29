# Quiz
This project is a simple demonstration of how to build a quiz game in for iOS in Objective-C restoring the previous session even if the app is closed. This way the user can't spend more than "maximum time" to make the Quiz, and can't response again the same question.

Notes:

    - I am not hundred percent happy with my solution, since it is implemented to just support a Quiz, but the task specifications didn't require to support multiple quizs. 
    If we needed to handle multiple quizs my approach would be completely different: I would use Core Data to store multiple quizs, and I would show a first view controller with a table view to select which one to do. The table in the database would contain the quiz's questions (parsed from the json file), and information about the user responses and start date, instead of using NSUserDefaults.
    Since the task specifications required a single Quiz, it doesn't make sense to use a database system storing a couple of properties, instead, we can use NSUserDefaults (or NSCoder) and keep the session information stored on it.

    - I used Cocoapods in order to add external libraries. One of the libraries is really useful for asynchronous downloads, perfect for setting the image on a cell. The library handles the indexpath of the collections/tables in order to optimize the download and set the proper image on the proper cell.
    There is a second library imported, which offers support for blocks on UIAlertViews, not that useful but practical sometimes.
    There is no need for running 'pod install', since the libraries are added to the repository.

    - Specifications required to allow a user to do it just once, so we also want to avoid the user from cheating by closing the app before finishing and starting again. 
    For doing so, we save the last session state when closing the app, and we restore when opening it back, including the count down. So, if the user started more than 2 min ago and tries to come back, the timer will be out. I chosed this option instead of stopping the timer since the user can also cheat by closing the app for every question in order to look for help and come back to the app once has found the response, so the timer shouldn't' stop once started.

    - There is a button * only on development builds * for restarting a quiz. The button with the functionality is hidden for production.

    -  I didn't focus on UI or UX, since that's something it should be defined by a UI/UX expert and I would implement his/her designs. I just focused on the implementation of the requirements. 