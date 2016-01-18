# Lawn Mowing App - Part 3

[![Build Status](https://travis-ci.org/hanloong/auto-mower.svg?branch=master)](https://travis-ci.org/hanloong/auto-mower)

This Project contains an Rails based API for mowing lawns. The API is hosted on heroku at [https://auto-mower-api.herokuapp.com](https://auto-mower-api.herokuapp.com)

## Other Branches

The solutions to the other sections can be found on the other Branches
 - [part-1](https://github.com/hanloong/auto-mower/tree/part-1)
 - [part-2](https://github.com/hanloong/auto-mower/tree/part-2)

## Setup

Make sure `Ruby` is installed first.

```bash
% git clone https://github.com/hanloong/auto-mower.git
% cd auto-mower
% gem install bundler
% bundle install
```

## Running

```bash
% rails server
```

## Example Usage

### POST `/lawn`

Creates a new lawn record.

Request
```json
{
    "width": 5,
    "height": 5
}
```

Response
```json
{
  "id": 4,
  "width": 5,
  "height": 5,
  "mowers": []
}
```

### GET `/lawn/:id`

Returns an existing lawn record by id

Request
```
GET: /lawn/4
```

Response
```json
{
  "id": 2,
  "width": 5,
  "height": 5,
  "mowers": [
    {
      "id": 5,
      "x": 1,
      "y": 3,
      "heading": "N",
      "commands": ""
    },
    {
      "id": 6,
      "x": 5,
      "y": 1,
      "heading": "E",
      "commands": ""
    }
  ]
}
```
### PUT `/lawn/4`

Updates an existing lawn record by id

Request
```json
{
    "width": 3,
    "height": 3
}
```

Response
```json
{
  "id": 4,
  "width": 3,
  "height": 3,
  "mowers": []
}
```
### DELETE `/lawn/:id`

Deletes an existing lawn record by id

Request
```
DELETE: /lawn/4
```

Response
```json
{
  "status": "ok"
}
```

### POST `/lawn/:lawn_id/mower`

Creates a new mower within the specified lawn

Request
```json
POST: /lawn/1/mower

{
    "x": 4,
    "y": 5,
    "heading": "E",
    "commands": "MLRMM"
}
```

Response
```json
{
  "id": 4,
  "x": 4,
  "y": 5,
  "heading": "E",
  "commands": "MLRMM"
}
```

### GET `/lawn/:lawn_id/mower/:id`

Returns an existing mower by id

Request
```json
POST: /lawn/1/mower/4
```

Response
```json
{
  "id": 4,
  "x": 4,
  "y": 5,
  "heading": "E",
  "commands": "MLRMM"
}
```

### PUT `/lawn/:lawn_id/mower/:id`

Updates an existing mower by id

Request
```json
PUT: /lawn/1/mower/4

{
    "x": 0,
    "y": 0,
    "heading": "N",
    "commands": "MLRMM"
}
```

Response
```json
{
  "id": 4,
  "x": 0,
  "y": 0,
  "heading": "N",
  "commands": "MLRMM"
}
```
### DELETE `/lawn/:lawn_id/:id`

Deletes an existing mower record by id

Request
```
DELETE: /lawn/1/mower/4
```

Response
```json
{
  "status": "ok"
}
```

### POST `/lawn/:id/execute`

nRuns the mowers across the lawns outputting the final state.

```josn
POST /lawn/1/execute
```

Response
```json
{
  "id": 2,
  "width": 5,
  "height": 5,
  "mowers": [
    {
      "id": 5,
      "x": 1,
      "y": 3,
      "heading": "N",
      "commands": ""
    },
    {
      "id": 6,
      "x": 5,
      "y": 1,
      "heading": "E",
      "commands": ""
    }
  ]
}
```

## Todos

What project would be complete without a list of things to improve on.

 - **Better Collision Detection** the current algorithm only detects when two or more mowers are on the same block, it should really check that they cannot swap block (unless these are jumping mowers).
