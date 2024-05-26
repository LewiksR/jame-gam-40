from argparse import ArgumentParser
import json
from pprint import pprint

parser = ArgumentParser(
                    prog="WordsGenerator",
                    description="Outputs JSON file grouped by word length")

parser.add_argument("filename",
                    help="Path to input file",
                    type=str)
parser.add_argument("-l", "--minlength",
                    dest="min_length",
                    help="Sets the minimum length of accepted words",
                    type=int,
                    default=4,
                    required=False)
parser.add_argument("-o", "--output",
                    dest="output_path",
                    help="Path to output JSON file",
                    type=str,
                    default="../godot/data/words.json",
                    required=False)

args = parser.parse_args()


def load_words(path: str) -> set[str]:
    with open(path) as word_file:
        valid_words = set(word_file.read().split())

    return valid_words


words_dict = {}
words = load_words(args.filename)
for word in words:
    length = len(word)
    if length < args.min_length:
        continue
    if length not in words_dict:
        words_dict[length] = []
    words_dict[length].append(word)

for key in sorted(words_dict):
    print(f"Amount of words of length {key}: {len(words_dict[key])}")

words_json = json.dumps(words_dict)
with open(args.output_path, "w") as file:
    file.write(words_json)