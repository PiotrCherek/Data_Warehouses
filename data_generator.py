import random
from faker import Faker
from datetime import datetime, timedelta
fakePL = Faker('pl_PL')

board_game_names = open('board_game_names.txt', 'r').read().split('\n')
print(board_game_names)

def random_bool():
    return random.choice([True, False])

def generate_name():
    return fakePL.first_name()

def generate_surname():
    return fakePL.last_name()

def generate_pesel():
    return fakePL.pesel()

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
        'date': fakePL.date_between(start_date='-1y', end_date='today').strftime('%d-%m-%Y'),
        'prize_pool': generate_price_pool(min_prize_pool, max_prize_pool),
        'entry_fee': generate_entry_fee(min_entry_fee, max_entry_fee)
    })
