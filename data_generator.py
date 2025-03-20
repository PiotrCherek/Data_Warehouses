import random
from faker import Faker
from datetime import datetime, timedelta
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
    return date.strftime('%d-%m-%Y')

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
starter_tournament_id = 1
max_prize_pool = 5000
min_prize_pool = 100
min_entry_fee = 10
max_entry_fee = 100
for i in range(number_of_tournaments):
    tournaments.append({
        'tournament_id': starter_tournament_id + i,
        'game': random.choice(board_game_names),
        'date': fakePL.date_between(start_date='-2y', end_date='today').strftime('%d-%m-%Y'),
        'prize_pool': generate_price_pool(min_prize_pool, max_prize_pool),
        'entry_fee': generate_entry_fee(min_entry_fee, max_entry_fee)
    })

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
for i in range(number_of_rents):
    random_customer = random.choice(customers)
    random_game = random.choice(owned_board_games)
    rents.append({
        'customer_code': random_customer['customer_code'],
        'game': random_game['game_id'],
        'date_of_rent': fakePL.date_between(start_date='-2y', end_date='today').strftime('%d-%m-%Y')
    })

# WORKERS
workers = []
number_of_workers = 10
for i in range(number_of_workers):
    workers.append({
        'pesel': generate_pesel(),
        'name': generate_name(),
        'surname': generate_surname()
    })
print(workers)