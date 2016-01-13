# Lawn Mowing App

This project contains a small Ruby app that simulates mowers mowing a yard based on a some text input.

## Setup

Make sure `Ruby` is installed first.

```bash
% git clone https://github.com/hanloong/auto-mower.git
% cd auto-mower
% gem install bundler
% bundle install
```

## Input/Output Samples

### Input Example
```
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

### Should output
```
1 3 N
5 1 E
```

## Running

```bash
% ruby run.rb <input-file-name>
```
