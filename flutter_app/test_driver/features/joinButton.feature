Feature: Join Button
The attendees should be incremented when the button is pressed.

Scenario: Counter increases when the button is pressed
    Given The "Join Us" button
    When I tap the "Join Us" button it changes to “unjoin button”
    Then I expect the “attendees” number to be 1 more than before.