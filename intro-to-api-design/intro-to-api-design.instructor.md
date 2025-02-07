# Instructor: Intro to API Design

## Designing Responses

Goal:

- The point is to get students to learn that they can shape their JSON meaningfully.
- My hope is that if they learn how to shape it meaningfully, they'll be better equipped to dive into the JSON, too.
- Bonus: Practice for capstone

Notes for teaching:

- The first half is boring, it's stuff that's been taught before
- The second half has an extended metaphor/walkthrough with Eryn, and then it ends in Slack API exploration

We recommend returning status code 204 for successful PUT and DELETE responses. There are other valid responses that could returned though:

- Status code 200 and a dictionary of deleted record. If we're deleting it, why do we need to send the data back? Most probably, a user was in a situation where they were already looking at the record (so the app already had the data for the record) and they took an action (like clicking a button) to remove the item. Even if we didn't return the data for the deleted item, if the app really needed to fetch it, it could do an initial GET before the DELETE.
- Status code 200 and a successfully deleted message. A message like "successfully deleted record 1" doesn't provide much benefit. We already know the deletion was successful from the status code, and the message itself isn't really structured for computer use. We should remember that end users don't typically interact with API calls, so they won't see the response. Instead, users interact with an app (code) that makes the API call and can display its own success or failure messages.

We're choosing to recommend sending back 204 because the 204 indicates the request was successful, and that there should be no attempt to read the response body (because there isn't one). Neither the deleted record data, nor a status message is immediately useful, so leaving it off entirely works well.

The same scenarios apply for PUT responses. With PUT, we might still choose to return the updated record, but since we must send all of the data for the updated record, then in theory we have all the data we need to update any local data ourselves if necessary (though there's a separation of concerns argument that could be made to tilt things in favor of returning the updated record).

PATCH responses are more likely to return the updated record, since we may have only sent a small piece of the entire record, or even made use of a custom route that performs additional work on the record in ways the app wouldn't necessarily know about.

We can explain that:
- Returning status code 200 and the record in the response _could_ be used for all cases (even DELETE)
- Returning status code 200 with some status message isn't useful
- Returning status code 204 with an empty response is suitable if the record dictionary isn't needed

## Activity

This is one of those activities where the conversation is more important than the outcome.

Encourage questions. API design in the wild is varied, and it's all about context. More APIs break rules than not, so I wouldn't stress about naming any specific answers.

The activity should be practicing skills that mimic capstone. (How do we go from feature to API?)
