from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage


class Introduction(Page):
    pass


class Search(Page):
    topic_descriptions = {
        'Wildlife Extinction': {
             'task': 'Your task is to find out how countries try to prevent the decline of species native to their countries.',
             'relevant': '<ul><li>A <span class="highlight">relevant</span> document should specify the <span class="highlight">country</span>, the <span class="highlight">involved species</span>, and <span class="highlight">steps taken</span> to save the species.</li><li>A <span class="highlight">not relevant</span> document discusses wildlife extinction prevention in <span class="highlight">America</span>.</li></ul>'
         },
         'Journalist Risk': {
             'task': 'Identify instances where a journalist has been put at risk (e.g., killed, arrested or taken hostage) in the performance of his work.',
             'relevant': '<ul><li>Any document identifying an instance where a journalist or correspondent has been <span class="highlight">killed</span>, <span class="highlight">arrested</span> or <span class="highlight">taken hostage</span> while performing his/her work is relevant.</li></ul>'
         },
         'Piracy': {
            'task': 'Identify modern instances of old fashioned piracy, that is the boarding or taking control of boats in the recent past.',
            'relevant': '<ul><li>Documents discussing piracy on any body of water are <span class="highlight">relevant</span>.</li><li>Documents discussing the legal taking of ships or their contents by a national authority are <span class="highlight">non-relevant</span>.</li><li>Clashes between fishing vessels over fishing are <span class="highlight">not relevant</span>.</li></ul>'
         },
         'Population Growth': {
            'task': 'Identify what measures have been taken to control population growth worldwide and identify the countries that have been effective at doing so.',
            'relevant': '<ul><li>Documents describing a case in which population measures have been taken of which the results are known are <span class="highlight">relevant</span>.</li><li>Passive events such as disease or famine involuntarily reducing the population are <span class="highlight">not relevant</span>.</li></ul>'
        }
    }

    def vars_for_template(self):
        return {
            'timeout_value': self.get_timeout_seconds(),
            'task_description': self.topic_descriptions[self.player.topicname]['task'],
            'relevant_description': self.topic_descriptions[self.player.topicname]['relevant']
        }
    def get_timeout_seconds(self):
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
    form_fields = [
        'age',
        'gender',
        'profession',
        'difficult',
        'performed_well',
        'interesting',
        'feel_time_pressure',
        'need_work_fast',
        'feel_hurried_rushed'
    ]


page_sequence = [
    Introduction,
    Search,
    Questionnaire
]
