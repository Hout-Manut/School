import hikari

def run(bot):
    """Starts the bot."""
    bot.run(
        status=hikari.Status.ONLINE,
        activity=hikari.Activity(
            name="FA diagrams.",
            type=hikari.ActivityType.WATCHING
        )
    )
