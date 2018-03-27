from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


class Introduction(Page):
    pass


class Search(Page):
    form_model = 'player'
    form_fields = ['total_task_time']


class Questionnaire(Page):
    pass


class End(Page):
    pass


page_sequence = [
    Introduction,
    Search,
    Questionnaire,
    End
]
