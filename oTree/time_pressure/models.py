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
        ['Wildlife Extinction',
         'The spotted owl episode in America highlighted U.S. efforts to prevent the extinction of wildlife species. '
         'What is not well known is the effort of other countries to prevent the demise of species native to their countries. '
         'What other countries have begun efforts to prevent such declines?',
         'A relevant item will specify the country, the involved species, and steps taken to save the species.'
         ],
        ['Journalist Risk',
         'Identify instances where a journalist has been put at risk (e.g., killed, arrested or taken hostage) '
         'in the performance of his work.',
         'Any document identifying an instance where a journalist or correspondent has been killed, '
         'arrested or taken hostage in the performance of his work is relevant.'
         ],
        ['Piracy',
         'What modern instances have there been of old fashioned piracy, the boarding or taking control of boats?',
         'Documents discussing piracy on any body of water are relevant.  Documents discussing the legal taking of '
         'ships or their contents by a national authority are non-relevant.  Clashes between fishing vessels over'
         'fishing are not relevant, unless one vessel is boarded.'
         ],
        ['Population Growth',
         'What measures have been taken worldwide and what countries have been effective in curbing population growth?',
         'A relevant document must describe an actual case in which population measures have been taken and their results are known. '
         'The reduction measures must have been actively pursued; that is, passive events such as disease or famine'
         'involuntarily reducing the population are not relevant.'
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

    total_task_time = models.IntegerField()
    relevant_marks = models.StringField()
    marked_as_relevant = models.IntegerField()
    queries_issued = models.IntegerField()
    documents_viewed = models.IntegerField()
    serps_viewed = models.IntegerField()
    document_view_time = models.IntegerField()
    serp_view_time = models.IntegerField()
    hover_depth = models.FloatField()
    current_hover_depth = models.FloatField()

    topicname = models.StringField()
    topicdes = models.StringField()
    topicnar = models.StringField()
    treatment = models.BooleanField()
