class ScriptHelpers:

    @staticmethod
    def get_filtered_dataint(script_command):
        return list(filter((0).__ne__, [script_command.dataint, script_command.dataint2,
                                        script_command.dataint3, script_command.dataint4]))

    @staticmethod
    def get_filtered_datalong(script_command):
        return list(filter((0).__ne__, [script_command.datalong, script_command.datalong2,
                                        script_command.datalong3, script_command.datalong4]))

    @staticmethod
    def get_filtered_event_scripts(event):
        return list(filter((0).__ne__, [event.action1_script, event.action2_script, event.action3_script]))
