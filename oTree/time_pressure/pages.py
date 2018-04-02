from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage


class Introduction(Page):
    pass


class Search(Page):
    def vars_for_template(self):
        return {'timeout_value': self.get_timeout_seconds()}
    def get_timeout_seconds(self):
        return 10
        if self.player.treatment == True:
            return 300
        else:
            return 900

    form_model = 'player'
    form_fields = [
        'total_task_time',
        'relevant_marks',
        'marked_as_relevant',
        'queries_issued',
        'documents_viewed',
        'serps_viewed',
        'document_view_time',
        'serp_view_time',
        'hover_depth',
        'current_hover_depth'
    ]


class Questionnaire(Page):
    form_model = 'player'
    form_fields = ['feel_time_pressure', 'need_work_fast', 'feel_hurried_rushed']


page_sequence = [
    Introduction,
    Search,
    Questionnaire
]
