# openCX-powerrangers Development Report

Welcome to the documentation pages of the Mingler of **openCX**!

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

Bernardo Moreira

Eduardo Campos

Miguel Gomes

Nuno Santos

Pedro Azevedo

---
## Product Vision

In a world where technology evolves much faster than a decade ago, people feel the urge to evolve with it. As this happens, the amount of information available grows much faster than the ways to get it. People found that each gathering participants is a port of data.  Our purpose is to diminish the obstacles in this and help that happen. “If you have knowledge, let others light their candles in it.” -Margaret Fuller

Mingler is an application that aims to promote and facilitate the interaction between individuals attending a conference, mainly when these have common interests. Hence, we aim to create a whole new dimension to social interaction within conferences.

Mingler makes attending a conference alone more satisfying and networking a less awkward and formal experience.

Users create an account and choose their personal interests from those addressed at the conference. Mingler will generate matches during the length of the conference based on the user’s interests and proximity, therefore it will provide peer-to-peer interactions surpassing the usual problem of not being able to interact with large groups or in the midst of a large and busy environment.

---
## Elevator Pitch

Where does one promote the best companies and ideas? At conferences.

Why do people go to conferences instead of reading about them online? To meet people.

And what’s the main problem with conferences? Participants rarely interact with others with the same interests as theirs.
This is where Mingler comes to play. Mingler solves all these problems and guarantees you get exactly what you want out of the conference.


Scratch your tingle, get ready to mingle!
-Mingler, 2019

---
## Requirements

### Use Case Diagram

