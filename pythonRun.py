import oracledb
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.svm import SVC
from google.cloud import language_v1
from google.oauth2 import service_account

SERVICE_ACCOUNT_FILE = 'auth.json'

# A list not a string
SCOPES = ['https://www.googleapis.com/auth/cloud-language']

credentials = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE
)
credentials=credentials.with_scopes(SCOPES)

# Oracle 데이터베이스에 연결
try:
    oracledb.init_oracle_client(lib_dir=r"C:\Users\User\Desktop\instantclient-basic-windows.x64-19.19.0.0.0dbru\instantclient_19_19")
    connection = oracledb.connect(user="hypemusic", password="hype1234", dsn="1.247.146.31:51521/xe")

    print("############")
    # 커서 생성
    cursor = connection.cursor()

    # 쿼리 실행
    cursor.execute("SELECT TRACK_ID, LYRICS FROM TB_MUSIC")
except oracledb.DatabaseError as e:
    print("There is a problem with Oracle", e)
# 결과 가져오기
lyrics_list = cursor.fetchall()
x=[]
y=[]
# 데이터 준비
score_list = []  
magnitude_list = []  
print(lyrics_list[1][0])
# 데이터 추출 및 처리
# for row in rows:
for i, lyrics in enumerate(lyrics_list[10:100]):
    
    # lyrics_list.append(lyrics)
    print(lyrics)

    client = language_v1.LanguageServiceClient(credentials=credentials)
    type_ = language_v1.Document.Type.PLAIN_TEXT
    language = "ko"
    text = f'''
    {lyrics}
    '''

    document = {"content": text, "type_": type_, "language": language}
    encoding_type = language_v1.EncodingType.UTF8
    response = client.analyze_sentiment(request={
        'document': document,
        'encoding_type': encoding_type
    })

    # -1.0 ~ 0 ~ 1.0 강한 부정 ~ 중립 ~ 강한 긍정
    score = response.document_sentiment.score
    score_list.append(score)
    # 감정의 경렬함 0 ~ inf 무한대
    magnitude = response.document_sentiment.magnitude
    magnitude_list.append(magnitude)
    print("---------------------")
    print(score,magnitude)
    print("---------------------")

# for i in range(len(score_list)):
    score = score_list[i]
    magnitude = magnitude_list[i]
    # track_id = i + 1  # 예시로 트랙 ID를 1부터 시작하는 정수로 가정
    # SQL 업데이트 쿼리 작성
    info_before_comma = lyrics[0]
    update_query = f"UPDATE TB_MUSIC SET score = '{score}', magnitude = '{magnitude}' WHERE TRACK_ID = '{info_before_comma}'"
    print(update_query)

    # 데이터베이스에 업데이트 쿼리 실행
    cursor.execute(update_query)

# lyrics_list = [row[0] for row in lyrics_list if row[0] is not None]
# # # CountVectorizer를 사용하여 텍스트 데이터를 벡터화
# vectorizer = CountVectorizer()
# X_train = vectorizer.fit_transform(lyrics_list)

# # # 모델 선택 및 학습
# model = MultinomialNB()  # 또는 SVC() 등 다른 모델로 변경 가능
# model.fit(X_train, y)

# # # 테스트 데이터 준비
# X_test = ["가사1", "가사2", "가사3"]  # 예측하고자 하는 가사 데이터

# # # 테스트 데이터 벡터화
# X_test_vectorized = vectorizer.transform(X_test)

# # # 예측
# y_pred = model.predict(X_test_vectorized)

# # 예측 결과 출력
# for i, prediction in enumerate(y_pred):
#     print(f"가사 '{X_test[i]}'의 예측 결과: {prediction}")
# # # 예측 결과 반영
# for row in lyrics_list[2:5]:  # lyrics_list에서 원하는 일부 데이터 추출 (예: 2번째부터 4번째까지의 데이터)
#     y.append(row[0])  # lyrics_list의 첫 번째 열의 데이터를 y 리스트에 추가

# 연결과 커서 닫기
connection.commit()
cursor.close()
connection.close()