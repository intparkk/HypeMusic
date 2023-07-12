package com.study.springboot.service;

import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_newsDAO;
import com.study.springboot.dto.newsDTO;

@Service
public class pjs_news_service
{
	private pjs_newsDAO newsDao;
	
    public pjs_news_service(pjs_newsDAO newsDao) {
        this.newsDao = newsDao;
    }
    
    /**
     * @apiNote 전체 뉴스 데이터를 불러오는 함수입니다
     * @return	전체 뉴스 데이터 ArrayList
     */
    public List<newsDTO> getNewsList() {
        List<newsDTO> originalList = newsDao.getNewsList(); // 원본 리스트 가져오기

        Set<String> titleSet = new HashSet<>();
        List<newsDTO> filteredList = new ArrayList<>();
        
        // 중복 처리 for 문
        for (newsDTO news : originalList) {
            String newsTitle = news.getNews_title();
            if (newsTitle != null && !titleSet.contains(newsTitle)) {
                titleSet.add(newsTitle);
                filteredList.add(news);
            }
        }
        return filteredList;
    }
    
    /**
     * @apiNote 스타 메거진 페이지에서 기사 10개씩 불러오는 함수입니다
     * @param 몇 페이지 인지 확인용 int 값
     * @return 뉴스 데이터 10개 ArrayList
     */
    
    public List<newsDTO> getNewsByPage(int page) {
        int itemsPerPage = 10; // 페이지당 아이템 수
        int startIndex = (page - 1) * itemsPerPage; // 시작 인덱스 계산

        List<newsDTO> originalList = newsDao.getNewsList(); // 원본 리스트 가져오기

        Set<String> titleSet = new HashSet<>();
        List<newsDTO> filteredList = new ArrayList<>();

        // 중복 처리 및 페이징 처리
        for (int i = startIndex; i < originalList.size(); i++) {
            newsDTO news = originalList.get(i);
            String newsTitle = news.getNews_title();
            if (newsTitle != null && !titleSet.contains(newsTitle)) {
                titleSet.add(newsTitle);
                filteredList.add(news);
            }

            // 페이지당 아이템 수만큼 추가된 경우 종료
            if (filteredList.size() >= itemsPerPage) {
                break;
            }
        }
        return filteredList;
    }



}