![alt text](https://github.com/softeng-feup/open-cx-powerrangers/blob/master/docs/img/use_case_diagram.png)

#### Create account use case:

* **Actor**: Attendee (since the conference staff can also use the app like a normal user, the actor 'Conference Staff' inherits from the'Atendee').
* **Description**: In order to use the app, all users must create an account before setting up a personal profile and adhering to any conference. This process consists simply on choosing an account name and e-mail for future logins and filling in personal information such as name, age, sex.
* **Preconditions and Postconditions**: The only precondition is to have the app downloaded and installed on the device. Since this use case assumes the user has no account prior to this step, the program is left in a state where it requires to user to create a personal profile.
* **Normal Flow**: 
  * User provides a username;
  * User provides a valid e-mail (i.e. must comply with the format email@example.com);
  * User inputs their full name, using only letters (A-Z, a-z);
  * User chooses their sex (male or female);
  * User inputs their age;
  * User presses a button the create the account with the suplied information.
* **Alternative Flows and Exceptions**: While the username can have almost every format, the user's full name and e-mail must adhere to the above mentioned conditions. If this isn't the case, then the system will inform the user and grey-out the 'Create' button until the errors are fixed.

#### Create profile use case:

* **Actor**: Attendee.
* **Description**: The user is now asked to create a profile for its account, persistent for all conferences. With this profile, other users are capable of identifying this user.
* **Preconditions and Postconditions**: As a precondition, the user must have already created an account. Afterwards, the app can now be used normally by the user.
* **Normal Flow**: 
  * User selects a profile picture, by which he/she will later be identified;
  * User selects a few personal (with a maximum of three), non-professional interests, for example, cooking, soccer, etc;
  * User inputs a small bio about themselves to provides some context;
  * User can choose to have all the above information, apart from the profile picture, public or private;
  * User presses the button to confirm and create the profile.
* **Alternative Flows and Exceptions**: The filling-in of the field 'Bio' and the number of interests chosen is optional, therefore, these steps are not mandatory to fufilling this task.

#### Select interests use case:

* **Actor**: Attendee.
* **Description**: When selecting to attend any given conference, the user must choose a few interests from a predefined pool, related to the conference, in order to provide a basis for how the matches are created. These interests are different from the profile-defined ones because they are only defined for each conference in particular. We call these 'professional interests'.
* **Preconditions and Postconditions**: As preconditions, the user must have a correctly setup a user account and profile and must have opted-in into participating in the conference in question. The user can also opt-in and out of having the system activelly looking for possible matches. If the user opts-out of this, the system is left in a state where nothing really happens until/if the user decides to opt-in into the matchmaking process.
* **Normal Flow**: 
  * User searches for the desired conferences from the in-app registred ones;
  * User joins the desired conference;
  * User is taken to a screen and is asked to select between three to five interests from the availiable pool;
  * User confirms his/hers choices;
  * User defines whether or not he wants to be included in the matchmaking process;
* **Alternative Flows and Exceptions**: This process is only successfully completed after the user chooses the minimum required of three interests.

#### Accept matches use case:

* **Actor**: Attendee.
* **Description**: Having completed the previous steps successfully, and having opted-in into the matchmaking, the system will begin trying to match the conference's users based on both proximity, their personal and professional interests, the latter having a bigger influence on the outcome.
* **Preconditions and Postconditions**: The user must have adhered to the conference in question, filled in the necessary interests and opted-in to the matchmaking process. Having accepted a match, the user must now look for their 'partner' in the real-world, and is given access to the other's profile information to ease this process. 
* **Normal Flow**: 
  * A notification is sent to the user's device;
  * The user is shown a screen showing the other user's profile picture and match rating and the option to accept the match;
  * User chooses to accept the match and is shown the rest of the other user's profile;
* **Alternative Flows and Exceptions**: Should one of the matched user decline the match for whichever reason, both receive a notification saying the match was cancelled. The match will also 'time-out' if one of the user's doesn't answer in a yet to be specified ammount of time. This happens even if the other user answered positively.

#### Search matches use case:

* **Actor**: Attendee.
* **Description**: The user is given the option to search his conference match history, so he can choose which match to Mingle with outside the conference.
* **Preconditions and Postconditions**: The user must have adhered to the conference in question, filled in the necessary interests and have at least one match.
* **Normal Flow**: 
  * The user navigates to his profile;
  * In his profile the user selects "Search Matches".
  * He presses the match and he is able to start a conversation.
  
#### Search events use case:

* **Actor**: Attendee.
* **Description**: The user is given the option to search for a given event present in the app's database to join it.
* **Preconditions and Postconditions**: The conference must have been already correctly setup.
* **Normal Flow**: 
  * The user navigates to the search screen;
  * The user inputs the events full or partial name;
  * The user selects the desired conference from between the presented ones.
  
#### See joined events use case:

* **Actor**: Attendee.
* **Description**: The user is given the option to search for all events (if any) he is currently enrolled in.
* **Preconditions and Postconditions**: The conference must have been already correctly setup.
* **Normal Flow**: 
  * The user navigates to the "My Events" screen;
  
#### Rate match use case:

* **Actor**: Atendee.
* **Description**: After the users involved in a match finish their conversation, they have to option to rate the person to which they matched, on a scale of 1 to 5 stars. In the future, a given user's rating will be displayed, in order to provides more information to other users on who they are going to match.
* **Preconditions and Postconditions**: The user must be in a active match for this option to appear. Internally, the system will mark a match as "complete" when one of the users involved rates the other.
* **Normal Flow**: 
  * The user accesses the app and is taken automatically to the match screen;
  * The user is shown a scale of five starts and can choose to rate the match or dismiss it;
  * The user confirms their option and leaves the match screen.
  
#### Create/edit conference use case:

* **Actor**: Conference Staff.
* **Description**: For attendees to be able to join and make matches in a conference, the conference needs to be set up in the app. Therefore, someone from the conference staff needs to create the in-app event, filling it with several informations such as name, location, dates, external sites for more information.
* **Preconditions and Postconditions**: The user must be the original creator of the event (i.e. its owner) in order to have access to the menu to edit any event. After the process is complete, the app will register the event and other user can search and join it. Afterwords, the staff member must define some topics for the event in the following page.
* **Normal Flow**: 
  * The user navigates to the 'My Events' menu;
  * The user presses the button to add a new event;
  * The user fills in the event's name, location, description and sets up and external link to the event's webpage;
  * The user confirms their submissions and creates/updates the event.
  
#### Define conference topics use case:

* **Actor**: Conference Staff.
* **Description**: For attendees to be able to make matches in a conference, the conference needs to have a availiable pool of topics. The conference's owner will be asked to provide a pool of topics related to it, so that attendees can choose which ones fit them the best.
* **Preconditions and Postconditions**: The user must the conference's creator. The conference must be already correctly setup in order for this process.
* **Normal Flow**: 
  * The user navigates to the 'My Events' menu;
  * The user defines a set of topics related to the conference;
  * The user confirms their submissions and creates the event.
  
  **Alternate flow**:
  * The user has already created the event and wants to change some/all of its topics;
  * The user navigates to the 'My Events' menu;
  * The user chooses the event to edit;
  * The user edits the desired topics and saves.
  
#### Lookup user information use case:

* **Actor**: Conference staff.
* **Description**: Conference staff members have access to a list of all currently joined users.
* **Preconditions and Postconditions**: The user must have higher priviledges for the conference in question to access this sub-menu.
* **Normal Flow**: 
  * The user navigates to the conference page;
  * In the conference settings, the user selects 'See registred users';
  * A page appears with all users;

### User stories

[Link to the Trello page.](https://trello.com/b/zLgW01zY/esof-mingler)

### Domain model

![alt text](https://github.com/softeng-feup/open-cx-powerrangers/blob/master/docs/img/domain_model.png)

## Architecture and Design

### Logical architecture

### Physical architecture

Our application is fully developed using the very recent (but powerful) Flutter. Flutter is a framework for mobile development developed by Google, and supports both iOS and Android. We chose this platform in place of others because, when brought to our attention, seemed to be a very interesting technology and, as a consequence of being very recent, was literally growing before our eyes (during the span of this semester alone, the framework suffered several updates and new features were added). Despite this, both the documentation provided by Google themselves, and community support were abundant - which was crucial in helping us understand the tools and develop the app itself.

As a consequence of using Flutter, the program had to be developed fully in Dart. Dart was also created by Google and is a script, object-oriented and class-based language. This language initially added a whole new layer of adaptation but we would soon realize its power and wielded it to our benefict. Using this language was less of a choice but more of an obligation related to the framework we use.

Finally, although if time permits we intend on using ESOF's own back-end, our current back-end is Google's Firebase. Firebase provides, basically freely, authentication services, databases, cloud storage and even notification-handling and messaging. The database is in NoSQL, but because of the structure of Firebase we don't have to interact with it directly, and is collection-based. Firebase has its challenges but with time became very intuitive and be it because the entire app resided inside Google's services ecosystem or because support for the several parts was extensive, we never had integration issues between all these components.

Regarding the architecture itself, briefly speaking, has two parts to it: the smartphone-based components and the Firebase-side artifacts. Through the app's UI screens, the user sees/edits several pieces of information which are sent to/retrieved from several classes (the Models). These classes get their internal information by accesing the collections located in Firebase and execute CRUD operations upon the documents inside them.

In essence, this is what the following UML diagram (which is an integrated deployment and component diagram) refers to:

![alt text](https://github.com/softeng-feup/open-cx-powerrangers/blob/master/docs/img/dep_com_uml.jpg)

