import naverHotel_scraping

if __name__=='__main__':
    sample_hotel_info=[]
    sample_hotel_keys=['hotel:Shilla_Stay_Gwanghwamun', 'hotel:Nine_Tree_Premier_Hotel_Insadong', 'hotel:Shilla_Stay_Yeoksam', 'hotel:Shilla_Stay_Seodaemun',
 'hotel:GLAD_Gangnam_COEX_Center', 'hotel:Glad_Mapo',]

    for key in sample_hotel_keys:
        result=naverHotel_scraping.get_hotel_info(key)
        sample_hotel_info.append(result)
    print(sample_hotel_info)