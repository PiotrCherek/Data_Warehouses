import random
from faker import Faker
import datetime
fakePL = Faker('pl_PL')

board_game_names = open('board_game_names.txt', 'r').read().split('\n')
city_districts = open('city_districts.txt', 'r').read().split('\n')

def random_bool():
    return random.choice([True, False])

def generate_name():
    return fakePL.first_name()

def generate_surname():
    return fakePL.last_name()

def generate_pesel():
    while True:
        pesel = fakePL.pesel()
        if pesel[0] > '6':
            break
    return pesel

def generate_birth_date():
    date = fakePL.date_of_birth(minimum_age=18, maximum_age=80)
    return date.strftime('%Y-%m-%d')

# WORKERS
workers = []
number_of_workers = 10
for i in range(number_of_workers):
    workers.append({
        'pesel': generate_pesel(),
        'name': generate_name(),
        'surname': generate_surname()
    })

# CUSTOMER ACCOUNT INFO
number_of_customers = 1000
customers = []
starter_customer_code = 10000
for i in range(number_of_customers):
    customers.append({
        'customer_code': starter_customer_code + i,
        'name': generate_name(),
        'surname': generate_surname(),
        'birth_date': generate_birth_date(),
        'is_subscribed': random_bool()
    })

def generate_price_pool(min_prize_pool, max_prize_pool):
    random_number = random.randint(min_prize_pool, max_prize_pool)
    if random_number % 100 != 0:
        random_number = random_number - (random_number % 100)
    return random_number

def generate_entry_fee(min_entry_fee, max_entry_fee):
    random_number = random.randint(min_entry_fee, max_entry_fee)
    if random_number % 10 != 0:
        random_number = random_number - (random_number % 10)
    return random_number

# TOURNAMENTS
number_of_tournaments = 100
tournaments = []
current_tournament_id = 1
max_prize_pool = 5000
min_prize_pool = 100
min_entry_fee = 10
max_entry_fee = 100
for i in range(number_of_tournaments):
    tournaments.append({
        'tournament_id': current_tournament_id,
        'game_id': random.randint(1, len(board_game_names)),
        'date': fakePL.date_between(start_date='-2y', end_date='today').strftime('%Y-%m-%d'),
        'prize_pool': generate_price_pool(min_prize_pool, max_prize_pool),
        'entry_fee': generate_entry_fee(min_entry_fee, max_entry_fee),
        'responsible_worker': random.choice(workers)['pesel']
    })
    current_tournament_id += 1

def generate_tournament_participants(number_of_participants):
    sample = random.sample(customers, number_of_participants)
    return [customer['customer_code'] for customer in sample]

def split_prize_pool(num_of_splits, prize_pool):
    splits_percentages = []
    for i in range(num_of_splits):
        splits_percentages.append(round(random.randint(1, 10) * 0.1,1))
    while sum(splits_percentages) > 1:
        random_split_index = random.randint(0, num_of_splits - 1)
        if splits_percentages[random_split_index] > 0.1:
            splits_percentages[random_split_index] -= 0.1
            splits_percentages[random_split_index] = round(splits_percentages[random_split_index], 1)
    while sum(splits_percentages) < 1:
        random_split_index = random.randint(0, num_of_splits - 1)
        if splits_percentages[random_split_index] < 1:
            splits_percentages[random_split_index] += 0.1
            splits_percentages[random_split_index] = round(splits_percentages[random_split_index], 1)
    for i in range(num_of_splits):
        splits_percentages[i] = round(prize_pool * splits_percentages[i])
    return sorted(splits_percentages, reverse=True)

def generate_winnings_list(prize_pool):
    num_of_winners = random.randint(3, 5)
    return split_prize_pool(num_of_winners, prize_pool)

# TOURNAMENT PARTICIPANTS
tournament_participants = []
for tournament in tournaments:
    number_of_participants = random.randint(5, 100)
    current_tournament_participants = generate_tournament_participants(number_of_participants)
    winnings_list = generate_winnings_list(tournament['prize_pool'])
    for i in range(number_of_participants):
        tournament_participants.append({
            'customer_code': current_tournament_participants[i],
            'tournament_id': tournament['tournament_id'],
            'place': i + 1,
            'prize_amount': winnings_list[i] if i < len(winnings_list) else 0
        })

# POSTERS
posters = []
for tournament in tournaments:
    number_of_districts = random.randint(2, 7)
    districts = random.sample(city_districts, number_of_districts)
    for i in range(number_of_districts):
        number_of_posters = random.randint(3, 10)
        posters.append({
            'tournament_id': tournament['tournament_id'],
            'district': districts[i],
            'number_of_posters': number_of_posters
        })

# OWNED BOARD GAMES
owned_board_games = []
starter_game_id = 1
for game in board_game_names:
    owned_board_games.append({
        'game_id': starter_game_id,
        'name': game,
        'quantity': random.randint(1, 5),
        'rent_price': random.randint(1, 3) * 5
    })
    starter_game_id += 1

# RENTS
rents = []
number_of_rents = 10000
starter_rent_id = 1
for i in range(number_of_rents):
    random_customer = random.choice(customers)
    random_game = random.choice(owned_board_games)
    rents.append({
        'rent_id': starter_rent_id + i,
        'customer_code': random_customer['customer_code'],
        'game': random_game['game_id'],
        'date_of_rent': fakePL.date_between(start_date='-2y', end_date='today').strftime('%Y-%m-%d')
    })

# CEO EXCEL 1
possible_additional_info = [
    'rents disabled during tournament',
    'morning tournament',
    'evening tournament',
    'meet 30 minutes before start',
    'do not bring children',
    'free snacks and drinks',
    'no additional info'
]
upcoming_tournaments = []
number_of_upcoming_tournaments = 10
for i in range(number_of_upcoming_tournaments):
    random_game = random.choice(owned_board_games)
    prize_pool = generate_price_pool(min_prize_pool, max_prize_pool)
    winnings_list = generate_winnings_list(prize_pool)
    date = fakePL.date_between(start_date=datetime.date.today(), end_date=datetime.date.today() + datetime.timedelta(days=60))
    formatted_date = date.strftime('%Y-%m-%d')
    while len(winnings_list) < 5:
        winnings_list.append(0)
    upcoming_tournaments.append({
        'tournament_id': current_tournament_id,
        'date': formatted_date,
        'name_of_game': random_game['name'],
        'entry_price': generate_entry_fee(min_entry_fee, max_entry_fee),
        'first_place_prize': winnings_list[0],
        'second_place_prize': winnings_list[1],
        'third_place_prize': winnings_list[2],
        'fourth_place_prize': winnings_list[3],
        'fifth_place_prize': winnings_list[4],
        'additional_info': random.choice(possible_additional_info)
    })
    current_tournament_id += 1

def push_to_file(file_name, data):
    with open(file_name, 'w') as file:
        for row in data:
            line = ''
            for key, value in row.items():
                line += str(value) + '|'
            file.write(line[:-1] + '\n')

push_to_file('customers.bulk', customers)
push_to_file('tournaments.bulk', tournaments)
push_to_file('tournament_participants.bulk', tournament_participants)
push_to_file('posters.bulk', posters)
push_to_file('owned_board_games.bulk', owned_board_games)
push_to_file('rents.bulk', rents)
push_to_file('workers.bulk', workers)