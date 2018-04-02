from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
import random

author = 'Boris Mattijssen & Roy Klip'

doc = """
Information Retrieval
"""


class Constants(BaseConstants):
    name_in_url = 'time_pressure'
    players_per_group = None
    num_rounds = 1
    choices = [
        [1, ''],
        [2, ''],
        [3, ''],
        [4, ''],
        [5, ''],
        [6, ''],
        [7, ''],
    ]
    topics = [
        'wildlife extinction',
        'journalist risk',
        'piracy',
        'population growth'
    ]


class Subsession(BaseSubsession):
    def creating_session(self):
        for p in self.get_players():
            p.topic = Constants.topics[(p.id_in_group % 4) - 1]
            p.treatment = random.choice([True, False])


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    feel_time_pressure = models.IntegerField(
        label='Did you feel time pressure?',
        choices=Constants.choices,
        widget=widgets.RadioSelectHorizontal
    )
    need_work_fast = models.IntegerField(
        label='Did you feel the need to work fast?',
        choices=Constants.choices,
        widget=widgets.RadioSelectHorizontal
    )
    feel_hurried_rushed = models.IntegerField(
        label='Did you feel hurried or rushed?',
        choices=Constants.choices,
        widget=widgets.RadioSelectHorizontal
    )

    total_task_time = models.FloatField(initial=300)

    topic = models.StringField()
    treatment = models.BooleanField()
