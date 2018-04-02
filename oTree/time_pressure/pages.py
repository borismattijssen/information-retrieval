from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


class Introduction(Page):
    pass


class Search(Page):
    def get_timeout_seconds(self):
        if self.player.treatment == True:
            return 300
        else:
            return 900

    form_model = 'player'
    form_fields = ['topic', 'total_task_time']


class Questionnaire(Page):
    form_model = 'player'
    form_fields = ['feel_time_pressure', 'need_work_fast', 'feel_hurried_rushed']


page_sequence = [
    Introduction,
    Search,
    Questionnaire
]
