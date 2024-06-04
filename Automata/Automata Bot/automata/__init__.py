import os

from dotenv import load_dotenv

load_dotenv()

TOKEN = os.getenv("TOKEN")
# BOT_ID = int(os.getenv("BOT_ID"))
DEFAULT_GUILDS = [int(x) for x in os.getenv("GUILDS").split(',')]

__version__ = "0.1"

from .bot import run
from .classes import (
    FA,
    FormView,
    FormModal,
)
from .Extensions.error_handler import (
    AutomataError,
    UserError,
    InvalidFAError,
)