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
    name_in_url = 'geraldine'
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
    profession_choices = [
        ['student', 'Student'],
        ['uni_staff', 'University Staff'],
        ['working', 'Working'],
        ['none', 'None of the above']
    ]
    genders = [
        ['male', 'Male'],
        ['female', 'Female'],
        ['none', 'None']
    ]
    topics = [
        ['Wildlife Extinction',
         '',
         ''
         ],
        ['Journalist Risk',
         '',
         ''
         ],
        ['Piracy',
         '',
         ''
         ],
        ['Population Growth',
         '',
         ''
         ]
    ]


class Subsession(BaseSubsession):
    def creating_session(self):
        for p in self.get_players():
            topic = Constants.topics[(p.id_in_group % 4) - 1]
            p.topicname = topic[0]
            p.topicdes = topic[1]
            p.topicnar = topic[2]
            p.treatment = random.choice([True, False])


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    age = models.IntegerField(
        label='What is your age?'
    )
    gender = models.StringField(
        label='What is your gender?',
        choices=Constants.genders
    )
    profession = models.StringField(
        label='What is your current occupation?',
        choices=Constants.profession_choices
    )
    difficult = models.IntegerField(
        label='Did you feel time pressure?',
        choices=Constants.choices,
        widget=widgets.RadioSelectHorizontal
    )
    performed_well = models.IntegerField(
        label='Did you feel time pressure?',
        choices=Constants.choices,
        widget=widgets.RadioSelectHorizontal
    )
    interesting = models.IntegerField(
        label='Did you feel time pressure?',
        choices=Constants.choices,
        widget=widgets.RadioSelectHorizontal
    )
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

    total_task_time = models.IntegerField(blank=True)
    relevant_marks = models.StringField(blank=True)
    marked_as_relevant = models.IntegerField(blank=True)
    queries_issued = models.IntegerField(blank=True)
    documents_viewed = models.IntegerField(blank=True)
    serps_viewed = models.IntegerField(blank=True)
    document_view_time = models.IntegerField(blank=True)
    serp_view_time = models.IntegerField(blank=True)
    hover_depth = models.FloatField(blank=True)
    current_hover_depth = models.FloatField(blank=True)

    topicname = models.StringField(blank=True)
    topicdes = models.StringField(blank=True)
    topicnar = models.StringField(blank=True)
    treatment = models.BooleanField(blank=True)
