## Level 3 - Beginner Program!

In this section, we will take our first steps toward learning The Elm Architecture (TEA), the architecture that inspired Dan Abramov to create Redux.

The goal of the section is to implement card clicking: all cards should start as `Closed`, and change to `Open` when clicked.
Don't worry about `Matched` for now - we'll deal with that later.

### 3.1 Tea

We've made it this far without TEA because we have a simple, static web page.
Now we want to start responding to user input, and TEA is the way Elm structures applications and handles interactivity.

Begin by reading the official docs on [`Html.beginnerProgram`](http://package.elm-lang.org/packages/elm-lang/html/1.1.0/Html-App#beginnerProgram)

You may also find the docs on [The Elm Architecture useful.](https://guide.elm-lang.org/architecture/)

Now that you're getting warm, we will be giving you fewer specific instructions and more high-level requirements. Use the workshop hosts if you have questions and don't forget to make use of the helpfulness of the compiler.

---
**Task**:

1. Create a type alias `Model` that has the following type: `{ cards : List Card }`
1. Create a value `init : Model`
1. Create the union type `Msg` with only one constructor: `CardClick Card`
1. Create a function `view : Model -> Html a` that renders a `div` with our list of cards.

### 3.2 Stuff is happening!

Now, let's implement opening closed cards.

When the user clicks a card we want to get a message (`CardClick`) with the clicked card.
We will then have to go over each card in our card list (in `Model`) and update the one that was clicked.

When this section is complete, you should see three closed cards, each of them opening when clicked.

---
**Task**:
1. Add `import Html.Events exposing (..)` and add an `onClick` (that sends `CardClick`) event handler on closed cards.
  * The compiler will now complain about some type signatures. Read the messages and fix accordingly.
1. Create a helper function `setCard: CardState -> Card -> Card`.
  * As you may have guessed, this function should return a new card with the `state` of the passed card set to the passed `CardState`.
  * See the docs on how to [update a record](http://elm-lang.org/docs/records#updating-records).
1. Create `update : Msg -> Model -> Model`
  * Use pattern matching and open the clicked card
1. Change `main` to be `Html.beginnerProgram { ... }`
  * Read the docs to see what parameters it accepts!

##### Hint:
To update an element in a list you can use `List.map`.