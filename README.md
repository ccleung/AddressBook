AddressBook
===========

This project contains a web service and API developed in Ruby on Rails to manage a user's contact list. The scope of the contact list is currently limited to first name, last name, multiple phone numbers, and multiple addresses. The app leverages several gems, such as Devise for building a quick login system, and Grape for building out an API.

Considerations were made to use existing Ruby on Rails controllers, response_to statement to create the API. However, in the long term we probably want to keep the website and the API separate, since they two serve different purposes, and may not have the same functionality. One example would be adding Oauth2 to the API such that we are able to protect our API/resources, and monitor who is using the API.

There is also unit testing on all the models and basic functional testing for the API.

Current features of the website:
* Register, signin, sign out a user leveraging Devise gem
* Create, Update, Retrieve, and Delete Contacts in your Contact list (including phone numbers and addresses associated to your COntacts)
* Validates phone number field for correct structure (e.g., country code, area code, number...) if inputted, requires at least a first name to create a contact entry (everything else is optional)

Current features of the API:
* Requires a valid e-mail sent as a custom header e.g., x-user-email for any request, otherwise will return 401 UnAuthorized
* Allows POST (Create) a contact to add to a user's list, PUT (Update) a contact belonging to a user, GET (Read) contact list for a given user email, DELETE a contact in a user's list

Since the API and website share the same model, the same validations are performed on Create/Save.  

Features that would be great to have:
1. For the Website
* Better UI to improve experience - for starters, get a nice stylesheet template
* Photo's associated to each of your contacts
* Localization
* Add click tracking to see how user's are actually using our website
* Make UI responsive so it can be viewed nicely on mobile phones
* Integrate Google Maps to validate contact list addresses, and to provide a link perhaps to show location on map

2. For the API
* OAuth2 - e.g., access tokens that can be revoked, have an expiry time, client's need to register with us and are provided with a client key
* Limiting endpoints based on access token authorization level (e.g., we may want to make some endpoints limited to certain customers, or allow some endpoints to have anonymous access)
* Pagination for list of contacts
* Filter contacts by character (e.g., all the contacts starting with first_name = 'a')
* Sorting of contacts by date added, date modified, last name, first name
* Searching for contact by different fields (e.g., name)
* Possibly integrate HALJson such that we can embed meta data (currently contacts only return contact id, first name and last name, but not phone numbers or addresses - we could leverage HALJson to enable embedding of these fields), embed links to next resources, enabling easier use of our API
* Integrating a plugin, such as swagger to create an auto-generated documentation page
* Integration with other contact list providers, such as gmail, work, outlook?

Improvements that can be made to make website/service and API more robust:
* Leverage caching of contact lists to make server more responsive
* Integrate metrics monitoring for API (what time does it get used the most, how often, from which geo's etc, which endpoints are used the most)
* Allow clients to make conditional requests with ETAGS
* Batch request, e.g., send up a list of category id's to delete, update (allows clients to make one request vs N requests for N items)

