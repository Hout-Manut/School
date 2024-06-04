import hikari
import miru

def run(bot):
    """Starts the bot."""
    miru.install(bot)
    bot.run(
        status=hikari.Status.ONLINE,
        activity=hikari.Activity(
            name="FA diagrams.",
            type=hikari.ActivityType.WATCHING
        )
    )
