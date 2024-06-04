import hikari
import lightbulb
import miru

import automata
from automata import TOKEN, DEFAULT_GUILDS

bot = lightbulb.BotApp(
    token=TOKEN,
    default_enabled_guilds=DEFAULT_GUILDS,
    intents=hikari.Intents.ALL,
    help_class=None,
    ignore_bots=True,
    prefix="+",
)

miru_client = miru.Client(bot)


bot.load_extensions_from("automata/Extensions")

if __name__ == '__main__':
    automata.run(bot)
