import random
from faker import Faker
import csv
import os

def generate_price_pool(min_val, max_val):
    return random.randint(min_val, max_val)

def generate_winnings_list(prize_pool):
    winnings = []
    remaining_pool = prize_pool
    for i in range(3):
        if remaining_pool <= 0:
            winnings.append(0)
            continue
        prize = random.randint(0, remaining_pool)
        winnings.append(prize)
        remaining_pool -= prize
    winnings.append(remaining_pool)
    winnings.append(0)
    return winnings

def generate_entry_fee(min_val, max_val):
    return random.randint(min_val, max_val)

fakePL = Faker('pl_PL')

games_rents_during_tournament = [
    'rents disabled during tournaments',
    'rents allowed during tournament',
]
meeting_time = ['morning', 'evening']
bringing_children = ['do not bring children', 'children allowed']
snack_and_drinks = ['free snacks and drinks', 'no snacks and drinks provided']

csv_file_name = 'existing_tournaments.csv'
csv_headers = ['tournament_id', 'games_rents_during_tournament', 'meeting_time', 'bringing_children', 'snack_and_drinks']

number_of_tournaments_T1 = 70
number_to_generate_each_run = 30  # Number to add in subsequent runs

# Check if CSV exists and how many records are already present
existing_rows = 0
if os.path.exists(csv_file_name):
    with open(csv_file_name, newline='', encoding='utf-8') as f:
        reader = list(csv.reader(f))
        existing_rows = len(reader) - 1  # subtract header

if existing_rows == 0:
    number_to_generate = number_of_tournaments_T1
    write_mode = 'w'
else:
    number_to_generate = number_to_generate_each_run
    write_mode = 'a'  # append mode

# Generate new tournament entries
new_data = []
for i in range(existing_rows + 1, existing_rows + 1 + number_to_generate):
    tournament = {
        'tournament_id': i,
        'games_rents_during_tournament': random.choice(games_rents_during_tournament),
        'meeting_time': random.choice(meeting_time),
        'bringing_children': random.choice(bringing_children),
        'snack_and_drinks': random.choice(snack_and_drinks)
    }
    new_data.append(tournament)

# Write to CSV
with open(csv_file_name, mode=write_mode, newline='', encoding='utf-8') as file:
    writer = csv.DictWriter(file, fieldnames=csv_headers)
    if write_mode == 'w':
        writer.writeheader()
    writer.writerows(new_data)

print(f"{number_to_generate} tournament(s) written to '{csv_file_name}'.")
