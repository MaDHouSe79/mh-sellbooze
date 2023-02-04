local Translations = {
    notify = {
        ['you_sell_all_items'] = "Je hebt al je drank verkocht!",
        ['no_items_to_sell'] = "Je hebt geen drank om te verkopen!",
    },
    target = {
        ['sell_items'] = "Verkoop al je drank",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations, 
    warnOnMissing = true
})