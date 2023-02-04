local Translations = {
    notify = {
        ['you_sell_all_items'] = "You sold all your booze!",
        ['no_items_to_sell'] = "You have no booze to sell!",
    },
    target = {
        ['sell_items'] = "Sell all your booze",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations, 
    warnOnMissing = true
})