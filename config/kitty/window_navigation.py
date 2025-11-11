from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut


def main():
    pass


def window_is_vim(window) -> bool:
    title: str = window.title
    return title.find("vim") >= 0


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    direction = args[1]
    mapping = args[2]
    window = boss.window_id_map.get(target_window_id)
    if window_is_vim(window):
        mods, key = parse_shortcut(mapping)
        event = KeyEvent(mods=mods, key=key,
                         shift=bool(mods & 1),
                         alt=bool(mods & 2),
                         ctrl=bool(mods & 4),
                         super=bool(mods & 8),
                         hyper=bool(mods & 16),
                         meta=bool(mods & 32),).as_window_system_event()
        encoded_key = window.encoded_key(event)
        window.write_to_child(encoded_key)
    else:
        boss.active_tab.neighboring_window(direction)
