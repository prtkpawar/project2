from config import API_KEY
import request


def get_movie_data(i):
    response=requests.get('https://api.themoviedb.org/3/movie/top_rated?api_key={}&&language=en-US&page={}'.format(API_KEY,i))
    Jsondata=response.json()['results']
    return Jsondata


def lambda_handler(event, context):
    res = get_movie_data(1) 
    print(res)

