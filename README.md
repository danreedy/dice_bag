# DiceBag

A digital dice bag.

## Installation


```ruby
gem 'dice_bag'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dice_bag

## Usage

Tell the dice bag what kind of and how many dice you are rolling and it'll give you the results.

    $ dice-bag roll d6 3
    4 3 5

    $ dice-bag roll 3d6
    11

## Notation

**Basic:** `d{sides}` e.g. `d20`, `d8`

**Multiple Dice**: `{numberOfDice}d{sides}` e.g. `2d8`, `4d6`

**With Modifier**: `{numberOfDice}d{sides}+{modifier}` or `{numberOfDice}d{sides}-{modifier}` e.g. `d20+5`, `2d8+5`

**Drop Lowest Number**: `{numberOfDice}d{sides}-L` e.g. `4d6-L`

**Drop Higest Number**: `{numberOfDice}d{sides}-H` e.g. `6d6-H`

## Options

*--verbose (-v)*: Shows the calculation for multiple dice

    $ dice-bag roll 3d6 -v
    9 (3+5+1)

    $ dice-bag roll 3d6 2 -v
    11 (4+4+3)
    14 (6+3+5)

*--modifier (-m)*: Adds a modifier to the calculated values

    $ dice-bag roll d4 -m 4
    6 (2+4)

    $ dice-bag roll 2d6 -m 3
    11 (8+3)

These options can be combined

    $ dice-bag roll 2d10 -m 5 -v
    17 (5+7+5)


## Contributing

1. Fork it ( https://github.com/danreedy/dice_bag/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
