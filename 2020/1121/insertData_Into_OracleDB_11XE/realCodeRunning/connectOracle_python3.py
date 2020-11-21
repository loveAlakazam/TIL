import cx_Oracle
import os


os.putenv('NLS_LANG', '.UTF8')

class Trip2ReapOracle:
    def __init__(self):
        self.connection= cx_Oracle.connect('TRIP2REAP', 'TRIP2REAP', 'localhost:1521/xe')
        self.cursor= self.connection.cursor()
        self.sql=None
    
    #데이터 조회(select)
    def selectQuery(self, sql):
        result=self.cursor.execute(sql)
        return [ list( d for d in data) for data in result]

    

members=Trip2ReapOracle().selectQueryData('select * from member')
for member in members:
    print(member)