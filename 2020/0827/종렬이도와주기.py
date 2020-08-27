def check_charged(arr):
    # 리스트배열 arr에 1이 10개가 꽉차면 => 충전완료
    all_charged= all(arr)
    if(all_charged):
        # all_charged=all(arr) 가 True이면 충전완료
        return '충전완료!'

    else:
        # 리스트배열 arr 0이 10개면 -> any(arr)=False 
        #                       ->not any(arr)= True 
        #                       -> 충전중

        # 리스트배열 arr 0,1 이 섞여있으면 -> any(arr)=True
        #                           -> not any(arr)=False 
        #                           -> 충전안됨
        charge_ready=not any(arr)

        if(charge_ready):
            return '충전 중'
        return '충전안됨'

samples= [ [0]*10,  # 0이 10개
           [1]*10, # 1이 10개
            [0,1,1,1,1,0,0,0,1,1],
            [0,0,0,1,0,1,0,0,0,1]
]

for sample in samples:
    print(check_charged(sample))