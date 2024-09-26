# attendance-app

To install dependencies:

```bash
bun install
```

To run:

```bash
bun run app.js
```

This project was created using `bun init` in bun v1.1.15. [Bun](https://bun.sh) is a fast all-in-one JavaScript runtime.

for generating the prisma schema
follow https://bun.sh/guides/ecosystem/prisma

install postgres, start the server and the
set the connection string in the
env variable DATABASE_URL

Test Data

- `http://localhost:3000/user/register`
  in body

```
{
  "role": "ADMIN",
  "employee_id": 230624,
  "name": "Manas",
  "position": "Quant Intern with SDE",
  "password": "test123"
}
```

- `http://localhost:3000/user/login`
  in body

```
{
  "employee_id": 230626,
  "password": "Manas@test"
}
```

- `http://localhost:3000/event/createEvent`
  in header
  ` authorization - Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJJZCI6MjMwNjI2LCJyb2xlIjoiQURNSU4ifSwiaWF0IjoxNzI3MzU1Mzg1fQ.LbFzeLZtLnAJZ5oxHM-Gu8QiGsiw_jNbyi128qMGigg`
  in body

```
{
  "title" : "test event",
  "description": "hi testing the event",
  "date": "2024-09-26T14:30:00Z",
  "locationName": "Home",
  "xCoordinate": 123.12,
  "yCoordinate": 321.21,
  "userIds": [230626, 230620]
}
```

- `http://localhost:3000/event/createSubEvent`
  in header
  ` authorization - Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJJZCI6MjMwNjI2LCJyb2xlIjoiQURNSU4ifSwiaWF0IjoxNzI3MzU1Mzg1fQ.LbFzeLZtLnAJZ5oxHM-Gu8QiGsiw_jNbyi128qMGigg`
  in Body

```
{
  "title" : "test event",
  "description": "hi testing the event",
  "date": "2024-09-26T14:30:00Z",
  "locationName": "Home",
  "xCoordinate": 123.12,
  "yCoordinate": 321.21,
  "userIds": [230626, 230622, 230623],
  "parentEventId": 12
}
```

- `http://localhost:3000/event/`
  in header the token as above, it is a get request
