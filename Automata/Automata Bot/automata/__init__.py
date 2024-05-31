import os

from dotenv import load_dotenv

load_dotenv()

TOKEN = os.getenv("TOKEN")
# BOT_ID = int(os.getenv("BOT_ID"))
BOT_ID = 0
DEFAULT_GUILDS = [int(x) for x in os.getenv("GUILDS").split(',')]

__version__ = "0.1"

from .bot import run