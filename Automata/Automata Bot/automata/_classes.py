from __future__ import annotations

import hikari
import lightbulb
import miru

from .Extensions import error_handler as error


class FA:

    def __init__(
        self,
        states: set[str],
        inputs: set[str],
        initial: str,
        finals: set[str],
        transitions: dict[tuple[str, str], set[str]],
    ) -> None:
        if not self.check_valid(states, inputs, initial, finals, transitions):
            raise Exception
        self.states = states
        self.inputs = inputs
        self.initial = initial
        self.finals = finals
        self.transitions = transitions

    @property
    def is_dfa(self) -> bool:
        return self.check_dfa(
            self.states, self.inputs, self.initial, self.finals, self.transitions
        )

    @staticmethod
    def check_valid(
        states: set[str],
        inputs: set[str],
        initial: str,
        finals: set[str],
        transitions: dict[tuple, set[str]],
    ) -> bool:
        """
        Determine if a given FA is valid.

        Args:
            states (set): The set of states.
            inputs (set): The set of imput symbols.
            initial (str): The start state.
            finals (set): The set of accept states.
            transitions (dict): The transition functions as a dictionary where the keys are (state, symbol) and values are set of next states

        Returns:
            bool: True if the FA is valid, ulse False
        """

        # Check the start and end states if they're in the set of all states
        if initial not in states:
            return False
        if not finals.issubset(states):
            return False

        for (state, symbol), next in transitions.items():
            if state not in states:
                return False
            if symbol != "" and symbol not in inputs:
                return False
            if not next.issubset(states):
                return False
        return True

    @staticmethod
    def check_dfa(
        states: set[str],
        inputs: set[str],
        initial: str,
        finals: set[str],
        transitions: dict[tuple, set[str]],
    ) -> bool:
        """
        Determine if a given FA is an NFA or a DFA.

        Args:
            states (set): The set of states.
            inputs (set): The set of imput symbols.
            initial (str): The start state.
            finals (set): The set of accept states.
            transitions (dict): The transition functions as a dictionary where the keys are (state, symbol) and values are set of next states

        Returns:
            bool: True if the FA is DFA, False if it is an NFA.
        """
        for state in states:
            for symbol in inputs:
                if (state, symbol) not in transitions:
                    return False  # Missing transition: NFA
                next_states = transitions[(state, symbol)]
                if len(next_states) != 1:
                    return False  # Transition of a state and symbol leads to 0 or more than 1 states: NFA

        return True


class NFA(FA):
    pass


class DFA(FA):
    pass


class FormView(miru.View):

    @miru.button(label="Enter Form", style=hikari.ButtonStyle.SUCCESS)
    async def form_button(self, ctx: miru.ViewContext, button: miru.Button) -> None:
        modal = FormModal(title="Enter FA data.")
        ctx.respond_with_modal(modal)


class FormModal(miru.modal):
    states = miru.TextInput(label="States", placeholder="q1 q2 q3...", required=True)
    inputs = miru.TextInput(label="Inputs", placeholder="a b...", required=True)
    initial = miru.TextInput(label="Initial state", placeholder="q0", required=True)
    finals = miru.TextInput(
        label="Final state(s)", placeholder="q2 q3...", required=True
    )
    transitions = miru.TextInput(
        label="Transition Functions",
        placeholder="q0,a=q1\nq0,b=q2...",
        style=hikari.TextInputStyle.PARAGRAPH,
        required=True,
    )

    async def callback(self, ctx: miru.ModalContext) -> None:
        pass
