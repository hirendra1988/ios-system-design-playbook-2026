##Key Rule You MUST Say Out Loud

“ViewModels depend only on the APIClient protocol, never on concrete implementations.”


# 🔁 Dependency Direction (VERY IMPORTANT)
Creation Flow: App → Composition Root → APIClient
Usage Flow:    ViewModels → APIClient


# 🔵 Layer-by-Layer Explanation

## 1️⃣ iOS App (AppDelegate / SceneDelegate)
## What this represents
- App entry point
- Controls application lifecycle
- Should not contain business logic


## Role in this diagram
- Responsible for starting the app
- Creates the Composition Root

## 2️⃣ Composition Root (NetworkContainer)
## What it is
- Central place where all dependencies are wired
- Knows about concrete implementations
- Exists once for the whole app

## Why it’s critical
- Prevents scattered object creation
- Makes dependency flow explicit
- Allows easy swapping of implementations

## What it creates
- DefaultAPIClient
- RetryingAPIClient
- Token store, retry policy, etc.

### Interview wording:
- The composition root owns object creation and hides concrete implementations from the rest of the app.


## 3️⃣ APIClient (Abstraction)

## What this represents
- A protocol, not a class
- Defines what networking can do
- Hides how networking is implemented

## Why abstraction matters
- ViewModels don’t care about:
    - URLSession
    - Retry logic
    - Token refresh

- They only care about:
    - “Give me data or an error”

### Interview wording:
“This abstraction allows the UI layer to remain completely decoupled from networking details.”


## 4️⃣ DefaultAPIClient (Implementation)
## What it does

- Builds URLRequest from Endpoint
- Executes network call
- Parses response
- Maps errors

## Why it exists
- Single responsibility
- No retry, auth refresh, or logging logic here

### Interview wording:
“This class handles core request execution and response parsing, nothing else.”


## 5️⃣ RetryingAPIClient (Decorator)

## Why it exists
- Retry is a cross-cutting concern
- Token refresh is orthogonal to request execution

## What it does
- Wraps another APIClient
- Intercepts failures
- Applies retry policy
- Refreshes token if needed
- Re-executes the request

## Key senior insight
- It does not replace DefaultAPIClient
- It enhances it

### Interview wording:
“Retry and authentication are added via a decorator so core networking logic remains clean and extensible.”


## 6️⃣ NetworkSession (URLSession Adapter)
## What this does
- Abstracts URLSession behind a protocol
- Allows mocking network calls

## Why it matters
- Essential for unit testing
- Removes dependency on system APIs

### Interview wording:
“This abstraction makes networking fully testable without hitting real APIs.”


## 7️⃣ ViewModels (Consumers)
## Key rule
## ViewModels:
    - ❌ Do not create APIClient
    - ❌ Do not know about URLSession
    - ❌ Do not handle retries

## What they do
- Request data
- Transform responses to UI state
- Handle success/failure

### Interview wording:
“ViewModels depend only on the APIClient protocol, which keeps them lightweight and testable.”





# 📐 Visual Order (Easy to Remember)
Abstractions
   ↓
Core Implementation
   ↓
Decorators
   ↓
Adapters
   ↓
Composition Root
   ↓
Consumers



# Full retry + refresh flow (most important)
1. apiClient.request(.getDogList)
2. RetryingAPIClient.request()
3. DefaultAPIClient → returns 401
4. RetryingAPIClient catches unauthorised
5. TokenRefresher.refreshToken() is called
6. TokenStore updated
7. SAME request retried automatically
8. Success returned to ViewModel


#3️⃣ Decorator pattern — CORRECT

You explicitly show:
- RetryAPIClient implements APIClient
- It decorates another APIClient
- It orchestrates retry + token refresh

This correctly expresses Liskov Substitution + Open/Closed Principle.


# 4️⃣ Token responsibilities — CORRECT
Your token placement is now exactly right:
Component               Role

TokenProvider       Read-only access
TokenStore          Owns & saves token
TokenRefresher      Calls refresh API
RetryAPIClient      Orchestrates refresh
DefaultAPIClient    Reads token for headers
